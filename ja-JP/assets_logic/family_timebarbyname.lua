-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_TimeFillByName")
GetFamily_TimeBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetFamily_TimeFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


