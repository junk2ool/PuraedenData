-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_CloseButtonUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


