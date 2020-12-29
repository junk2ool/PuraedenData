-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_ShopItemByName")
GetFamily_ShopItemListUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Item_01 = GetFamily_ShopItemUis(ui:GetChild("Item_01"))
  uis.Item_02 = GetFamily_ShopItemUis(ui:GetChild("Item_02"))
  uis.Item_03 = GetFamily_ShopItemUis(ui:GetChild("Item_03"))
  uis.Item_04 = GetFamily_ShopItemUis(ui:GetChild("Item_04"))
  uis.Item_05 = GetFamily_ShopItemUis(ui:GetChild("Item_05"))
  uis.root = ui
  return uis
end


