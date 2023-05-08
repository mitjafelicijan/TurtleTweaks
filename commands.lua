-- Adds the following commands that lists:
-- * /addons: all loaded addons.
-- * /reloadui, /reload, and /rl: reloads the UI.
-- Author: Mitja Felicijan (m@mitjafelicijan.com)

local frame = CreateFrame("FRAME")
frame:SetAllPoints(UIParent)

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if Commands == nil then
            Commands = {}
            Commands["enabled"] = false
            Commands["config"] = {}
        end

        -- Registers the slash commands.
        if Commands and Commands["enabled"] then
            frame.reloadUI()
            frame.listAddons()
            frame.alignGrid()
        end
    end
end)

-- Reloads the UI.
frame.reloadUI = function()
    SLASH_TweeksReload1 = "/reloadui"
    SLASH_TweeksReload2 = "/reload"
    SLASH_TweeksReload3 = "/rl"

    SlashCmdList["TweeksReload"] = function(msg, editbox)
        ConsoleExec("reloadui")
    end
end

-- List of all the addons.
frame.listAddons = function()
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

-- Adds aling grid to the screen.
frame.alignGrid = function()
    SLASH_TweeksAlign1 = "/align"

    local grid = nil
    local gridVisible = false
    local quadSize = 64
    local lineWeight = 1.1
    local primaryLinesAlpha = 1.0
    local secondaryLinesAlpha = 0.7

    function generateGrid()
        grid = CreateFrame("Frame", nil, UIParent)
        grid.boxSize = quadSize
        grid:SetAllPoints(UIParent)
        grid:Hide()

        local windowWidth = GetScreenWidth() * 2
        local ratio = windowWidth / GetScreenHeight()
        local windowHeight = GetScreenHeight() * ratio * 2

        function drawVerticalLine(centerOffset, r, g, b, a)
            local tex = grid:CreateTexture(nil, "BACKGROUND")
            tex:SetTexture(r, g, b, a)
            tex:SetWidth(lineWeight)
            tex:SetHeight(windowHeight)
            tex:SetPoint("CENTER", grid, "CENTER", centerOffset, 0)
        end

        function drawHorizontalLine(centerOffset, r, g, b, a)
            local tex = grid:CreateTexture(nil, "BACKGROUND")
            tex:SetTexture(r, g, b, a)
            tex:SetWidth(windowHeight)
            tex:SetHeight(lineWeight)
            tex:SetPoint("CENTER", grid, "CENTER", 0, centerOffset)
        end

        -- Drawing center lines.
        drawVerticalLine(0, 1, 0, 1, primaryLinesAlpha)
        drawHorizontalLine(0, 1, 0, 1, primaryLinesAlpha)

        -- Drawing other vertical lines.
        local verticalSteps = math.ceil(windowWidth / quadSize)
        for i = 1, verticalSteps do
            local offset = i * quadSize
            drawVerticalLine(offset, 0, 0, 0, secondaryLinesAlpha)
            drawVerticalLine(-offset, 0, 0, 0, secondaryLinesAlpha)
        end

        -- Drawing other horizontal lines.
        local horizontalSteps = math.ceil(windowHeight / quadSize)
        for i = 1, horizontalSteps do
            local offset = i * quadSize
            drawHorizontalLine(offset, 0, 0, 0, secondaryLinesAlpha)
            drawHorizontalLine(-offset, 0, 0, 0, secondaryLinesAlpha)
        end
    end

    -- Create grid in case it doesn't exist.
    if grid == nil then
        generateGrid()
    end

    SlashCmdList["TweeksAlign"] = function(msg, editbox)
        if gridVisible then
            grid:Hide()
            gridVisible = false
        else
            grid:Show()
            gridVisible = true
        end
    end
end


-- Holds all the UI elements for settings.
CommandsUI = {}
CommandsUI["enabled"] = nil

CommandsUI.form = function(container, verticalOffset)
    CommandsUI["enabled"] = CreateFrame("CheckButton", "Checkbox", container, "UICheckButtonTemplate")
    CommandsUI["enabled"]:SetPoint("TOPLEFT", 20, verticalOffset)
    CommandsUI["enabled"]:SetChecked(Commands["enabled"])

    local titleLabel = CommandsUI["enabled"]:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleLabel:SetPoint("LEFT", CommandsUI["enabled"], "RIGHT", 10, 7)
    titleLabel:SetText("Helper commands")

    local descriptionLabel = CommandsUI["enabled"]:CreateFontString("Status", "LOW", "GameFontHighlightSmall")
    descriptionLabel:SetPoint("LEFT", CommandsUI["enabled"], "RIGHT", 10, -7)
    descriptionLabel:SetText("Enables commands: /addons, /rl, /align.")
end

CommandsUI.save = function()
    Commands["enabled"] = (CommandsUI["enabled"]:GetChecked() and true or false)
end

CommandsUI.cancel = function()
    CommandsUI["enabled"]:SetChecked(Commands["enabled"])
end

CommandsUI.reset = function()
    Commands["enabled"] = false
end
