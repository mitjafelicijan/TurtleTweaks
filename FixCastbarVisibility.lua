local feature = ns.Register({
  identifier = "FixCastbarVisibility",
  description = "Fixes castbar still being shown after casting.",
  category = "utility",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("SPELLCAST_FAILED")
frame:RegisterEvent("SPELLCAST_STOP")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  -- TODO: Find which event is needed to fix this mess.
  -- CastingBarFrame:Hide()
end)
