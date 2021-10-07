-- params : ...
-- function num : 0 , upvalues : _ENV
require("LotteryIntegral_RewardListShowByName")
GetLotteryIntegral_IntegralUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RewardListShow = GetLotteryIntegral_RewardListShowUis(ui:GetChild("RewardListShow"))
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.IntegralTxt = ui:GetChild("IntegralTxt")
  uis.root = ui
  return uis
end


