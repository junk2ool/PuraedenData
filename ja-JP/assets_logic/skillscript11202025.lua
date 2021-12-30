-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300013_xp", totalHitCount = 10}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_25, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(6599, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(6632, true)
  ChangeDefCardLayer(8199, LayerMaskNames.DEFAULT)
  ChangeDefState(7999, "hit_1")
  ChangeDefState(8399, "hit_2")
  ChangeDefState(8499, "hit_1")
  ChangeDefState(8599, "hit_2")
  ChangeDefState(8699, "hit_1")
  ChangeDefState(8799, "hit_2")
  ChangeDefState(8899, "hit_1")
  ChangeDefState(8999, "hit_2")
  ChangeDefState(9099, "hit_1")
  ChangeDefState(9199, "hit_2", true)
  ChangeAtkState(9365, "idle", true)
  MoveAtkCard(9365, nil, 0)
  MoveDefCard(9365, nil, 0)
  ChangeDefCardLayer(9365, LayerMaskNames.SKILL_HIGHLIGHT)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

