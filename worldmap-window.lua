-- Last Modified: 2023-05-09
-- Contents: Change the default world map to a smaller and in a window.

local moduleRegistered = false
local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if WorldmapWindow == nil then
            WorldmapWindow = {
                enabled = false,
                config = {
                    scale = 1,
                },
            }
        end
    end

    if WorldmapWindow and WorldmapWindow["enabled"] and event == "PLAYER_ENTERING_WORLD" then
        -- Allows other panels to be opened while the world map is open.
        UIPanelWindows.WorldMapFrame = { area = "CENTER" }
        UIPanelWindows.WorldMapFrame.allowOtherPanels = true


        -- Hide the black background.
        BlackoutWorld:Hide();

        -- Triggered when the world map is opened.
        WorldMapFrame:SetScript("onShow", function()
            WorldMapFrame:EnableKeyboard(false)
            WorldMapFrame:EnableMouseWheel(true)
            WorldMapFrame:SetScale(WorldmapWindow.config.scale)

            WorldMapFrame:ClearAllPoints()
            WorldMapFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
            WorldMapFrame:SetWidth(WorldMapButton:GetWidth())
            WorldMapFrame:SetHeight(WorldMapButton:GetHeight())
        end)
    end
end)

WorldmapWindowUI = {
    enabled = nil,
    slider = nil,
    form = function(container, verticalOffset, horizontalOffset)
        horizontalOffset = horizontalOffset or 25

        -- Creates the checkbox.
        WorldmapWindowUI.enabled = CreateFrame("CheckButton", nil, container, "UICheckButtonTemplate")
        WorldmapWindowUI.enabled:SetPoint("TOPLEFT", horizontalOffset, verticalOffset + 30)
        WorldmapWindowUI.enabled:SetChecked(WorldmapWindow.enabled)

        -- Create the title label.
        WorldmapWindowUI.enabled.Text = WorldmapWindowUI.enabled:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        WorldmapWindowUI.enabled.Text:SetPoint("TOPLEFT", WorldmapWindowUI.enabled, "TOPLEFT", 37, -1)
        WorldmapWindowUI.enabled.Text:SetText("Worldmap in a Window")

        -- Create the description label.
        local descriptionLabel = WorldmapWindowUI.enabled:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
        descriptionLabel:SetPoint("TOPLEFT", WorldmapWindowUI.enabled, "TOPLEFT", 37, -15)
        descriptionLabel:SetText("Adjust the world map window scaling.")

        -- Create the slider.
        WorldmapWindowUI.slider = CreateFrame("Slider", nil, container, "OptionsSliderTemplate")
        WorldmapWindowUI.slider:SetWidth(240)
        WorldmapWindowUI.slider:SetHeight(20)
        WorldmapWindowUI.slider:SetPoint("TOPLEFT", horizontalOffset + 5, verticalOffset - 0)
        WorldmapWindowUI.slider:SetMinMaxValues(0.2, 1)
        WorldmapWindowUI.slider:SetValue(WorldmapWindow.config.scale)
        WorldmapWindowUI.slider:SetValueStep(0.05)
    end,
    save = function()
        WorldmapWindow.enabled = (WorldmapWindowUI.enabled:GetChecked() and true or false)
        WorldmapWindow.config.scale = WorldmapWindowUI.slider:GetValue()
    end,
    cancel = function()
        WorldmapWindowUI.enabled:SetChecked(WorldmapWindow.enabled)
    end,
    reset = function()
        WorldmapWindow = nil
    end
}
