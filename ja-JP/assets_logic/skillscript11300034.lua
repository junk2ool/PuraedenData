-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11300034_XP", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(3333, BattleConfig.positionInvisible, 0)
  MoveDefCard(0, BattleConfig.positionInvisible, 0)
  MoveDefCard(6332, nil, 0)
  DisplaySkillMask(0, 1)
  local actionList = {7132, 7282, 7432, 7582, 7732, 7882, 8032, 8182, 8332}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(8400, nil, 0)
  ChangeAtkState(8400, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

