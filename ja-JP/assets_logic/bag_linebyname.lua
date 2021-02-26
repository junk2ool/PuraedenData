-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetBag_LineUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line_03 = GetCommonResource_Line_03Uis(ui:GetChild("Line_03"))
  uis.root = ui
  return uis
end


