-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_BossFormByName")
GetGuildBoss_NewsShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.BossForm = GetGuildBoss_BossFormUis(ui:GetChild("BossForm"))
  uis.root = ui
  return uis
end


