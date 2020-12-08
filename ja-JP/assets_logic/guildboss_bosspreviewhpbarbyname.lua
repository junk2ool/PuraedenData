-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_BossPreviewHpFillByName")
GetGuildBoss_BossPreviewHpBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetGuildBoss_BossPreviewHpFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


