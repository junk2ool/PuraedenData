-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_LandEffectsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PlantLoader = ui:GetChild("PlantLoader")
  uis.root = ui
  return uis
end


