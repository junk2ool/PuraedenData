-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {7965, 8115, 8265, 8415, 8565, 8715, 8865, 9015, 9165, 9315, 9465, 9615, 9765}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_11300043_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetDefCardsActive(0, false)
  SetAtkCardActive(2999, false)
  SetDefCardsActive(6632, true)
  MoveDefCard(6632, BattleConfig.positionCenter_13 + BattleConfig.positionCenter_5)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  MoveDefCard(10365, nil, 0)
  MoveAtkCard(10365, nil, 0)
  ChangeAtkState(10365, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

