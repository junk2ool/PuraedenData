-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {7636, 7782, 7932, 8082, 8232, 8382, 8532}
local totalHitCount = #hitSeq
local SkillScript = {totalHitCount = totalHitCount, timelineName = "FX_timeline_11300037_xp"}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetDefCardsActive(0, false)
  SetAtkCardActive(7265, false)
  SetDefCardsActive(7299, true)
  MoveDefCard(7299, BattleConfig.positionCenter_25)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  MoveDefCard(8666, nil, 0)
  MoveAtkCard(8666, nil, 0)
  ChangeAtkState(8666, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

