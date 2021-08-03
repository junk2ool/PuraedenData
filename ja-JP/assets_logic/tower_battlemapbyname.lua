-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
GetTower_BattleMapUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.MapList = ui:GetChild("MapList")
  uis.root = ui
  return uis
end


