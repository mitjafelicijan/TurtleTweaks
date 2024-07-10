local feature = ns.Register({
  identifier = "SellGrayItems",
  description = "Automatically sells gray items when visiting merchant.",
  category = "automation",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("MERCHANT_SHOW")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  if event == "MERCHANT_SHOW" then
    for bagID = 0, NUM_BAG_SLOTS do
      for slotIndex = 1, GetContainerNumSlots(bagID) do
        local name = GetContainerItemLink(bagID, slotIndex)
        if name and string.find(name,"ff9d9d9d") then 
          print(string.format("|cff00ff00Item sold: %s", name))
          UseContainerItem(bagID, slotIndex)
        end
      end
    end
  end
end)
