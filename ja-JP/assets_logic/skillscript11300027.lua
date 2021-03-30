-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11300027_xp", totalHitCount = 14}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  DisplaySkillMask(0, 1)
  SetDefCardsActive(0, false)
  SetDefCardsActive(6032.73, true)
  local actionList = {6965, 7115, 7265, 7415, 7565, 7715, 7865, 8015, 8165, 8315, 8465, 8615, 8765, 8915}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(5932.74, BattleConfig.positionInvisible, 0)
  MoveAtkCard(8999, nil, 0)
  MoveDefCard(8999, nil, 0)
  ChangeAtkState(8999, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

