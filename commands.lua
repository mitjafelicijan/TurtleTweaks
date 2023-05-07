-- Adds the following commands that lists:
-- * /addons: all loaded addons.
-- * /reloadui, /reload, and /rl: reloads the UI.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)

local frame = CreateFrame("FRAME")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if Commands == nil then
            Commands = {}
            Commands["enabled"] = false
            Commands["config"] = {}
        end

        -- Registers the slash commands.
        if Commands and Commands["enabled"] then
            -- Lists all loaded addons.
            SLASH_TweeksAddons1 = "/addons"

            SlashCmdList["TweeksAddons"] = function(msg, editbox)
                local numAddOns = GetNumAddOns()
                print("Loaded Addons (" .. numAddOns .. "):")
                for i = 1, numAddOns do
                    local name, _, _, _, _, _, loaded = GetAddOnInfo(i)
                    if loaded then
                        print(" - " .. name)
                    end
                end
            end

            -- Reloads the UI.
            SLASH_TweeksReload1 = "/reloadui"
            SLASH_TweeksReload2 = "/reload"
            SLASH_TweeksReload3 = "/rl"

            SlashCmdList["TweeksReload"] = function(msg, editbox)
                ConsoleExec("reloadui")
            end
        end
    end
end)

-- Holds all the UI elements for settings.
CommandsUI = {}
CommandsUI["enabled"] = nil

CommandsUI.form = function(container, verticalOffset)
    CommandsUI["enabled"] = CreateFrame("CheckButton", "Checkbox", container, "UICheckButtonTemplate")
    CommandsUI["enabled"]:SetPoint("TOPLEFT", 20, verticalOffset)
    CommandsUI["enabled"]:SetChecked(Commands["enabled"])

    local titleLabel = CommandsUI["enabled"]:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleLabel:SetPoint("LEFT", CommandsUI["enabled"], "RIGHT", 10, 7)
    titleLabel:SetText("Helper commands")

    local descriptionLabel = CommandsUI["enabled"]:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
    descriptionLabel:SetPoint("LEFT", CommandsUI["enabled"], "RIGHT", 10, -7)
    descriptionLabel:SetText("Enables commands: /addons, /rl.")
end

CommandsUI.save = function()
    Commands["enabled"] = (CommandsUI["enabled"]:GetChecked() and true or false)
end

CommandsUI.cancel = function()
    CommandsUI["enabled"]:SetChecked(Commands["enabled"])
end

CommandsUI.reset = function()
    Commands["enabled"] = false
end
