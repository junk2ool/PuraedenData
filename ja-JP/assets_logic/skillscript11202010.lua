-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11202010_xp", totalHitCount = 16}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20 - Vector3(0, 5, 0), 0)
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(2033, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(2033.13, true)
  MoveAtkCard(4999, nil, 0)
  ChangeAtkState(4999, "idle", true)
  ChangeDefState(2366, "hit_1")
  ChangeDefState(2516, "hit_2")
  ChangeDefState(2666, "hit_1")
  ChangeDefState(2816, "hit_2")
  ChangeDefState(2966, "hit_1")
  ChangeDefState(3166, "hit_2")
  ChangeDefState(3266, "hit_1")
  ChangeDefState(3416, "hit_2")
  ChangeDefState(3566, "hit_1")
  ChangeDefState(3716, "hit_2")
  ChangeDefState(3866, "hit_1")
  ChangeDefState(4016, "hit_2")
  ChangeDefState(4166, "hit_1")
  ChangeDefState(4316, "hit_2")
  ChangeDefState(4466, "hit_1")
  ChangeDefState(4616, "hit_2", true)
  MoveDefCard(4999, nil, 0.1)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

