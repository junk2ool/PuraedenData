-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_ThreeDraw_1ByName")
GetShop_ThreeDrawUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n0 = GetShop_ThreeDraw_1Uis(ui:GetChild("n0"))
  uis.root = ui
  return uis
end


