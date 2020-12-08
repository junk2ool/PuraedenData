-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "FX_timeline_11201011_xp", totalHitCount = 17}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(5654, BattleConfig.positionInvisible, 0)
  MoveAtkCard(9432, nil, 0)
  ChangeAtkState(9432, "idle", true)
  SetDefCardsActive(0, false)
  SetDefCardsActive(5966, true)
  ChangeDefState(6932, "hit_1")
  ChangeDefState(7082, "hit_2")
  ChangeDefState(7232, "hit_1")
  ChangeDefState(7382, "hit_2")
  ChangeDefState(7532, "hit_1")
  ChangeDefState(7682, "hit_2")
  ChangeDefState(7832, "hit_1")
  ChangeDefState(7982, "hit_2")
  ChangeDefState(8132, "hit_1")
  ChangeDefState(8282, "hit_2")
  ChangeDefState(8432, "hit_1")
  ChangeDefState(8582, "hit_2")
  ChangeDefState(8732, "hit_1")
  ChangeDefState(8882, "hit_2")
  ChangeDefState(9032, "hit_1")
  ChangeDefState(9182, "hit_2")
  ChangeDefState(9332, "hit_1", true)
  MoveDefCard(9432, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

