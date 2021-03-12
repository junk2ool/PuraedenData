-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_ImprintSkillShowByName")
require("Card_CirclePropFrameByName")
require("Card_SpendByName")
GetCard_ImprintSkillUpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.ImprintSkillShow = GetCard_ImprintSkillShowUis(ui:GetChild("ImprintSkillShow"))
  uis.ItemOneGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemOneGrp"))
  uis.ItemTwoGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemTwoGrp"))
  uis.ItemThreeGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemThreeGrp"))
  uis.ItemSixGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemSixGrp"))
  uis.ItemFiveGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemFiveGrp"))
  uis.ItemFourGrp = GetCard_CirclePropFrameUis(ui:GetChild("ItemFourGrp"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.Spend = GetCard_SpendUis(ui:GetChild("Spend"))
  uis.UpSureBtn = ui:GetChild("UpSureBtn")
  uis.ImprintTipsTxt = ui:GetChild("ImprintTipsTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


