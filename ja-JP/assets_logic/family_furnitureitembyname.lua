-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_FurnitureItemUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.FurnitureItemLoader = ui:GetChild("FurnitureItemLoader")
  uis.root = ui
  return uis
end


