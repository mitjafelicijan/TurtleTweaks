local feature = ns.Register({
  identifier = "FreeBagSlots",
  description = "Displays the number of free bag slots.",
  category = "interface",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("BAG_UPDATE")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  if event == "PLAYER_LOGIN" or event == "BAG_UPDATE" then
    if not MainMenuBarBackpackButton then return end

    if not MainMenuBarBackpackButton.text then
      MainMenuBarBackpackButton.text = MainMenuBarBackpackButton:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
      MainMenuBarBackpackButton.text:SetTextColor(1, 1, 1)
      MainMenuBarBackpackButton.text:SetPoint("BOTTOMRIGHT", MainMenuBarBackpackButton, "BOTTOMRIGHT", -3, 3)
      MainMenuBarBackpackButton.text:SetDrawLayer("OVERLAY", 2)
    end

    local totalFree = 0
    local freeSlots = 0

    for i = 0, NUM_BAG_SLOTS do
      freeSlots = 0
      for slot = 1, GetContainerNumSlots(i) do
        local texture = GetContainerItemInfo(i, slot)
        if not (texture) then
          freeSlots = freeSlots + 1
        end
      end
      totalFree = totalFree + freeSlots
    end

    MainMenuBarBackpackButton.freeSlots = totalFree
    MainMenuBarBackpackButton.text:SetText(string.format("%s", totalFree))
  end
end)
