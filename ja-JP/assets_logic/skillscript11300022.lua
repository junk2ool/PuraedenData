-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300022_xp", totalHitCount = 14}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(2499, BattleConfig.positionInvisible, 0)
  DisplaySkillMask(0, 1)
  MoveDefCard(0, BattleConfig.positionInvisible, 0)
  MoveDefCard(5166, nil, 0)
  local actionList = {6232, 6382, 6532, 6682, 6832, 6982, 7132, 7282, 7432, 7582, 7732, 7882, 8032, 8182}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(9165, nil, 0)
  ChangeAtkState(9165, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

