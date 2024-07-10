local feature = ns.Register({
  identifier = "ChatArrowKeys",
  description = "Allows arrow keys to be used in chat windows.",
  category = "social",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end
  ChatFrameEditBox:SetAltArrowKeyMode(false);
end)
