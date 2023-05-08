-- Change the default world map to a smaller, movable one.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)

local frame = CreateFrame("Frame")

local hooked = false

frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function()
    if not hooked then
        UIPanelWindows["WorldMapFrame"] = { area = "center" }
        UIPanelWindows["WorldMapFrame"].allowOtherPanels = true
        hooked = true

        WorldMapFrame:EnableKeyboard(false)
        WorldMapFrame:EnableMouseWheel(1)

        WorldMapFrame:SetMovable(true)
        WorldMapFrame:EnableMouse(true)

        WorldMapFrame:SetScale(0.85)
        WorldMapFrame:ClearAllPoints()
        WorldMapFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 50, -50)
        WorldMapFrame:SetWidth(600)
        WorldMapFrame:SetHeight(400)
        BlackoutWorld:Hide()

        -- DEFAULT_CHAT_FRAME:AddMessage(WorldMapFrame:GetScale())
    end
end)
