-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_FarmSceneByName")
require("Family_EmptyByName")
require("Family_LandByName")
require("Family_FamilyEffectsByName")
require("CommonResource_AssetStripByName")
require("Family_WarehouseByName")
require("Family_LevelByName")
GetFamily_FarmUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.FarmScene = GetFamily_FarmSceneUis(ui:GetChild("FarmScene"))
  uis.Empty = GetFamily_EmptyUis(ui:GetChild("Empty"))
  uis.HouseBtn = ui:GetChild("HouseBtn")
  uis.Land_1 = GetFamily_LandUis(ui:GetChild("Land_1"))
  uis.Land_2 = GetFamily_LandUis(ui:GetChild("Land_2"))
  uis.Land_3 = GetFamily_LandUis(ui:GetChild("Land_3"))
  uis.Land_4 = GetFamily_LandUis(ui:GetChild("Land_4"))
  uis.Land_5 = GetFamily_LandUis(ui:GetChild("Land_5"))
  uis.Land_6 = GetFamily_LandUis(ui:GetChild("Land_6"))
  uis.FamilyEffects = GetFamily_FamilyEffectsUis(ui:GetChild("FamilyEffects"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.Warehouse = GetFamily_WarehouseUis(ui:GetChild("Warehouse"))
  uis.Level = GetFamily_LevelUis(ui:GetChild("Level"))
  uis.HarvestBtn = ui:GetChild("HarvestBtn")
  uis.WareHouseBtn = ui:GetChild("WareHouseBtn")
  uis.ShopBtn = ui:GetChild("ShopBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


