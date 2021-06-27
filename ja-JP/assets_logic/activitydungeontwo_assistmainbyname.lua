-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_BattleTipsByName")
GetActivityDungeonTwo_AssistMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BattleTips = GetActivityDungeonTwo_BattleTipsUis(ui:GetChild("BattleTips"))
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.BattleHelpBtn = ui:GetChild("BattleHelpBtn")
  uis.BattleRewardBtn = ui:GetChild("BattleRewardBtn")
  uis.root = ui
  return uis
end


