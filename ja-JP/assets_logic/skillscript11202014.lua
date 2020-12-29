-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11202014_xp", totalHitCount = 13}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(1999.8, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(2000, true)
  MoveAtkCard(4340, nil, 0)
  ChangeAtkState(4340, "idle", true)
  ChangeDefState(2533, "hit_1")
  ChangeDefState(2683, "hit_2")
  ChangeDefState(2833, "hit_1")
  ChangeDefState(2983, "hit_2")
  ChangeDefState(3133, "hit_1")
  ChangeDefState(3283, "hit_2")
  ChangeDefState(3433, "hit_1")
  ChangeDefState(3583, "hit_2")
  ChangeDefState(3733, "hit_1")
  ChangeDefState(3883, "hit_2")
  ChangeDefState(4033, "hit_1")
  ChangeDefState(4183, "hit_2")
  ChangeDefState(4333, "hit_1", true)
  MoveDefCard(4333, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

