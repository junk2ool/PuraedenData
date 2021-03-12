-- params : ...
-- function num : 0 , upvalues : _ENV
RelicMgr = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

RelicMgr.OpenBattlePreview = function(stageId, ...)
  -- function num : 0_0 , upvalues : _ENV
  OpenWindow((WinResConfig.RelicBattlePreviewWindow).name, UILayer.HUD, stageId)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

RelicMgr.GetTempleData = function(stageId, ...)
  -- function num : 0_1 , upvalues : _ENV
  local data = nil
  for key,value in pairs((TableData.gTable).BaseTempleData) do
    if value.stage_id == stageId then
      data = value
    end
  end
  return data
end


