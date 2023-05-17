local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if CooldownTimers == nil then
            CooldownTimers = {
                enabled = false,
                config = {}
            }
        end
    end
end)

local function GetButton(i)
    if i <= 12 then
        return getglobal("ActionButton" .. i)
    elseif i <= 24 then
        return getglobal("MultiBarBottomRightButton" .. (i - 12))
    elseif i <= 36 then
        return getglobal("MultiBarBottomLeftButton" .. (i - 24))
    elseif i <= 48 then
        return getglobal("MultiBarRightButton" .. (i - 36))
    else
        return getglobal("MultiBarLeftButton" .. (i - 48))
    end
end

frame:SetScript("OnUpdate", function(self, elapsed)
    if CooldownTimers and CooldownTimers.enabled then
        for i = 1, 120 do
            local start, duration, enable = GetActionCooldown(i)
            if start and duration and enable then
                local cooldown = start + duration - GetTime()
                local button = GetButton(i)
                if button then
                    if not button.cooldownText then
                        local textFrame = CreateFrame("Frame", nil, button)
                        textFrame:SetAllPoints(button)
                        textFrame:SetFrameLevel(button:GetFrameLevel() + 5)
                        button.cooldownText = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                        button.cooldownText:SetPoint("CENTER", textFrame, "CENTER", 0, 0)
                        button.cooldownText:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                    end
                    if cooldown > 0 then
                        button.cooldownText:SetText(string.format("%.1f", cooldown))
                    else
                        button.cooldownText:SetText("")
                    end
                end
            end
        end
    end
end)

-- Holds all the UI elements for settings.
CooldownTimersUI = {
    enabled = nil,
    form = function(container, verticalOffset)
        CooldownTimersUI.enabled = CreateFrame("CheckButton", nil, container, "UICheckButtonTemplate")
        CooldownTimersUI.enabled:SetPoint("TOPLEFT", 20, verticalOffset)
        CooldownTimersUI.enabled:SetChecked(CooldownTimers.enabled)

        local titleLabel = CooldownTimersUI.enabled:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        titleLabel:SetPoint("LEFT", CooldownTimersUI.enabled, "RIGHT", 10, 7)
        titleLabel:SetText("Cooldown Timers")

        local descriptionLabel = CooldownTimersUI.enabled:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
        descriptionLabel:SetPoint("LEFT", CooldownTimersUI.enabled, "RIGHT", 10, -7)
        descriptionLabel:SetText("Enables cooldown timer frames in actionbars.")
    end,
    save = function()
        CooldownTimers.enabled = (CooldownTimersUI.enabled:GetChecked() and true or false)
    end,
    cancel = function()
        CooldownTimersUI.enabled:SetChecked(CooldownTimers.enabled)
    end,
    reset = function()
        CooldownTimers = nil
    end
}
