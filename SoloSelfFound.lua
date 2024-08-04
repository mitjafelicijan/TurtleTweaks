local feature = ns.Register({
  identifier = "SoloSelfFound",
  description = "Solo Self-Found - Disables auction house, mail and trade.",
  category = "automation",
  config = {},
  data = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("AUCTION_HOUSE_SHOW")
frame:RegisterEvent("MAIL_SHOW")
frame:RegisterEvent("TRADE_REQUEST")
frame:RegisterEvent("TRADE_SHOW")
frame:RegisterEvent("PARTY_INVITE_REQUEST")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end
  
  if event == "AUCTION_HOUSE_SHOW" then
    CloseAuctionHouse()
    CloseAllBags()
  end

  if event == "MAIL_SHOW" then
    CloseMail()
    CloseAllBags()
  end

  if event == "TRADE_SHOW" or event == "TRADE_REQUEST" then
    CloseTrade()
    CloseAllBags()
    SendChatMessage("Sorry, I'm doing Solo Self-Found.", "SAY")
  end

  if event == "PARTY_INVITE_REQUEST" then
    DeclineGroup()
    StaticPopup_Hide("PARTY_INVITE")
    SendChatMessage("Sorry, I'm doing Solo Self-Found.", "SAY")
  end
end)

