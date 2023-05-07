-- Change the default world map to a smaller, movable one.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function()
    -- Do not load if other map addon is loaded.
    if Cartographer then return end
    if METAMAP_TITLE then return end

    UIPanelWindows["WorldMapFrame"] = { area = "center" }

    local mapFrame = WorldMapFrame

    mapFrame:SetMovable(true)
    mapFrame:EnableMouse(true)
    mapFrame:EnableKeyboard(false)

    mapFrame:ClearAllPoints()
    mapFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    -- mapFrame:SetWidth(WorldMapButton:GetWidth() - 150)
    -- mapFrame:SetHeight(WorldMapButton:GetHeight() - 550)

    mapFrame:SetWidth(500)
    mapFrame:SetHeight(500)

    mapFrame:SetScale(0.3)
end)
