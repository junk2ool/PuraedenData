-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300017_xp", totalHitCount = 1}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(2000, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4932, true)
  ChangeDefState(time, "hit_1", true, nil, true)
  ChangeAtkState(time - 1, "idle", true)
  MoveAtkCard(time - 1, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

