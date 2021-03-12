-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_ItemFrameByName")
require("CommonResource_HeadDebrisByName")
GetCard_ImprintDebrisChangeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.WangNengItemGrp = GetCommonResource_ItemFrameUis(ui:GetChild("WangNengItemGrp"))
  uis.WangNengItemTxt = ui:GetChild("WangNengItemTxt")
  uis.JueSeDebrisGrp = GetCommonResource_HeadDebrisUis(ui:GetChild("JueSeDebrisGrp"))
  uis.JueSeDebrisTxt = ui:GetChild("JueSeDebrisTxt")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.ChangeNumberTxt = ui:GetChild("ChangeNumberTxt")
  uis.ReduceBtn = ui:GetChild("ReduceBtn")
  uis.AddBtn = ui:GetChild("AddBtn")
  uis.MinBtn = ui:GetChild("MinBtn")
  uis.root = ui
  return uis
end


