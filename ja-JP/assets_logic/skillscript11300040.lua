-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {7932, 8082, 8232, 8382, 8532, 8682, 8982, 9132, 9282, 9432, 9582, 9732, 9882}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_11300040_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetDefCardsActive(0, false)
  SetAtkCardActive(3000, false)
  SetDefCardsActive(7565, true)
  SetDefCardsActive(9165, false)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  MoveDefCard(10798, nil, 0)
  MoveAtkCard(10798, nil, 0)
  ChangeAtkState(10798, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

