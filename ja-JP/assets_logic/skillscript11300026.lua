-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11300026_xp", totalHitCount = 21}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  DisplaySkillMask(0, 1)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4332, true)
  SetDefCardsActive(6566.01, false)
  SetDefCardsActive(8233, true)
  MoveDefCard(8233, nil, 0)
  local actionList = {4799, 4949, 5099, 5249, 5399, 5549, 5699, 5849, 5999, 6149, 6299, 6499, 6599, 6749, 6899, 7049, 7199, 7349, 7499, 7649, 7799}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(6000, BattleConfig.positionInvisible, 0)
  MoveAtkCard(8233, nil, 0)
  ChangeAtkState(8233, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

