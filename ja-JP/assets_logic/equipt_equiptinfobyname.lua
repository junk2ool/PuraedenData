-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_EquiptIconByName")
GetEquipt_EquiptInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.EquiptIcon = GetCommonResource_EquiptIconUis(ui:GetChild("EquiptIcon"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


