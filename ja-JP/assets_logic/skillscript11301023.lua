-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11301023_xp", totalHitCount = 8}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(2000, BattleConfig.positionInvisible, 0)
  MoveDefCard(0, BattleConfig.positionInvisible, 0)
  MoveDefCard(7199.28, nil, 0)
  MoveDefCard(8732, BattleConfig.positionInvisible, 0)
  local actionList = {8765, 8915, 9065, 9215, 9365, 9515, 9665, 9999}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(9999, nil, 0)
  ChangeAtkState(9999, "idle", true)
  MoveDefCard(9999, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

