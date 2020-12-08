-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11202009_xp", totalHitCount = 17}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(2233, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(3266, true)
  MoveAtkCard(5936, nil, 0)
  ChangeAtkState(5936, "idle", true)
  ChangeDefState(3932, "hit_1")
  ChangeDefState(4057, "hit_2")
  ChangeDefState(4182, "hit_1")
  ChangeDefState(4307, "hit_2")
  ChangeDefState(4432, "hit_1")
  ChangeDefState(4557, "hit_2")
  ChangeDefState(4682, "hit_1")
  ChangeDefState(4807, "hit_2")
  ChangeDefState(4932, "hit_1")
  ChangeDefState(5057, "hit_2")
  ChangeDefState(5182, "hit_1")
  ChangeDefState(5307, "hit_2")
  ChangeDefState(5432, "hit_2")
  ChangeDefState(5557, "hit_2")
  ChangeDefState(5682, "hit_2")
  ChangeDefState(5807, "hit_2")
  ChangeDefState(5932, "hit_1", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

