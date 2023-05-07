local max_width = 500
local max_height = 680

local settings = CreateFrame("Frame", "TurtleTweaksGUI", UIParent)
settings:EnableMouse(true)
settings:Hide()

-- Create a frame for our addon and position it in the center of the screen.
settings:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
settings:SetWidth(max_width)
settings:SetHeight(max_height)

-- Create a backdrop for our addon.
settings:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})

-- Add a title to the frame.
settings.title = CreateFrame("Frame", "AdvancedSettingsGUITtitle", settings)
settings.title:SetPoint("TOP", settings, "TOP", 0, 12)
settings.title:SetWidth(256)
settings.title:SetHeight(64)

-- Create a backdrop for the title.
settings.title.tex = settings.title:CreateTexture(nil, "MEDIUM")
settings.title.tex:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
settings.title.tex:SetAllPoints()

-- Create a font string for the title.
settings.title.text = settings.title:CreateFontString(nil, "HIGH", "GameFontNormal")
settings.title.text:SetText("Turtle Tweaks")
settings.title.text:SetPoint("TOP", 0, -14)

-- Creates a cancel button that is attached to our frame.
settings.cancel = CreateFrame("Button", "AdvancedSettingsGUICancel", settings, "GameMenuButtonTemplate")
settings.cancel:SetWidth(90)
settings.cancel:SetPoint("BOTTOMRIGHT", settings, "BOTTOMRIGHT", -17, 17)
settings.cancel:SetText(CANCEL)
settings.cancel:SetScript("OnClick", function()
    print("TT: Cancel pressed")
    -- current_config = {}
    settings:Hide()
end)

-- Creates a okay button that is attached to our frame.
settings.okay = CreateFrame("Button", "AdvancedSettingsGUIOkay", settings, "GameMenuButtonTemplate")
settings.okay:SetWidth(90)
settings.okay:SetPoint("RIGHT", settings.cancel, "LEFT", 0, 0)
settings.okay:SetText(OKAY)
settings.okay:SetScript("OnClick", function()
    print("TT: Okey pressed")
    settings:Hide()
end)

-- Creates a defaults button that is attached to our frame.
settings.defaults = CreateFrame("Button", "AdvancedSettingsGUICancel", settings, "GameMenuButtonTemplate")
settings.defaults:SetWidth(90)
settings.defaults:SetPoint("BOTTOMLEFT", settings, "BOTTOMLEFT", 17, 17)
settings.defaults:SetText(DEFAULTS)
settings.defaults:SetScript("OnClick", function()
    print("TT: Reseting to defaults")
end)

-- Add a button to the game menu that opens our addon frame when clicked.
local mainMenuButton = CreateFrame("Button", "TurtleTweaksMenuButton", GameMenuFrame, "GameMenuButtonTemplate")
mainMenuButton:SetPoint("TOP", GameMenuButtonUIOptions, "BOTTOM", 0, -1)
mainMenuButton:SetText("Turtle Tweaks")
mainMenuButton:SetScript("OnClick", function()
    HideUIPanel(GameMenuFrame)
    settings:Show()
end)

-- Add a button to the game menu that opens our addon frame when clicked.
GameMenuButtonKeybindings:ClearAllPoints()
GameMenuButtonKeybindings:SetPoint("TOP", mainMenuButton, "BOTTOM", 0, -1)
GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + 10)
