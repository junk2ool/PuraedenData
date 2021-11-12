-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {6566, 6716, 6866, 7016, 7166, 7316, 7466, 7616, 7766, 7919, 8066, 8216, 8366, 8516, 8666, 8816, 8966}
local totalHitCount = #hitSeq
local SkillScript = {totalHitCount = totalHitCount, timelineName = "FX_timeline_11300045_xp"}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  DisplaySkillMask(0, 1)
  ChangeAtkState(0, "uniqueskill", false)
  MoveAtkCard(0, BattleConfig.positionZero)
  SetDefCardsActive(0, false)
  SetAtkCardActive(3333, false)
  SetDefCardsActive(5632, true)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  SetDefCardsActive(7532, false)
  SetAtkCardActive(9399, true)
  SetDefCardsActive(9399, true)
  MoveAtkCard(9399, nil, 0)
  ChangeAtkState(9399, "idle", true)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

