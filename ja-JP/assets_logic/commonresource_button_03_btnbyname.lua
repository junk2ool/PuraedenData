-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_Button_03_BtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


