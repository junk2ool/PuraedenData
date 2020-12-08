-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11201012_xp", totalHitCount = 16}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, Vector3(0, 0, 0), 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(3166, BattleConfig.positionInvisible, 0)
  MoveAtkCard(7165, nil, 0)
  ChangeAtkState(7165, "idle", true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(3166, true)
  ChangeDefState(4432, "hit_1")
  ChangeDefState(4528, "hit_2")
  ChangeDefState(4732, "hit_1")
  ChangeDefState(4882, "hit_2")
  ChangeDefState(5032, "hit_1")
  ChangeDefState(5182, "hit_2")
  ChangeDefState(5332, "hit_1")
  ChangeDefState(5482, "hit_2")
  ChangeDefState(5632, "hit_1")
  ChangeDefState(5782, "hit_2")
  ChangeDefState(5932, "hit_1")
  ChangeDefState(6082, "hit_2")
  ChangeDefState(6232, "hit_1")
  ChangeDefState(6382, "hit_2")
  ChangeDefState(6532, "hit_1")
  ChangeDefState(6682, "hit_2", true)
  MoveDefCard(7165, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

