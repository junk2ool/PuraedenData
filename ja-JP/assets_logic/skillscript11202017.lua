-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11202017_xp", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(2999, BattleConfig.positionInvisible, 0)
  MoveDefCard(0, BattleConfig.positionInvisible, 0)
  MoveDefCard(4332.9, nil, 0)
  local actionList = {4669, 4819, 4969, 5119, 5269, 5419, 5569, 5719, 5869}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(6132, nil, 0)
  ChangeAtkState(6132, "idle", true)
  MoveDefCard(6132, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

