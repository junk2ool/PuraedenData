-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_ActiveFillByName")
GetGuildBoss_ActiveBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetGuildBoss_ActiveFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


