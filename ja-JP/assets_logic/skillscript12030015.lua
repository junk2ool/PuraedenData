-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030015_xp", totalHitCount = 27}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(1883, BattleConfig.positionInvisible, 0)
  local actionList = {1883, 1958, 2033, 2108, 2183, 2258, 2333, 2408, 2483, 2558, 2633, 2708, 2783, 2858, 2933, 3008, 3083, 3158, 3233, 3308, 3383, 3458, 3533, 3608, 3683, 3758, 3833}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(4049.5, nil, 0)
  ChangeAtkState(4049.5, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

