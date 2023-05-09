-- Adds a bunch of debug features for testing and development.

local moduleRegistered = false
local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if not moduleRegistered and event == "ADDON_LOADED" then
        if Debug == nil then
            Debug = {
                enabled = false,
                config = {
                    autoDisplayNameplates = true,
                    showReloadUiButton = true,
                }
            }
        end

        if Debug.enabled then
            if Debug.config.autoDisplayNameplates then
                local displayNameplates = CreateFrame("Frame", nil, UIParent)
                displayNameplates:RegisterEvent("PLAYER_ENTERING_WORLD")
                displayNameplates:SetScript("OnEvent", function()
                    ShowNameplates()
                    ShowFriendNameplates()
                end)
            end

            if Debug.config.showReloadUiButton then
                local reloadUiButton = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
                reloadUiButton:SetWidth(110)
                reloadUiButton:SetHeight(25)
                reloadUiButton:SetPoint("BOTTOMRIGHT", -30, 30)
                reloadUiButton:SetText("Reload UI")
                reloadUiButton:SetScript("OnClick", function(self, event, ...)
                    ConsoleExec("reloadui")
                end)

                local toggleNameplatesButton = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
                toggleNameplatesButton:SetWidth(110)
                toggleNameplatesButton:SetHeight(25)
                toggleNameplatesButton:SetPoint("BOTTOMRIGHT", -30, 65)
                toggleNameplatesButton:SetText("Toggle Plates")
                toggleNameplatesButton:SetScript("OnClick", function(self, event, ...)
                    if Debug.config.autoDisplayNameplates then
                        Debug.config.autoDisplayNameplates = false
                        DEFAULT_CHAT_FRAME:AddMessage("> Auto-displaying nameplates DISABLED.")
                        HideNameplates()
                        HideFriendNameplates()
                    else
                        Debug.config.autoDisplayNameplates = true
                        DEFAULT_CHAT_FRAME:AddMessage("> Auto-displaying nameplates ENABLED.")
                        ShowNameplates()
                        ShowFriendNameplates()
                    end
                end)

                local settingsButton = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
                settingsButton:SetWidth(110)
                settingsButton:SetHeight(25)
                settingsButton:SetPoint("BOTTOMRIGHT", -30, 100)
                settingsButton:SetText("Settings")
                settingsButton:SetScript("OnClick", function(self, event, ...)
                    settings:Show()
                end)
            end
        end

        -- Adds slash commands to enable/disable debug mode.
        SLASH_TweeksDebug1 = "/twdebug"
        SLASH_TweeksDebug2 = "/twd"

        SlashCmdList["TweeksDebug"] = function(msg, editbox)
            if msg == "on" then
                Debug["enabled"] = true
                ConsoleExec("reloadui")
            elseif msg == "off" then
                Debug["enabled"] = false
                ConsoleExec("reloadui")
            else
                DEFAULT_CHAT_FRAME:AddMessage("Usage: /twdebug [on|off]")
            end
        end
    end
end)
