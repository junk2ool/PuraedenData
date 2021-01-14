-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300019_xp", totalHitCount = 14}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveDefCardFront(0, Vector3.zero, 0)
  DisplaySkillMask(0, 1)
  MoveAtkCard(2000, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(5599, true)
  local actionList = {6266, 6366, 6499, 6765, 6965, 7832, 7982, 8132, 8282, 8432, 8582, 8732, 8882, 9032}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveDefCard(9099, nil, 0)
  MoveAtkCard(9099, nil, 0)
  ChangeAtkState(9099, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

