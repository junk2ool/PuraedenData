-- params : ...
-- function num : 0 , upvalues : _ENV
GetTower_BattleSkipBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ItemLoader = ui:GetChild("ItemLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


