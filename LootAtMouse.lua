local feature = ns.Register({
  identifier = "LootAtMouse",
  description = "Opens the loot window at the current cursor position.",
  category = "interface",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("LOOT_OPENED")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  if event == "LOOT_OPENED" then
    local x, y = GetCursorPosition()
    local scale = UIParent:GetScale()

    if LootFrame then
      LootFrame:ClearAllPoints()
      LootFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", (x/scale)-42, (y/scale)+98)
    end
  end  
end)
