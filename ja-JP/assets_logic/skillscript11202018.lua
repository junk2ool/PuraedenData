-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {2433, 2899, 3049, 3199, 3349, 3499, 3649, 3799, 3949, 4099, 4249, 4399, 4549, 4699, 4849, 4999, 4849, 4999}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_11202018_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  MoveDefCard(0, BattleConfig.positionCenter_25, 0)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  MoveDefCard(5099, nil, 0)
  MoveAtkCard(5099, nil, 0)
  ChangeAtkState(5099, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

