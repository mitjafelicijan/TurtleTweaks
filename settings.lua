local maxWidth = 500
local maxHeight = 400 -- 280
local alreadyLoaded = false

local settings = CreateFrame("Frame", "VanillaTweaksGUI", UIParent)

settings:RegisterEvent("ADDON_LOADED")

settings:SetScript("OnEvent", function()
    if event == "ADDON_LOADED" and not alreadyLoaded then
        alreadyLoaded = true
        settings:EnableMouse(true)
        settings:Hide()

        -- Create a frame for our addon and position it in the center of the screen.
        settings:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
        settings:SetWidth(maxWidth)
        settings:SetHeight(maxHeight)
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
        settings.title = CreateFrame("Frame", "VanillaTweaksGUITitle", settings)
        settings.title:SetPoint("TOP", settings, "TOP", 0, 12)
        settings.title:SetWidth(256)
        settings.title:SetHeight(64)

        -- Create a backdrop for the title.
        settings.title.tex = settings.title:CreateTexture(nil, "MEDIUM")
        settings.title.tex:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
        settings.title.tex:SetAllPoints()

        -- Create a font string for the title.
        settings.title.text = settings.title:CreateFontString(nil, "HIGH", "GameFontNormal")
        settings.title.text:SetText("Vanilla Tweaks")
        settings.title.text:SetPoint("TOP", 0, -14)

        -- Creates a cancel button that is attached to our frame.
        settings.cancel = CreateFrame("Button", "VanillaTweaksGUICancel", settings, "GameMenuButtonTemplate")
        settings.cancel:SetWidth(90)
        settings.cancel:SetPoint("BOTTOMRIGHT", settings, "BOTTOMRIGHT", -17, 17)
        settings.cancel:SetText(CANCEL)
        settings.cancel:SetScript("OnClick", function()
            -- Calling the cancel function for each tweak.
            BagSlotsUI.cancel()
            RestedBarUI.cancel()
            LootAtMouseUI.cancel()
            CommandsUI.cancel()
            CameraDistanceUI.cancel()

            -- Hide the settings frame.
            settings:Hide()
        end)

        -- Creates a okay button that is attached to our frame.
        settings.okay = CreateFrame("Button", "VanillaTweaksGUIOkey", settings, "GameMenuButtonTemplate")
        settings.okay:SetWidth(90)
        settings.okay:SetPoint("RIGHT", settings.cancel, "LEFT", 0, 0)
        settings.okay:SetText(OKAY)
        settings.okay:SetScript("OnClick", function()
            -- Calling the save function for each tweak.
            BagSlotsUI.save()
            RestedBarUI.save()
            LootAtMouseUI.save()
            CommandsUI.save()
            CameraDistanceUI.save()

            -- Reload the UI to apply the changes.
            ConsoleExec("reloadui")
        end)

        -- Creates a defaults button that is attached to our frame.
        settings.defaults = CreateFrame("Button", "VanillaTweaksGUIDefaults", settings, "GameMenuButtonTemplate")
        settings.defaults:SetWidth(90)
        settings.defaults:SetPoint("BOTTOMLEFT", settings, "BOTTOMLEFT", 17, 17)
        settings.defaults:SetText(DEFAULTS)
        settings.defaults:SetScript("OnClick", function()
            -- Calling the reset function for each tweak.
            BagSlotsUI.reset()
            RestedBarUI.reset()
            LootAtMouseUI.reset()
            CommandsUI.reset()
            CameraDistanceUI.reset()

            -- Reload the UI to apply the changes.
            ConsoleExec("reloadui")
        end)

        -- Add a button to the game menu that opens our addon frame when clicked.
        local mainMenuButton = CreateFrame("Button", "VanillaTweaksGUIMenuButton", GameMenuFrame,
            "GameMenuButtonTemplate")
        mainMenuButton:SetPoint("TOP", GameMenuButtonUIOptions, "BOTTOM", 0, -1)
        mainMenuButton:SetText("Vanilla Tweaks")
        mainMenuButton:SetScript("OnClick", function()
            HideUIPanel(GameMenuFrame)
            settings:Show()
        end)

        -- Add a button to the game menu that opens our addon frame when clicked.
        GameMenuButtonKeybindings:ClearAllPoints()
        GameMenuButtonKeybindings:SetPoint("TOP", mainMenuButton, "BOTTOM", 0, -1)
        GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + 10)

        -- Create a container for our settings.
        settings.container = CreateFrame("Frame", "VanillaTweaksGUIContainer", settings)
        settings.container:SetPoint("CENTER", settings, 0, 20)
        settings.container:SetHeight(maxHeight - 30)
        settings.container:SetWidth(maxWidth - 20)

        -- Calls the configElement function for each element in the table.
        -- These functions are defined in the individual files for each tweak.
        -- Each row has 40 pixels offset from the previous one.
        BagSlotsUI.form(settings.container, -50)
        RestedBarUI.form(settings.container, -90)
        LootAtMouseUI.form(settings.container, -130)
        CommandsUI.form(settings.container, -170)
        CameraDistanceUI.form(settings.container, -270)
    end
end)
