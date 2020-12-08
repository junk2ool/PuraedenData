-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_BossRewardChoiceByName")
GetGuildBoss_BossRewardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.BossRewardChoice = GetGuildBoss_BossRewardChoiceUis(ui:GetChild("BossRewardChoice"))
  uis.root = ui
  return uis
end


