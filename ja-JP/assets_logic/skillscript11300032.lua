-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11300032_xp", totalHitCount = 11}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  DisplaySkillMask(0, 1)
  SetDefCardsActive(0, false)
  SetDefCardsActive(5566, true)
  local actionList = {5966, 6116, 6266, 6416, 7166, 7316, 7466, 7616, 7766, 7916, 8066}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(8200, nil, 0)
  ChangeAtkState(8200, "idle", true)
  MoveDefCard(8200, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

