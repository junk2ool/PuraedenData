-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11202015_xp", totalHitCount = 14}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveDefCard(0, BattleConfig.positionCenter_25, 0)
  DisplaySkillMask(0, 1)
  SetAtkCardActive(2299.77, false)
  SetDefCardsActive(0, false)
  SetDefCardsActive(2333.1, true)
  local actionList = {2833, 2983, 3133, 3283, 3433, 3583, 3733, 3883, 4033, 4183, 4333, 4483, 4633, 4783}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(4832, nil, 0)
  MoveDefCard(4832, nil, 0)
  ChangeAtkState(4832, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

