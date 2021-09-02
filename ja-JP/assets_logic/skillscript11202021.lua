-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {4099, 4249, 4399, 4549, 4699, 4849, 4999, 5599, 5749, 5899}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_11202021_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetDefCardsActive(0, false)
  SetAtkCardActive(3832, false)
  SetDefCardsActive(3832.5, true)
  MoveDefCard(3832.5, BattleConfig.positionCenter_20)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  MoveDefCard(6466, nil, 0)
  MoveAtkCard(6466, nil, 0)
  ChangeAtkState(6466, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

