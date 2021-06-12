-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
require("Card_StarUpEffectByName")
require("Card_ImprintEffectByName")
require("Card_ImprintByName")
require("Card_ImprintSkillUpByName")
GetCard_StarGrpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.DecorateGrp = ui:GetChild("DecorateGrp")
  uis.CardPicesLoader = ui:GetChild("CardPicesLoader")
  uis.ButtonOneBtn = ui:GetChild("ButtonOneBtn")
  uis.ButtonTwoBtn = ui:GetChild("ButtonTwoBtn")
  uis.GoldBackImage = ui:GetChild("GoldBackImage")
  uis.GoldImage = ui:GetChild("GoldImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.StarNumberTxt = ui:GetChild("StarNumberTxt")
  uis.TipsBtn = ui:GetChild("TipsBtn")
  uis.HeadFrameGrp = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrameGrp"))
  uis.StarList = ui:GetChild("StarList")
  uis.UpGrp = GetCard_StarUpEffectUis(ui:GetChild("UpGrp"))
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.StarDebrisChangeBtn = ui:GetChild("StarDebrisChangeBtn")
  uis.ImprintTxt = ui:GetChild("ImprintTxt")
  uis.ImprintEffect = GetCard_ImprintEffectUis(ui:GetChild("ImprintEffect"))
  uis.Imprint = GetCard_ImprintUis(ui:GetChild("Imprint"))
  uis.ImprintSkillUp = GetCard_ImprintSkillUpUis(ui:GetChild("ImprintSkillUp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


