-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("GuildBoss_PlayerHeadByName")
require("Title_TitlePicByName")
require("GuildBoss_TipsBattleNumberByName")
require("GuildBoss_GuildHeadByName")
require("GuildBoss_PresidentByName")
require("GuildBoss_MemberByName")
require("GuildBoss_IntegralNumberByName")
GetGuildBoss_BossRewardInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.MonthBtn = ui:GetChild("MonthBtn")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.PlayerHead = GetGuildBoss_PlayerHeadUis(ui:GetChild("PlayerHead"))
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.TipsBattleNumber = GetGuildBoss_TipsBattleNumberUis(ui:GetChild("TipsBattleNumber"))
  uis.GuildHead = GetGuildBoss_GuildHeadUis(ui:GetChild("GuildHead"))
  uis.President = GetGuildBoss_PresidentUis(ui:GetChild("President"))
  uis.Member = GetGuildBoss_MemberUis(ui:GetChild("Member"))
  uis.IntegralNumber = GetGuildBoss_IntegralNumberUis(ui:GetChild("IntegralNumber"))
  uis.RankNumberTxt = ui:GetChild("RankNumberTxt")
  uis.PlusImage = ui:GetChild("PlusImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


