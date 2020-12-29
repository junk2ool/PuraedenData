-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_AssetStripByName")
require("Family_ShopPanelByName")
GetFamily_FamilyShopUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.TimeNameTxt = ui:GetChild("TimeNameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.RefreshBtn = ui:GetChild("RefreshBtn")
  uis.RefreshGrp = ui:GetChild("RefreshGrp")
  uis.CommodityList = ui:GetChild("CommodityList")
  uis.ShopPanel = GetFamily_ShopPanelUis(ui:GetChild("ShopPanel"))
  uis.root = ui
  return uis
end


