-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityDungeonMgr = {}
local cachedDungeonWindow = nil
local GetDungeonWindowName = function(...)
  -- function num : 0_0 , upvalues : cachedDungeonWindow, _ENV
  if cachedDungeonWindow == nil then
    local currentDungeonId = (ActivityDungeonData.GetCurrentActivityDungeonId)()
    if currentDungeonId ~= -1 then
      local winResConfig = WinResConfig["ActivityDungeonWindow" .. currentDungeonId]
      if winResConfig then
        cachedDungeonWindow = winResConfig.name
      end
    end
  end
  do
    return cachedDungeonWindow
  end
end

local SendMessageActivityDungeonWindow = function(id, param, ...)
  -- function num : 0_1 , upvalues : _ENV, GetDungeonWindowName
  if (ActivityDungeonData.GetCurrentActivityDungeonId)() == -1 then
    return 
  end
  local dungeonWindowName = GetDungeonWindowName()
  UIMgr:SendWindowMessage(dungeonWindowName, id, param)
end

ActivityDungeonMgr.OpenActivityDungeonWindow = function(...)
  -- function num : 0_2 , upvalues : GetDungeonWindowName, _ENV
  local windowName = GetDungeonWindowName()
  OpenWindow(windowName, UILayer.HUD)
end

ActivityDungeonMgr.CheckNADPurchaseTimes = function(times, isShowTips, ...)
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

ActivityDungeonMgr.ChangeNADPurchaseTime = function(origin, value, showTips, ...)
  -- function num : 0_4 , upvalues : _ENV, ActivityDungeonMgr
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
          if not (ActivityDungeonMgr.CheckNADPurchaseTimes)(times, maxTime == origin) then
            times = maxTime
          end
          if (NewActivityDungeonData.BuyingItem).id == AssetType.PHYSICAL and (NewActivityDungeonData.GetNADMaxBuyTimes)() <= origin then
            (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
            return 
          end
          if (ActivityDungeonMgr.CheckNADPurchaseTimes)(times, showTips) then
            UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonShopBuyWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_PURCHASE_INFO, times)
          end
          -- DECOMPILER ERROR: 4 unprocessed JMP targets
        end
      end
    end
  end
end

ActivityDungeonMgr.NADPurchaseItem = function(times, itemName, ...)
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

ActivityDungeonMgr.SetRoundData = function(data, ...)
  -- function num : 0_6 , upvalues : _ENV
  (NewActivityDungeonData.SetRoundData)(data)
  UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonExchangeWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_REWARD_LIST)
end

ActivityDungeonMgr.SetExploreTimes = function(times, ...)
  -- function num : 0_7 , upvalues : _ENV, SendMessageActivityDungeonWindow
  (ActivityRiskData.SetExploreTimes)(times)
  SendMessageActivityDungeonWindow((WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE_COST)
end

ActivityDungeonMgr.ChangeExploreTimes = function(value, config, ...)
  -- function num : 0_8 , upvalues : _ENV, SendMessageActivityDungeonWindow
  if value == 0 then
    (ActivityRiskData.SetExploreTimes)((ActivityRiskData.CheckTimeUp)(config, (ActivityRiskData.GetExploreTimes)()))
    if ActivityRiskData.MaxTimes <= (ActivityRiskData.GetExploreTimes)() then
      if ActivityRiskData.ConfigMax then
        (MessageMgr.SendCenterTips)((PUtil.get)(60000648))
      else
        local config = (Util.GetConfigByItemIDAndType)((ActivityRiskData.CurrentExploreCost).Id, (ActivityRiskData.CurrentExploreCost).Type)
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000125, config.name))
      end
      do
        do return  end
        ;
        (ActivityRiskData.SetExploreTimes)(ActivityRiskData.MaxTimes)
        ;
        (ActivityRiskData.SetExploreTimes)((ActivityRiskData.CheckTimeUp)(config, (ActivityRiskData.GetExploreTimes)(), true))
        -- DECOMPILER ERROR at PC79: Unhandled construct in 'MakeBoolean' P1

        if value < 0 and (ActivityRiskData.GetExploreTimes)() <= 1 then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000076))
          return 
        end
        ;
        (ActivityRiskData.SetExploreTimes)((ActivityRiskData.CheckTimeUp)(config, (ActivityRiskData.GetExploreTimes)()))
        if ActivityRiskData.MaxTimes <= (ActivityRiskData.GetExploreTimes)() then
          if ActivityRiskData.ConfigMax then
            (MessageMgr.SendCenterTips)((PUtil.get)(60000648))
          else
            local config = (Util.GetConfigByItemIDAndType)((ActivityRiskData.CurrentExploreCost).Id, (ActivityRiskData.CurrentExploreCost).Type)
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(20000125, config.name))
          end
          do
            do return  end
            ;
            (ActivityRiskData.SetExploreTimes)((ActivityRiskData.GetExploreTimes)() + value)
            ;
            (ActivityRiskData.SetExploreTimes)((ActivityRiskData.CheckTimeUp)(config, (ActivityRiskData.GetExploreTimes)()), true)
            SendMessageActivityDungeonWindow((WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE_COST)
          end
        end
      end
    end
  end
end

ActivityDungeonMgr.InitRiskDataList = function(data, ...)
  -- function num : 0_9 , upvalues : _ENV, SendMessageActivityDungeonWindow
  (ActivityRiskData.InitRiskDataList)(data.riskDataList)
  SendMessageActivityDungeonWindow((WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE)
end

ActivityDungeonMgr.RefreshRiskData = function(data, ...)
  -- function num : 0_10 , upvalues : _ENV, SendMessageActivityDungeonWindow
  (ActivityRiskData.InitRiskData)(data.riskData)
  SendMessageActivityDungeonWindow((WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE)
end

ActivityDungeonMgr.ReqBeginRisk = function(id, ...)
  -- function num : 0_11 , upvalues : _ENV
  local config = ((TableData.gTable).BaseActivityRiskStageData)[id]
  if not (Util.CheckCondition)(config.open_condition) then
    return 
  end
  ;
  (ActivityRiskData.SetExploreTimes)((ActivityRiskData.CheckTimeUp)(config, (ActivityRiskData.GetExploreTimes)(), true))
  local exploreTimes = (ActivityRiskData.GetExploreTimes)()
  local cost = {id = (ActivityRiskData.CurrentExploreCost).Id, type = (ActivityRiskData.CurrentExploreCost).Type, value = (ActivityRiskData.CurrentExploreCost).Value * exploreTimes}
  if (Util.CheckCostResources)(cost.type .. ":" .. cost.id .. ":" .. cost.value) then
    local duration = (LuaTime.GetTimeStrVersion2)(config.explore_time * exploreTimes, true)
    local costStr = ((Util.GetConfigByItemIDAndType)(cost.id, cost.type)).name .. "*" .. cost.value
    ;
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000625, costStr, duration), function(...)
    -- function num : 0_11_0 , upvalues : _ENV, id, config, exploreTimes
    (ActivityDungeonService.ReqBeginRisk)(id, config.explore_time * exploreTimes * 1000)
  end
)
  end
end

ActivityDungeonMgr.ReqEndRisk = function(id, ...)
  -- function num : 0_12 , upvalues : _ENV
  local data = (ActivityRiskData.GetRiskDataById)(id)
  if data.endTime == 0 or (math.floor)(data.endTime * 0.001) < (LuaTime.GetTimeStamp)() then
    (ActivityDungeonService.ReqEndRisk)(id)
  else
    local exploredTime = (LuaTime.GetTimeStamp)() - (math.floor)(data.beginTime * 0.001)
    local config = ((TableData.gTable).BaseActivityRiskStageData)[id]
    local times = (math.floor)(exploredTime / config.explore_time)
    local totalTims = (math.floor)((data.endTime - data.beginTime) * 0.001 / config.explore_time)
    local costName = ((Util.GetConfigByItemIDAndType)((ActivityRiskData.CurrentExploreCost).Id, (ActivityRiskData.CurrentExploreCost).Type)).name
    ;
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000626, (LuaTime.GetTimeStrVersion2)(exploredTime), costName .. "*" .. times * (ActivityRiskData.CurrentExploreCost).Value, costName .. "*" .. (totalTims - times) * (ActivityRiskData.CurrentExploreCost).Value), function(...)
    -- function num : 0_12_0 , upvalues : _ENV, id
    (ActivityDungeonService.ReqEndRisk)(id)
  end
)
  end
end

ActivityDungeonMgr.RecvEndRisk = function(msg, ...)
  -- function num : 0_13 , upvalues : _ENV, GetDungeonWindowName, SendMessageActivityDungeonWindow
  (ActivityRiskData.RemoveRiskData)(msg.id)
  do
    if (_G.next)((ActivityRiskData.GetRiskDataList)()) == nil then
      local windowName = GetDungeonWindowName()
      ;
      (RedDotMgr.EliminateRedDot)(windowName and windowName or "", RedDotComID.NAD_Exploration)
    end
    SendMessageActivityDungeonWindow((WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE)
  end
end

ActivityDungeonMgr.InitAssistData = function(...)
  -- function num : 0_14 , upvalues : _ENV
  (ActivityDungeonService.ReqAssistFightInit)()
end

ActivityDungeonMgr.CancelNotify = function(...)
  -- function num : 0_15
end

ActivityDungeonMgr.RecvAssistData = function(msg, ...)
  -- function num : 0_16 , upvalues : _ENV, ActivityDungeonMgr, SendMessageActivityDungeonWindow
  (ActivityRiskData.InitAssistData)(msg.data)
  local rewardStatus = {}
  local assistData = (ActivityRiskData.GetAssistData)()
  local count = #assistData.gotReward
  for i = 1, count do
    rewardStatus[(assistData.gotReward)[i]] = true
  end
  assistData.gotReward = rewardStatus
  ;
  (ActivityDungeonMgr.RefreshAssitReddot)(assistData)
  SendMessageActivityDungeonWindow((WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_ASSIST_FIGHT)
  SendMessageActivityDungeonWindow((WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_GUILD_ASSIST)
end

ActivityDungeonMgr.RefreshAssitReddot = function(assistData, ...)
  -- function num : 0_17 , upvalues : _ENV, ActivityDungeonMgr
  local config = ((TableData.gTable).BaseActivityAidData)[assistData.id]
  if config.assist_num <= assistData.assistedTime then
    local name = (ActivityDungeonMgr.GetDungeonWindowName)()
    ;
    (RedDotMgr.EliminateRedDot)(name, RedDotComID.NAD_GuildHelp)
    ;
    (RedDotMgr.RefreshTreeUI)(name)
  end
end

ActivityDungeonMgr.OpenPhaseRewardShow = function(...)
  -- function num : 0_18 , upvalues : _ENV
  local assistData = (ActivityRiskData.GetAssistData)()
  if assistData == nil then
    return 
  end
  ;
  (ActivityRiskData.InitShowRewardData)()
  local rewardShowData = (ActivityRiskData.GetRewardShowData)()
  local count = #rewardShowData
  local ids = {}
  local datas = {}
  local data, config, id = nil, nil, nil
  for i = 1, count do
    data = rewardShowData[i]
    if not (assistData.gotReward)[data.Id] and assistData.remainHp <= data.Value then
      config = ((TableData.gTable).BaseActivityPhaseRewardData)[data.Id]
      ;
      (table.insert)(ids, data.Id)
      ;
      (table.insert)(datas, config.phase_reward_view)
    else
      if data.Value < assistData.remainHp then
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
    (ActivityDungeonService.ReqChallengeReward)(id)
  end

        ;
        (MessageMgr.OpenMultiplyRewardWindow)(ids, datas, btnData, nil, (PUtil.get)(60000632))
      end
    end
  end
end

ActivityDungeonMgr.RecvReward = function(msg, ...)
  -- function num : 0_19 , upvalues : _ENV
  local assistData = (ActivityRiskData.GetAssistData)()
  local rewardShowData = (ActivityRiskData.GetRewardShowData)()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (assistData.gotReward)[msg.id] = true
  local count = #rewardShowData
  local found = false
  local data = nil
  for i = 1, count do
    data = rewardShowData[i]
    if not (assistData.gotReward)[data.Id] and assistData.remainHp <= data.Value then
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

ActivityDungeonMgr.TryChallengeBoss = function(...)
  -- function num : 0_20 , upvalues : _ENV
  local assistData = (ActivityRiskData.GetAssistData)()
  if assistData.remainHp <= 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000649))
    return 
  end
  local config = ((TableData.gTable).BaseActivityAidData)[assistData.id]
  if config.challenge_num <= assistData.challengedTime then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000628))
    return 
  end
  local formationData = {}
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(20000021)
  btnData.fun = function(formation, ...)
    -- function num : 0_20_0 , upvalues : _ENV
    (ActivityDungeonService.ReqChallengeAssistFight)((Util.CovertLoaclFormationToRemote)(formation))
  end

  formationData.myselfList = (Util.CovertRemoteFormationToLocal)(assistData.cardInfo)
  formationData.enemyList = (Util.GetMonsterFormation)(config.monster_group_list)
  formationData.BtnData = btnData
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).ASSIST
  formationData.formationType = FormationType.Basic
  formationData.closeFun = function(formation, ...)
    -- function num : 0_20_1 , upvalues : _ENV, assistData
    (Util.BeforeCloseFormation)(formation, function(...)
      -- function num : 0_20_1_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.FormationWindow).name)
    end
, function(...)
      -- function num : 0_20_1_1 , upvalues : _ENV, assistData
      return (Util.CovertRemoteFormationToLocal)(assistData.cardInfo), 60000062
    end
, function(newFormation, ...)
      -- function num : 0_20_1_2 , upvalues : _ENV, formation
      (ActivityDungeonService.ReqCardGroups)(formation)
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
      (ActivityDungeonService.ReqCardGroups)(formation)
    end
)
  end

  formationData.isSelfClose = true
  ;
  (MessageMgr.OpenFormationWindow)(formationData)
  return true
end

ActivityDungeonMgr.ReqChallengeAssistFight = function(formation, ...)
  -- function num : 0_21 , upvalues : _ENV
  if (_G.next)(formation) == nil then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000040))
    return 
  end
  local assistData = (ActivityRiskData.GetAssistData)()
  local config = ((TableData.gTable).BaseActivityAidData)[assistData.id]
  if config.challenge_num <= assistData.challengedTime then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000628))
    return 
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

  ActivityRiskData.Formation = formation
  ;
  (ActivityDungeonService.ReqChallengeAssistFight)(formation)
end

ActivityDungeonMgr.RecvSettleAssistFight = function(msg, ...)
  -- function num : 0_22 , upvalues : _ENV, SendMessageActivityDungeonWindow
  local assistData = (ActivityRiskData.GetAssistData)()
  assistData.remainHp = msg.remainHp * 0.01
  assistData.challengedTime = assistData.challengedTime + 1
  if msg.success then
    local m = {}
    m.BattleType = (ProtoEnum.E_BATTLE_TYPE).ASSIST
    m.cardInfo = ActivityRiskData.Formation
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
        SendMessageActivityDungeonWindow((WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_BOSS_HP)
      end
    end
  end
end

ActivityDungeonMgr.OpenGuildAssist = function(...)
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

ActivityDungeonMgr.TryAssistGuildMember = function(data, ...)
  -- function num : 0_24 , upvalues : _ENV
  local assistData = (ActivityRiskData.GetAssistData)()
  local config = ((TableData.gTable).BaseActivityAidData)[assistData.id]
  local leftTimes = config.assisted_num - data.byAssistTime
  if leftTimes == 0 then
    return 
  end
  ;
  (ActivityDungeonService.ReqAssistGuildMember)(data.objectindex)
end

ActivityDungeonMgr.RecvAssistGuildMember = function(msg, ...)
  -- function num : 0_25 , upvalues : _ENV, ActivityDungeonMgr
  local data = (GuildData.MemberList)[(GuildData.MemberList)[msg.playerIndex]]
  local assistData = (ActivityRiskData.GetAssistData)()
  assistData.assistedTime = assistData.assistedTime + 1
  data.byAssistTime = msg.byAssistTime
  data.remainHp = msg.remainHp
  ;
  (ActivityDungeonMgr.RefreshAssitReddot)(assistData)
  UIMgr:SendWindowMessage((WinResConfig.NewActivityDungeonGuildAssistWindow).name, (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_ASSIST_LIST_INFO)
end

ActivityDungeonMgr.CheckNextChapter = function(index, ...)
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

ActivityDungeonMgr.SetSelectDungeon = function(stageId, ...)
  -- function num : 0_27 , upvalues : _ENV
  local stageId = tonumber(stageId)
  if not stageId or stageId <= 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000039))
    return 
  end
  if (PlotDungeonMgr.IsCanChallenge)(stageId, false) and (PlotDungeonMgr.CheckSatisfyContent)(stageId) then
    OpenPlotPlay(stageId, PlotPlayTriggerType.CLICK_LEVEL_ICON, function(...)
    -- function num : 0_27_0 , upvalues : _ENV, stageId
    (ActivityDungeonData.SetSelectedStageId)(stageId)
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

ActivityDungeonMgr.GetDungeonWindowName = GetDungeonWindowName
ActivityDungeonMgr.SendMessageActivityDungeonWindow = SendMessageActivityDungeonWindow
return ActivityDungeonMgr

