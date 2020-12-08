-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_11300010_xp", totalHitCount = 22}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveAtkCard(9399, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(0, false)
  SetDefCardsActive(6832, true)
  ChangeDefCardLayer(9399, LayerMaskNames.DEFAULT)
  ChangeDefCardLayer(11198, LayerMaskNames.SKILL_HIGHLIGHT)
  ChangeDefState(7600, "hit_1")
  ChangeDefState(7750, "hit_2")
  ChangeDefState(7900, "hit_1")
  ChangeDefState(8050, "hit_2")
  ChangeDefState(8200, "hit_1")
  ChangeDefState(8350, "hit_2")
  ChangeDefState(8500, "hit_1")
  ChangeDefState(8650, "hit_2")
  ChangeDefState(8800, "hit_1")
  ChangeDefState(8950, "hit_2")
  ChangeDefState(9100, "hit_1")
  ChangeDefState(9250, "hit_2")
  ChangeDefState(9400, "hit_1")
  ChangeDefState(9765, "hit_2")
  ChangeDefState(9915, "hit_1")
  ChangeDefState(10065, "hit_2")
  ChangeDefState(10215, "hit_1")
  ChangeDefState(10365, "hit_2")
  ChangeDefState(10515, "hit_1")
  ChangeDefState(10665, "hit_2")
  ChangeDefState(10815, "hit_1")
  ChangeDefState(10965, "hit_2", true)
  ChangeAtkState(11198, "idle", true)
  MoveAtkCard(11198, nil, 0)
  MoveDefCard(11198, nil, 0)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

