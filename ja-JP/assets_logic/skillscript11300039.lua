-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {6532, 6682, 6832, 6982, 7132, 7278, 7432, 7582, 7732, 7882, 8032, 8182, 8332, 8482, 8632, 8782, 8932, 9082, 9232, 9382, 9532, 9682}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_11300039_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetDefCardsActive(0, false)
  SetAtkCardActive(3000, false)
  SetDefCardsActive(5999, true)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  MoveDefCard(10132, nil, 0)
  MoveAtkCard(10132, nil, 0)
  ChangeAtkState(10132, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

