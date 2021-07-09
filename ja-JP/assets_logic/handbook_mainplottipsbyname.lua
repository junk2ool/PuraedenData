-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_NewCompByName")
GetHandBook_MainPlotTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.ChapterTxt = ui:GetChild("ChapterTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.NewCompGrp = GetCommonResource_NewCompUis(ui:GetChild("NewCompGrp"))
  uis.c3Ctr = ui:GetController("c3")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


