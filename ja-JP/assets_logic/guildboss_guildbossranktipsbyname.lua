-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("GuildBoss_IntegralNumberByName")
require("GuildBoss_PlayerHeadByName")
require("Title_TitlePicByName")
require("GuildBoss_TipsBattleNumberByName")
require("GuildBoss_GuildHeadByName")
GetGuildBoss_GuildBossRankTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Ranking_01_Image = ui:GetChild("Ranking_01_Image")
  uis.FirstGrp = ui:GetChild("FirstGrp")
  uis.Ranking_02_Image = ui:GetChild("Ranking_02_Image")
  uis.SecondGrp = ui:GetChild("SecondGrp")
  uis.Ranking_03_Image = ui:GetChild("Ranking_03_Image")
  uis.ThirdGrp = ui:GetChild("ThirdGrp")
  uis.Ranking_04_Image = ui:GetChild("Ranking_04_Image")
  uis.Ranking_04_Txt = ui:GetChild("Ranking_04_Txt")
  uis.FouthGrp = ui:GetChild("FouthGrp")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.IntegralNumber = GetGuildBoss_IntegralNumberUis(ui:GetChild("IntegralNumber"))
  uis.PlayerHead = GetGuildBoss_PlayerHeadUis(ui:GetChild("PlayerHead"))
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.TipsBattleNumber = GetGuildBoss_TipsBattleNumberUis(ui:GetChild("TipsBattleNumber"))
  uis.GuildHeadImage = ui:GetChild("GuildHeadImage")
  uis.GuildHead = GetGuildBoss_GuildHeadUis(ui:GetChild("GuildHead"))
  uis.GuildLevelTxt = ui:GetChild("GuildLevelTxt")
  uis.PlayerNumberTxt = ui:GetChild("PlayerNumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.c3Ctr = ui:GetController("c3")
  uis.c4Ctr = ui:GetController("c4")
  uis.root = ui
  return uis
end


