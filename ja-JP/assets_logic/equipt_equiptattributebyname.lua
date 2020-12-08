-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetEquipt_EquiptAttributeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.SecondaryList = ui:GetChild("SecondaryList")
  uis.root = ui
  return uis
end


