local config = {
  loaded = false,
  yOffset = 0, -- Starting offset.
  title = "Turtle Tweaks",
  width = 600,
  height = 500,
  categories = {
    interface = { label = "Interface", items = {} },
    utility = { label = "Utilities", items = {} },
    social = { label = "Social & Chat", items = {} },
    automation = { label = "Automation", items = {} },
  }
}

local frame = CreateFrame("FRAME", nil, UIParent)

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
  if event == "ADDON_LOADED" and not config.loaded then
    frame:EnableMouse(true)
    frame:Hide()

    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetWidth(config.width)
    frame:SetHeight(config.height)

    -- Create a backdrop for our addon.
    frame:SetBackdrop({
      bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
      edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
      tile = true,
      tileSize = 32,
      edgeSize = 32,
      insets = {
        left = 11,
        right = 12,
        top = 12,
        bottom = 11
      }
    })

    -- Add a title to the frame.
    frame.title = CreateFrame("Frame", nil, frame)
    frame.title:SetPoint("TOP", frame, "TOP", 0, 12)
    frame.title:SetWidth(256)
    frame.title:SetHeight(64)

    -- Create a backdrop for the title.
    frame.title.tex = frame.title:CreateTexture(nil, "MEDIUM")
    frame.title.tex:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    frame.title.tex:SetAllPoints()

    -- Create a font string for the title.
    frame.title.text = frame.title:CreateFontString(nil, "HIGH", "GameFontNormal")
    frame.title.text:SetText("Turtle Tweaks")
    frame.title.text:SetPoint("TOP", 0, -14)

    -- Create scrollable frame.
    frame.scrollFrame = CreateFrame("ScrollFrame", "TurtleTweaksSettings", frame, "UIPanelScrollFrameTemplate")
    frame.scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -40)
    frame.scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -36, 52)

    local child = CreateFrame("Frame", nil, frame.scrollFrame)
    child:SetWidth(frame:GetWidth())
    child:SetHeight(frame:GetHeight() - 100)
    frame.scrollFrame:SetScrollChild(child)
    
    -- Move features to categories.
    for _, item in ipairs(ns.Features) do
      tinsert(config.categories[item.category].items, item)
    end

    -- Render categories and options.
    local yOffset = config.yOffset
    for name, data in pairs(config.categories) do
      yOffset = yOffset + 10

      local title = child:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
      title:SetPoint("TOPLEFT", 30, -yOffset)
      title:SetText(data.label)
      yOffset = yOffset + 20

      for _, item in ipairs(data.items) do
        local checkbox = CreateFrame("CheckButton", nil, child, "UICheckButtonTemplate")
        checkbox:SetPoint("TOPLEFT", 40, -yOffset)
        checkbox.identifier = item.identifier
      
        if TurtleTweaksDB[item.identifier] ~= nil then
          checkbox:SetChecked(TurtleTweaksDB[item.identifier])
        end

        local label = checkbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        label:SetPoint("LEFT", checkbox, "RIGHT", 5, 1)
        label:SetText(item.description)
        
        checkbox:SetScript("OnClick", function(self)
          local checked = checkbox:GetChecked()
          if checked then
            TurtleTweaksDB[checkbox.identifier] = true
          else
            TurtleTweaksDB[checkbox.identifier] = false
          end
        end)

        yOffset = yOffset + 30
      end
    end

    local apply = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    apply:SetPoint("BOTTOMRIGHT", -20, 18)
    apply:SetWidth(70)
    apply:SetHeight(22)
    apply:SetText("Apply")
    apply:SetScript("OnClick", function(self)
      ReloadUI()
    end)

    local cancel = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    cancel:SetPoint("BOTTOMRIGHT", -100, 18)
    cancel:SetWidth(70)
    cancel:SetHeight(22)
    cancel:SetText("Cancel")
    cancel:SetScript("OnClick", function(self)
      frame:Hide()
    end)

    -- Add a button to the game menu that opens our addon frame when clicked.
    local mainMenuButton = CreateFrame("Button", nil, GameMenuFrame, "GameMenuButtonTemplate")
    mainMenuButton:SetPoint("TOP", GameMenuButtonUIOptions, "BOTTOM", 0, -20)
    mainMenuButton:SetText("Turtle Tweaks")
    mainMenuButton:SetScript("OnClick", function()
      HideUIPanel(GameMenuFrame)
      frame:Show()
    end)

    -- Add a button to the game menu that opens our addon frame when clicked.
    GameMenuButtonKeybindings:ClearAllPoints()
    GameMenuButtonKeybindings:SetPoint("TOP", mainMenuButton, "BOTTOM", 0, -1)
    GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + 30)
    
    do
      SLASH_TT1 = "/tt"
      SlashCmdList["TT"] = function(msg, editbox)
        if frame:IsVisible() then
          frame:Hide()
        else
          frame:Show()
        end
      end
    end
    
    config.loaded = true
  end
end)
