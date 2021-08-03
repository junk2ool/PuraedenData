-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {7099, 7249, 7399, 7549, 8099, 8149, 8299, 8449, 8599, 8749, 8899}
local totalHitCount = #hitSeq
local SkillScript = {totalHitCount = totalHitCount, timelineName = "FX_timeline_11300036_xp"}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  SetDefCardsActive(0, false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetAtkCardActive(3333, false)
  SetDefCardsActive(6266, true)
  MoveDefCard(6266, BattleConfig.positionCenter_20)
  SetDefCardsActive(7599.24, false)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  SetAtkCardActive(9332, true)
  SetDefCardsActive(9332, true)
  MoveDefCard(9332, nil, 0)
  MoveAtkCard(9332, nil, 0)
  ChangeAtkState(9332, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

