-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_NumberFillByName")
GetGuildBoss_NumberBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetGuildBoss_NumberFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


