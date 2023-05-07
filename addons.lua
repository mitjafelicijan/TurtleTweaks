-- Adds /addons commands that lists all loaded addons.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)

local frame = CreateFrame("FRAME")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if ListAddons == nil then
            ListAddons = {}
            ListAddons["enabled"] = true
            ListAddons["config"] = {}
        end

        -- Registers the slash commands.
        if ListAddons["enabled"] then
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
        end
    end
end)
