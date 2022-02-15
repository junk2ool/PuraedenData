-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
GetFormation_TitleUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TabImage = ui:GetChild("TabImage")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.root = ui
  return uis
end


