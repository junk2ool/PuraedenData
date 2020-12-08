-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityDungeon_CardInfoUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


