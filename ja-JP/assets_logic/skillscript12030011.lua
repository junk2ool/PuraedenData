-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030011_xp", totalHitCount = 21}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(1199, "hit_1")
  ChangeDefState(1349, "hit_2")
  ChangeDefState(1499, "hit_1")
  ChangeDefState(1649, "hit_2")
  ChangeDefState(1799, "hit_1")
  ChangeDefState(1949, "hit_2")
  ChangeDefState(2099, "hit_1")
  ChangeDefState(2249, "hit_2")
  ChangeDefState(2399, "hit_1")
  ChangeDefState(2549, "hit_2")
  ChangeDefState(2699, "hit_1")
  ChangeDefState(2849, "hit_2")
  ChangeDefState(2999, "hit_1")
  ChangeDefState(3149, "hit_2")
  ChangeDefState(3299, "hit_1")
  ChangeDefState(3449, "hit_2")
  ChangeDefState(3599, "hit_1")
  ChangeDefState(3749, "hit_2")
  ChangeDefState(3899, "hit_1")
  ChangeDefState(4049, "hit_2")
  ChangeDefState(4199, "hit_1", true)
  MoveAtkCard(4200, nil, 0)
  ChangeAtkState(4200, "idle", true)
  MoveDefCard(4200, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

