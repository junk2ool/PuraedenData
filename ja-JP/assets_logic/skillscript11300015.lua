-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300015_xp", totalHitCount = 27}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(2000, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4699, true)
  ChangeDefState(4849, "hit_2")
  ChangeDefState(4999, "hit_1")
  ChangeDefState(5149, "hit_2")
  ChangeDefState(5299, "hit_1")
  ChangeDefState(5449, "hit_2")
  ChangeDefState(5599, "hit_1")
  ChangeDefState(5749, "hit_2")
  ChangeDefState(5899, "hit_1")
  ChangeDefState(6049, "hit_2")
  ChangeDefState(6199, "hit_1")
  ChangeDefState(6349, "hit_2")
  ChangeDefState(6499, "hit_1")
  ChangeDefState(6649, "hit_2")
  ChangeDefState(6799, "hit_1")
  ChangeDefState(6949, "hit_2")
  ChangeDefState(7099, "hit_1")
  ChangeDefState(7249, "hit_2")
  ChangeDefState(7399, "hit_1")
  ChangeDefState(7549, "hit_2")
  ChangeDefState(7699, "hit_1")
  ChangeDefState(7849, "hit_2")
  ChangeDefState(7999, "hit_1")
  ChangeDefState(8149, "hit_2")
  ChangeDefState(8299, "hit_1")
  ChangeDefState(8449, "hit_2")
  ChangeDefState(8599, "hit_1")
  ChangeDefState(8749, "hit_2", true)
  ChangeAtkState(8799, "idle", true)
  MoveAtkCard(8799, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

