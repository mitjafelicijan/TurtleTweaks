local feature = ns.Register({
  identifier = "ItemLevel",
  description = "Shows item level and quality.",
  category = "interface",
  config = {
    quality = {
      [0] = {r = 0.5, g = 0.5, b = 0.5, key = "Poor" },      -- Poor (Gray)
      [1] = {r = 1.0, g = 1.0, b = 1.0, key = "Common" },    -- Common (White)
      [2] = {r = 0.1, g = 1.0, b = 0.1, key = "Uncommon" },  -- Uncommon (Green)
      [3] = {r = 0.0, g = 0.4, b = 1.0, key = "Rare" },      -- Rare (Blue)
      [4] = {r = 1.0, g = 0.1, b = 1.0, key = "Epic" },      -- Epic (Purple)
      [5] = {r = 1.0, g = 0.5, b = 0.0, key = "Legendary" }, -- Legendary (Orange)
    },
    slots = {
      "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot",
      "TabardSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot",
      "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot", "MainHandSlot",
      "SecondaryHandSlot", "RangedSlot"
    }
  }
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("BAG_UPDATE")
frame:RegisterEvent("UNIT_INVENTORY_CHANGED")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  -- Bag item levels.
  do
    -- Clear all existing labels.
    for bagID = 0, NUM_BAG_SLOTS do
      local numSlots = GetContainerNumSlots(bagID)
      for slotIndex = 1, numSlots do
        local slotFrameName = "ContainerFrame" .. (bagID + 1) .. "Item" .. (numSlots - slotIndex) + 1 .. "ItemLevelLabel"
        local label = _G[slotFrameName]
        if label then
          label:SetParent(nil)
          _G[slotFrameName] = nil
        end
      end
    end

    -- Add item level labels.
    for bagID = 0, NUM_BAG_SLOTS do
      local numSlots = GetContainerNumSlots(bagID)
      for slotIndex = 1, numSlots do
        local frameID = "ContainerFrame" .. (bagID + 1) .. "Item" .. (numSlots - slotIndex) + 1
        local link = GetContainerItemLink(bagID, slotIndex)

        if link then
          local _, _, _, itemID = string.find(link, "|c%x+|H(item:(%d+):%d+:%d+:%d+)|h%[.-%]|h|r")
          local itemName, _, itemQuality, itemType, _, _, _, itemEquipLoc = GetItemInfo(itemID)

          if itemEquipLoc ~= "" then
            local weaponItemData = WoWCodexWeapons[itemID]
            local armorItemData = WoWCodexArmor[itemID]
            local itemData = weaponItemData or armorItemData
            
            if itemData then
              local quality = feature.config.quality[tonumber(itemData.Quality)]
              local slotFrame = _G[frameID]
              local slotFrameName = frameID .. "ItemLevelLabel"
              local label = slotFrame:CreateFontString(slotFrameName, "OVERLAY", "NumberFontNormal")
              label:SetText(itemData.ItemLevel)
              label:SetPoint("TOPLEFT", 2, -2)
              label:SetTextColor(quality.r, quality.g, quality.b)
              label:SetShadowColor(0, 0, 0, 1)
            end
          end
        end
      end
    end
  end

  -- Uquiped inventory.
  do
    -- Clear all existing labels.
    for _, slotName in ipairs(feature.config.slots) do
      local slotFrameName = "Character" .. slotName .. "ItemLevelLabel"
      local label = _G[slotFrameName]
      if label then
        label:SetParent(nil)
        _G[slotFrameName] = nil
      end
    end

    -- Add item level labels.
    for _, slotName in ipairs(feature.config.slots) do
      local slotID = GetInventorySlotInfo(slotName)
      local link = GetInventoryItemLink("player", slotID)

      if link then
        local _, _, _, itemID = string.find(link, "|c%x+|H(item:(%d+):%d+:%d+:%d+)|h%[.-%]|h|r")
        local weaponItemData = WoWCodexWeapons[itemID]
        local armorItemData = WoWCodexArmor[itemID]
        local itemData = weaponItemData or armorItemData
        
        if itemData then
          local quality = feature.config.quality[tonumber(itemData.Quality)]
          local slotFrame = _G["Character" .. slotName]
          local slotFrameName = "Character" .. slotName .. "ItemLevelLabel"
          local label = slotFrame:CreateFontString(slotFrameName, "OVERLAY", "NumberFontNormal")
          label:SetText(itemData.ItemLevel)
          label:SetPoint("TOPLEFT", 2, -2)
          label:SetTextColor(quality.r, quality.g, quality.b)
          label:SetShadowColor(0, 0, 0, 1)
        end
      end
    end
  end

end)
