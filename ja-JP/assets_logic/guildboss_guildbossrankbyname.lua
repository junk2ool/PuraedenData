-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_GuildBossRankChoiceByName")
require("GuildBoss_BossRewardInfoByName")
GetGuildBoss_GuildBossRankUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.GuildBossRankChoice = GetGuildBoss_GuildBossRankChoiceUis(ui:GetChild("GuildBossRankChoice"))
  uis.BossRewardInfo = GetGuildBoss_BossRewardInfoUis(ui:GetChild("BossRewardInfo"))
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


