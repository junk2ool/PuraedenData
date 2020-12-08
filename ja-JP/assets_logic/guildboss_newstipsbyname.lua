-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_PlayerHeadByName")
require("Title_TitlePicByName")
require("CommonResource_Line_03ByName")
require("GuildBoss_TipsBattleNumberByName")
GetGuildBoss_NewsTipsUis = function(ui, ...)
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
  uis.PlayerHead = GetGuildBoss_PlayerHeadUis(ui:GetChild("PlayerHead"))
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.TipsBattleNumber = GetGuildBoss_TipsBattleNumberUis(ui:GetChild("TipsBattleNumber"))
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.NumberProgressBar = ui:GetChild("NumberProgressBar")
  uis.c1Ctr = ui:GetController("c1")
  uis.c3Ctr = ui:GetController("c3")
  uis.root = ui
  return uis
end


