-- params : ...
-- function num : 0 , upvalues : _ENV
GetShop_ShopPanelUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BtnList = ui:GetChild("BtnList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


