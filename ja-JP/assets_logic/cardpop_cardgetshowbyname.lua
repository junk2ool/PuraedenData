-- params : ...
-- function num : 0 , upvalues : _ENV
require("CardPop_CardGetEffectByName")
require("CardPop_RepeatByName")
require("CardPop_PicExplainByName")
require("CardPop_RepeatTipsByName")
require("CardPop_CardGetShowEffectByName")
require("Share_InformationByName")
GetCardPop_CardGetShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlueImage = ui:GetChild("BlueImage")
  uis.PurpleImage = ui:GetChild("PurpleImage")
  uis.OrangeImage = ui:GetChild("OrangeImage")
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.CardGetEffect = GetCardPop_CardGetEffectUis(ui:GetChild("CardGetEffect"))
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.CVImage = ui:GetChild("CVImage")
  uis.CVNameLoader = ui:GetChild("CVNameLoader")
  uis.CVNameTxt = ui:GetChild("CVNameTxt")
  uis.NameImage = ui:GetChild("NameImage")
  uis.NameImage = ui:GetChild("NameImage")
  uis.NameLoader = ui:GetChild("NameLoader")
  uis.CardNameTxt = ui:GetChild("CardNameTxt")
  uis.Repeat = GetCardPop_RepeatUis(ui:GetChild("Repeat"))
  uis.R_Image = ui:GetChild("R_Image")
  uis.SR_Image = ui:GetChild("SR_Image")
  uis.SSR_Image = ui:GetChild("SSR_Image")
  uis.StarList = ui:GetChild("StarList")
  uis.PicExplain = GetCardPop_PicExplainUis(ui:GetChild("PicExplain"))
  uis.RepeatTips = GetCardPop_RepeatTipsUis(ui:GetChild("RepeatTips"))
  uis.CardGetShowEffectGrp = GetCardPop_CardGetShowEffectUis(ui:GetChild("CardGetShowEffectGrp"))
  uis.Cothes_1_Btn = ui:GetChild("Cothes_1_Btn")
  uis.Cothes_2_Btn = ui:GetChild("Cothes_2_Btn")
  uis.Cothes_3_Btn = ui:GetChild("Cothes_3_Btn")
  uis.WhiteEffect = GetCardPop_CardGetEffectUis(ui:GetChild("WhiteEffect"))
  uis.Information = GetShare_InformationUis(ui:GetChild("Information"))
  uis.c2Ctr = ui:GetController("c2")
  uis.c1Ctr = ui:GetController("c1")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


