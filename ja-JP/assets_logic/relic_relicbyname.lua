-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_BaseMapByName")
require("Relic_BattleContentByName")
require("CommonResource_AssetStripByName")
GetRelic_RelicUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.BaseMap = GetRelic_BaseMapUis(ui:GetChild("BaseMap"))
  uis.BattleContent = GetRelic_BattleContentUis(ui:GetChild("BattleContent"))
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.RelicShopBtn = ui:GetChild("RelicShopBtn")
  uis.root = ui
  return uis
end


