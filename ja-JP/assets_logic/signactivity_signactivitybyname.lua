-- params : ...
-- function num : 0 , upvalues : _ENV
require("SignActivity_Decorate_01ByName")
require("SignActivity_TimeByName")
require("SignActivity_RewardByName")
GetSignActivity_SignActivityUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BgLoader = ui:GetChild("BgLoader")
  uis.TitleLoader = ui:GetChild("TitleLoader")
  uis.Decorate_01 = GetSignActivity_Decorate_01Uis(ui:GetChild("Decorate_01"))
  uis.Decorate_02 = GetSignActivity_Decorate_01Uis(ui:GetChild("Decorate_02"))
  uis.Time = GetSignActivity_TimeUis(ui:GetChild("Time"))
  uis.Reward = GetSignActivity_RewardUis(ui:GetChild("Reward"))
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.root = ui
  return uis
end


