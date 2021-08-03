-- params : ...
-- function num : 0 , upvalues : _ENV
TowerTopStageMgr = {}
local self = TowerTopStageMgr
require("TowerTopStageData")
-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.TryOpenTowerTopStageUI = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (TowerTopStageService.ReqTowerExpandData)(true)
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.RecvTowerTopStageData = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  TowerTopStageData.FormationInfo = msg.cardInfo
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  TowerTopStageData.TowerExpandList = msg.tower
  ;
  (TowerTopStageData.SetChangFc)(msg.changeFc)
  ;
  (TowerTopStageData.InitExpandData)(msg.tower)
  ;
  (TowerTopStageData.FilterTower)(msg.tower)
  ;
  (TowerTopStageMgr.OpenTowerTopStageUI)()
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.OpenTowerTopStageUI = function(...)
  -- function num : 0_2 , upvalues : _ENV
  OpenWindow((WinResConfig.TowerTopStageWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.CheckExpandAvailable = function(layerId, stageId, ...)
  -- function num : 0_3 , upvalues : _ENV
  if (TowerTopStageData.BaseInfo)[layerId] == nil then
    (TowerTopStageMgr.CheckExpandLayerLockReasonById)(layerId)
    return false
  end
  if (TowerTopStageData.UnlockStage)[layerId] < ((TowerTopStageData.TowerStageNumber)[layerId])[stageId] then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000091))
    return false
  end
  return true
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.CheckExpandLayerLockReasonById = function(layerId, ...)
  -- function num : 0_4 , upvalues : _ENV
  local config = ((TableData.gTable).BaseTowerData)[layerId]
  local conditions = (split(config.open_condition, ","))
  -- DECOMPILER ERROR at PC8: Overwrote pending register: R3 in 'AssignReg'

  local condition = .end
  local count = #conditions
  for i = 1, count do
    condition = split(conditions[i], ":")
    if tonumber(condition[1]) == ConditionType.PLAYER_LEVEL then
      if tonumber(condition[3]) <= (ActorData.GetLevel)() then
        (MessageMgr.SendCenterTips)((PUtil.get)(60000091))
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(60000090, tonumber(condition[3])))
      end
    end
  end
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.SetEquipDesc = function(list, attributes, buffIdList, ...)
  -- function num : 0_5 , upvalues : _ENV
  list:RemoveChildrenToPool()
  local height = (list.margin).top
  height = height + (TowerTopStageMgr.SetSuitBuff)(list, buffIdList)
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.SetSuitBuff = function(list, buffIdList, ...)
  -- function num : 0_6 , upvalues : _ENV
  local height = 0
  height = (TowerTopStageMgr.AddSeperater)(list, 40002081) + list.lineGap
  height = height + (TowerTopStageMgr.AddSingleSuit)(list, buffIdList)
  return height
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.AddSingleSuit = function(list, buffIdList, ...)
  -- function num : 0_7 , upvalues : _ENV
  local item = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.TowerTopStageWindow).package, TowerTopStageData.EQUIP_LIST_SUIT_DESC))
  ;
  (item:GetChild("WordTxt")).text = buffIdList
  return item.height
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.SetAttribute = function(list, attributes, ...)
  -- function num : 0_8 , upvalues : _ENV
  local height = 0
  local count = #attributes
  for i = 1, count do
    if i == 1 then
      height = (TowerTopStageMgr.AddSeperater)(list, 60000445) + list.lineGap
    end
    height = height + (TowerTopStageMgr.AddSingleAttr)(list, attributes[i])
  end
  return height
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.AddSeperater = function(list, content, resources, ...)
  -- function num : 0_9 , upvalues : _ENV
  if not resources then
    resources = TowerTopStageData.EQUIP_LIST_TITLE
  end
  local seperater = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.TowerTopStageWindow).package, resources))
  ;
  (seperater:GetChild("NameTxt")).text = (PUtil.get)(content)
  return seperater.height
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.AddSingleAttr = function(list, attribute, ...)
  -- function num : 0_10 , upvalues : _ENV
  local item = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.TowerTopStageWindow).package, TowerTopStageData.EQUIP_LIST_ATTRIBUTE_DESC))
  local attributeId = (split(attribute, ":"))[1]
  local num = (split(attribute, ":"))[2]
  local attributeConfig = ((TableData.gTable).BaseAttributeData)[tonumber(attributeId)]
  ;
  (item:GetChild("NameTxt")).text = "[color=" .. EquiptAttrColor[attributeConfig.type] .. "]" .. attributeConfig.display_name .. "[/color]"
  ;
  (item:GetChild("NumberTxt")).text = "[color=" .. EquiptAttrColor[attributeConfig.type] .. "]" .. num .. "[/color]"
  return item.height
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.GetEntranceType = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local count = #TowerTopStageData.TowerList
  if count < 2 then
    return 1
  else
    return 2
  end
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.CheckEntranceOpen = function(expandConfig, ...)
  -- function num : 0_12 , upvalues : _ENV
  local configOpen = false
  local timeOpen = false
  local towerId = split(expandConfig.towerId, ":")
  for k,v in pairs(towerId) do
    for a,b in pairs(TowerTopStageData.TowerExpandList) do
      if b.towerId == tonumber(v) then
        configOpen = true
      end
    end
  end
  if #towerId > 1 then
    configOpen = true
  end
  if (TowerTopStageData.GetLayerOpenById)(expandConfig) then
    timeOpen = true
  end
  if timeOpen and configOpen then
    return true
  else
    return false
  end
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.GetEntranceTime = function(config, ...)
  -- function num : 0_13 , upvalues : _ENV
  local beginTime = (((ActivityMgr.InitTowerExpandData)()).baseActivityInfo).beginTime
  local endTime = (((ActivityMgr.InitTowerExpandData)()).baseActivityInfo).endTime
  local curTime = (LuaTime.GetTimeStamp)() * 1000
  local timeTable = {}
  local timeConfig = split(config.openTime, ",")
  local timeConfigCount = #timeConfig
  for i = 1, timeConfigCount do
    local sTime = tonumber((split(timeConfig[i], ":"))[1])
    local oTime = tonumber((split(timeConfig[i], ":"))[2])
    local time = {start = sTime, over = oTime}
    timeTable[i] = time
  end
  local openTime = 0
  local shutTime = 0
  for k,v in ipairs(timeTable) do
    local sTime = v.start * 1000
    local oTime = v.over * 1000
    local openTime = beginTime + sTime
    local shutTime = beginTime + oTime
    if curTime >= openTime and (shutTime >= curTime or endTime >= openTime) then
      if (shutTime < beginTime and shutTime >= openTime) or openTime < beginTime then
        openTime = beginTime
      end
      if endTime < shutTime then
        shutTime = endTime
      end
      return openTime, shutTime
    end
  end
  return openTime, shutTime
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.GetEnterNextOpenTime = function(config, ...)
  -- function num : 0_14 , upvalues : _ENV
  local openTime = 0
  local timeTable = {}
  local beginTime = (((ActivityMgr.InitTowerExpandData)()).baseActivityInfo).beginTime
  local endTime = (((ActivityMgr.InitTowerExpandData)()).baseActivityInfo).endTime
  local curTime = (LuaTime.GetTimeStamp)() * 1000
  local timeConfig = split(config.openTime, ",")
  local timeConfigCount = #timeConfig
  for i = 1, timeConfigCount do
    local sTime = tonumber((split(timeConfig[i], ":"))[1])
    local oTime = tonumber((split(timeConfig[i], ":"))[2])
    local time = {start = sTime, over = oTime}
    timeTable[i] = time
  end
  for k,v in ipairs(timeTable) do
    local sTime = v.start * 1000
    local oTime = v.over * 1000
    local openTime = beginTime + sTime
    local shutTime = beginTime + oTime
    if curTime < openTime then
      return openTime
    end
  end
  return openTime
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.GetOldData = function(...)
  -- function num : 0_15 , upvalues : _ENV
  local data = {}
  for k,v in pairs(TowerTopStageData.TowerExpandList) do
    for a,b in pairs(TowerTopStageData.InterTypeSort) do
      local towerId = b.towerId
      for x,y in pairs(towerId) do
        if b.type == 2 and tonumber(y) == v.towerId then
          return tonumber(y)
        end
      end
    end
  end
  return nil
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.RefreshReceiveMsg = function(...)
  -- function num : 0_16 , upvalues : _ENV
  local tower = TowerTopStageData.TowerExpandList
  local towerId = TowerTopStageData.CurrentLayer
  local towerConfig = ((TableData.gTable).BaseTowerData)[towerId]
  ;
  (TowerTopStageData.InitExpandData)(tower)
  ;
  (TowerTopStageData.FilterTower)(tower)
  OpenWindow((WinResConfig.TowerExpandBattleWindow).name, UILayer.HUD, towerConfig)
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.TowerExpandFc = function(fc, ...)
  -- function num : 0_17 , upvalues : self
  if fc == nil then
    return self.towerExpandFc
  else
    self.towerExpandFc = fc
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.CurStageId = function(id, ...)
  -- function num : 0_18 , upvalues : self
  if id == nil then
    return self.towerStageId
  else
    self.towerStageId = id
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

TowerTopStageMgr.BeforeCloseFormation = function(formation, cb, ...)
  -- function num : 0_19 , upvalues : _ENV
  (Util.BeforeCloseFormation)(formation, cb, function(...)
    -- function num : 0_19_0 , upvalues : _ENV
    return (Util.CovertRemoteFormationToLocal)(TowerTopStageData.FormationInfo), 60000062
  end
, function(newFormation, ...)
    -- function num : 0_19_1 , upvalues : _ENV
    (TowerTopStageService.ReqTowerCardGroups)(newFormation)
  end
)
end


