-- params : ...
-- function num : 0 , upvalues : _ENV
NewActivityDungeonMgr = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.TryOpenNAD = function(...)
  -- function num : 0_0 , upvalues : _ENV
  if NewActivityDungeonData.NADData == nil then
    (ActivityService.OnReqActivityInfo)((ActivityMgr.ActivityType).NewActivityDungeon)
  end
  ;
  (PlotDungeonService.ReqStoryInfo)((ProtoEnum.E_CHALLENGE_TYPE).NEW_ACTIVITY_CHALLENGE)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.OpenActivityExplatin = function(...)
  -- function num : 0_1 , upvalues : _ENV
  (NewActivityDungeonData.InitADExplainPicData)()
  OpenWindow((WinResConfig.NewActivityExplainWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.RefreshADStatus = function(...)
  -- function num : 0_2 , upvalues : _ENV
  local data = nil
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  NewActivityDungeonData.ActivityDungeonStatus = ADStatus.None
  local list = (ActivityMgr.GetOpenActivityList)()
  for k,v in ipairs(list) do
    data = ((TableData.gTable).BaseActivityData)[v]
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

    if data then
      if data.type == (ActivityMgr.ActivityType).ActivityDungeon then
        NewActivityDungeonData.ActivityDungeonStatus = ADStatus.AD
      else
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

        if data.type == (ActivityMgr.ActivityType).NewActivityDungeon then
          NewActivityDungeonData.ActivityDungeonStatus = ADStatus.NAD
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.CheckNADPurchaseTimes = function(times, isShowTips, ...)
  -- function num : 0_3 , upvalues : _ENV
  if times <= 0 then
    if isShowTips then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000076))
    end
    return false
  else
    if (NewActivityDungeonData.BuyingData).MaxNum < times then
      if isShowTips then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000077))
      end
      return false
    else
      local itemId, Num = (NewActivityDungeonData.GetNADConsumptionIdAndNum)(times)
      local haveNum = (ActorData.GetAssetCount)(tonumber(itemId))
      local asset = ((TableData.gTable).BaseAssetData)[tonumber(itemId)]
      if tonumber(itemId) == AssetType.DIAMOND_BIND then
        haveNum = (ActorData.GetAssetCount)(AssetType.DIAMOND) + haveNum
      end
      if haveNum < Num then
        if isShowTips then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000125, asset.name))
        end
        return false
      end
    end
  end
  do
    return true
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.ChangeNADPurchaseTime = function(origin, value, showTips, ...)
  -- function num : 0_4 , upvalues : _ENV
  origin = tonumber(origin)
  local times = origin + value
  if value >= 0 then
    local maxTime = (NewActivityDungeonData.GetNADMaxBuyTimes)()
    local maxPhysical = (NewActivityDungeonData.GetNADMaxPhysicalTimes)()
    maxTime = (math.min)(maxTime, maxPhysical)
    if maxTime <= origin and (NewActivityDungeonData.BuyingItem).id == AssetType.PHYSICAL then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
      return 
    end
    if value == 0 then
      times = maxTime
    else
      times = (math.min)(origin + value, maxTime)
      if maxTime < (NewActivityDungeonData.BuyingData).MaxNum and origin == maxTime then
        local itemId = (NewActivityDungeonData.GetNADConsumptionIdAndNum)(origin)
        local asset = ((TableData.gTable).BaseAssetData)[tonumber(itemId)]
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000125, asset.name))
        return 
      end
      do
        do
          if not (NewActivityDungeonMgr.CheckNADPurchaseTimes)(times, maxTime == origin) then
            times = maxTime
          end
          if (NewActivityDungeonData.BuyingItem).id == AssetType.PHYSICAL and (NewActivityDungeonData.GetNADMaxBuyTimes)() <= origin then
            (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
            return 
          end
          if (NewActivityDungeonMgr.CheckNADPurchaseTimes)(times, showTips) then
            UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonShopBuyWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_PURCHASE_INFO, times)
          end
          -- DECOMPILER ERROR: 4 unprocessed JMP targets
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.NADPurchaseItem = function(times, itemName, ...)
  -- function num : 0_5 , upvalues : _ENV
  local itemId, Num, getId, getNum, type = (NewActivityDungeonData.GetNADConsumptionIdAndNum)(times)
  ;
  (MessageMgr.OpenCostResConfirmWindow)(60000523, type .. ":" .. itemId .. ":" .. Num, function(...)
    -- function num : 0_5_0 , upvalues : _ENV, getNum, times
    local PoolData = ((TableData.gTable).BaseShopPoolData)[(NewActivityDungeonData.BuyingData).poolID]
    local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, (NewActivityDungeonData.BuyingData).buyTime)
    if NewActivityDungeonData.BuyingType == PropType.EQUIP and (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Shop, nil, true) then
      return 
    end
    if tonumber(str[2]) == AssetType.PHYSICAL then
      local FixedData = ((TableData.gTable).BaseFixedData)[Const.MaxPhysicalFixedID]
      local configData = split(FixedData.array_value, ":")
      local max = tonumber(configData[2])
      local possess = (ActorData.GetAssetCount)(AssetType.PHYSICAL)
      if max < possess + getNum then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
        return 
      end
    end
    do
      ;
      (ShopService.OnReqShopBuy)((NewActivityDungeonData.BuyingData).shopType, (NewActivityDungeonData.BuyingData).poolID, (NewActivityDungeonData.BuyingData).gridID, times)
    end
  end
, nil, function(...)
    -- function num : 0_5_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ActivityDungeonShopBuyWindow).name)
  end
, true, itemName)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.SetRoundData = function(data, ...)
  -- function num : 0_6 , upvalues : _ENV
  (NewActivityDungeonData.SetRoundData)(data)
  UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonExchangeWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_REWARD_LIST)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.SetExploreTimes = function(times, ...)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  NewActivityDungeonData.CurrentTimes = times
  UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonMainWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE_COST)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.ChangeExploreTimes = function(value, config, ...)
  -- function num : 0_8 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if value == 0 then
    NewActivityDungeonData.CurrentTimes = (NewActivityDungeonData.CheckTimeUp)(config, NewActivityDungeonData.CurrentTimes)
    if NewActivityDungeonData.MaxTimes <= NewActivityDungeonData.CurrentTimes then
      if NewActivityDungeonData.ConfigMax then
        (MessageMgr.SendCenterTips)((PUtil.get)(60000648))
      else
        local config = (Util.GetConfigByItemIDAndType)((NewActivityDungeonData.CurrentEachCost).Id, (NewActivityDungeonData.CurrentEachCost).Type)
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000125, config.name))
      end
      do
        do return  end
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

        NewActivityDungeonData.CurrentTimes = NewActivityDungeonData.MaxTimes
        -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

        NewActivityDungeonData.CurrentTimes = (NewActivityDungeonData.CheckTimeUp)(config, NewActivityDungeonData.CurrentTimes, true)
        -- DECOMPILER ERROR at PC72: Unhandled construct in 'MakeBoolean' P1

        if value < 0 and NewActivityDungeonData.CurrentTimes <= 1 then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000076))
          return 
        end
        -- DECOMPILER ERROR at PC82: Confused about usage of register: R2 in 'UnsetPending'

        NewActivityDungeonData.CurrentTimes = (NewActivityDungeonData.CheckTimeUp)(config, NewActivityDungeonData.CurrentTimes)
        if NewActivityDungeonData.MaxTimes <= NewActivityDungeonData.CurrentTimes then
          if NewActivityDungeonData.ConfigMax then
            (MessageMgr.SendCenterTips)((PUtil.get)(60000648))
          else
            local config = (Util.GetConfigByItemIDAndType)((NewActivityDungeonData.CurrentEachCost).Id, (NewActivityDungeonData.CurrentEachCost).Type)
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(20000125, config.name))
          end
          do
            do return  end
            -- DECOMPILER ERROR at PC123: Confused about usage of register: R2 in 'UnsetPending'

            NewActivityDungeonData.CurrentTimes = NewActivityDungeonData.CurrentTimes + value
            -- DECOMPILER ERROR at PC132: Confused about usage of register: R2 in 'UnsetPending'

            NewActivityDungeonData.CurrentTimes = (NewActivityDungeonData.CheckTimeUp)(config, NewActivityDungeonData.CurrentTimes, true)
            UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonMainWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE_COST)
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.OpenMainNADUI = function(...)
  -- function num : 0_9 , upvalues : _ENV
  if not NewActivityDungeonData.AdventureInit then
    (NewActivityDungeonService.ReqRiskDataInit)()
  end
  OpenWindow((WinResConfig.NewActivityDungeonMainWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.InitAdventureData = function(data, ...)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  NewActivityDungeonData.AdventureInit = true
  ;
  (NewActivityDungeonData.InitAdventureData)(data.riskDataList)
  UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonMainWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.RefreshRiskData = function(data, ...)
  -- function num : 0_11 , upvalues : _ENV
  (NewActivityDungeonData.InitSingleAdventureData)(data.riskData)
  UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonMainWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.ReqBeginRisk = function(id, ...)
  -- function num : 0_12 , upvalues : _ENV
  local config = ((TableData.gTable).BaseActivityRiskStageData)[id]
  if not (Util.CheckCondition)(config.open_condition) then
    return 
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  NewActivityDungeonData.CurrentTimes = (NewActivityDungeonData.CheckTimeUp)(config, NewActivityDungeonData.CurrentTimes, true)
  local cost = {}
  cost.type = (NewActivityDungeonData.CurrentEachCost).Type
  cost.id = (NewActivityDungeonData.CurrentEachCost).Id
  cost.value = (NewActivityDungeonData.CurrentEachCost).Value * NewActivityDungeonData.CurrentTimes
  if (Util.CheckCostResources)((NewActivityDungeonData.CurrentEachCost).Type .. ":" .. (NewActivityDungeonData.CurrentEachCost).Id .. ":" .. cost.value) then
    local duration = (LuaTime.GetTimeStrVersion2)(config.explore_time * NewActivityDungeonData.CurrentTimes, true)
    local costStr = ((Util.GetConfigByItemIDAndType)(cost.id, cost.type)).name .. "*" .. cost.value
    ;
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000625, costStr, duration), function(...)
    -- function num : 0_12_0 , upvalues : _ENV, id, config
    (NewActivityDungeonService.ReqBeginRisk)(id, config.explore_time * NewActivityDungeonData.CurrentTimes * 1000)
  end
)
  end
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.ReqEndRisk = function(id, ...)
  -- function num : 0_13 , upvalues : _ENV
  local data = (NewActivityDungeonData.AdventureData)[id]
  if data.endTime == 0 or (math.floor)(data.endTime * 0.001) < (LuaTime.GetTimeStamp)() then
    (NewActivityDungeonService.ReqEndRisk)(id)
  else
    local exploredTime = (LuaTime.GetTimeStamp)() - (math.floor)(data.beginTime * 0.001)
    local config = ((TableData.gTable).BaseActivityRiskStageData)[id]
    local times = (math.floor)(exploredTime / config.explore_time)
    local totalTims = (math.floor)((data.endTime - data.beginTime) * 0.001 / config.explore_time)
    local costName = ((Util.GetConfigByItemIDAndType)((NewActivityDungeonData.CurrentEachCost).Id, (NewActivityDungeonData.CurrentEachCost).Type)).name
    ;
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000626, (LuaTime.GetTimeStrVersion2)(exploredTime), costName .. "*" .. times * (NewActivityDungeonData.CurrentEachCost).Value, costName .. "*" .. (totalTims - times) * (NewActivityDungeonData.CurrentEachCost).Value), function(...)
    -- function num : 0_13_0 , upvalues : _ENV, id
    (NewActivityDungeonService.ReqEndRisk)(id)
  end
)
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.RecvEndRisk = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (NewActivityDungeonData.AdventureData)[msg.id] = nil
  if (_G.next)(NewActivityDungeonData.AdventureData) == nil then
    (RedDotMgr.EliminateRedDot)((WinResConfig.NewActivityDungeonMainWindow).name, RedDotComID.NAD_Exploration)
  end
  UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonMainWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.InitAssistData = function(...)
  -- function num : 0_15 , upvalues : _ENV
  if (ActivityMgr.GetActivityIsOpen)((ActivityMgr.ActivityType).NewActivityDungeon) then
    (NewActivityDungeonService.ReqAssistFightInit)()
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.CancelNotify = function(...)
  -- function num : 0_16
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.RecvAssistData = function(msg, ...)
  -- function num : 0_17 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (msg.data).remainHp = (msg.data).remainHp * 0.01
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  NewActivityDungeonData.AssistData = msg.data
  local rewardStatus = {}
  local count = #(NewActivityDungeonData.AssistData).gotReward
  for i = 1, count do
    rewardStatus[((NewActivityDungeonData.AssistData).gotReward)[i]] = true
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (NewActivityDungeonData.AssistData).gotReward = rewardStatus
  UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonMainWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_ASSIST_FIGHT)
  UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonGuildAssistWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_GUILD_ASSIST)
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.OpenPhaseRewardShow = function(...)
  -- function num : 0_18 , upvalues : _ENV
  if NewActivityDungeonData.AssistData == nil then
    return 
  end
  ;
  (NewActivityDungeonData.InitShowRewardData)()
  local count = #NewActivityDungeonData.RewardShowData
  local ids = {}
  local datas = {}
  local data, config, id = nil, nil, nil
  for i = 1, count do
    data = (NewActivityDungeonData.RewardShowData)[i]
    if not ((NewActivityDungeonData.AssistData).gotReward)[data.Id] and (NewActivityDungeonData.AssistData).remainHp <= data.Value then
      config = ((TableData.gTable).BaseActivityPhaseRewardData)[data.Id]
      ;
      (table.insert)(ids, data.Id)
      ;
      (table.insert)(datas, config.phase_reward_view)
    else
      if data.Value < (NewActivityDungeonData.AssistData).remainHp then
        id = data.Id
        break
      end
    end
  end
  do
    if (_G.next)(ids) == nil then
      if id == nil then
        (MessageMgr.SendCenterTips)((PUtil.get)(60000633))
      else
        local btnData = {}
        btnData.btnTxt = (PUtil.get)(60000004)
        btnData.fun = function(id, ...)
    -- function num : 0_18_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.RewardDisplayWindow).name)
  end

        config = ((TableData.gTable).BaseActivityPhaseRewardData)[id]
        ;
        (MessageMgr.OpenRewardWindow)(config.phase_reward_view, btnData, id, nil, (PUtil.get)(60000631))
      end
    else
      do
        local btnData = {}
        btnData.btnTxt = (PUtil.get)(60000023)
        btnData.fun = function(id, ...)
    -- function num : 0_18_1 , upvalues : _ENV
    (NewActivityDungeonService.ReqChallengeReward)(id)
  end

        ;
        (MessageMgr.OpenMultiplyRewardWindow)(ids, datas, btnData, nil, (PUtil.get)(60000632))
      end
    end
  end
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.RecvReward = function(msg, ...)
  -- function num : 0_19 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((NewActivityDungeonData.AssistData).gotReward)[msg.id] = true
  local count = #NewActivityDungeonData.RewardShowData
  local found = false
  local data = nil
  for i = 1, count do
    data = (NewActivityDungeonData.RewardShowData)[i]
    if not ((NewActivityDungeonData.AssistData).gotReward)[data.Id] and (NewActivityDungeonData.AssistData).remainHp <= data.Value then
      found = true
    end
  end
  if not found then
    (RedDotMgr.EliminateRedDot)((WinResConfig.NewActivityDungeonMainWindow).name, RedDotComID.NAD_AssitsFight)
  end
  if (MessageMgr.CheckNeedShowReward)() then
    UIMgr:SendWindowMessage((WinResConfig.RewardDisplayWindow).name, (WindowMsgEnum.MessageWindow).E_MSG_REWARD_REFRESH)
  else
    UIMgr:CloseWindow((WinResConfig.RewardDisplayWindow).name)
  end
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.TryChallengeBoss = function(...)
  -- function num : 0_20 , upvalues : _ENV
  if (NewActivityDungeonData.AssistData).remainHp <= 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000649))
    return 
  end
  local config = ((TableData.gTable).BaseActivityAidData)[(NewActivityDungeonData.AssistData).id]
  if config.challenge_num <= (NewActivityDungeonData.AssistData).challengedTime then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000628))
    return 
  end
  local formationData = {}
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(20000021)
  btnData.fun = function(formation, ...)
    -- function num : 0_20_0 , upvalues : _ENV
    (NewActivityDungeonService.ReqChallengeAssistFight)((Util.CovertLoaclFormationToRemote)(formation))
  end

  formationData.myselfList = (Util.CovertRemoteFormationToLocal)((NewActivityDungeonData.AssistData).cardInfo)
  formationData.enemyList = (Util.GetMonsterFormation)(config.monster_group_list)
  formationData.BtnData = btnData
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).ASSIST
  formationData.formationType = FormationType.Basic
  formationData.closeFun = function(formation, ...)
    -- function num : 0_20_1 , upvalues : _ENV
    (Util.BeforeCloseFormation)(formation, function(...)
      -- function num : 0_20_1_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.FormationWindow).name)
    end
, function(...)
      -- function num : 0_20_1_1 , upvalues : _ENV
      return (Util.CovertRemoteFormationToLocal)((NewActivityDungeonData.AssistData).cardInfo), 60000062
    end
, function(newFormation, ...)
      -- function num : 0_20_1_2 , upvalues : _ENV, formation
      (NewActivityDungeonService.ReqCardGroups)(formation)
    end
)
  end

  formationData.backFun = function(formation, ...)
    -- function num : 0_20_2 , upvalues : _ENV
    (Util.BeforeCloseFormation)(formation, function(...)
      -- function num : 0_20_2_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.FormationWindow).name)
    end
, function(...)
      -- function num : 0_20_2_1 , upvalues : _ENV
      return (Util.CovertRemoteFormationToLocal)((NewActivityDungeonData.AssistData).cardInfo), 60000062
    end
, function(newFormation, ...)
      -- function num : 0_20_2_2 , upvalues : _ENV, formation
      (NewActivityDungeonService.ReqCardGroups)(formation)
    end
)
  end

  formationData.isSelfClose = true
  ;
  (MessageMgr.OpenFormationWindow)(formationData)
  return true
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.ReqChallengeAssistFight = function(formation, ...)
  -- function num : 0_21 , upvalues : _ENV
  if (_G.next)(formation) == nil then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000040))
    return 
  end
  local config = ((TableData.gTable).BaseActivityAidData)[(NewActivityDungeonData.AssistData).id]
  if config.challenge_num <= (NewActivityDungeonData.AssistData).challengedTime then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000628))
    return 
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  NewActivityDungeonData.Formation = formation
  ;
  (NewActivityDungeonService.ReqChallengeAssistFight)(formation)
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.RecvSettleAssistFight = function(msg, ...)
  -- function num : 0_22 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (NewActivityDungeonData.AssistData).remainHp = msg.remainHp * 0.01
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (NewActivityDungeonData.AssistData).challengedTime = (NewActivityDungeonData.AssistData).challengedTime + 1
  if msg.success then
    local m = {}
    m.BattleType = (ProtoEnum.E_BATTLE_TYPE).ASSIST
    m.cardInfo = NewActivityDungeonData.Formation
    local btn2 = {}
    btn2.btnTxt = (PUtil.get)(20000016)
    btn2.fun = function(...)
    -- function num : 0_22_0 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_22_0_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.BattleWinConvergeWindow).name)
    end
  end

    m.btn2 = btn2
    ;
    (CommonWinMgr.OpenBattleSettleConvergeWindow)(m)
  else
    do
      do
        local m = {}
        m.BattleType = (ProtoEnum.E_BATTLE_TYPE).ASSIST
        ;
        (CommonWinMgr.OpenBattleFailConvergeWindow)(m)
        UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonMainWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_BOSS_HP)
      end
    end
  end
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.OpenGuildAssist = function(...)
  -- function num : 0_23 , upvalues : _ENV
  if (ActorData.GetGuildID)() == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000280))
    return 
  end
  ld("Guild")
  ;
  (GuildMgr.CheckMemberList)(true)
  OpenWindow((WinResConfig.NewActivityDungeonGuildAssistWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.TryAssistGuildMember = function(data, ...)
  -- function num : 0_24 , upvalues : _ENV
  local config = ((TableData.gTable).BaseActivityAidData)[(NewActivityDungeonData.AssistData).id]
  local leftTimes = config.assisted_num - data.byAssistTime
  if leftTimes == 0 then
    return 
  end
  ;
  (NewActivityDungeonService.ReqAssistGuildMember)(data.objectindex)
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.RecvAssistGuildMemebr = function(msg, ...)
  -- function num : 0_25 , upvalues : _ENV
  local data = (GuildData.MemberList)[(GuildData.MemberList)[msg.playerIndex]]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (NewActivityDungeonData.AssistData).assistedTime = (NewActivityDungeonData.AssistData).assistedTime + 1
  data.byAssistTime = msg.byAssistTime
  data.remainHp = msg.remainHp
  UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonGuildAssistWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_ASSIST_LIST_INFO)
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.CheckNextChapter = function(index, ...)
  -- function num : 0_26 , upvalues : _ENV
  local data = (NewActivityDungeonData.ChapterData)[index]
  local stageId = (data.Stages)[1]
  local status = (PlotDungeonMgr.GetDungeonStatus)(stageId)
  if status == StageStatus.Unlock and not (PlotDungeonMgr.IsCanChallenge)(stageId, false) then
    status = StageStatus.Lock
  end
  if status == StageStatus.Lock then
    local config = ((TableData.gTable).BaseStageData)[stageId]
    local preConfig = ((TableData.gTable).BaseStageData)[config.pre]
    if config.openSec ~= 0 then
      if (PlotDungeonMgr.IsPassDungeon)(config.pre) then
        local time = (math.floor)((NewActivityDungeonData.NADData).beginTime * 0.001) + config.openSec
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(60000651, (LuaTime.GetLeftTimeStr)(time, true)))
      else
        do
          do
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(20000058, preConfig.name))
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(20000058, preConfig.name))
            do return false end
            do return true end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonMgr.SetSelectDungeon = function(stageId, ...)
  -- function num : 0_27 , upvalues : _ENV
  local stageId = tonumber(stageId)
  if not stageId or stageId <= 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000039))
    return 
  end
  if (PlotDungeonMgr.IsCanChallenge)(stageId, false) and (PlotDungeonMgr.CheckSatisfyContent)(stageId) then
    OpenPlotPlay(stageId, PlotPlayTriggerType.CLICK_LEVEL_ICON, function(...)
    -- function num : 0_27_0 , upvalues : _ENV, stageId
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    NewActivityDungeonData.CurrentDungeon = stageId
    if (FunctionControlMgr.GetFunctionState)(ControlID.StageDetail_Panel, false) then
      OpenWindow((WinResConfig.NewActivityDungeonPlotDetailWindow).name, UILayer.HUD)
    else
      ;
      (PlotDungeonMgr.OnClickChallengeDungeon)()
    end
  end
)
  end
  local preID = (((TableData.gTable).BaseStageData)[stageId]).pre
  local stageData = ((TableData.gTable).BaseStageData)[preID]
  ;
  (MessageMgr.SendCenterTips)((PUtil.get)(20000058, stageData.name))
end


