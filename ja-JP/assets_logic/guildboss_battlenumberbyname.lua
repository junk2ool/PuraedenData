-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuildBoss_BattleNumberUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.RoundTxt = ui:GetChild("RoundTxt")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.TalentTxt = ui:GetChild("TalentTxt")
  uis.TipsBtn = ui:GetChild("TipsBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


