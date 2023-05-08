-- Sets the maximum camera distance based on the slider value.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)

-- Holds all the UI elements for settings.
CameraDistanceUI = {}
CameraDistanceUI["slider"] = nil

CameraDistanceUI.form = function(container, verticalOffset)
    local currentCameraDistance = GetCVar("cameraDistanceMaxFactor") or 2.0

    -- Create the slider.
    CameraDistanceUI["slider"] = CreateFrame("Slider", "MySliderGlobalName", container, "OptionsSliderTemplate")
    CameraDistanceUI["slider"]:SetWidth(200)
    CameraDistanceUI["slider"]:SetHeight(20)
    CameraDistanceUI["slider"]:SetPoint("TOPLEFT", 20, verticalOffset)
    CameraDistanceUI["slider"]:SetMinMaxValues(1, 3)
    CameraDistanceUI["slider"]:SetValue(currentCameraDistance)
    CameraDistanceUI["slider"]:SetValueStep(0.2)

    -- Create the title label.
    CameraDistanceUI["slider"].Text = CameraDistanceUI["slider"]:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    CameraDistanceUI["slider"].Text:SetPoint("BOTTOMLEFT", CameraDistanceUI["slider"], "TOPLEFT", 0, 20)
    CameraDistanceUI["slider"].Text:SetText("Camera distance")

    -- Create the description label.
    local descriptionLabel = CameraDistanceUI["slider"]:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
    descriptionLabel:SetPoint("TOPLEFT", CameraDistanceUI["slider"], "TOPLEFT", 0, 15)
    descriptionLabel:SetText("Sets the maximum camera distance.")
end

CameraDistanceUI.save = function()
    local roundedFactor = tonumber(CameraDistanceUI["slider"]:GetValue())
    SetCVar("cameraDistanceMaxFactor", roundedFactor)
end

CameraDistanceUI.cancel = function()
    SetCVar("cameraDistanceMaxFactor", GetCVar("cameraDistanceMaxFactor"))
end

CameraDistanceUI.reset = function()
    SetCVar("cameraDistanceMaxFactor", 2)
end
