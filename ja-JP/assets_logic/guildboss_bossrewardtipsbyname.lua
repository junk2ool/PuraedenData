-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuildBoss_BossRewardTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.RewardList = ui:GetChild("RewardList")
  uis.GetBtn = ui:GetChild("GetBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


