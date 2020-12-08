-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11202008_xp", totalHitCount = 13}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(1999.8, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(2033.13, true)
  MoveAtkCard(5100, nil, 0)
  ChangeAtkState(5100, "idle", true)
  ChangeDefState(3266, "hit_1")
  ChangeDefState(3416, "hit_2")
  ChangeDefState(3566, "hit_1")
  ChangeDefState(3716, "hit_2")
  ChangeDefState(3866, "hit_1")
  ChangeDefState(4016, "hit_2")
  ChangeDefState(4166, "hit_1")
  ChangeDefState(4316, "hit_2")
  ChangeDefState(4466, "hit_1")
  ChangeDefState(4616, "hit_2")
  ChangeDefState(4766, "hit_1")
  ChangeDefState(4916, "hit_2")
  ChangeDefState(5066, "hit_1", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

