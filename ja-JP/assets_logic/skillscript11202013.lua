-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11202013_xp", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(2099.79, BattleConfig.positionInvisible, 0)
  DisplaySkillMask(0, 1)
  MoveDefCard(0, BattleConfig.positionInvisible, 0)
  MoveDefCard(2133.12, nil, 0)
  local actionList = {3166.35, 3466, 3616, 3766, 3916, 4066, 4216, 4366, 4516}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(4899, nil, 0)
  ChangeAtkState(4899, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

