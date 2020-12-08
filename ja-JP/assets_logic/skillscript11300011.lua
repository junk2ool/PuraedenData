-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300011_xp", totalHitCount = 15}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(7565, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(7599, true)
  ChangeDefCardLayer(8899, LayerMaskNames.DEFAULT)
  ChangeDefCardLayer(12532, LayerMaskNames.SKILL_HIGHLIGHT)
  ChangeDefState(9065, "hit_1")
  ChangeDefState(9232, "hit_2")
  ChangeDefState(9382, "hit_1")
  ChangeDefState(9532, "hit_2")
  ChangeDefState(9682, "hit_1")
  ChangeDefState(9832, "hit_2")
  ChangeDefState(9982, "hit_1")
  ChangeDefState(10132, "hit_2")
  ChangeDefState(10732, "hit_1")
  ChangeDefState(10882, "hit_2")
  ChangeDefState(11032, "hit_1")
  ChangeDefState(11182, "hit_2")
  ChangeDefState(11332, "hit_1")
  ChangeDefState(11482, "hit_2")
  ChangeDefState(11632, "hit_1", true)
  ChangeAtkState(12532, "idle", true)
  MoveAtkCard(12532, nil, 0)
  MoveDefCard(12532, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

