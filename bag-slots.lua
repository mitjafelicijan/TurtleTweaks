-- Last Modified: 2023-05-08
-- Contents: Adds a number of free bag slots to the backpack button.

local frame = CreateFrame("FRAME")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("BAG_UPDATE")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if BagSlots == nil then
            BagSlots = {
                enabled = false,
                config = {}
            }
        end
    end

    -- Updates the number of free bag slots.
    if BagSlots and BagSlots.enabled then
        if event == "PLAYER_LOGIN" or event == "BAG_UPDATE" then
            local backpackButton = MainMenuBarBackpackButton
            if not backpackButton then return end
            if not backpackButton.text then
                backpackButton.text = backpackButton:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
                backpackButton.text:SetTextColor(1, 1, 1)
                backpackButton.text:SetPoint("BOTTOMRIGHT", backpackButton, "BOTTOMRIGHT", -5, 2)
                backpackButton.text:SetDrawLayer("OVERLAY", 2)
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
            backpackButton.text:SetText(string.format("(%s)", totalFree))
        end
    end
end)

-- Holds all the UI elements for settings.
BagSlotsUI = {
    enabled = nil,
    form = function(container, verticalOffset)
        BagSlotsUI.enabled = CreateFrame("CheckButton", nil, container, "UICheckButtonTemplate")
        BagSlotsUI.enabled:SetPoint("TOPLEFT", 20, verticalOffset)
        BagSlotsUI.enabled:SetChecked(BagSlots.enabled)

        local titleLabel = BagSlotsUI.enabled:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        titleLabel:SetPoint("LEFT", BagSlotsUI.enabled, "RIGHT", 10, 7)
        titleLabel:SetText("Empty bag slots counter")

        local descriptionLabel = BagSlotsUI.enabled:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
        descriptionLabel:SetPoint("LEFT", BagSlotsUI.enabled, "RIGHT", 10, -7)
        descriptionLabel:SetText("Displays the number of free bag slots on the backpack button.")
    end,
    save = function()
        BagSlots.enabled = (BagSlotsUI.enabled:GetChecked() and true or false)
    end,
    cancel = function()
        BagSlotsUI.enabled:SetChecked(BagSlots.enabled)
    end,
    reset = function()
        BagSlots = nil
    end
}
