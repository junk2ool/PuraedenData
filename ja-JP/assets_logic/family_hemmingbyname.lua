-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_HemmingUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ExtensionBtn = ui:GetChild("ExtensionBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


