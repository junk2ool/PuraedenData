-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {4832, 4982, 5132, 5282, 5432, 5582, 5732, 5882, 6032, 6182}
local totalHitCount = #hitSeq
local SkillScript = {totalHitCount = totalHitCount, timelineName = "FX_timeline_11300047_xp"}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetDefCardsActive(0, false)
  SetAtkCardActive(2999, false)
  SetDefCardsActive(4332, true)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  SetAtkCardActive(6232, true)
  MoveAtkCard(6232, nil, 0)
  ChangeAtkState(6232, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

