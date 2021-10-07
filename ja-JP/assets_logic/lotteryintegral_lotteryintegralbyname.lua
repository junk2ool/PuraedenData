-- params : ...
-- function num : 0 , upvalues : _ENV
require("LotteryIntegral_IntegralByName")
require("LotteryIntegral_TipsByName")
require("CommonResource_AssetStripByName")
GetLotteryIntegral_LotteryIntegralUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Integral = GetLotteryIntegral_IntegralUis(ui:GetChild("Integral"))
  uis.Tips = GetLotteryIntegral_TipsUis(ui:GetChild("Tips"))
  uis.GoBtn = ui:GetChild("GoBtn")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.root = ui
  return uis
end


