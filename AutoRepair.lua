local feature = ns.Register({
  identifier = "AutoRepair",
  description = "Automatically initiates gear repairs upon interacting with a merchant.",
  category = "automation",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("MERCHANT_SHOW")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  if IsShiftKeyDown() then return end
  if CanMerchantRepair() then
    local RepairCost, CanRepair = GetRepairAllCost()
    if RepairCost > 0 and GetMoney() >= RepairCost then
      RepairAllItems()
      print(string.format("|cff00ff00Gear repaired: |cffffffff%s", GetCoinText(RepairCost)))
    end
  end
end)
