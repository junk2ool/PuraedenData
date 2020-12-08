-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetGuildBoss_StateTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.TipsImage = ui:GetChild("TipsImage")
  uis.RankingImage = ui:GetChild("RankingImage")
  uis.RankNumberTxt = ui:GetChild("RankNumberTxt")
  uis.PositionImage = ui:GetChild("PositionImage")
  uis.PlusImage = ui:GetChild("PlusImage")
  uis.BossRankBtn = ui:GetChild("BossRankBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


