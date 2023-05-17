-- Last Modified: 2023-05-09
-- Contents: Adds rested bar to player frame.
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
            RestedBar = {
                enabled = false,
                config = {
                    position = "top"
                }
            }
        end
    end

    if RestedBar and RestedBar.enabled then
        -- Creates a frame for the rested bar.
        if event == "PLAYER_ENTERING_WORLD" then
            currentRestValue = frame.getRestedPercentage()

            statusBar = CreateFrame("StatusBar", nil, PlayerFrame, "TextStatusBar")
            statusBar:ClearAllPoints()
            statusBar:SetWidth(100)
            statusBar:SetHeight(12)
            statusBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
            statusBar:SetStatusBarColor(0, 255, 255)
            statusBar:SetMinMaxValues(0, 100)

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

            if RestedBar.config.position == "top" then
                statusBar:SetPoint("TOPLEFT", 114, -10)
                statusBar.bd:SetPoint("TOPLEFT", -10, 4)
                statusBar.bd:SetTexCoord(0.0234375, 0.6875, 0.0, 1.0)
            end

            if RestedBar.config.position == "bottom" then
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
    if RestedBar and RestedBar.enabled then
        statusBar.text:SetText(currentRestValue .. "%")
        statusBar:SetValue(currentRestValue)

        if currentRestValue < 33 then
            statusBar:SetStatusBarColor(255, 255, 255)
        else
            statusBar:SetStatusBarColor(0, 255, 255)
        end
    end
end)

-- Holds all the UI elements for settings.
RestedBarUI = {
    enabled = nil,
    form = function(container, verticalOffset)
        RestedBarUI.enabled = CreateFrame("CheckButton", nil, container, "UICheckButtonTemplate")
        RestedBarUI.enabled:SetPoint("TOPLEFT", 20, verticalOffset)
        RestedBarUI.enabled:SetChecked(RestedBar.enabled)

        local titleLabel = RestedBarUI.enabled:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        titleLabel:SetPoint("LEFT", RestedBarUI.enabled, "RIGHT", 10, 7)
        titleLabel:SetText("Rested bar on player unit frame")

        local descriptionLabel = RestedBarUI.enabled:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
        descriptionLabel:SetPoint("LEFT", RestedBarUI.enabled, "RIGHT", 10, -7)
        descriptionLabel:SetText("Displays the current rested percentage in a bar on the player unit frame.")
    end,
    save = function()
        RestedBar.enabled = (RestedBarUI.enabled:GetChecked() and true or false)
    end,
    cancel = function()
        RestedBarUI.enabled:SetChecked(RestedBar.enabled)
    end,
    reset = function()
        RestedBar = nil
    end
}
