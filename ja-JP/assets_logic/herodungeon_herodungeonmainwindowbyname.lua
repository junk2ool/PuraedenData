-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("CommonResource_Line_04ByName")
GetHeroDungeon_HeroDungeonMainWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.HeroPlotMapList = ui:GetChild("HeroPlotMapList")
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.SweepBtn = ui:GetChild("SweepBtn")
  uis.RewardBtn = ui:GetChild("RewardBtn")
  uis.n30 = GetCommonResource_Line_04Uis(ui:GetChild("n30"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NameGrp = ui:GetChild("NameGrp")
  uis.root = ui
  return uis
end


