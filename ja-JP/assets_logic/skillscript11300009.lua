-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300009_xp", totalHitCount = 20}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(3766, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(3999, true)
  ChangeDefState(5499, "hit_1")
  ChangeDefState(5649, "hit_2")
  ChangeDefState(5799, "hit_1")
  ChangeDefState(5949, "hit_2")
  ChangeDefState(6099, "hit_1")
  ChangeDefState(6249, "hit_2")
  ChangeDefState(6399, "hit_1")
  ChangeDefState(6549, "hit_2")
  ChangeDefState(6699, "hit_1")
  ChangeDefState(6849, "hit_2")
  ChangeDefState(6999, "hit_1")
  ChangeDefState(7149, "hit_2")
  ChangeDefState(7299, "hit_1")
  ChangeDefState(7449, "hit_2")
  ChangeDefState(7599, "hit_1")
  ChangeDefState(7749, "hit_2")
  ChangeDefState(7899, "hit_1")
  ChangeDefState(8049, "hit_2")
  ChangeDefState(8199, "hit_1")
  ChangeDefState(8349, "hit_2", true)
  ChangeAtkState(8599, "idle", true)
  MoveAtkCard(8599, nil, 0)
  MoveDefCard(8599, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

