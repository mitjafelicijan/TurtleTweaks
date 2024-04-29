local feature = ns.Register({
  identifier = "CastbarPosition",
  description = "Adjust the position of the casting bar higher.",
  category = "interface",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("UI_SCALE_CHANGED")
frame:RegisterEvent("DISPLAY_SIZE_CHANGED")
frame:RegisterEvent("UNIT_SPELLCAST_SENT")
frame:RegisterEvent("SPELL_UPDATE_USABLE")
frame:RegisterEvent("UNIT_AURA")
frame:RegisterEvent("SPELLCAST_START")
frame:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  CastingBarFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 270)  
end)
