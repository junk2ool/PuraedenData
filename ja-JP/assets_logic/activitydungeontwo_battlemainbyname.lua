-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_ActivityBackGroundByName")
require("ActivityDungeonTwo_PlotMainByName")
require("ActivityDungeonTwo_ExploreMainByName")
require("ActivityDungeonTwo_AssistMainByName")
require("CommonResource_AssetStripByName")
require("ActivityDungeonTwo_LabelListByName")
GetActivityDungeonTwo_BattleMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ActivityBackGround = GetActivityDungeonTwo_ActivityBackGroundUis(ui:GetChild("ActivityBackGround"))
  uis.PlotMain = GetActivityDungeonTwo_PlotMainUis(ui:GetChild("PlotMain"))
  uis.ExploreMain = GetActivityDungeonTwo_ExploreMainUis(ui:GetChild("ExploreMain"))
  uis.AssistBattleMain = GetActivityDungeonTwo_AssistMainUis(ui:GetChild("AssistBattleMain"))
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.LabelList = GetActivityDungeonTwo_LabelListUis(ui:GetChild("LabelList"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


