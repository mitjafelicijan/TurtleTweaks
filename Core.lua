_G = getfenv(0)

if TurtleTweaksDB == nil then
  TurtleTweaksDB = {}
end

ns = {}
ns.Features = {}
ns.Config = {
  ManaBarColor = { r = 0.0, g = 0.7, b = 1 },
}

ns.Register = function(feature)
  if TurtleTweaksDB[feature.identifier] == nil then
    TurtleTweaksDB[feature.identifier] = false
  end
  
  tinsert(ns.Features, feature)
  return feature
end

ns.IsEnabled = function(identifier)
  if TurtleTweaksDB[identifier] ~= nil then
    return TurtleTweaksDB[identifier]
  end
end

ns.KVStorage = {}

ns.KVStorage.defaults = function()
  TurtleTweaksDB.KV = {}
end

ns.KVStorage.Get = function(key)
  if not TurtleTweaksDB.KV then ns.KVStorage.defaults() end

  if key and TurtleTweaksDB.KV[key] then
    return TurtleTweaksDB.KV[key]
  end
end

ns.KVStorage.Set = function(key, value)
  if not TurtleTweaksDB.KV then ns.KVStorage.defaults() end
  
  if key then
    TurtleTweaksDB.KV[key] = value
  end
end

ns.KVStorage.Del = function(key)
  if not TurtleTweaksDB.KV then ns.KVStorage.defaults() end

  if key and TurtleTweaksDB.KV[key] then
    TurtleTweaksDB.KV[key] = nil
  end
end

do
  SLASH_TweeksReload1 = "/reloadui"
  SLASH_TweeksReload2 = "/reload"
  SLASH_TweeksReload3 = "/rl"

  SlashCmdList["TweeksReload"] = function(msg, editbox)
    ConsoleExec("reloadui")
  end
end

function print(message)
  DEFAULT_CHAT_FRAME:AddMessage(tostring(message))
end

function ShowErrorMessage(message)
  UIErrorsFrame:AddMessage(message, 1.0, 0.9, 0.4)
end

function GetCoinText(money)
  if type(money) ~= "number" then return "-" end

  local gold = floor(money/100/100)
  local silver = floor(mod((money/100),100))
  local copper = floor(mod(money,100))

  local parts = {}
  if gold > 0 then table.insert(parts, string.format("%dg", gold)) end
  if silver > 0 then table.insert(parts, string.format("%ds", silver)) end
  if copper > 0 then table.insert(parts, string.format("%dc", copper)) end

  return table.concat(parts, " ")
end 
