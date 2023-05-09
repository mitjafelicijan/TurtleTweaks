local function MoveBuffsDebuffs()
    -- Find the target frame
    local targetFrame = TargetFrame
    if not targetFrame then
        return
    end

    -- Get all the child frames of the target frame
    local children = { targetFrame:GetChildren() }

    -- Filter out the buff frames
    local buffFrames = {}
    for _, child in ipairs(children) do
        if child:GetObjectType() == "Button" and child:GetName() and string.find(child:GetName(), "Buff") then
            table.insert(buffFrames, child)
        end
    end

    -- Filter out the debuff frames
    local debuffFrames = {}
    for _, child in ipairs(children) do
        if child:GetObjectType() == "Button" and child:GetName() and string.find(child:GetName(), "Debuff") then
            table.insert(debuffFrames, child)
        end
    end

    -- DEFAULT_CHAT_FRAME:AddMessage("+++++++++++++++++++++++++++++++++")
    for _, child in ipairs(children) do
        -- DEFAULT_CHAT_FRAME:AddMessage(child:GetName())
    end

    -- Loop through the buff frames and move them to the top of the target frame
    for i, buffFrame in ipairs(buffFrames) do
        buffFrame:ClearAllPoints()
        if i == 1 then
            buffFrame:SetPoint("TOPLEFT", targetFrame, "TOPLEFT", 5, 2)
        else
            buffFrame:SetPoint("LEFT", buffFrames[i - 1], "RIGHT", 2, 0)
        end
    end

    -- Loop through the debuff frames and move them to the top of the target frame
    for i, debuffFrame in ipairs(debuffFrames) do
        -- DEFAULT_CHAT_FRAME:AddMessage("> " .. debuffFrame:GetName())
        debuffFrame:ClearAllPoints()
        if i == 1 then
            debuffFrame:SetPoint("TOPLEFT", targetFrame, "TOPLEFT", 5, 0)
        else
            debuffFrame:SetPoint("LEFT", debuffFrames[i - 1], "RIGHT", 2, 0)
        end
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", MoveBuffsDebuffs)
