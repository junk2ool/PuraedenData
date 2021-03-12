-- params : ...
-- function num : 0 , upvalues : _ENV
GetRelic_BossSignUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BossSignLoader = ui:GetChild("BossSignLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


