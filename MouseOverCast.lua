local feature = ns.Register({
  identifier = "MouseOverCast",
  description = "Enables /stcast command that uses mouseover to detect the unit.",
  category = "utility",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

local function MouseoverUnit()
  local unit = "mouseover"

  if not UnitExists(unit) then
    local frame = GetMouseFocus()
    local fparent = frame:GetParent()
    if frame.label and frame.id then
      unit = frame.label .. frame.id
    elseif frame.unit then
      unit = frame.unit
    elseif fparent and fparent.unit then
      unit = fparent.unit
    elseif UnitExists("target") then
      unit = "target"
    elseif GetCVar("autoSelfCast") == "1" then
      unit = "player"
    else
      unit = nil
    end
  end

  return unit
end 

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  do
    SLASH_STCAST1 = "/stcast"
    SlashCmdList["STCAST"] = function(msg, editbox)
      local spell = msg or nil
      local unit = MouseoverUnit()
      
      if unit and spell then
        TargetUnit(unit)
        SpellTargetUnit(unit)
        CastSpellByName(spell)
        TargetLastTarget()
      end
    end
  end
end)
