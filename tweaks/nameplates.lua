local function IsNamePlateFrame(frame)
    local overlayRegion = frame:GetRegions()
    if not overlayRegion or overlayRegion:GetObjectType() ~= "Texture" or overlayRegion:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
        return false
    end
    return true
end

local frame = CreateFrame("frame")

-- Default nameplate values that are mostly the same as the Blizzard default nameplates.
local nameplate = {
    base = 115,
    notch = 25,
    height = 35
}

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if Nameplates == nil then
            Nameplates = {
                enabled = false,
                config = {
                    scale = 0.8
                }
            }
        end
    end
end)

frame:SetScript("OnUpdate", function()
    if Nameplates and Nameplates.enabled then
        local frames = {WorldFrame:GetChildren()}
        local scale = tonumber(Nameplates.config.scale)
        for _, namePlate in ipairs(frames) do
            if IsNamePlateFrame(namePlate) then
                local HealthBar = namePlate:GetChildren()
                local Border, Glow, Name, Level = namePlate:GetRegions()

                namePlate:SetWidth((nameplate.base + nameplate.notch) * scale)
                namePlate:SetHeight(nameplate.height * scale)

                HealthBar:ClearAllPoints()
                HealthBar:SetWidth(nameplate.base * scale)
                HealthBar:SetHeight(((nameplate.height / 2) - (5 * scale)) * scale)
                HealthBar:SetPoint("BOTTOM", namePlate, "BOTTOM", -(8 * scale), (2 * scale))

                Name:ClearAllPoints()
                Name:SetFont(STANDARD_TEXT_FONT, (12 * scale), "OUTLINE")
                Name:SetPoint("BOTTOM", namePlate, "BOTTOM", 0, (16 * scale) + (3 * scale))
                Name:SetShadowColor(0, 0, 0, .3)

                Level:ClearAllPoints()
                Level:SetPoint("BOTTOM", namePlate, "BOTTOM", (((nameplate.base / 2)) * scale), ((nameplate.height / 2) * scale) - (12 * scale))
                Level:SetFont(UNIT_NAME_FONT, (9 * scale), "OUTLINE")
                Level:SetShadowColor(0, 0, 0, .3)
            end
        end
    end
end)

-------------------------------------------------------------------- SETTINGS UI

-- Holds all the UI elements for settings.
NameplatesUI = {
    enabled = nil,
    slider = nil,
    form = function(container, verticalOffset, horizontalOffset)
        horizontalOffset = horizontalOffset or 25
        local currentCameraDistance = GetCVar("cameraDistanceMaxFactor") or 2.0

        -- Creates the checkbox.
        NameplatesUI.enabled = CreateFrame("CheckButton", nil, container, "UICheckButtonTemplate")
        NameplatesUI.enabled:SetPoint("TOPLEFT", horizontalOffset, verticalOffset + 30)
        NameplatesUI.enabled:SetChecked(Nameplates.enabled)

        -- Create the title label.
        NameplatesUI.enabled.Text = NameplatesUI.enabled:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        NameplatesUI.enabled.Text:SetPoint("TOPLEFT", NameplatesUI.enabled, "TOPLEFT", 37, -1)
        NameplatesUI.enabled.Text:SetText("Nameplates scaling")

        -- Create the description label.
        local descriptionLabel = NameplatesUI.enabled:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
        descriptionLabel:SetPoint("TOPLEFT", NameplatesUI.enabled, "TOPLEFT", 37, -15)
        descriptionLabel:SetText("Adjust the nameplates scaling.")

        -- Create the slider.
        NameplatesUI.slider = CreateFrame("Slider", nil, container, "OptionsSliderTemplate")
        NameplatesUI.slider:SetWidth(240)
        NameplatesUI.slider:SetHeight(20)
        NameplatesUI.slider:SetPoint("TOPLEFT", horizontalOffset + 5, verticalOffset - 0)
        NameplatesUI.slider:SetMinMaxValues(0.6, 1)
        NameplatesUI.slider:SetValue(Nameplates.config.scale)
        NameplatesUI.slider:SetValueStep(0.05)
    end,
    save = function()
        Nameplates.enabled = (NameplatesUI.enabled:GetChecked() and true or false)
        Nameplates.config.scale = NameplatesUI.slider:GetValue()
    end,
    cancel = function()
        NameplatesUI.enabled:SetChecked(Nameplates.enabled)
    end,
    reset = function()
        Nameplates = nil
    end
}
