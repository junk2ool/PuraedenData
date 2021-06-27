-- params : ...
-- function num : 0 , upvalues : _ENV
NewActivityDungeonData = {}
local self = NewActivityDungeonData
ADStatus = {None = 1, AD = 2, NAD = 3, BOTH = 4}
NADAdventueStatus = {None = 0, Exploring = 1, Finish = 2}
NADExplorationEventType = {Normal = 1, Reward = 2, Begin = 3, Finish = 4}
-- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.ACTIVITY_EXPLAIN = 33001401
-- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.ActivityDungeonStatus = ADStatus.None
-- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.NADData = nil
-- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.ADExplainPicData = {}
-- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.ShopData = {}
-- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.RoleNeedGoods = {}
-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.BuyingData = nil
-- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.BuyingType = nil
-- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.BuyingItem = nil
-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.SlotsConfig = nil
-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.RoundDataList = {}
-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.RoundData = {}
-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.AimListData = {}
-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.BasicListData = {}
-- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.CurrentTimes = 0
-- DECOMPILER ERROR at PC60: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.MaxTimes = 0
-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.ConfigMax = nil
-- DECOMPILER ERROR at PC64: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.CurrentEachCost = 0
-- DECOMPILER ERROR at PC66: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.AdventureInit = false
-- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.AssistData = nil
-- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.RewardShowData = {}
-- DECOMPILER ERROR at PC73: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.KeepNotify = false
-- DECOMPILER ERROR at PC75: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.PlayerFC = 0
-- DECOMPILER ERROR at PC77: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.EnemyFC = 0
-- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.ChapterData = {}
-- DECOMPILER ERROR at PC82: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.CurrentDungeon = nil
-- DECOMPILER ERROR at PC84: Confused about usage of register: R1 in 'UnsetPending'

NewActivityDungeonData.AdventureData = nil
local _beginEventId, _finishEventId = nil, nil
-- DECOMPILER ERROR at PC88: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.InitADExplainPicData = function(...)
  -- function num : 0_0 , upvalues : _ENV
  if (_G.next)(NewActivityDungeonData.ADExplainPicData) == nil then
    local config = ((TableData.gTable).BaseActivityData)[NewActivityDungeonData.ACTIVITY_EXPLAIN]
    local picInfo = split(config.pic, ",")
    for index,value in ipairs(picInfo) do
      (table.insert)(NewActivityDungeonData.ADExplainPicData, value)
    end
  end
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.InitBuyingData = function(data, ...)
  -- function num : 0_1 , upvalues : self, _ENV
  self.BuyingData = data
  local PoolData = ((TableData.gTable).BaseShopPoolData)[(self.BuyingData).poolID]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  self.BuyingType = tonumber(configItem[1])
  self.BuyingItem = (Util.GetConfigByItemIDAndType)(tonumber(configItem[2]), self.BuyingType)
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.GetNADConsumptionIdAndNum = function(times, ...)
  -- function num : 0_2 , upvalues : _ENV, self
  local PoolData = ((TableData.gTable).BaseShopPoolData)[(self.BuyingData).poolID]
  local consumeConfigs = ((Util.ParseConfigStr)(PoolData.sell_price))[1]
  local costNum = 0
  local getNum = 0
  local costType, str, getStr = nil, nil, nil
  for i = 1, times do
    str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, (self.BuyingData).buyTime + i - 1)
    costNum = costNum + tonumber(str[3])
    costType = tonumber(str[1])
    getStr = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, (self.BuyingData).buyTime + i - 1)
    getNum = getNum + tonumber(getStr[3])
  end
  return consumeConfigs[2], costNum, tonumber(consumeConfigs[1]), getNum, costType
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.GetNADMaxPhysicalTimes = function(...)
  -- function num : 0_3 , upvalues : self, _ENV
  local maxTime = (self.BuyingData).MaxNum
  local PoolData = ((TableData.gTable).BaseShopPoolData)[(self.BuyingData).poolID]
  local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, 1)
  if tonumber(str[2]) ~= AssetType.PHYSICAL then
    return maxTime
  end
  local FixedData = ((TableData.gTable).BaseFixedData)[Const.MaxPhysicalFixedID]
  local configData = split(FixedData.array_value, ":")
  local max = tonumber(configData[2])
  local remain = max - (ActorData.GetAssetCount)(AssetType.PHYSICAL)
  local count = 0
  for i = 1, maxTime do
    local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, i - 1)
    count = count + tonumber(str[3])
    if remain < count then
      return (math.max)(i - 1, 1)
    end
  end
  return maxTime
end

-- DECOMPILER ERROR at PC100: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.GetNADMaxBuyTimes = function(...)
  -- function num : 0_4 , upvalues : self, _ENV
  local maxTime = (self.BuyingData).MaxNum
  while 1 do
    while 1 do
      if maxTime > 0 then
        local itemId, Num = (NewActivityDungeonData.GetNADConsumptionIdAndNum)(maxTime)
        local haveNum = (ActorData.GetAssetCount)(tonumber(itemId))
        if tonumber(itemId) == AssetType.DIAMOND_BIND then
          haveNum = (ActorData.GetAssetCount)(AssetType.DIAMOND) + haveNum
        end
        if Num <= haveNum then
          do return maxTime end
          -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    maxTime = maxTime - 1
  end
  do
    return 1
  end
end

-- DECOMPILER ERROR at PC103: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.InitSlotsRelativeData = function(...)
  -- function num : 0_5 , upvalues : _ENV
  (NewActivityDungeonData.InitSlotsConfig)()
  ;
  (NewActivityDungeonData.InitRoundDataList)()
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.InitSlotsConfig = function(...)
  -- function num : 0_6 , upvalues : _ENV, self
  local type = (SlotsData.GetCurrentType)()
  local ShowData = (TableData.gTable).BaseSlotsData
  for _,v in pairs(ShowData) do
    if v.type == type then
      self.SlotsConfig = v
      break
    end
  end
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.InitRoundDataList = function(...)
  -- function num : 0_7 , upvalues : _ENV, self
  local mData = (TableData.gTable).BaseSlotsRoundData
  self.RoundDataList = {}
  for _,v in pairs(mData) do
    if v.type == (self.SlotsConfig).type then
      (table.insert)(self.RoundDataList, v)
    end
  end
  ;
  (table.sort)(self.RoundDataList, function(a, b, ...)
    -- function num : 0_7_0
    do return a.num_round < b.num_round end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC112: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.GetRemainCount = function(...)
  -- function num : 0_8 , upvalues : _ENV, self
  local mData = nil
  for k,v in ipairs(self.RoundDataList) do
    if v.num_round == (SlotsData.SlotRound)() then
      mData = v
    end
  end
  local PoolData = (TableData.gTable).BaseSlotsPoolData
  local count = 0
  local get = 0
  for k,v in pairs(PoolData) do
    if v.type == mData.pool then
      count = count + v.reward_max
      local times = (SlotsData.GetItemTimes)(mData.num_round, v.id)
      if times > 0 then
        get = get + times
      end
    end
  end
  return count - (get)
end

-- DECOMPILER ERROR at PC115: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.SetRoundData = function(data, ...)
  -- function num : 0_9 , upvalues : self, _ENV
  self.RoundData = data
  local mData = (TableData.gTable).BaseSlotsPoolData
  self.AimListData = {}
  self.BasicListData = {}
  for _,v in pairs(mData) do
    if v.type == (self.RoundData).pool then
      if v.reward_lab == 1 then
        (table.insert)(self.AimListData, v)
      else
        ;
        (table.insert)(self.BasicListData, v)
      end
    end
  end
  ;
  (table.sort)(self.AimListData, function(a, b, ...)
    -- function num : 0_9_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(self.BasicListData, function(a, b, ...)
    -- function num : 0_9_1
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC118: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.GetLotteryColor = function(goods, equip, ...)
  -- function num : 0_10 , upvalues : _ENV
  local id = 0
  for _,v in pairs(goods) do
    if v.value >= 0 then
      id = v.id
    end
    do break end
  end
  do
    for _,v in pairs(equip) do
      id = v.id
      do break end
    end
    do
      local configData, type = (Util.GetConfigDataByID)(id)
      if type == PropType.ITEM or type == PropType.ASSET then
        return configData.quality
      else
        if type == PropType.CARD then
          return configData.intelligence + 1
        else
          if type == PropType.EQUIP then
            return configData.intelligence
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC121: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.GetAimCount = function(List, ...)
  -- function num : 0_11 , upvalues : _ENV, self
  local roundNum = (SlotsData.SlotRound)()
  local count = 0
  local getCount = 0
  for _,v in pairs(List) do
    count = count + v.reward_max
    local times = (SlotsData.GetItemTimes)((self.RoundData).num_round, v.id)
    if times == -1 then
      times = v.reward_max
    end
    if roundNum == (self.RoundData).num_round then
      local get = times
      getCount = getCount + get
    else
      do
        do
          if (self.RoundData).num_round < roundNum then
            getCount = times + (getCount)
          else
            getCount = 0
          end
          -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return count, getCount
end

-- DECOMPILER ERROR at PC124: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.InitAdventureData = function(data, ...)
  -- function num : 0_12 , upvalues : _beginEventId, _ENV, _finishEventId, self
  if _beginEventId == nil then
    local configs = (TableData.gTable).BaseActivityRiskEventData
    for k,v in pairs(configs) do
      if v.event_type == NADExplorationEventType.Begin then
        _beginEventId = k
      else
        if v.event_type == NADExplorationEventType.End then
          _finishEventId = k
        end
      end
    end
  end
  do
    self.AdventureData = {}
    local count = #data
    local eachData = nil
    for i = 1, count do
      eachData = data[i]
      ;
      (NewActivityDungeonData.InitSingleAdventureData)(eachData)
    end
  end
end

-- DECOMPILER ERROR at PC127: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.InitSingleAdventureData = function(eachData, ...)
  -- function num : 0_13 , upvalues : _ENV, self
  (NewActivityDungeonData.UpdateStatus)(eachData)
  ;
  (NewActivityDungeonData.MergeRewards)(eachData)
  local config = ((TableData.gTable).BaseActivityRiskStageData)[eachData.id]
  eachData.updateTime = (NewActivityDungeonData.GetNextRefreshTimestamp)(eachData.beginTime, config.explore_time, config.event_refresh_time)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.AdventureData)[eachData.id] = eachData
end

-- DECOMPILER ERROR at PC130: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.MergeRewards = function(eachData, ...)
  -- function num : 0_14 , upvalues : _ENV
  eachData.reward = {}
  if eachData.event ~= nil then
    local rewards = {}
    local count = #eachData.event
    local event, item, subCount = nil, nil, nil
    for i = 1, count do
      event = (eachData.event)[i]
      if event.reward ~= nil then
        subCount = #event.reward
        for j = 1, subCount do
          item = (event.reward)[j]
          if rewards[item.id] == nil then
            rewards[item.id] = (Util.Copy)(item)
          else
            -- DECOMPILER ERROR at PC44: Confused about usage of register: R14 in 'UnsetPending'

            ;
            (rewards[item.id]).value = (rewards[item.id]).value + item.value
          end
        end
      end
    end
    for k,v in pairs(rewards) do
      (table.insert)(eachData.reward, v)
    end
  end
end

-- DECOMPILER ERROR at PC133: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.UpdateStatus = function(eachData, ...)
  -- function num : 0_15 , upvalues : _ENV
  if eachData == nil then
    return 
  end
  local timeStamp = (ActorData.GetServerTime)()
  if eachData.endTime ~= nil and eachData.endTime < timeStamp then
    eachData.status = NADAdventueStatus.Finish
  else
    eachData.status = NADAdventueStatus.Exploring
  end
end

-- DECOMPILER ERROR at PC136: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.GetNextRefreshTimestamp = function(beginTime, exploreTime, eventRefreshTime, ...)
  -- function num : 0_16 , upvalues : _ENV
  exploreTime = exploreTime * 1000
  eventRefreshTime = eventRefreshTime * 1000
  local curTime = (ActorData.GetServerTime)()
  local passedTime = curTime - beginTime
  local nextInterval1 = exploreTime - passedTime % (exploreTime)
  local nextInterval2 = eventRefreshTime - passedTime % (eventRefreshTime)
  local nextInterval = (math.min)(nextInterval1, nextInterval2)
  return curTime + nextInterval
end

-- DECOMPILER ERROR at PC139: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.RefreshEachExploreCost = function(config, ...)
  -- function num : 0_17 , upvalues : self, _ENV
  self.CurrentEachCost = {}
  local costInfo = split(config.need_vit, ",")
  costInfo = split(costInfo[1], ":")
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.CurrentEachCost).Id = tonumber(costInfo[2])
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.CurrentEachCost).Value = tonumber(costInfo[3])
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.CurrentEachCost).Type = tonumber(costInfo[1])
  self.MaxTimes = (ActorData.GetAssetCount)((NewActivityDungeonData.CurrentEachCost).Id) / (NewActivityDungeonData.CurrentEachCost).Value
  self.MaxTimes = (math.floor)(self.MaxTimes)
  local configMax = (math.floor)(config.max_explore_time / config.explore_time)
  if self.MaxTimes < configMax then
    self.ConfigMax = false
  else
    self.ConfigMax = true
    self.MaxTimes = configMax
  end
  if self.MaxTimes <= 0 then
    self.MaxTimes = 1
  end
end

-- DECOMPILER ERROR at PC142: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.CheckTimeUp = function(config, times, showTips, ...)
  -- function num : 0_18 , upvalues : _ENV
  local time = (LuaTime.GetTimeStamp)()
  local endTime = (math.ceil)((NewActivityDungeonData.NADData).endTime * 0.001)
  do
    if endTime < time + times * config.explore_time then
      local leftTime = endTime - time
      if leftTime <= 0 then
        times = 0
        if showTips then
          (MessageMgr.SendCenterTips)((PUtil.get)(60000657))
        end
      else
        times = (math.floor)(leftTime / config.explore_time)
        if showTips then
          (MessageMgr.SendCenterTips)((PUtil.get)(60000656, (LuaTime.GetFormatTimeStr)("%H:%M:%S", endTime)))
        end
      end
    end
    if times == 0 then
      times = 1
    end
    return times
  end
end

-- DECOMPILER ERROR at PC145: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.InitChapterData = function(...)
  -- function num : 0_19 , upvalues : self, _ENV
  self.ChapterData = {}
  local activityChapter = {}
  local activityChapterConfigs = (TableData.gTable).BaseActivityChapterData
  local chapterConfigs = (TableData.gTable).BaseChapterData
  local config = nil
  for k,v in pairs(activityChapterConfigs) do
    config = chapterConfigs[v.normal_chapter]
    if config.type == (ProtoEnum.E_CHALLENGE_TYPE).NEW_ACTIVITY_CHALLENGE then
      (table.insert)(activityChapter, v)
    end
  end
  ;
  (table.sort)(activityChapter, function(x, y, ...)
    -- function num : 0_19_0
    if x.sort == y.sort then
      return false
    else
      return x.sort < y.sort
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  local count = #activityChapter
  local chapterInfo, stageInfo, subCount = nil, nil, nil
  for i = 1, count do
    chapterInfo = {}
    chapterInfo.Id = (activityChapter[i]).normal_chapter
    chapterInfo.Map = (activityChapter[i]).set_style
    chapterInfo.Name = (activityChapter[i]).name
    config = chapterConfigs[chapterInfo.Id]
    stageInfo = split(config.stages, ":")
    subCount = #stageInfo
    chapterInfo.Stages = {}
    for j = 1, subCount do
      (table.insert)(chapterInfo.Stages, tonumber(stageInfo[j]))
    end
    ;
    (table.insert)(self.ChapterData, chapterInfo)
  end
end

-- DECOMPILER ERROR at PC148: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.InitShowRewardData = function(...)
  -- function num : 0_20 , upvalues : _ENV, self
  if (_G.next)(self.RewardShowData) ~= nil then
    return 
  end
  local configs = (TableData.gTable).BaseActivityPhaseRewardData
  for k,v in pairs(configs) do
    (table.insert)(self.RewardShowData, {Id = v.id, Value = v.need_hp * 0.01})
  end
  ;
  (table.sort)(self.RewardShowData, function(x, y, ...)
    -- function num : 0_20_0
    if x.Value == y.Value then
      return false
    else
      return y.Value < x.Value
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC151: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.GetChapterIndex = function(...)
  -- function num : 0_21 , upvalues : _ENV
  local count = #NewActivityDungeonData.ChapterData
  local chapterIndex = 1
  local stageIndex, chapterItem, subCount = nil, nil, nil
  for i = 1, count do
    chapterItem = (NewActivityDungeonData.ChapterData)[i]
    subCount = #chapterItem.Stages
    for j = 1, subCount do
      if (PlotDungeonMgr.GetDungeonStatus)((chapterItem.Stages)[j]) ~= StageStatus.Lock and (PlotDungeonMgr.IsCanChallenge)((chapterItem.Stages)[j], false) then
        chapterIndex = i
        stageIndex = j
      end
    end
  end
  if stageIndex == nil then
    chapterIndex = count
    stageIndex = #((NewActivityDungeonData.ChapterData)[chapterIndex]).Stages
  end
  return chapterIndex, stageIndex
end

-- DECOMPILER ERROR at PC154: Confused about usage of register: R3 in 'UnsetPending'

NewActivityDungeonData.ResetData = function(...)
  -- function num : 0_22 , upvalues : self, _ENV
  self.ActivityDungeonStatus = ADStatus.None
  self.NADData = nil
  self.RoleNeedGoods = {}
  self.BuyingData = nil
  self.BuyingType = nil
  self.BuyingItem = nil
  self.SlotsConfig = nil
  self.RoundDataList = {}
  self.RoundData = {}
  self.ChapterData = {}
  self.AimListData = {}
  self.BasicListData = {}
  self.CurrentTimes = 0
  self.MaxTimes = 0
  self.CurrentEachCost = 0
  self.AdventureInit = false
  self.AssistData = nil
  self.KeepNotify = false
end


