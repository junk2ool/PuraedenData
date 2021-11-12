-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030026_xp", totalHitCount = 1}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  SetDefCardsActive(0, false)
  SetAtkCardActive(2000, false)
  ChangeAtkState(time - 1, "idle", true)
  SetAtkCardActive(time - 1, true)
  SetDefCardsActive(time - 1, true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
end

return SkillScript

