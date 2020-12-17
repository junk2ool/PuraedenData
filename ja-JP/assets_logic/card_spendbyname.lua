-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_SpendUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ItemImage = ui:GetChild("ItemImage")
  uis.ItemLoader = ui:GetChild("ItemLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.root = ui
  return uis
end


