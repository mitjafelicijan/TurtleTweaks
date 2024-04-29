local feature = ns.Register({
  identifier = "FixCastbarVisibility",
  description = "Fixes castbar still being shown after casting bug.",
  category = "utility",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("SPELLCAST_FAILED")
frame:RegisterEvent("SPELLCAST_STOP")
frame:RegisterEvent("SPELLCAST_INTERRUPTED")
frame:RegisterEvent("LOOT_OPENED")
frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  -- TODO: Find which event is needed to fix this mess.
  CastingBarFrame:Hide()
end)
