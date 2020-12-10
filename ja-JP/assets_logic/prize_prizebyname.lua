-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Prize_RewardShowByName")
require("Prize_TimeByName")
require("Prize_SkipByName")
GetPrize_PrizeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.RewardShow = GetPrize_RewardShowUis(ui:GetChild("RewardShow"))
  uis.Time = GetPrize_TimeUis(ui:GetChild("Time"))
  uis.RewardBtn = ui:GetChild("RewardBtn")
  uis.ResultBtn = ui:GetChild("ResultBtn")
  uis.OneBtn = ui:GetChild("OneBtn")
  uis.TenBtn = ui:GetChild("TenBtn")
  uis.Skip = GetPrize_SkipUis(ui:GetChild("Skip"))
  uis.root = ui
  return uis
end


