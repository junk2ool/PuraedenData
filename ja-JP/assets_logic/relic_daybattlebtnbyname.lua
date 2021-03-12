-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_DayBattleNumberByName")
GetRelic_DayBattleBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DayBattleNumber = GetRelic_DayBattleNumberUis(ui:GetChild("DayBattleNumber"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


