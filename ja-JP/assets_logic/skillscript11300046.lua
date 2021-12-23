-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {6832, 6982, 7132, 7282, 7432, 7582, 7732, 7882, 8032, 8182}
local totalHitCount = #hitSeq
local SkillScript = {totalHitCount = totalHitCount, timelineName = "FX_timeline_11300046_xp"}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetDefCardsActive(0, false)
  SetAtkCardActive(6132, false)
  SetDefCardsActive(6165, true)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  SetAtkCardActive(9299, true)
  ChangeAtkState(9299, "idle", true)
  MoveAtkCard(9299, nil, 0)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

