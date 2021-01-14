-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300018_xp", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  MoveAtkCard(5699.4, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(5700, true)
  local actionList = {6865, 7232, 7599, 8665, 8815, 8965, 9115, 9265, 9415}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveDefCard(9532, nil, 0)
  MoveAtkCard(9532, nil, 0)
  ChangeAtkState(9532, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

