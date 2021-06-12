-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11300023_xp", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(2000, BattleConfig.positionInvisible, 0)
  MoveDefCard(0, BattleConfig.positionInvisible, 0)
  MoveDefCard(5332, nil, 0)
  local actionList = {6099, 6249, 6399, 6549, 6699, 6849, 6999, 7149, 7299}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(7399, nil, 0)
  ChangeAtkState(7399, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

