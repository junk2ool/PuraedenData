-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_RewardShowByName")
require("ActivityDungeon_GetRewardByName")
require("CommonResource_AssetStripByName")
require("ActivityDungeon_TipsByName")
GetActivityDungeon_ExchangeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BgLoader = ui:GetChild("BgLoader")
  uis.ALoader = ui:GetChild("ALoader")
  uis.RewardShow = GetActivityDungeon_RewardShowUis(ui:GetChild("RewardShow"))
  uis.GetReward_A = GetActivityDungeon_GetRewardUis(ui:GetChild("GetReward_A"))
  uis.GetReward_B = GetActivityDungeon_GetRewardUis(ui:GetChild("GetReward_B"))
  uis.GetReward_C = GetActivityDungeon_GetRewardUis(ui:GetChild("GetReward_C"))
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.ResetBtn = ui:GetChild("ResetBtn")
  uis.SkipBtn = ui:GetChild("SkipBtn")
  uis.SkipTxt = ui:GetChild("SkipTxt")
  uis.Tips = GetActivityDungeon_TipsUis(ui:GetChild("Tips"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


