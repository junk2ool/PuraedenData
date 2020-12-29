-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
GetFamily_LivePlaceBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


