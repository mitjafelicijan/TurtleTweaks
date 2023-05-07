-- Adds a number of free bag slots to the backpack button.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)
-- Inspired by https://github.com/anzz1/FreeBagSlots

local frame = CreateFrame("FRAME")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent('PLAYER_LOGIN')
frame:RegisterEvent('BAG_UPDATE')

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if BagSlots == nil then
            BagSlots = {}
            BagSlots["enabled"] = true
            BagSlots["config"] = {}
        end
    end

    -- Updates the number of free bag slots.
    if BagSlots and BagSlots["enabled"] then
        if event == "PLAYER_LOGIN" or event == "BAG_UPDATE" then
            local backpackButton = MainMenuBarBackpackButton

            if not backpackButton then return end
            if not backpackButton then return end
            if not backpackButton.text then
                backpackButton.text = backpackButton:CreateFontString(nil, 'OVERLAY', 'NumberFontNormal')
                backpackButton.text:SetTextColor(1, 1, 1)
                backpackButton.text:SetPoint('BOTTOMRIGHT', backpackButton, 'BOTTOMRIGHT', -5, 2)
                backpackButton.text:SetDrawLayer('OVERLAY', 2)
            end

            local totalFree = 0
            local freeSlots = 0

            for i = 0, NUM_BAG_SLOTS do
                freeSlots = 0
                for slot = 1, GetContainerNumSlots(i) do
                    local texture = GetContainerItemInfo(i, slot)
                    if not (texture) then
                        freeSlots = freeSlots + 1
                    end
                end
                totalFree = totalFree + freeSlots
            end

            backpackButton.freeSlots = totalFree
            backpackButton.text:SetText(string.format('(%s)', totalFree))
        end
    end
end)
