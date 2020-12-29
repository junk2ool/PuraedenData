-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_RedDollByName")
require("Family_DayBuyByName")
require("CommonResource_NewCompByName")
GetFamily_ShopItemUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ItemNameTxt = ui:GetChild("ItemNameTxt")
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.RedDollGrp = GetCommonResource_RedDollUis(ui:GetChild("RedDollGrp"))
  uis.DayBuy = GetFamily_DayBuyUis(ui:GetChild("DayBuy"))
  uis.NewCompGrp = GetCommonResource_NewCompUis(ui:GetChild("NewCompGrp"))
  uis.IconNumberTxt = ui:GetChild("IconNumberTxt")
  uis.BuyEnd_01_Image = ui:GetChild("BuyEnd_01_Image")
  uis.BuyEndGrp = ui:GetChild("BuyEndGrp")
  uis.CostLoader = ui:GetChild("CostLoader")
  uis.CostTxt = ui:GetChild("CostTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


