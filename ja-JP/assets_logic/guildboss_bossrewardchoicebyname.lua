-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuildBoss_BossRewardChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ABtn = ui:GetChild("ABtn")
  uis.BBtn = ui:GetChild("BBtn")
  uis.CBtn = ui:GetChild("CBtn")
  uis.RewardList = ui:GetChild("RewardList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


