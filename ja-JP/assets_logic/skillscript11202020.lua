-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {2499, 2649, 2799, 2949, 3099, 3249, 3399, 3549, 3699, 3849, 3999, 4149, 4299}
local totalHitCount = #hitSeq
local SkillScript = {totalHitCount = totalHitCount, timelineName = "FX_timeline_11202020_xp"}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  MoveAtkCard(4666, nil, 0)
  ChangeAtkState(4666, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

