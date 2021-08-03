-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
GetTower_ThemeMainStageUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.ThemeMainStageList = ui:GetChild("ThemeMainStageList")
  uis.root = ui
  return uis
end


