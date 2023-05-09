-- Last Modified: 2023-05-09
-- Contents: Adds a button to the mail window that allows the user to open all mail at once.

local frame = CreateFrame("FRAME")

local requestedMailOpening = false
local openingMailInProgress = false
local currentMailIndex = 1

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("MAIL_INBOX_UPDATE")

frame:SetScript("OnEvent", function()
    -- Fallback to default behavior if the user has disabled this feature.
    if event == "ADDON_LOADED" then
        if OpenMail == nil then
            OpenMail = {}
            OpenMail["enabled"] = false
            OpenMail["config"] = {}
        end

        -- Adds the button to the mail window.
        if OpenMail and OpenMail["enabled"] then
            -- ReturnInboxItem(1)

            local openAllMail = CreateFrame("Button", "TweaksOpenMailButton", InboxFrame, "UIPanelButtonTemplate")
            openAllMail:SetPoint("CENTER", InboxFrame, "CENTER", -10, -155)
            openAllMail:SetHeight(25)
            openAllMail:SetWidth(120)
            openAllMail:SetText("Open All Mail")
            openAllMail:SetScript("OnClick", function()
                -- If opening mail is already in progress, do nothing.
                if openingMailInProgress then
                    DEFAULT_CHAT_FRAME:AddMessage("Opening mail is already in progress.")
                    return
                end

                requestedMailOpening = true
                openingMailInProgress = true
                openNextMail()
            end)
        end
    end

    if OpenMail and OpenMail["enabled"] then
        if event == "MAIL_INBOX_UPDATE" then
            if requestedMailOpening then
                openNextMail()
            end
        end
    end
end)

function openNextMail()
    DEFAULT_CHAT_FRAME:AddMessage("Opening mail " .. tostring(currentMailIndex))

    -- Check if all mail has been opened.
    if currentMailIndex > GetInboxNumItems() then
        DEFAULT_CHAT_FRAME:AddMessage("Finished opening mail.")
        openingMailInProgress = false
        return
    end
end

-- openMailAtIndex(1)

-- DEFAULT_CHAT_FRAME:AddMessage("Open All Mail: " .. tostring(GetInboxNumItems()) .. " mails")

-- -- Hack to prevent beancounter from deleting mail from another Mail Addon
-- local TakeInboxMoney, TakeInboxItem, DeleteInboxItem = TakeInboxMoney, TakeInboxItem, DeleteInboxItem

-- for i = 1, GetInboxNumItems() do
--     -- CODAmount - The amount of COD payment required to receive the package.
--     local _, _, _, _, _, CODAmount, _, _, _, _, _, _, isGM = GetInboxHeaderInfo(i)

--     if CODAmount > 0 or isGM then
--         DEFAULT_CHAT_FRAME:AddMessage("Skipping mail " .. tostring(i) .. " because it is COD or from a GM.")
--     end

--     -- GetInboxText(i)
--     -- TakeInboxMoney(i)
--     -- TakeInboxItem(i)
--     -- DeleteInboxItem(i)
-- end
