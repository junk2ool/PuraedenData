-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetGuildBoss_AllBossBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.BossNameTxt = ui:GetChild("BossNameTxt")
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.Word_02_Txt = ui:GetChild("Word_02_Txt")
  uis.BackOrangeImage = ui:GetChild("BackOrangeImage")
  uis.BossLoader = ui:GetChild("BossLoader")
  uis.QualityOrangeImage = ui:GetChild("QualityOrangeImage")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


