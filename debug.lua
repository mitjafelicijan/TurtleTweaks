-- Adds a bunch of debug features for testing and development.

local frame = CreateFrame("FRAME")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if Debug == nil then
            Debug = {}
            Debug["enabled"] = false
            Debug["config"] = {
                autoDisplayNameplates = true,
                showReloadUiButton = true,
            }
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
                print("Usage: /twdebug [on|off]")
            end
        end

        local function print(msg)
            DEFAULT_CHAT_FRAME:AddMessage("> " .. msg)
        end

        if Debug["enabled"] then
            if Debug["config"]["autoDisplayNameplates"] then
                local displayNameplates = CreateFrame("Frame", nil, UIParent)
                displayNameplates:RegisterEvent("PLAYER_ENTERING_WORLD")
                displayNameplates:SetScript("OnEvent", function()
                    print("Auto-displaying ALL nameplates.")
                    ShowNameplates()
                    ShowFriendNameplates()
                end)
            end

            if Debug["config"]["showReloadUiButton"] then
                local reloadUiButton = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
                reloadUiButton:SetWidth(100)
                reloadUiButton:SetHeight(25)
                reloadUiButton:SetPoint("BOTTOMRIGHT", -30, 30)
                reloadUiButton:SetText("Reload UI")
                reloadUiButton:SetScript("OnClick", function(self, event, ...)
                    ConsoleExec("reloadui")
                end)
            end
        end
    end
end)
