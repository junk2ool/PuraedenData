-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_ItemFrameByName")
GetFamily_TipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TipsImage = ui:GetChild("TipsImage")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.ItemFrame = GetCommonResource_ItemFrameUis(ui:GetChild("ItemFrame"))
  uis.ItemNameTxt = ui:GetChild("ItemNameTxt")
  uis.HaveNumber_01_Txt = ui:GetChild("HaveNumber_01_Txt")
  uis.HaveNumberTxt = ui:GetChild("HaveNumberTxt")
  uis.HaveNumberGrp = ui:GetChild("HaveNumberGrp")
  uis.ItemWordTxt = ui:GetChild("ItemWordTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.root = ui
  return uis
end


