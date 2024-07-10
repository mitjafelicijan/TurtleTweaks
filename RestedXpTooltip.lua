local feature = ns.Register({
  identifier = "RestedXpTooltip",
  description = "Adds rested XP in percentage to the XP bar.",
  category = "interface",
  config = {},
  frames = {
    expbar = nil,
  },
  data = {
    attached = false,
    exhaustion = 0,
    currentXP = 0,
    nextLevelXP = 0,
  },
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("UPDATE_EXHAUSTION")
frame:RegisterEvent("PLAYER_UPDATE_RESTING")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:RegisterEvent("PLAYER_XP_UPDATE")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  if not feature.frames.exp then
    feature.frames.exp = CreateFrame("Frame", "exp", UIParent)
    feature.frames.exp:SetFrameStrata("HIGH")
    
    feature.frames.exp.expstring = feature.frames.exp:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    feature.frames.exp.expstring:ClearAllPoints()
    feature.frames.exp.expstring:SetPoint("CENTER", MainMenuExpBar, "CENTER", 0, 2)
    feature.frames.exp.expstring:SetJustifyH("CENTER")
    feature.frames.exp.expstring:SetTextColor(1,1,1)

    MainMenuExpBar:SetScript("OnEnter", function(self)
      feature.frames.exp.expstring:SetText(string.format("XP %s / %s (%s%%)", feature.data.currentXP, feature.data.nextLevelXP, feature.data.exhaustion))
      feature.frames.exp:Show()
    end)
    
    MainMenuExpBar:SetScript("OnLeave", function(self)
      feature.frames.exp:Hide()
    end)

    feature.data.attached = true
  end
end)

frame:SetScript("OnUpdate", function()
  if not ns.IsEnabled(feature.identifier) then return end

  local currentXP, nextLevelXP, exhaustion = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion() or 0
  feature.data.exhaustion = math.floor(exhaustion / nextLevelXP * 100) or 0
  feature.data.currentXP = currentXP
  feature.data.nextLevelXP = nextLevelXP
end)
