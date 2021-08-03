-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
GetTower_ChoiceEquiptUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.TipsList = ui:GetChild("TipsList")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.root = ui
  return uis
end


