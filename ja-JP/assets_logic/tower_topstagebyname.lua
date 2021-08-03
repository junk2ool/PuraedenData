-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Tower_EquiptTipsByName")
GetTower_TopStageUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.EquiptTips = GetTower_EquiptTipsUis(ui:GetChild("EquiptTips"))
  uis.TipsList = ui:GetChild("TipsList")
  uis.root = ui
  return uis
end


