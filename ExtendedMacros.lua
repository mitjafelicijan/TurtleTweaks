local feature = ns.Register({
  identifier = "ExtendedMacros",
  description = "Adds a bunch of macros making it more like Classic client.",
  category = "utility",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  do
    SLASH_CANCELFORM1 = "/cancelform"
    SlashCmdList["CANCELFORM"] = function(msg, editbox)
      -- Druid forms.
      for i = 1, GetNumShapeshiftForms() do
        _, _, active, _ = GetShapeshiftFormInfo(i)
        if active ~= nil then
          CastShapeshiftForm(i)
        end
      end

      -- Priest Shadowform aura.
      for i = 1, 15 do
        buffTexture = GetPlayerBuffTexture(i)
        if buffTexture ~= nil then
          startPos, endPos = string.find(buffTexture, "Spell_Shadow_Shadowform")
          if startPos ~= nil and endPos ~= nil then CancelPlayerBuff(i) end
        end
      end
    end
  end

  do
    SLASH_DISMOUNT1 = "/dismount"
    SlashCmdList["DISMOUNT"] = function(msg, editbox)
      for i = 1, 15 do
        buffTexture = GetPlayerBuffTexture(i)
        if buffTexture ~= nil then
          -- Normal mounts.
          startPos, endPos = string.find(buffTexture, "Ability_Mount")
          if startPos ~= nil and endPos ~= nil then CancelPlayerBuff(i) end
          -- Turtle mounts.
          startPos, endPos = string.find(buffTexture, "inv_pet_speedy")
          if startPos ~= nil and endPos ~= nil then CancelPlayerBuff(i) end
        end
      end
    end
  end

  do
    SLASH_USE1 = "/use"
    SlashCmdList["USE"] = function(msg, editbox)
      for bagID = 0, NUM_BAG_SLOTS do
        for slotIndex = 1, GetContainerNumSlots(bagID) do
          local name = GetContainerItemLink(bagID, slotIndex)
          if name and string.find(name, msg) then 
            UseContainerItem(bagID, slotIndex)
          end
        end
      end
    end
  end
end)
