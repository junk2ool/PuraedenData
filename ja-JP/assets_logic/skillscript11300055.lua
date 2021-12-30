-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {9265, 9415, 9565, 9715, 9865, 10015, 10165, 10315, 10465, 10615, 10765, 10915, 11065}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_11300055_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionCenter_5 / 2)
  SetDefCardsActive(0, false)
  SetAtkCardActive(7565, false)
  SetDefCardsActive(7599, true)
  MoveDefCard(7599, BattleConfig.positionCenter_13 + BattleConfig.positionCenter_5)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  MoveDefCard(11665, nil, 0)
  MoveAtkCard(11665, nil, 0)
  ChangeAtkState(11665, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

