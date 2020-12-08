-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("Equipt_CleanUpBtnPanel_AByName")
GetEquipt_EquiptTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.EquiptPanelGrp = GetEquipt_CleanUpBtnPanel_AUis(ui:GetChild("EquiptPanelGrp"))
  uis.root = ui
  return uis
end


