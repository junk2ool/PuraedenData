-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {7865, 8015, 8165, 8315, 8465, 8615, 8765, 8915, 9065, 9215, 9365}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_11300021_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetDefCardsActive(0, false)
  SetAtkCardActive(7199, false)
  SetDefCardsActive(7232, true)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  MoveDefCard(9999, nil, 0)
  MoveAtkCard(9999, nil, 0)
  ChangeAtkState(9999, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

