-- https://forum.nostalrius.org/viewtopic.php?t=1100&f=32
-- If game was started with `-console` open shell with backtick and
-- type `gxRestart` to restart the graphics engine.

local feature = ns.Register({
  identifier = "GameplaySmoothness",
  description = "Optimises for smoother gameplay. Requires game restart.",
  category = "utility",
  config = {
    cmds = {
      "bspcache",
      "gxTripleBuffer",
      "M2UsePixelShaders",
      "M2UseZFill",
      "M2UseClipPlanes",
      "M2UseThreads",
      "M2UseShaders",
      "M2BatchDoodads",
    },
  },
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then
    -- Reset to default game values.
    for _, cmd in pairs(feature.config.cmds) do
      SlashCmdList["CONSOLE"](string.format("%s 0", cmd))
    end
    return
  end

  SlashCmdList["CONSOLE"]("M2Faster 3") -- Quad-core and above.
  for _, cmd in pairs(feature.config.cmds) do
    SlashCmdList["CONSOLE"](string.format("%s 1", cmd))
  end
end)
