-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
GetFormation_TeamTipsBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n6 = GetCommonResource_Line_03Uis(ui:GetChild("n6"))
  uis.n7 = GetCommonResource_Base_01Uis(ui:GetChild("n7"))
  uis.n8 = GetCommonResource_Base_02Uis(ui:GetChild("n8"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.BattleWordTxt = ui:GetChild("BattleWordTxt")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.HeadList = ui:GetChild("HeadList")
  uis.EditBtn = ui:GetChild("EditBtn")
  uis.UseBtn = ui:GetChild("UseBtn")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


