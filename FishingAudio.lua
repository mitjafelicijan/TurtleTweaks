local feature = ns.Register({
  identifier = "FishingAudio",
  description = "Enhances audio while fishing making it easier to hear bait splash.",
  category = "profession",
  config = {
    master = 1,
    music = 0,
    sound = 1,
    ambience = 0,
  },
  data = {
    fishingInProgress = false,
    master = 0,
    music = 0,
    sound = 0,
    ambience = 0,
  }
})

local function saveSoundSettings()
  feature.data.master = GetCVar("MasterVolume")
  feature.data.music = GetCVar("MusicVolume")
  feature.data.sound = GetCVar("SoundVolume")
  feature.data.ambience = GetCVar("AmbienceVolume")
end

local function restoreSoundSettings()
  SetCVar("MasterVolume", feature.data.master)
  SetCVar("MusicVolume", feature.data.music)
  SetCVar("SoundVolume", feature.data.sound)
  SetCVar("AmbienceVolume", feature.data.ambience)
end

local function fishingSoundSettings()
  SetCVar("MasterVolume", feature.config.master)
  SetCVar("MusicVolume", feature.config.music)
  SetCVar("SoundVolume", feature.config.sound)
  SetCVar("AmbienceVolume", feature.config.ambience)
end

local frame = CreateFrame("Frame")

frame:RegisterEvent("SPELLCAST_CHANNEL_START")
frame:RegisterEvent("SPELLCAST_CHANNEL_STOP")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  if event == "SPELLCAST_CHANNEL_START" then
    if CastingBarText ~= nil and CastingBarText:GetText() == "Fishing" then
      saveSoundSettings()
      fishingSoundSettings()
      feature.data.fishingInProgress = true
    end
  end

  if event == "SPELLCAST_CHANNEL_STOP" then
    if feature.data.fishingInProgress then
      restoreSoundSettings()
      feature.data.fishingInProgress = false
    end
  end
end)
