-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_AdjustByName")
GetFamily_FurnitureUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Adjust = GetFamily_AdjustUis(ui:GetChild("Adjust"))
  uis.root = ui
  return uis
end


