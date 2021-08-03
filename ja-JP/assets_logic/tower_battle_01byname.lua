-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_NewCompByName")
GetTower_Battle_01Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.EquiptIconList = ui:GetChild("EquiptIconList")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.NewComp = GetCommonResource_NewCompUis(ui:GetChild("NewComp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


