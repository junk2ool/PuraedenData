-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_ItemUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ItemLoader = ui:GetChild("ItemLoader")
  uis.ItemNumberTxt = ui:GetChild("ItemNumberTxt")
  uis.root = ui
  return uis
end


