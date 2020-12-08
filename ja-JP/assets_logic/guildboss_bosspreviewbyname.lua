-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("CommonResource_Line_03ByName")
GetGuildBoss_BossPreviewUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.ShadowImage = ui:GetChild("ShadowImage")
  uis.BossLoader = ui:GetChild("BossLoader")
  uis.BossHpProgressBar = ui:GetChild("BossHpProgressBar")
  uis.HpNumberTxt = ui:GetChild("HpNumberTxt")
  uis.ReportBtn = ui:GetChild("ReportBtn")
  uis.SimulateBtn = ui:GetChild("SimulateBtn")
  uis.n5 = GetCommonResource_Line_04Uis(ui:GetChild("n5"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.EndTimeTxt = ui:GetChild("EndTimeTxt")
  uis.SurplusTxt = ui:GetChild("SurplusTxt")
  uis.n8 = GetCommonResource_Line_03Uis(ui:GetChild("n8"))
  uis.RewardList = ui:GetChild("RewardList")
  uis.RewardTxt = ui:GetChild("RewardTxt")
  uis.root = ui
  return uis
end


