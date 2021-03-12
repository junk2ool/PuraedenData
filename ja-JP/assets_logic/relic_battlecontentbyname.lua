-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_BossMapByName")
GetRelic_BattleContentUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.BuildMapList = ui:GetChild("BuildMapList")
  uis.BossMap = GetRelic_BossMapUis(ui:GetChild("BossMap"))
  uis.DayBattleBtn = ui:GetChild("DayBattleBtn")
  uis.TypeABtn = ui:GetChild("TypeABtn")
  uis.TypeBBtn = ui:GetChild("TypeBBtn")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.RewardBtn = ui:GetChild("RewardBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


