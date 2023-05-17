-- Last Modified: 2023-05-09
-- Contents: Opens the loot window at the current cursor position.
-- FIXME: Close target frame when opening loot window.
local frame = CreateFrame("FRAME")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("LOOT_OPENED")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if LootAtMouse == nil then
            LootAtMouse = {
                enabled = false,
                config = {}
            }
        end
    end

    -- Open the loot window at the current cursor position.
    if LootAtMouse and LootAtMouse.enabled then
        if event == "LOOT_OPENED" then
            local x, y = GetCursorPosition()
            local scale = UIParent:GetScale()
            local lootFrame = LootFrame

            if lootFrame then
                lootFrame:ClearAllPoints()
                lootFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / scale, y / scale)
            end
        end
    end
end)

-- Holds all the UI elements for settings.
LootAtMouseUI = {
    enabled = nil,
    form = function(container, verticalOffset)
        LootAtMouseUI.enabled = CreateFrame("CheckButton", nil, container, "UICheckButtonTemplate")
        LootAtMouseUI.enabled:SetPoint("TOPLEFT", 20, verticalOffset)
        LootAtMouseUI.enabled:SetChecked(LootAtMouse.enabled)

        local titleLabel = LootAtMouseUI.enabled:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        titleLabel:SetPoint("LEFT", LootAtMouseUI.enabled, "RIGHT", 10, 7)
        titleLabel:SetText("Loot window at mouse cursor")

        local descriptionLabel = LootAtMouseUI.enabled:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
        descriptionLabel:SetPoint("LEFT", LootAtMouseUI.enabled, "RIGHT", 10, -7)
        descriptionLabel:SetText("Opens the loot window at the current cursor position.")
    end,
    save = function()
        LootAtMouse.enabled = (LootAtMouseUI.enabled:GetChecked() and true or false)
    end,
    cancel = function()
        LootAtMouseUI.enabled:SetChecked(LootAtMouse.enabled)
    end,
    reset = function()
        LootAtMouse = nil
    end
}
