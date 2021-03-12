-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_LayerBossByName")
GetRelic_BossMapUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Boss1 = GetRelic_LayerBossUis(ui:GetChild("Boss1"))
  uis.Boss2 = GetRelic_LayerBossUis(ui:GetChild("Boss2"))
  uis.Boss3 = GetRelic_LayerBossUis(ui:GetChild("Boss3"))
  uis.Boss4 = GetRelic_LayerBossUis(ui:GetChild("Boss4"))
  uis.Boss5 = GetRelic_LayerBossUis(ui:GetChild("Boss5"))
  uis.root = ui
  return uis
end


