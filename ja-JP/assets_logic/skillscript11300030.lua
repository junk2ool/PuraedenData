-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300030_xp", totalHitCount = 17}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(2000, BattleConfig.positionInvisible, 0)
  DisplaySkillMask(0, 1)
  SetDefCardsActive(0, false)
  SetDefCardsActive(5432, true)
  SetDefCardsActive(8099, false)
  SetDefCardsActive(9999, true)
  local actionList = {6266, 6466, 6632, 7299, 7449, 7599, 7749, 7899, 8049, 8199, 8349, 8499, 8649, 8799, 8949, 8099, 9249}
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

