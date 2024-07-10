local feature = ns.Register({
  identifier = "EnvironmentGlow",
  description = "Disable screen glow which makes the environment less hazy.",
  category = "interface",
  config = {}
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then
    -- Reset to default game values.
    SlashCmdList["CONSOLE"]("ffxGlow 1")
    return
  end

  SlashCmdList["CONSOLE"]("ffxGlow 0")
end)
