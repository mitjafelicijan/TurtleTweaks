-- Last Modified: 2024-04-27
-- Contents: Opens the loot window at the current cursor position.
local frame = CreateFrame("FRAME")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("UNIT_AURA")
frame:RegisterEvent("UNIT_MANA")
frame:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")

-- frame:RegisterEvent("UNIT_POWER_UPDATE")
-- frame:RegisterEvent("SPELL_UPDATE_USABLE")
-- frame:RegisterEvent("UNIT_OTHER_PARTY_CHANGED")
-- frame:RegisterEvent("RAID_ROSTER_UPDATE")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if ManabarColor == nil then
            ManabarColor = {
                enabled = false,
                config = {
                    color = { r = 0.0, g = 0.6, b = 1 }
                },
            }
        end
    end

    DEFAULT_CHAT_FRAME:AddMessage(">event>" .. tostring(event))

    -- Open the loot window at the current cursor position.
    if ManabarColor and ManabarColor.enabled then
        if (UnitPowerType("player") == 0) then
            PlayerFrameManaBar:SetStatusBarColor(0.0, 0.6, 1.0)
        end
        
        if (UnitPowerType("pet") == 0) then
            PetFrameManaBar:SetStatusBarColor(0.0, 0.6, 1.0)
        end
        
        if (UnitPowerType("target") == 0) then
            TargetFrameManaBar:SetStatusBarColor(0.0, 0.6, 1.0)
        end
        
        -- if (UnitPowerType("targettarget") == 0) then
            -- TargetFrameToTManaBar:SetStatusBarColor(0.0, 0.6, 1.0)
        -- end
    end
end)

-- Holds all the UI elements for settings.
ManabarColorUI = {
    enabled = nil,
    form = function(container, verticalOffset)
        ManabarColorUI.enabled = CreateFrame("CheckButton", nil, container, "UICheckButtonTemplate")
        ManabarColorUI.enabled:SetPoint("TOPLEFT", 20, verticalOffset)
        ManabarColorUI.enabled:SetChecked(ManabarColor.enabled)

        local titleLabel = ManabarColorUI.enabled:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        titleLabel:SetPoint("LEFT", ManabarColorUI.enabled, "RIGHT", 10, 7)
        titleLabel:SetText("Manabar color")

        local descriptionLabel = ManabarColorUI.enabled:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
        descriptionLabel:SetPoint("LEFT", ManabarColorUI.enabled, "RIGHT", 10, -7)
        descriptionLabel:SetText("Changes manabar color to lighter blue one.")
    end,
    save = function()
        ManabarColor.enabled = (ManabarColorUI.enabled:GetChecked() and true or false)
    end,
    cancel = function()
        ManabarColorUI.enabled:SetChecked(ManabarColor.enabled)
    end,
    reset = function()
        ManabarColor = nil
    end
}
