-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {1799, 1949, 2099, 2249, 2399, 2549, 2699, 2849, 2999, 3149, 3299, 3449, 3599, 3749, 3899, 4049}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_12030023_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  ChangeAtkState(4332, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

