-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300016_xp", totalHitCount = 18}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(5499, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(5832.75, true)
  MoveDefCard(0, BattleConfig.positionCenter_25, 0)
  MoveDefCard(9499, nil, 0)
  ChangeDefState(6732, "hit_2")
  ChangeDefState(6882, "hit_1")
  ChangeDefState(7032, "hit_2")
  ChangeDefState(7182, "hit_1")
  ChangeDefState(7332, "hit_2")
  ChangeDefState(7482, "hit_1")
  ChangeDefState(7632, "hit_2")
  ChangeDefState(7782, "hit_1")
  ChangeDefState(7932, "hit_2")
  ChangeDefState(8082, "hit_1")
  ChangeDefState(8232, "hit_2")
  ChangeDefState(8382, "hit_1")
  ChangeDefState(8532, "hit_2")
  ChangeDefState(8682, "hit_1")
  ChangeDefState(8832, "hit_2")
  ChangeDefState(8982, "hit_1")
  ChangeDefState(9132, "hit_2")
  ChangeDefState(9282, "hit_1", true)
  ChangeAtkState(9499, "idle", true)
  MoveAtkCard(9499, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

