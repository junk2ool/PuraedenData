-- params : ...
-- function num : 0 , upvalues : _ENV
GetHeroDungeon_AnimationUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.StoryImage = ui:GetChild("StoryImage")
  uis.RewardBoxImage = ui:GetChild("RewardBoxImage")
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


