-- params : ...
-- function num : 0 , upvalues : _ENV
local hitState = {"hit_2", "hit_1"}
local hitSeq = {3566, 3716, 4016, 4166, 4316, 4466, 4616, 4766, 4916, 5066, 5216, 5366, 5516}
local totalHitCount = #hitSeq
local SkillScript = {timelineName = "FX_timeline_12030025_xp", totalHitCount = totalHitCount}
SkillScript.Play = function(time, endedCallback, ...)
  -- function num : 0_0 , upvalues : _ENV, totalHitCount, hitSeq, hitState
  ChangeAtkState(0, "uniqueskill", false)
  DisplaySkillMask(0, 1)
  MoveDefCard(0, BattleConfig.positionCenter_20 * 1.5 + BattleConfig.positionCenter_5, 0)
  for i = 1, totalHitCount do
    ChangeDefState(hitSeq[i], hitState[i % 2 + 1], i == totalHitCount)
  end
  ChangeAtkState(5666, "idle", true)
  MoveDefCard(5666, nil, 0)
  ClearSkillMask(time - 1, nil, 1, endedCallback)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return SkillScript

