-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030012_xp", totalHitCount = 11}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  ChangeDefState(1166, "hit_1")
  ChangeDefState(1316, "hit_2")
  ChangeDefState(1466, "hit_1")
  ChangeDefState(1616, "hit_2")
  ChangeDefState(1766, "hit_1")
  ChangeDefState(1916, "hit_2")
  ChangeDefState(2066, "hit_1")
  ChangeDefState(2216, "hit_2")
  ChangeDefState(2366, "hit_1")
  ChangeDefState(2516, "hit_2")
  ChangeDefState(2666, "hit_1", true)
  MoveAtkCard(2699, nil, 0)
  ChangeAtkState(2699, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

