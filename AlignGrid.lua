local feature = ns.Register({
  identifier = "AlignGrid",
  description = "Draws an align grid on a screen if Ctrl+Alt+Shift is being pressed.",
  category = "interface",
  config = {},
  data = {}
})

local frame = CreateFrame("Frame", nil, UIParent)

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  if event == "ADDON_LOADED" then
    frame.grid = CreateFrame("Frame")
    frame.grid:Hide()
    frame.grid:SetAllPoints(UIParent)

    local w, h = GetScreenWidth() * UIParent:GetEffectiveScale(), GetScreenHeight() * UIParent:GetEffectiveScale()
    local ratio = w / h
    local sqsize = w / 20
    local wline = floor(sqsize - mod(sqsize, 2))
    local hline = floor(sqsize / ratio - mod((sqsize / ratio), 2))

    -- Plot vertical lines.
    for i = 0, wline do
      local t = frame.grid:CreateTexture(nil, "BACKGROUND")
      if i == wline / 2 then
        t:SetTexture(1, 1, 0, 0.7) -- Yellow line in the middle
      else
        t:SetTexture(0, 0, 0, 0.7) -- Black lines elsewhere
      end
      t:SetPoint("TOPLEFT", frame.grid, "TOPLEFT", i * w / wline - 1, 0)
      t:SetPoint("BOTTOMRIGHT", frame.grid, "BOTTOMLEFT", i * w / wline + 1, 0)
    end

    -- Plot horizontal lines.
    for i = 0, hline do
      local t = frame.grid:CreateTexture(nil, "BACKGROUND")
      if i == hline / 2 then
        t:SetTexture(1, 1, 0, 0.7) -- Yellow line in the middle
      else
        t:SetTexture(0, 0, 0, 0.7) -- Black lines elsewhere
      end
      t:SetPoint("TOPLEFT", frame.grid, "TOPLEFT", 0, -i * h / hline + 1)
      t:SetPoint("BOTTOMRIGHT", frame.grid, "TOPRIGHT", 0, -i * h / hline - 1)
    end
  end

  frame:SetScript("OnUpdate", function()
    if IsControlKeyDown() and IsShiftKeyDown() and IsAltKeyDown() then
      frame.grid:Show()
    else
      frame.grid:Hide()
    end
  end)

  frame:UnregisterEvent("ADDON_LOADED")
end)

