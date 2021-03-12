-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_BossSignByName")
GetRelic_BaseMapUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BaseMapLoader = ui:GetChild("BaseMapLoader")
  uis.Boss1 = GetRelic_BossSignUis(ui:GetChild("Boss1"))
  uis.Boss2 = GetRelic_BossSignUis(ui:GetChild("Boss2"))
  uis.Boss3 = GetRelic_BossSignUis(ui:GetChild("Boss3"))
  uis.Boss4 = GetRelic_BossSignUis(ui:GetChild("Boss4"))
  uis.Boss5 = GetRelic_BossSignUis(ui:GetChild("Boss5"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


