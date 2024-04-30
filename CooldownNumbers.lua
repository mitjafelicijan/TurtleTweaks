local feature = ns.Register({
  identifier = "CooldownNumbers",
  description = "Display the remaining duration on every cooldown.",
  category = "interface",
  config = {
    minDuration = 3,
  },
  data = {
    CooldownFrame_SetTimer = nil, 
  }
})

local frame = CreateFrame("Frame")

frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function()
  if not ns.IsEnabled(feature.identifier) then return end

  if not feature.data.CooldownFrame_SetTimer then
    feature.data.CooldownFrame_SetTimer = CooldownFrame_SetTimer
    CooldownFrame_SetTimer = function(cooldownFrame, start, duration, enable)
      feature.data.CooldownFrame_SetTimer(cooldownFrame, start, duration, enable)

      if start > 0 and duration > feature.config.minDuration and enable > 0 then
        if not cooldownFrame.countdownTimer then
          cooldownFrame.countdownTimer = CreateFrame("Frame", nil, cooldownFrame)
          cooldownFrame.countdownTimer:SetAllPoints(cooldownFrame)
          cooldownFrame.countdownTimer.duration = duration
          cooldownFrame.countdownTimer.start = start

          cooldownFrame.countdownTimer.label = cooldownFrame.countdownTimer:CreateFontString(nil, "HIGH", "GameFontNormal")
          cooldownFrame.countdownTimer.label:SetPoint("CENTER", 0, 0)
          cooldownFrame.countdownTimer.label:SetFont("Fonts\\FRIZQT__.TTF", 11)
          cooldownFrame.countdownTimer.label:SetText(duration)
          cooldownFrame.countdownTimer.label:SetTextColor(1,1,1)

          cooldownFrame.countdownTimer:SetScript("OnUpdate", function()
            if this.label then
              local remaining = math.abs((start + duration) - GetTime())
              local labelText = nil
              
              if remaining >= 3600 then
                labelText = string.format("%dh", math.ceil(remaining / 60 / 60))
              elseif remaining >= 90 then
                labelText = string.format("%dm", math.ceil(remaining / 60))
              elseif remaining < 90 then
                labelText = string.format("%ds", math.ceil(remaining))
              end

              this.label:SetText(labelText)
            end
          end)
        end
      end
    end
  end
end)

