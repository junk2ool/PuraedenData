-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030014_xp", totalHitCount = 11}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero - Vector3(20, 0, 0), 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(2299, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(2300, true)
  local actionList = {2899, 3049, 3199, 3349, 3499, 3649, 3799, 3949, 4099, 4249, 4399}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(4549, nil, 0)
  ChangeAtkState(4549, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

