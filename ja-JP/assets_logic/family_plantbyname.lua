-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_TimeByName")
GetFamily_PlantUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlantLoader = ui:GetChild("PlantLoader")
  uis.Time = GetFamily_TimeUis(ui:GetChild("Time"))
  uis.root = ui
  return uis
end


