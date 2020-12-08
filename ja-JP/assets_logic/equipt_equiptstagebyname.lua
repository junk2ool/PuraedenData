-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetEquipt_EquiptStageUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.StageList = ui:GetChild("StageList")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.root = ui
  return uis
end


