-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("CommonResource_Line_03ByName")
require("Relic_BattleSpendByName")
require("Relic_BattlePowerByName")
GetRelic_BattlePreviewUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.ImageLoader = ui:GetChild("ImageLoader")
  uis.n5 = GetCommonResource_Line_04Uis(ui:GetChild("n5"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.BNWordTxt = ui:GetChild("BNWordTxt")
  uis.n8 = GetCommonResource_Line_03Uis(ui:GetChild("n8"))
  uis.RewardList = ui:GetChild("RewardList")
  uis.RewardTxt = ui:GetChild("RewardTxt")
  uis.HpNumberTxt = ui:GetChild("HpNumberTxt")
  uis.BattleSpend = GetRelic_BattleSpendUis(ui:GetChild("BattleSpend"))
  uis.BattlePowerA = GetRelic_BattlePowerUis(ui:GetChild("BattlePowerA"))
  uis.BattlePowerB = GetRelic_BattlePowerUis(ui:GetChild("BattlePowerB"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


