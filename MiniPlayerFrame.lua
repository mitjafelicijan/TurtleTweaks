local feature = ns.Register({
  identifier = "MiniPlayerFrame",
  description = "Adds health, mana and power unit frame below a player.",
  category = "interface",
  config = {
    offset = 150,
    barWidth = 106,
    barHeight = 6,
    barAlpha = 1.0,
    barBackgroundAlpha = 0.4,
  },
  data = {
    intialized = false
  }
})

local frame = CreateFrame("Frame", nil, UIParent)

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("UNIT_DISPLAYPOWER")
frame:RegisterEvent("PLAYER_AURAS_CHANGED")

frame:RegisterEvent("UNIT_MANA")
frame:RegisterEvent("UNIT_MAXMANA")
frame:RegisterEvent("UNIT_HEALTH")
frame:RegisterEvent("UNIT_MAXHEALTH")
frame:RegisterEvent("UNIT_RAGE")
frame:RegisterEvent("UNIT_MAXRAGE")
frame:RegisterEvent("UNIT_ENERGY")
frame:RegisterEvent("UNIT_MAXENERGY")
frame:RegisterEvent("UNIT_FOCUS")
frame:RegisterEvent("UNIT_MAXFOCUS")

frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
frame:RegisterEvent("PLAYER_AURAS_CHANGED")
frame:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
frame:RegisterEvent("SPELLCAST_STOP")
frame:RegisterEvent("UNIT_DISPLAYPOWER")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  local _, playerClass = UnitClass("player")
  local power = UnitPowerType("player")
  local currentHealth = UnitHealth("player")
  local maxHealth = UnitHealthMax("player")
  local currentMana = UnitMana("player")
  local maxMana = UnitManaMax("player")

  if event == "ADDON_LOADED" and not feature.data.initialized then
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, -feature.config.offset)
    frame:SetWidth(128)
    frame:SetHeight(64)
    frame:EnableMouse(false)
    frame:Show()

    -- Health bar.
    frame.health = CreateFrame("StatusBar", nil, frame, "TextStatusBar")
    frame.health:SetPoint("CENTER", frame, "CENTER", 0, 20)
    frame.health:SetWidth(feature.config.barWidth)
    frame.health:SetHeight(feature.config.barHeight)
    frame.health:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    frame.health:SetStatusBarColor(0.0, 1.0, 0.0, feature.config.barAlpha)
    frame.health:SetMinMaxValues(0, maxHealth)
    frame.health:SetValue(currentHealth)
    frame.health:EnableMouse(false)

    -- Primary bar.
    frame.primary = CreateFrame("StatusBar", nil, frame, "TextStatusBar")
    frame.primary:SetPoint("CENTER", frame, "CENTER", 0, -feature.config.barHeight + 17)
    frame.primary:SetWidth(feature.config.barWidth)
    frame.primary:SetHeight(feature.config.barHeight)
    frame.primary:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    frame.primary:SetStatusBarColor(0.0, 0.7, 1.0, feature.config.barAlpha)
    frame.primary:SetMinMaxValues(0, 100)
    frame.primary:SetValue(40)
    frame.primary:EnableMouse(false)

    -- Setting up the texture.
    frame.border = frame:CreateTexture(nil, "OVERLAY")
    frame.border:SetTexture("Interface\\AddOns\\TurtleTweaks\\UI\\MiniUnitFrame.tga")
    frame.border:SetAllPoints(frame)
    frame.border:SetTexCoord(0, 1, 0, 0.5)

    -- Setting up strata of elements.
    frame.health:SetFrameStrata("BACKGROUND")
    frame.primary:SetFrameStrata("BACKGROUND")

    -- Hiding all initial bars.
    frame.health:Hide()
    frame.primary:Hide()

    -- Adding background to the bars.
    DebugPlaceholder(frame.health, 0, 0, 0, feature.config.barBackgroundAlpha)
    DebugPlaceholder(frame.primary, 0, 0, 0, feature.config.barBackgroundAlpha)

    feature.data.initialized = true
  end

  if feature.data.initialized then
    -- Setting up primary bar colors and bar slots.
    if playerClass == "DRUID" then
      if power == 0 then frame.primary:SetStatusBarColor(0.0, 0.7, 1.0, feature.config.barAlpha) end
      if power == 1 then frame.primary:SetStatusBarColor(1.0, 0.0, 0.0, feature.config.barAlpha) end
      if power == 3 then frame.primary:SetStatusBarColor(1.0, 1.0, 0.0, feature.config.barAlpha) end

      if power == 0 or power == 2 then
        frame.border:SetTexCoord(0.0, 1.0, 0.0, 0.5) -- two slot
      else
        frame.border:SetTexCoord(0.0, 1.0, 0.5, 1.0) -- three slot
      end
    end

    if playerClass == "WARRIOR" then
      frame.primary:SetStatusBarColor(1.0, 0.0, 0.0, feature.config.barAlpha)
    end

    if playerClass == "ROGUE" then
      frame.primary:SetStatusBarColor(1.0, 1.0, 0.0, feature.config.barAlpha)
    end

    -- Updating health bar.
    frame.health:SetMinMaxValues(0, maxHealth)
    frame.health:SetValue(currentHealth)
    frame.health:Show()

    -- Update primary bar.
    frame.primary:SetMinMaxValues(0, maxMana)
    frame.primary:SetValue(currentMana)
    frame.primary:Show()
  end
end)

