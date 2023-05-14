-- Last Modified: 2023-05-09
-- Contents: Sets the maximum camera distance based on the slider value.
-- FIXME: Check if the new cam distance is smaller than the current one, then set it to the new one.

-- Holds all the UI elements for settings.
CameraDistanceUI = {
    slider = nil,
    form = function(container, verticalOffset)
        local currentCameraDistance = GetCVar("cameraDistanceMaxFactor") or 2.0

        -- Create the slider.
        CameraDistanceUI.slider = CreateFrame("Slider", nil, container, "OptionsSliderTemplate")
        CameraDistanceUI.slider:SetWidth(240)
        CameraDistanceUI.slider:SetHeight(20)
        CameraDistanceUI.slider:SetPoint("TOPLEFT", 25, verticalOffset)
        CameraDistanceUI.slider:SetMinMaxValues(1, 3)
        CameraDistanceUI.slider:SetValue(currentCameraDistance)
        CameraDistanceUI.slider:SetValueStep(0.3)

        -- Create the title label.
        CameraDistanceUI.slider.Text = CameraDistanceUI.slider:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        CameraDistanceUI.slider.Text:SetPoint("BOTTOMLEFT", CameraDistanceUI.slider, "TOPLEFT", 0, 20)
        CameraDistanceUI.slider.Text:SetText("Camera distance")

        -- Create the description label.
        local descriptionLabel = CameraDistanceUI.slider:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
        descriptionLabel:SetPoint("TOPLEFT", CameraDistanceUI.slider, "TOPLEFT", 0, 15)
        descriptionLabel:SetText("Sets the maximum camera distance.")
    end,
    save = function()
        local roundedFactor = tonumber(CameraDistanceUI.slider:GetValue())
        SetCVar("cameraDistanceMaxFactor", roundedFactor)
    end,
    cancel = function()
        SetCVar("cameraDistanceMaxFactor", GetCVar("cameraDistanceMaxFactor"))
    end,
    reset = function()
        SetCVar("cameraDistanceMaxFactor", 2)
    end
}
