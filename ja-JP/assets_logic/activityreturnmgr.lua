-- params : ...
-- function num : 0 , upvalues : _ENV
ActivityReturnMgr = {}
local self = ActivityReturnMgr
-- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnMgr.CheckNeedOpenUI = function(...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  ActivityReturnData.Reason = (ActivityReturnData.ReasonType).Auto
  ;
  (ActivityReturnMgr.ReqActivityData)()
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnMgr.TryOpenUI = function(...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  ActivityReturnData.Reason = (ActivityReturnData.ReasonType).Manual
  ;
  (ActivityReturnMgr.ReqActivityData)()
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnMgr.ReqActivityData = function(...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ActivityReturnData.ActivityId = (ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).Return)
  ;
  (ActivityService.OnReqActivityInfo)((ActivityMgr.ActivityType).Return, nil, ActivityReturnData.ActivityId)
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnMgr.RecvActivityData = function(msg, ...)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ActivityReturnData.BasicData = msg.baseActivityInfo
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ActivityReturnData.TodayGet = (msg.returnLoginActInfo).todayGet
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ActivityReturnData.TotalScore = (msg.returnLoginActInfo).totalPoint
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ActivityReturnData.InitLevel = (msg.returnLoginActInfo).initLevel
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ActivityReturnData.Day = (msg.returnLoginActInfo).dayNum
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ActivityReturnData.LoginRewardsStatus = {}
  local count = #(msg.returnLoginActInfo).rewardList
  for i = 1, count do
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

    (ActivityReturnData.LoginRewardsStatus)[(((msg.returnLoginActInfo).rewardList)[i]).id] = (((msg.returnLoginActInfo).rewardList)[i]).status
  end
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

  ActivityReturnData.ScoreRewardsStatus = {}
  count = #(msg.returnLoginActInfo).pointList
  for i = 1, count do
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

    (ActivityReturnData.ScoreRewardsStatus)[(((msg.returnLoginActInfo).pointList)[i]).id] = (((msg.returnLoginActInfo).pointList)[i]).status
  end
  ;
  (ActivityReturnData.InitLoginRewardConfigs)()
  if ActivityReturnData.Reason == (ActivityReturnData.ReasonType).Manual then
    OpenWindow((WinResConfig.ActivityReturnWindow).name, UILayer.HUD)
  else
    if not ActivityReturnData.TodayGet then
      OpenWindow((WinResConfig.ActivityReturnWindow).name, UILayer.HUD, true)
    end
  end
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnMgr.ReqGetReward = function(rewId, ...)
  -- function num : 0_4 , upvalues : _ENV
  (ActivityService.ReqGetReward)(ActivityReturnData.ActivityId, rewId)
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnMgr.RecvGetReward = function(msg, ...)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if msg.result then
    ActivityReturnData.TodayGet = true
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (ActivityReturnData.LoginRewardsStatus)[msg.rewId] = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS
    UIMgr:SendWindowMessage((WinResConfig.ActivityReturnWindow).name, (WindowMsgEnum.ActivityReturn).E_MSG_REFRESH_LOGIN)
  end
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnMgr.ReqPointReward = function(rewId, ...)
  -- function num : 0_6 , upvalues : _ENV
  (ActivityService.OnReqPointReward)(ActivityReturnData.ActivityId, rewId)
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnMgr.RecvPointReward = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if msg.result then
    (ActivityReturnData.ScoreRewardsStatus)[msg.rewId] = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS
    local eliminate = true
    local config = nil
    for k,v in pairs(ActivityReturnData.ScoreRewardsStatus) do
      if v ~= (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
        config = ((TableData.gTable).BaseActivityLoginData)[k]
        if config.day <= ActivityReturnData.Day and config.point <= ActivityReturnData.TotalScore then
          eliminate = false
        end
      end
    end
    if eliminate then
      (RedDotMgr.EliminateRedDot)((WinResConfig.ActivityReturnWindow).name, RedDotComID.ActivityReturn_Vigour_Reward)
    end
    UIMgr:SendWindowMessage((WinResConfig.ActivityReturnWindow).name, (WindowMsgEnum.ActivityReturn).E_MSG_REFRESH_SCORE)
    local rewardConfig = ((TableData.gTable).BaseActivityLoginData)[msg.rewId]
    local rewards = split(rewardConfig.pointRewards, ",")
    local items = {}
    for index,value in ipairs(rewards) do
      local rewardStr = split(value, ":")
      local item = {}
      item.Type = tonumber(rewardStr[1])
      item.id = tonumber(rewardStr[2])
      item.Num = tonumber(rewardStr[3])
      ;
      (table.insert)(items, item)
    end
    ;
    (MessageMgr.OpenRewardShowWindow)(items)
  end
end


