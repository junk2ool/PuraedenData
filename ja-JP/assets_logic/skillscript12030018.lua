-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillScript = {timelineName = "Fx_timeline_12030018_xp", totalHitCount = 8}
SkillScript.Play = function(time, timelineEndCall, ...)
  -- function num : 0_0 , upvalues : _ENV
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(3799, BattleConfig.positionInvisible, 0)
  DisplaySkillMask(0, 1)
  local actionList = {899, 1433, 1899, 3033, 3183, 3333, 3483, 3633}
  local count = #actionList
  for i = 1, count do
    ChangeDefState(actionList[i], i % 2 == 0 and "hit_1" or "hit_2", i == count)
  end
  MoveAtkCard(4466, nil, 0)
  ChangeAtkState(4466, "idle", true)
  ClearSkillMask(time - 1, nil, 1, timelineEndCall)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

