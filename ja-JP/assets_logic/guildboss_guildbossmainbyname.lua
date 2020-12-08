-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_MapByName")
require("CommonResource_AssetStripByName")
require("GuildBoss_StateTipsByName")
require("GuildBoss_BattleNumberByName")
require("GuildBoss_IntegralShowByName")
require("GuildBoss_ActiveByName")
GetGuildBoss_GuildBossMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Map = GetGuildBoss_MapUis(ui:GetChild("Map"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.InformationBtn = ui:GetChild("InformationBtn")
  uis.TalentBtn = ui:GetChild("TalentBtn")
  uis.RewardBtn = ui:GetChild("RewardBtn")
  uis.HelpBtn = ui:GetChild("HelpBtn")
  uis.StateTips = GetGuildBoss_StateTipsUis(ui:GetChild("StateTips"))
  uis.BattleNumber = GetGuildBoss_BattleNumberUis(ui:GetChild("BattleNumber"))
  uis.IntegralShow = GetGuildBoss_IntegralShowUis(ui:GetChild("IntegralShow"))
  uis.Active = GetGuildBoss_ActiveUis(ui:GetChild("Active"))
  uis.root = ui
  return uis
end


