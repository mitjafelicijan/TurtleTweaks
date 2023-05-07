-- Adds rested bar to player frame.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)
-- Inspired by https://github.com/Steelbash/RestBar

local frame = CreateFrame("FRAME")

local lastRestValue = 0
local currentRestValue = 0
local statusBar = nil

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("UPDATE_EXHAUSTION")
frame:RegisterEvent("PLAYER_UPDATE_RESTING")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Calculates the percentage of rested XP.
frame.getRestedPercentage = function()
    local unit = "player"
    local max = UnitXPMax(unit) or 0
    local exhaustion = GetXPExhaustion() or 0
    local maxValue = max * 1.5

    return math.floor(exhaustion / maxValue * 100)
end

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if RestedBar == nil then
            RestedBar = {}
            RestedBar["enabled"] = true
            RestedBar["config"] = {}
            RestedBar["config"]["position"] = "top"
        end
    end

    if RestedBar and RestedBar["enabled"] then
        -- Creates a frame for the rested bar.
        if event == "PLAYER_ENTERING_WORLD" then
            currentRestValue = frame.getRestedPercentage()

            statusBar = CreateFrame("StatusBar", nil, PlayerFrame, "TextStatusBar")
            statusBar:SetWidth(100)
            statusBar:SetHeight(12)
            statusBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
            statusBar:SetStatusBarColor(255, 0, 255)

            statusBar.bg = statusBar:CreateTexture(nil, "BACKGROUND")
            statusBar.bg:SetAllPoints(statusBar)
            statusBar.bg:SetTexture(TEXTURE)
            statusBar.bg:SetVertexColor(0, 0, 0, 0.5)

            statusBar.bd = statusBar:CreateTexture(nil, "OVERLAY")
            statusBar.bd:SetWidth(120)
            statusBar.bd:SetHeight(18)
            statusBar.bd:SetTexture("Interface\\CharacterFrame\\UI-CharacterFrame-GroupIndicator")

            statusBar.text = statusBar:CreateFontString(nil, "OVERLAY")
            statusBar.text:SetPoint("CENTER", 0, 0)
            statusBar.text:SetFont(STANDARD_TEXT_FONT, 8, "OUTLINE")

            statusBar.tick = statusBar:CreateFontString(nil, "OVERLAY")
            statusBar.tick:SetPoint("LEFT", 110, 0)
            statusBar.tick:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            statusBar.tick:SetTextColor(205, 0, 205, 1)

            statusBar:ClearAllPoints()

            if RestedBar["config"]["position"] == "top" then
                statusBar:SetPoint("TOPLEFT", 114, -10)
                statusBar.bd:SetPoint("TOPLEFT", -10, 4)
                statusBar.bd:SetTexCoord(0.0234375, 0.6875, 0.0, 1.0)
            end

            if RestedBar["config"]["position"] == "bottom" then
                statusBar:SetPoint("BOTTOMLEFT", 114, 23)
                statusBar.bd:SetPoint("TOPLEFT", -12, 0)
                statusBar.bd:SetTexCoord(0.0234375, 0.6875, 1.0, 0.0)
            end
        end

        -- Updates the rested bar when the player gains or loses rested state.
        if event == "UPDATE_EXHAUSTION" or event == "PLAYER_UPDATE_RESTING" then
            currentRestValue = frame.getRestedPercentage()
        end
    end
end)

-- Updates the UI rested bar.
frame:SetScript("OnUpdate", function()
    if RestedBar and RestedBar["enabled"] then
        if lastRestValue ~= currentRestValue then
            lastRestValue = currentRestValue
            statusBar.text:SetText(lastRestValue .. "%")
        end
    end
end)
