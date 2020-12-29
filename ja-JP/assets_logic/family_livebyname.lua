-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_02ByName")
GetFamily_LiveUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.Line = GetCommonResource_Line_02Uis(ui:GetChild("Line"))
  uis.LivePlaceList = ui:GetChild("LivePlaceList")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.root = ui
  return uis
end


