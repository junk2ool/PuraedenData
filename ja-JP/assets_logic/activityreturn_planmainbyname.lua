-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityReturn_PicShowByName")
require("ActivityReturn_PlanRewardByName")
GetActivityReturn_PlanMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PicShow = GetActivityReturn_PicShowUis(ui:GetChild("PicShow"))
  uis.PlanReward = GetActivityReturn_PlanRewardUis(ui:GetChild("PlanReward"))
  uis.root = ui
  return uis
end


