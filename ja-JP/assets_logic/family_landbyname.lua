-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_LandEffectsByName")
require("Family_PlantByName")
require("Family_LandTips_AByName")
GetFamily_LandUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.LandEffects = GetFamily_LandEffectsUis(ui:GetChild("LandEffects"))
  uis.Plant = GetFamily_PlantUis(ui:GetChild("Plant"))
  uis.LandTips_A = GetFamily_LandTips_AUis(ui:GetChild("LandTips_A"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


