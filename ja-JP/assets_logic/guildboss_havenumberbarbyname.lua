-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_HaveNumberFillByName")
GetGuildBoss_HaveNumberBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetGuildBoss_HaveNumberFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


