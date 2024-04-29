local feature = ns.Register({
  identifier = "ManabarColor",
  description = "Changes default color of mana power bar.",
  category = "interface",
  config = {},
  data = {
    HookUnitFrame_UpdateManaType = nil
  }
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  if not HookUnitFrame_UpdateManaType then
    local HookUnitFrame_UpdateManaType = UnitFrame_UpdateManaType
    function UnitFrame_UpdateManaType(uf)
      HookUnitFrame_UpdateManaType(uf)
      if not uf then uf = this end
      local mb = uf.unit and uf.manabar
      if not mb then return end

      if (UnitPowerType(uf.unit) == 0) then
        mb:SetStatusBarColor(ns.Config.ManaBarColor.r, ns.Config.ManaBarColor.g, ns.Config.ManaBarColor.b)
      end
    end
  end
end)
