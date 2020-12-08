-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_BossHpFillByName")
GetGuildBoss_BossHpBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetGuildBoss_BossHpFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


