-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
require("CommonResource_AssetStripByName")
GetActivityDungeonTwo_PlotDetailUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlotImageLoader = ui:GetChild("PlotImageLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.ChallengeBtn = ui:GetChild("ChallengeBtn")
  uis.sweepaway10Btn = ui:GetChild("sweepaway10Btn")
  uis.sweepawayBtn = ui:GetChild("sweepawayBtn")
  uis.Prop1List = ui:GetChild("Prop1List")
  uis.DropDisplayTxt = ui:GetChild("DropDisplayTxt")
  uis.Drop1ListGrp = ui:GetChild("Drop1ListGrp")
  uis.DecorateImage = GetCommonResource_Base_01Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Base_02Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Base_01Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Base_02Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Base_01Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Base_02Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.mycombatTxt = ui:GetChild("mycombatTxt")
  uis.mycombatnumberTxt = ui:GetChild("mycombatnumberTxt")
  uis.recommendedcombatTxt = ui:GetChild("recommendedcombatTxt")
  uis.recommendedcombatmumberTxt = ui:GetChild("recommendedcombatmumberTxt")
  uis.vitalityTxt = ui:GetChild("vitalityTxt")
  uis.vitalitynumberTxt = ui:GetChild("vitalitynumberTxt")
  uis.vitalitynumber_01_Txt = ui:GetChild("vitalitynumber_01_Txt")
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.challengenumberTxt = ui:GetChild("challengenumberTxt")
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


