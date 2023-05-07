-- Adds threat bar to the target frame.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)
-- Inspired by https://github.com/CosminPOP/TWThreat

local frame = CreateFrame("FRAME")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if ThreatBar == nil then
            ThreatBar = {}
            ThreatBar["enabled"] = true
            ThreatBar["config"] = {}
        end
    end

    -- Open the loot window at the current cursor position.
    if ThreatBar and ThreatBar["enabled"] then
    end
end)
