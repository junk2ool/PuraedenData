-- params : ...
-- function num : 0 , upvalues : _ENV
GetRelic_LayerBossUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end

