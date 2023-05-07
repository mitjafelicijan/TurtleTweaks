-- Adds /reloadui, /reload, and /rl commands to reload the UI.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)

local frame = CreateFrame("FRAME")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if ReloadUI == nil then
            ReloadUI = {}
            ReloadUI["enabled"] = true
            ReloadUI["config"] = {}
        end

        -- Registers the slash commands.
        if ReloadUI["enabled"] then
            SLASH_TweeksReloadUI1 = "/reloadui"
            SLASH_TweeksReloadUI2 = "/reload"
            SLASH_TweeksReloadUI3 = "/rl"

            SlashCmdList["TweeksReloadUI"] = function(msg, editbox)
                ConsoleExec("reloadui")
            end
        end
    end
end)
