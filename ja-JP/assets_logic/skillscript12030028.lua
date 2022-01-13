-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {1933, 2083, 2233, 2383, 2533, 2683, 2833, 2983, 3133, 3283, 3433, 3583, 3733}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_12030028_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveDefCard(0, BattleConfig.positionCenter_20, 0)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  ChangeAtkState(3799, "idle", true)
  MoveDefCard(3799, nil, 0)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

