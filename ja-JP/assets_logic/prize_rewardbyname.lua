-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_02ByName")
require("Prize_PrizeItemAByName")
require("Prize_PrizeItemBByName")
require("Prize_PrizeItemSByName")
GetPrize_RewardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.ItemList = ui:GetChild("ItemList")
  uis.n1 = GetCommonResource_Line_02Uis(ui:GetChild("n1"))
  uis.PrizeItemA = GetPrize_PrizeItemAUis(ui:GetChild("PrizeItemA"))
  uis.PrizeItemB = GetPrize_PrizeItemBUis(ui:GetChild("PrizeItemB"))
  uis.PrizeItemS = GetPrize_PrizeItemSUis(ui:GetChild("PrizeItemS"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


