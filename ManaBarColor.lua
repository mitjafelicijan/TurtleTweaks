local feature = ns.Register({
  identifier = "ManabarColor",
  description = "Changes default color of mana power bar.",
  category = "interface",
  config = {}
})

local frame = CreateFrame("Frame")

-- frame:RegisterEvent("ADDON_LOADED")
-- frame:RegisterEvent("PLAYER_ENTERING_WORLD")
-- frame:RegisterEvent("UNIT_AURA")
-- frame:RegisterEvent("UNIT_MANA")
-- frame:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
-- frame:RegisterEvent("PLAYER_TARGET_CHANGED")
-- frame:RegisterEvent("PLAYER_STATE_CHANGED")
-- frame:RegisterEvent("PLAYER_LEVEL_UP")
-- frame:RegisterEvent("PLAYER_ENTER_COMBAT")

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
