-- params : ...
-- function num : 0 , upvalues : _ENV
local hitStates = {"hit_2", "hit_1"}
local hitSeq = {6699, 6849, 6999, 7149, 7299, 7447, 7599, 7749, 7899, 8049, 8199}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_11300035_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitStates
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero, 0)
  SetDefCardsActive(0, false)
  MoveAtkCard(3333, BattleConfig.positionInvisible, 0)
  SetDefCardsActive(6032, true)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitStates[i % 2 + 1], i == totalHitCount)
  end
  MoveAtkCard(8400, nil, 0)
  ChangeAtkState(8400, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

