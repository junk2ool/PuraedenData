-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_ShopPanelUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ShenMiBtn = ui:GetChild("ShenMiBtn")
  uis.JiaJuBtn = ui:GetChild("JiaJuBtn")
  uis.ZhongZiBtn = ui:GetChild("ZhongZiBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


