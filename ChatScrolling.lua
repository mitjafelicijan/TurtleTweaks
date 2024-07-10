local feature = ns.Register({
  identifier = "ChatScrolling",
  description = "Allows to scroll in chat using the mouse wheel.",
  category = "social",
  config = {
    scrollSpeed = 1,
  }
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

local function ChatOnMouseWheel()
  if arg1 > 0 then
    if IsShiftKeyDown() then
      this:ScrollToTop()
    else
      for i=1, feature.config.scrollSpeed do
        this:ScrollUp()
      end
    end
  elseif arg1 < 0 then
    if IsShiftKeyDown() then
      this:ScrollToBottom()
    else
      for i=1, feature.config.scrollSpeed do
        this:ScrollDown()
      end
    end
  end
end

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  for i=1, NUM_CHAT_WINDOWS do
    _G["ChatFrame" .. i]:EnableMouseWheel(true)
    _G["ChatFrame" .. i]:SetScript("OnMouseWheel", ChatOnMouseWheel)
  end
end)
