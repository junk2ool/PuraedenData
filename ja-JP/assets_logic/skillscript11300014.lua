-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300014_xp", totalHitCount = 14}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(3000, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(6500, true)
  ChangeDefState(6666, "hit_1")
  ChangeDefState(8132, "hit_2")
  ChangeDefState(8232, "hit_1")
  ChangeDefState(8332, "hit_2")
  ChangeDefState(8432, "hit_1")
  ChangeDefState(8532, "hit_2")
  ChangeDefState(8632, "hit_1")
  ChangeDefState(8732, "hit_2")
  ChangeDefState(8832, "hit_1")
  ChangeDefState(8932, "hit_2")
  ChangeDefState(9032, "hit_1")
  ChangeDefState(9132, "hit_2")
  ChangeDefState(9232, "hit_1")
  ChangeDefState(9332, "hit_2", true)
  ChangeAtkState(9665, "idle", true)
  MoveAtkCard(9665, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

