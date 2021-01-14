-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030017_xp", totalHitCount = 12}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  local actionList = {1266, 1416, 1566, 1716, 1866, 2016, 2166, 2316, 2466, 2616, 2766, 2916}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  ChangeAtkState(2916, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

