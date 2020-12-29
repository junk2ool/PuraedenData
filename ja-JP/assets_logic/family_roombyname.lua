-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_CurrencyWindowByName")
require("CommonResource_AssetStripByName")
require("Family_WarehouseByName")
require("Family_PlayerInfoByName")
GetFamily_RoomUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CurrencyWindow = GetFamily_CurrencyWindowUis(ui:GetChild("CurrencyWindow"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.ClearBtn = ui:GetChild("ClearBtn")
  uis.HideBtn = ui:GetChild("HideBtn")
  uis.StorageBtn = ui:GetChild("StorageBtn")
  uis.ShopBtn = ui:GetChild("ShopBtn")
  uis.LiveBtn = ui:GetChild("LiveBtn")
  uis.RandomVisitBtn = ui:GetChild("RandomVisitBtn")
  uis.VisitBtn = ui:GetChild("VisitBtn")
  uis.ABtn = ui:GetChild("ABtn")
  uis.BBtn = ui:GetChild("BBtn")
  uis.CBtn = ui:GetChild("CBtn")
  uis.DBtn = ui:GetChild("DBtn")
  uis.Warehouse = GetFamily_WarehouseUis(ui:GetChild("Warehouse"))
  uis.PlayerInfo = GetFamily_PlayerInfoUis(ui:GetChild("PlayerInfo"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


