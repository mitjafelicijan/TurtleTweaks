local feature = ns.Register({
  identifier = "CastbarPosition",
  description = "Adjust the position of the casting bar higher.",
  category = "interface",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterAllEvents()

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  CastingBarFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 270)  
end)
