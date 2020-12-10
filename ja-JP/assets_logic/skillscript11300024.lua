-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300024_xp", totalHitCount = 8}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(1000, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(6566, true)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  MoveDefCard(8700, nil, 0)
  ChangeDefState(7649, "hit_2")
  ChangeDefState(7799, "hit_1")
  ChangeDefState(7949, "hit_2")
  ChangeDefState(8099, "hit_1")
  ChangeDefState(8249, "hit_2")
  ChangeDefState(8399, "hit_1")
  ChangeDefState(8549, "hit_2")
  ChangeDefState(8699, "hit_1", true)
  ChangeAtkState(8700, "idle", true)
  MoveAtkCard(8700, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

