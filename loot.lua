-- Opens the loot window at the current cursor position.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)

local frame = CreateFrame("FRAME")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("LOOT_OPENED")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if LootAtMouse == nil then
            LootAtMouse = {}
            LootAtMouse["enabled"] = true
            LootAtMouse["config"] = {}
        end
    end

    -- Open the loot window at the current cursor position.
    if LootAtMouse and LootAtMouse["enabled"] then
        if event == "LOOT_OPENED" then
            local x, y = GetCursorPosition()
            local scale = UIParent:GetScale()
            local lootFrame = LootFrame

            lootFrame:ClearAllPoints()
            lootFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / scale, y / scale)
        end
    end
end)
