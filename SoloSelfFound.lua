local feature = ns.Register({
  identifier = "SoloSelfFound",
  description = "Solo Self Found - Disables auction house and mail.",
  category = "automation",
  config = {},
  data = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("AUCTION_HOUSE_SHOW")
frame:RegisterEvent("MAIL_SHOW")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end
  
  if event == "AUCTION_HOUSE_SHOW" then
    CloseAuctionHouse()
  end

  if event == "MAIL_SHOW" then
    CloseMail()
  end
end)

