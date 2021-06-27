-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_RewardShowByName")
require("ActivityDungeonTwo_GetRewardByName")
require("CommonResource_AssetStripByName")
GetActivityDungeonTwo_ExchangeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ALoader = ui:GetChild("ALoader")
  uis.RewardShow = GetActivityDungeonTwo_RewardShowUis(ui:GetChild("RewardShow"))
  uis.GetReward_A = GetActivityDungeonTwo_GetRewardUis(ui:GetChild("GetReward_A"))
  uis.GetReward_B = GetActivityDungeonTwo_GetRewardUis(ui:GetChild("GetReward_B"))
  uis.GetReward_C = GetActivityDungeonTwo_GetRewardUis(ui:GetChild("GetReward_C"))
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.ResetBtn = ui:GetChild("ResetBtn")
  uis.SkipBtn = ui:GetChild("SkipBtn")
  uis.SkipTxt = ui:GetChild("SkipTxt")
  uis.root = ui
  return uis
end


