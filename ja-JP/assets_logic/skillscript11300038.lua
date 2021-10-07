-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {6899, 7049, 7199, 7349, 7499, 7649, 7799, 7949, 8099, 8249, 8399, 8549, 8699, 8849, 8999, 9149, 9299, 9449, 9599}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_11300038_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetDefCardsActive(0, false)
  SetAtkCardActive(3000, false)
  SetDefCardsActive(6266, true)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  MoveDefCard(10265, nil, 0)
  MoveAtkCard(10265, nil, 0)
  ChangeAtkState(10265, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

