local feature = ns.Register({
  identifier = "CompareTooltip",
  description = "Shows compare tooltips while the shift key is pressed.",
  category = "interface",
  config = {},
})

local frame = CreateFrame("Frame", nil, GameTooltip)

local itemtypes = {
  ["enUS"] = {
    ["INVTYPE_WAND"] = "Wand",
    ["INVTYPE_THROWN"] = "Thrown",
    ["INVTYPE_GUN"] = "Gun",
    ["INVTYPE_CROSSBOW"] = "Crossbow",
    ["INVTYPE_PROJECTILE"] = "Projectile",
  },
}

-- set globals for all inventory types
for key, value in pairs(itemtypes[GetLocale()]) do setglobal(key, value) end
INVTYPE_WEAPON_OTHER = INVTYPE_WEAPON.."_other";
INVTYPE_FINGER_OTHER = INVTYPE_FINGER.."_other";
INVTYPE_TRINKET_OTHER = INVTYPE_TRINKET.."_other";

local slots = {
  [INVTYPE_2HWEAPON] = "MainHandSlot",
  [INVTYPE_BODY] = "ShirtSlot",
  [INVTYPE_CHEST] = "ChestSlot",
  [INVTYPE_CLOAK] = "BackSlot",
  [INVTYPE_FEET] = "FeetSlot",
  [INVTYPE_FINGER] = "Finger0Slot",
  [INVTYPE_FINGER_OTHER] = "Finger1Slot",
  [INVTYPE_HAND] = "HandsSlot",
  [INVTYPE_HEAD] = "HeadSlot",
  [INVTYPE_HOLDABLE] = "SecondaryHandSlot",
  [INVTYPE_LEGS] = "LegsSlot",
  [INVTYPE_NECK] = "NeckSlot",
  [INVTYPE_RANGED] = "RangedSlot",
  [INVTYPE_RELIC] = "RangedSlot",
  [INVTYPE_ROBE] = "ChestSlot",
  [INVTYPE_SHIELD] = "SecondaryHandSlot",
  [INVTYPE_SHOULDER] = "ShoulderSlot",
  [INVTYPE_TABARD] = "TabardSlot",
  [INVTYPE_TRINKET] = "Trinket0Slot",
  [INVTYPE_TRINKET_OTHER] = "Trinket1Slot",
  [INVTYPE_WAIST] = "WaistSlot",
  [INVTYPE_WEAPON] = "MainHandSlot",
  [INVTYPE_WEAPON_OTHER] = "SecondaryHandSlot",
  [INVTYPE_WEAPONMAINHAND] = "MainHandSlot",
  [INVTYPE_WEAPONOFFHAND] = "SecondaryHandSlot",
  [INVTYPE_WRIST] = "WristSlot",
  [INVTYPE_WAND] = "RangedSlot",
  [INVTYPE_GUN] = "RangedSlot",
  [INVTYPE_PROJECTILE] = "AmmoSlot",
  [INVTYPE_CROSSBOW] = "RangedSlot",
  [INVTYPE_THROWN] = "RangedSlot",
}

local function ShowCompare(tooltip)
  -- abort if shift is not pressed
  if not IsShiftKeyDown() then
    ShoppingTooltip1:Hide()
    ShoppingTooltip2:Hide()
    return
  end

  for i=1,tooltip:NumLines() do
    local tmpText = _G[tooltip:GetName() .. "TextLeft"..i]

    for slotType, slotName in pairs(slots) do
      if tmpText:GetText() == slotType then
        local slotID = GetInventorySlotInfo(slotName)

        -- determine screen part
        local x = GetCursorPosition() / UIParent:GetEffectiveScale()
        local anchor = x < GetScreenWidth() / 2 and "BOTTOMLEFT" or "BOTTOMRIGHT"
        local relative = x < GetScreenWidth() / 2 and "BOTTOMRIGHT" or "BOTTOMLEFT"

        -- overwrite position for tooltips without owner
        local pos, parent = tooltip:GetPoint()
        if parent and parent == UIParent and pos == "BOTTOMRIGHT" then
          anchor = "BOTTOMRIGHT"
          relative = "BOTTOMLEFT"
        end

        -- first tooltip
        ShoppingTooltip1:SetOwner(tooltip, "ANCHOR_NONE");
        ShoppingTooltip1:ClearAllPoints();
        ShoppingTooltip1:SetPoint(anchor, tooltip, relative, 0, 0);
        ShoppingTooltip1:SetInventoryItem("player", slotID)
        ShoppingTooltip1:Show()

        -- second tooltip
        if slots[slotType .. "_other"] then
          local slotID_other = GetInventorySlotInfo(slots[slotType .. "_other"])
          ShoppingTooltip2:SetOwner(tooltip, "ANCHOR_NONE");
          ShoppingTooltip2:ClearAllPoints();
          ShoppingTooltip2:SetPoint(anchor, ShoppingTooltip1, relative, 0, 0);
          ShoppingTooltip2:SetInventoryItem("player", slotID_other)
          ShoppingTooltip2:Show();
        end
      end
    end
  end
end

frame:SetScript("OnUpdate", function()
  if not ns.IsEnabled(feature.identifier) then return end
  ShowCompare(GameTooltip)
end)
