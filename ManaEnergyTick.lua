local feature = ns.Register({
  identifier = "ManaEnergyTick",
  description = "Displays mana and energy tick in bars.",
  category = "interface",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  print("Mana and energy tick")
end)
