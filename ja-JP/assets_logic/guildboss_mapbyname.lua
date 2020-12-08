-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_BossFormByName")
GetGuildBoss_MapUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Boss_1 = GetGuildBoss_BossFormUis(ui:GetChild("Boss_1"))
  uis.Boss_2 = GetGuildBoss_BossFormUis(ui:GetChild("Boss_2"))
  uis.Boss_3 = GetGuildBoss_BossFormUis(ui:GetChild("Boss_3"))
  uis.Boss_4 = GetGuildBoss_BossFormUis(ui:GetChild("Boss_4"))
  uis.Boss_5 = GetGuildBoss_BossFormUis(ui:GetChild("Boss_5"))
  uis.root = ui
  return uis
end


