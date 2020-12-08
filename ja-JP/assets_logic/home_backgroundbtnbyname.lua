-- params : ...
-- function num : 0 , upvalues : _ENV
GetHome_BackGroundBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.buttonCtr = ui:GetController("button")
  uis.ClothesCtr = ui:GetController("Clothes")
  uis.root = ui
  return uis
end


