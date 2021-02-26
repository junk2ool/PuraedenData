-- params : ...
-- function num : 0 , upvalues : _ENV
GetLotteryIntegral_IntegralUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.RewardList = ui:GetChild("RewardList")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.IntegralTxt = ui:GetChild("IntegralTxt")
  uis.root = ui
  return uis
end


