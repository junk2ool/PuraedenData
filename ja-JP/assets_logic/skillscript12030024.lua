-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {1590, 1740, 1890, 2040, 2190, 2340, 2490, 2640, 2790, 2940, 3090, 3240, 3390}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_12030024_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  ChangeAtkState(3450, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

