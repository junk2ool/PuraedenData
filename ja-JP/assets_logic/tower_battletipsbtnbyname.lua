-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_BattleTipsByName")
GetTower_BattleTipsBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BattleTips = GetTower_BattleTipsUis(ui:GetChild("BattleTips"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


