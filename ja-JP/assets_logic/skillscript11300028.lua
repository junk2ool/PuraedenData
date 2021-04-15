-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11300028_xp", totalHitCount = 19}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  DisplaySkillMask(0, 1)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4366.23, true)
  local actionList = {4832, 4982, 5132, 5282, 5432, 5582, 5732, 5882, 6032, 6182, 6332, 6482, 6632, 6782, 6932, 7082, 7232, 7382, 7532}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(7532, nil, 0)
  MoveDefCard(7532, nil, 0)
  ChangeAtkState(7532, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

