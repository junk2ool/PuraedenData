-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11301003_xp", totalHitCount = 15}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  DisplaySkillMask(0, 1)
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_30, 0)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(1266.54, BattleConfig.positionInvisible, 0)
  MoveAtkCard(6432.69, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(4166.25, true)
  ChangeDefState(4232.91, "hit_1")
  ChangeDefState(4399.56, "hit_2")
  ChangeDefState(5232.81, "hit_1")
  ChangeDefState(5399.46, "hit_2")
  ChangeDefState(5632.77, "hit_1")
  ChangeDefState(5899.41, "hit_2")
  ChangeDefState(6066.06, "hit_1")
  ChangeDefState(6332.7, "hit_2")
  ChangeDefState(6499.35, "hit_1")
  ChangeDefState(7132.62, "hit_2")
  ChangeDefState(7299.27, "hit_1")
  ChangeDefState(7465.92, "hit_2")
  ChangeDefState(7632.57, "hit_1")
  ChangeDefState(7799.22, "hit_2")
  ChangeDefState(7965.87, "hit_1", true)
  ChangeAtkState(8465.82, "idle", true)
  MoveAtkCard(8465.82, nil, 0)
  MoveDefCard(8465.82, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

