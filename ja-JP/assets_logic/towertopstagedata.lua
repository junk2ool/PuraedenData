-- params : ...
-- function num : 0 , upvalues : _ENV
TowerTopStageData = {}
-- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.EQUIP_LIST_TITLE = "EquiptTitle"
-- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.EQUIP_LIST_ATTRIBUTE_DESC = "EquiptA"
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.EQUIP_LIST_SUIT_DESC = "EquiptB"
-- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.Data = nil
-- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.BaseInfo = nil
-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.FormationInfo = nil
-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.TowerLayerData = {}
-- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.CurrentLucky = 0
-- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.TowerStageData = {}
-- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.CurrentLayer = 0
-- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.CurLayerStageConfig = {}
-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.UnlockLayer = 0
-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.UnlockStage = {}
-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.TowerLayerNumber = {}
-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.TowerStageNumber = {}
-- DECOMPILER ERROR at PC39: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.LastReqStageId = 0
-- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.CurrentStage = 0
-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.ExpandConfig = nil
-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.TowerExpandList = {}
-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.TowerList = {}
-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.InterTypeSort = {}
-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.SetChangFc = function(fc, ...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  TowerTopStageData.changeFc = fc
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.GetChangeFc = function(...)
  -- function num : 0_1 , upvalues : _ENV
  return TowerTopStageData.changeFc
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.InitData = function(...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  TowerTopStageData.TowerLayerData = {}
  local config = nil
  for _,v in pairs((TableData.gTable).BaseTowerData) do
    if v.type == 2 then
      config = v
      ;
      (table.insert)(TowerTopStageData.TowerLayerData, config.id)
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (TowerTopStageData.TowerLayerNumber)[config.id] = #TowerTopStageData.TowerLayerData
    end
  end
  ;
  (table.sort)(TowerTopStageData.TowerLayerData, function(a, b, ...)
    -- function num : 0_2_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  TowerTopStageData.TowerStageData = {}
  for k,v in pairs((TableData.gTable).BaseTowerStageData) do
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R6 in 'UnsetPending'

    if (TowerTopStageData.TowerStageData)[v.tower_id] == nil and (v.pre == 0 or (((TableData.gTable).BaseTowerStageData)[v.pre]).tower_id ~= v.tower_id) then
      (TowerTopStageData.TowerStageData)[v.tower_id] = {}
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (TowerTopStageData.TowerStageNumber)[v.tower_id] = {}
      config = v
      repeat
        (table.insert)((TowerTopStageData.TowerStageData)[v.tower_id], config.id)
        -- DECOMPILER ERROR at PC91: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((TowerTopStageData.TowerStageNumber)[v.tower_id])[config.id] = #(TowerTopStageData.TowerStageData)[v.tower_id]
        config = ((TableData.gTable).BaseTowerStageData)[config.next]
      until config == nil or config.tower_id ~= v.tower_id
    end
  end
  local activityId = (((ActivityMgr.InitTowerExpandData)()).baseActivityInfo).actId
  for k,v in pairs((TableData.gTable).BaseTowerExpandData) do
    if v.activityId == activityId then
      local info = {}
      info.type = v.inter_type
      info.towerId = {}
      info.towerId = split(v.towerId, ":")
      -- DECOMPILER ERROR at PC131: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (TowerTopStageData.InterTypeSort)[k] = info
    end
  end
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.FilterTower = function(towerList, ...)
  -- function num : 0_3 , upvalues : _ENV
  local towerCount = #towerList
  for i = 1, towerCount do
    local towerId = (towerList[i]).towerId
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (TowerTopStageData.TowerList)[i] = towerId
  end
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.InitExpandData = function(data, ...)
  -- function num : 0_4 , upvalues : _ENV
  local count = #data
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  TowerTopStageData.BaseInfo = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  TowerTopStageData.CurrentLayer = 0
  local eachData, subCount, actualCount, subData, noPass = nil, nil, nil, nil, nil
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R7 in 'UnsetPending'

  TowerTopStageData.UnlockLayer = 1
  for i = 1, count do
    eachData = data[i]
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (TowerTopStageData.BaseInfo)[eachData.towerId] = {}
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (TowerTopStageData.UnlockStage)[eachData.towerId] = 0
    noPass = true
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R11 in 'UnsetPending'

    if TowerTopStageData.UnlockLayer < (TowerTopStageData.TowerLayerNumber)[eachData.towerId] then
      TowerTopStageData.UnlockLayer = (TowerTopStageData.TowerLayerNumber)[eachData.towerId]
    end
    subCount = #eachData.towerSatge
    for j = 1, subCount do
      subData = (eachData.towerSatge)[j]
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R15 in 'UnsetPending'

      ;
      ((TowerTopStageData.BaseInfo)[eachData.towerId])[subData.towerStageId] = subData
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R15 in 'UnsetPending'

      ;
      (TowerTopStageData.UnlockStage)[eachData.towerId] = (TowerTopStageData.UnlockStage)[eachData.towerId] + 1
    end
  end
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R7 in 'UnsetPending'

  TowerTopStageData.CurrentLayer = (TowerTopStageData.TowerLayerData)[TowerTopStageData.UnlockLayer]
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.InitLuckyInfo = function(...)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  TowerTopStageData.CurrentLucky = (CardData.GetFormationLucky)(TowerTopStageData.FormationInfo)
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.GetAllStageConfigByLayer = function(lyaerId, ...)
  -- function num : 0_6 , upvalues : _ENV
  local curLayerStageConfig = {}
  local layerConfig = ((TableData.gTable).BaseTowerData)[lyaerId]
  local stageIdList = split(layerConfig.stages, ":")
  for _,v in ipairs(stageIdList) do
    local stageConfig = ((TableData.gTable).BaseTowerStageData)[tonumber(v)]
    ;
    (table.insert)(curLayerStageConfig, stageConfig)
  end
  return curLayerStageConfig
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.UpdateExpandData = function(data, ...)
  -- function num : 0_7 , upvalues : _ENV
  if data.towerStage == nil then
    return 
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((TowerTopStageData.BaseInfo)[TowerTopStageData.CurrentLayer])[(data.towerStage).towerStageId] = data.towerStage
  if data.nextTowerStage ~= nil then
    local count = #(TowerTopStageData.TowerStageData)[TowerTopStageData.CurrentLayer]
    local layerId = nil
    for i = 1, count do
      if ((TowerTopStageData.TowerStageData)[TowerTopStageData.CurrentLayer])[i] == (data.nextTowerStage).towerStageId then
        layerId = TowerTopStageData.CurrentLayer
        break
      end
    end
    do
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

      if layerId == nil then
        TowerTopStageData.UnlockLayer = TowerTopStageData.UnlockLayer + 1
        layerId = (TowerTopStageData.TowerLayerData)[TowerTopStageData.UnlockLayer]
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (TowerTopStageData.BaseInfo)[layerId] = {}
        -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (TowerTopStageData.UnlockStage)[layerId] = 1
      else
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (TowerTopStageData.UnlockStage)[TowerTopStageData.CurrentLayer] = (TowerTopStageData.UnlockStage)[TowerTopStageData.CurrentLayer] + 1
      end
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((TowerTopStageData.BaseInfo)[layerId])[(data.nextTowerStage).towerStageId] = data.nextTowerStage
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R3 in 'UnsetPending'

      if (TowerTopStageData.UnlockStage)[layerId] == 1 then
        TowerTopStageData.CurrentLayer = layerId
      end
    end
  end
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.GetActualRewardItem = function(first, id, amount, type, ...)
  -- function num : 0_8
  local item = {}
  item.First = first
  item.Id = id
  item.Amount = amount
  item.Type = type
  return item
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.GetActualReward = function(data, ...)
  -- function num : 0_9 , upvalues : _ENV
  local basicReward = {}
  local extraReward = {}
  local firstReward = {}
  local goods = {}
  local count, eachData = nil, nil
  if data.isFirst then
    count = #data.firstGoods
    for i = 1, count do
      eachData = (data.firstGoods)[i]
      if eachData.type == PropType.EQUIP or goods[eachData.id] == nil then
        (table.insert)(firstReward, (TowerTopStageData.GetActualRewardItem)(true, eachData.id, eachData.value, eachData.type))
        goods[eachData.id] = #firstReward
      else
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (firstReward[goods[eachData.id]]).Amount = (firstReward[goods[eachData.id]]).Amount + eachData.value
      end
    end
  end
  do
    ;
    (table.sort)(firstReward, TowerTopStageData.Sort)
    goods = {}
    local basicGoods = {}
    count = #data.basicGoods
    for i = 1, count do
      eachData = (data.basicGoods)[i]
      if eachData.type == PropType.EQUIP or goods[eachData.id] == nil then
        (table.insert)(basicGoods, (TowerTopStageData.GetActualRewardItem)(false, eachData.id, eachData.value, eachData.type))
        goods[eachData.id] = #basicGoods
      else
        -- DECOMPILER ERROR at PC101: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (basicGoods[goods[eachData.id]]).Amount = (basicGoods[goods[eachData.id]]).Amount + eachData.value
      end
    end
    ;
    (table.sort)(basicGoods, TowerData.Sort)
    count = #basicGoods
    for i = 1, count do
      (table.insert)(basicReward, basicGoods[i])
    end
    goods = {}
    count = #data.extGoods
    local eachData = nil
    for i = 1, count do
      eachData = (data.extGoods)[i]
      if eachData.type == PropType.EQUIP or goods[eachData.id] == nil then
        (table.insert)(extraReward, (TowerData.GetActualRewardItem)(false, eachData.id, eachData.value, eachData.type))
        goods[eachData.id] = #extraReward
      else
        -- DECOMPILER ERROR at PC164: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (extraReward[goods[eachData.id]]).Amount = (extraReward[goods[eachData.id]]).Amount + eachData.value
      end
    end
    ;
    (table.sort)(extraReward, TowerData.Sort)
    return basicReward, extraReward, firstReward
  end
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.GetLayerOpenById = function(config, ...)
  -- function num : 0_10 , upvalues : _ENV
  local open = true
  local openTime, endTime = (TowerTopStageMgr.GetEntranceTime)(config)
  if openTime == 0 and endTime == 0 then
    open = false
  end
  return open
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.GetCurrentTowerBGAndBGM = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local config = ((TableData.gTable).BaseTowerData)[TowerTopStageData.CurrentLayer]
  return config.background_path, config.bgm_id
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.GetReward = function(layer, stage, ...)
  -- function num : 0_12 , upvalues : _ENV
  local detail, count = nil, nil
  local basicReward = {}
  local config = ((TableData.gTable).BaseTowerStageData)[stage]
  if (TowerTopStageData.BaseInfo)[layer] == nil or ((TowerTopStageData.BaseInfo)[layer])[stage] == nil or (((TowerTopStageData.BaseInfo)[layer])[stage]).isPass == false then
    detail = split(config.first_reward, ",")
    count = #detail
    for i = 1, count do
      (table.insert)(basicReward, (TowerTopStageData.GetRewardItem)(true, detail[i]))
    end
  end
  do
    detail = split(config.drop_show, ",")
    count = #detail
    local item = nil
    for i = 1, count do
      (table.insert)(basicReward, (TowerTopStageData.GetRewardItem)(false, detail[i]))
    end
    local luckyReward = {}
    detail = split(config.ext_drop_show, ",")
    count = #detail
    for i = 1, count do
      item = (TowerTopStageData.GetRewardItem)(false, detail[i], true)
      ;
      (table.insert)(luckyReward, item)
    end
    return basicReward, luckyReward
  end
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageData.GetRewardItem = function(first, data, lucky, ...)
  -- function num : 0_13 , upvalues : _ENV
  local item = {}
  item.First = first
  local info = split(data, ":")
  item.Id = tonumber(info[2])
  item.Type = tonumber(info[1])
  item.LuckyCondition = 0
  item.Lucky = lucky or false
  local value = tonumber(info[3])
  if value == nil then
    return item
  end
  if first then
    item.Amount = value
  else
    -- DECOMPILER ERROR at PC35: Unhandled construct in 'MakeBoolean' P1

    if lucky and TowerTopStageData.CurrentLucky < value then
      item.LuckyCondition = value
    end
  end
  item.Chance = value
  return item
end

;
(TowerTopStageData.InitData)()

