-- params : ...
-- function num : 0 , upvalues : _ENV
require("Prize_PrizeItemSByName")
require("Prize_PrizeItemAByName")
require("Prize_PrizeItemBByName")
GetPrize_RewardShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Item_1 = GetPrize_PrizeItemSUis(ui:GetChild("Item_1"))
  uis.Item_2 = GetPrize_PrizeItemSUis(ui:GetChild("Item_2"))
  uis.Item_3 = GetPrize_PrizeItemSUis(ui:GetChild("Item_3"))
  uis.Item_4 = GetPrize_PrizeItemSUis(ui:GetChild("Item_4"))
  uis.Item_5 = GetPrize_PrizeItemAUis(ui:GetChild("Item_5"))
  uis.Item_6 = GetPrize_PrizeItemAUis(ui:GetChild("Item_6"))
  uis.Item_7 = GetPrize_PrizeItemAUis(ui:GetChild("Item_7"))
  uis.Item_8 = GetPrize_PrizeItemAUis(ui:GetChild("Item_8"))
  uis.Item_9 = GetPrize_PrizeItemAUis(ui:GetChild("Item_9"))
  uis.Item_10 = GetPrize_PrizeItemBUis(ui:GetChild("Item_10"))
  uis.Item_11 = GetPrize_PrizeItemBUis(ui:GetChild("Item_11"))
  uis.Item_12 = GetPrize_PrizeItemBUis(ui:GetChild("Item_12"))
  uis.Item_13 = GetPrize_PrizeItemBUis(ui:GetChild("Item_13"))
  uis.Item_14 = GetPrize_PrizeItemBUis(ui:GetChild("Item_14"))
  uis.Item_15 = GetPrize_PrizeItemBUis(ui:GetChild("Item_15"))
  uis.root = ui
  return uis
end


