-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030013_xp", totalHitCount = 9}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(2000, "hit_1")
  ChangeDefState(2866, "hit_2")
  ChangeDefState(3046, "hit_1")
  ChangeDefState(3226, "hit_2")
  ChangeDefState(3406, "hit_1")
  ChangeDefState(3586, "hit_2")
  ChangeDefState(3766, "hit_1")
  ChangeDefState(3946, "hit_2")
  ChangeDefState(4126, "hit_1", true)
  MoveAtkCard(4699, nil, 0)
  ChangeAtkState(4699, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

