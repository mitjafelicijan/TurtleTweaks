local feature = ns.Register({
  identifier = "NameplatePosition",
  description = "Adjusts nameplate position to not overlap with mobs.",
  category = "interface",
  config = {
    nameplate = {
      base = 115,
      notch = 25,
      height = 35,
      scaleTweak = 0.05,
    }
  }
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

local function IsNamePlateFrame(frame)
  local overlayRegion = frame:GetRegions()
  if not overlayRegion or overlayRegion:GetObjectType() ~= "Texture" or overlayRegion:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
    return false
  end
  return true
end

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end
end)

frame:SetScript("OnUpdate", function()
  if not ns.IsEnabled(feature.identifier) then return end
  
  local frames = {WorldFrame:GetChildren()}
--   local scale = UIParent:GetScale() - feature.config.nameplate.scaleTweak
  
  for _, nameplate in ipairs(frames) do
    if IsNamePlateFrame(nameplate) then
      DebugPlaceholder(nameplate, 0, 0, 1, 0.3)
      nameplate:ClearAllPoints()
--       nameplate:SetPoint("TOP", -300)  
      
--       nameplate:SetHeight(300)


--       local HealthBar = nameplate:GetChildren()
--       local Border, Glow, Name, Level = nameplate:GetRegions()

--       nameplate:SetWidth((feature.config.nameplate.base + feature.config.nameplate.notch) * scale)
--       nameplate:SetHeight(feature.config.nameplate.height * scale)
-- 
--       HealthBar:ClearAllPoints()
--       HealthBar:SetWidth(feature.config.nameplate.base * scale)
--       HealthBar:SetHeight(((feature.config.nameplate.height / 2) - (5 * scale)) * scale)
--       HealthBar:SetPoint("BOTTOM", nameplate, "BOTTOM", -(8 * scale), (2 * scale))
-- 
--       Name:ClearAllPoints()
--       Name:SetFont(STANDARD_TEXT_FONT, (12 * scale), "OUTLINE")
--       Name:SetPoint("BOTTOM", nameplate, "BOTTOM", 0, (16 * scale) + (3 * scale))
--       Name:SetShadowColor(0, 0, 0, .3)
-- 
--       Level:ClearAllPoints()
--       Level:SetPoint("BOTTOM", nameplate, "BOTTOM", (((feature.config.nameplate.base / 2)) * scale), ((feature.config.nameplate.height / 2) * scale) - (12 * scale))
--       Level:SetFont(UNIT_NAME_FONT, (9 * scale), "OUTLINE")
--       Level:SetShadowColor(0, 0, 0, .3)
    end
  end
end)
