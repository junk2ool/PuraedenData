-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_BossPicByName")
GetActivityDungeonTwo_BattleTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BossPic = GetActivityDungeonTwo_BossPicUis(ui:GetChild("BossPic"))
  uis.HpProgressBar = ui:GetChild("HpProgressBar")
  uis.BattleBossBtn = ui:GetChild("BattleBossBtn")
  uis.HpTxt = ui:GetChild("HpTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


