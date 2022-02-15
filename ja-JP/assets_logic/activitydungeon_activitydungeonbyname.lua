-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("CommonResource_AssetStripByName")
GetActivityDungeon_ActivityDungeonUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BgLoader = ui:GetChild("BgLoader")
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Time_01_Txt = ui:GetChild("Time_01_Txt")
  uis.Time_02_Txt = ui:GetChild("Time_02_Txt")
  uis.Difficulty_01_Btn = ui:GetChild("Difficulty_01_Btn")
  uis.Difficulty_02_Btn = ui:GetChild("Difficulty_02_Btn")
  uis.MapList = ui:GetChild("MapList")
  uis.SweepBtn = ui:GetChild("SweepBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


