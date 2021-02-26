-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_TenTimeBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


