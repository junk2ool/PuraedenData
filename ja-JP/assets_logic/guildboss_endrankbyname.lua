-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuildBoss_EndRankUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.RankNumberTxt = ui:GetChild("RankNumberTxt")
  uis.PlusImage = ui:GetChild("PlusImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


