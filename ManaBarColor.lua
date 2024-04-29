local feature = ns.Register({
  identifier = "ManabarColor",
  description = "Changes default color of mana power bar.",
  category = "interface",
  config = {}
})

local frame = CreateFrame("Frame")

-- NOTE: This is not ideal, listening to all event, but the list was getting a bit long.
frame:RegisterAllEvents()

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  if PlayerFrameManaBar and UnitPowerType("player") == 0 then
    PlayerFrameManaBar:SetStatusBarColor(ns.Config.ManaBarColor.r, ns.Config.ManaBarColor.g, ns.Config.ManaBarColor.b)
  end

  if PetFrameMember and UnitPowerType("pet") == 0 then
    PetFrameManaBar:SetStatusBarColor(ns.Config.ManaBarColor.r, ns.Config.ManaBarColor.g, ns.Config.ManaBarColor.b)
  end

  if TargetFrameManaBar and UnitPowerType("target") == 0 then
    TargetFrameManaBar:SetStatusBarColor(ns.Config.ManaBarColor.r, ns.Config.ManaBarColor.g, ns.Config.ManaBarColor.b)
  end
end)
