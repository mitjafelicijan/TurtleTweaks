local frame = CreateFrame("Frame")

-- DEFAULT_CHAT_FRAME:AddMessage("> Loaded: personal-diary.lua", 0.0, 1.0, 0.0)
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("WORLD_MAP_UPDATE")

local function getCurrentPlayerLocation()
    local posX, posY = GetPlayerMapPosition("player") -- Get the player's position on the current map
    local zone = GetRealZoneText() -- Get the name of the current zone
    local mapFrame = Minimap:GetParent() -- Get the parent frame of the minimap

    local mapContinent = GetCurrentMapContinent();
    local mapZone = GetCurrentMapZone();
    local mapName = GetMapInfo();

    DEFAULT_CHAT_FRAME:AddMessage("mapContinent>>: " .. tostring(mapContinent))
    DEFAULT_CHAT_FRAME:AddMessage("mapZone>>: " .. tostring(mapZone))
    DEFAULT_CHAT_FRAME:AddMessage("mapName>>: " .. tostring(mapName))

    -- Create the marker texture
    local marker = mapFrame:CreateTexture(nil, "ARTWORK")
    -- marker:ClearAllPoints()

    marker:SetTexture("Interface\\Buttons\\UI-GuildButton-PublicNote-Up")
    marker:SetWidth(14)
    marker:SetHeight(14)
    -- marker:SetPoint("CENTER", mapFrame, "TOPLEFT", posX * mapFrame:GetWidth(), -posY * mapFrame:GetHeight())

    local x = posX * mapFrame:GetWidth()
    local y = -posY * mapFrame:GetHeight()
    marker:SetPoint("CENTER", mapFrame, "TOPLEFT", x, y)

    -- marker:SetFrameLevel(MiniMapTrackingFrame:GetFrameLevel());

    if posX and posY and zone then
        -- local globalX, globalY = posX * 10000, posY * 10000
        -- DEFAULT_CHAT_FRAME:AddMessage("Player global position: " .. zone .. " (" .. globalX .. ", " .. globalY .. ")")
        DEFAULT_CHAT_FRAME:AddMessage("Player global position: " .. zone .. " (" .. posX * 1000 .. ", " .. posY * 1000 .. ")")
    end

    DEFAULT_CHAT_FRAME:AddMessage("**********************************************")
end

local function pingLocationOnMinimap(x, y)
    Minimap:PingLocation(x, y)
end

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if PersonalDiary == nil then
            PersonalDiary = {
                enabled = false,
                config = {},
                diary = {}
            }
        end
    end

    PersonalDiary.enabled = true

    getCurrentPlayerLocation()
    pingLocationOnMinimap(10, 10)
end)

-- Frame for
