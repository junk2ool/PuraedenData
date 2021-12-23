-- params : ...
-- function num : 0 , upvalues : _ENV
ActivityService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResSignInInit, ActivityService.ResSignInInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResSignIn, ActivityService.ResSignIn)
  ;
  (Net.AddListener)((Proto.MsgName).ResSignInReward, ActivityService.ResSignInReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResVitGetInit, ActivityService.ResVitGetInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResVitGet, ActivityService.ResVitGet)
  ;
  (Net.AddListener)((Proto.MsgName).ResActivityList, ActivityService.ResActivityList)
  ;
  (Net.AddListener)((Proto.MsgName).ResActivityInfo, ActivityService.ResActivityInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResTaskGroup, ActivityService.ResTaskGroup)
  ;
  (Net.AddListener)((Proto.MsgName).ResTaskReward, ActivityService.ResTaskReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResPointReward, ActivityService.ResPointReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResDecActivity, ActivityService.ResDecActivity)
  ;
  (Net.AddListener)((Proto.MsgName).ResSetYjCode, ActivityService.ResSetYjCode)
  ;
  (Net.AddListener)((Proto.MsgName).ResLoginAct, ActivityService.ResLoginAct)
  ;
  (Net.AddListener)((Proto.MsgName).ResLoginActGet, ActivityService.ResLoginActGet)
  ;
  (Net.AddListener)((Proto.MsgName).ResGiftCode, ActivityService.OnResGiftCode)
  ;
  (Net.AddListener)((Proto.MsgName).ResBannerIdList, ActivityService.RecvBannerIdList)
  ;
  (Net.AddListener)((Proto.MsgName).ResSaveBannerId, ActivityService.RecvSaveBannerId)
  ;
  (Net.AddListener)((Proto.MsgName).ResRemoveBannerId, ActivityService.RecvRemoveBannerId)
  ;
  (Net.AddListener)((Proto.MsgName).ResGetReward, ActivityService.OnResGetReward)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnReqSignInInit = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqSignInInit, m, (Proto.MsgName).ResSignInInit)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResSignInInit = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (ActivityMgr.SingInitData)(msg)
  ;
  (ActivityMgr.ServiceOpenWindow)((WindowMsgEnum.ActivityMainWindow).SING_INIT)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnReqSignIn = function(...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqSignIn, m, (Proto.MsgName).ResSignIn)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResSignIn = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (ActivityMgr.SetSignData)(msg)
  ;
  (ActivityMgr.CheckIsDisPosRedDot)()
  SendActivityWindowMessage((ActivityWindowName.ActivitySignView).name, 1)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnReqSignInReward = function(...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqSignInReward, m, (Proto.MsgName).ResSignInReward)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResSignInReward = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  (ActivityMgr.SetExtraId)(msg.extraId, msg.canGet)
  ;
  (ActivityMgr.CheckIsDisPosRedDot)()
  SendActivityWindowMessage((ActivityWindowName.ActivitySignView).name, 2)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnReqVitGetInit = function(...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqVitGetInit, m, (Proto.MsgName).ResVitGetInit)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResVitGetInit = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  (ActivityMgr.VitGetInitData)(msg)
  ;
  (ActivityMgr.ServiceOpenWindow)((WindowMsgEnum.ActivityMainWindow).VIT_GET_INIT)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnReqVitGet = function(id, ...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqVitGet, m, (Proto.MsgName).ResVitGet)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResVitGet = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  (ActivityMgr.SetGetVitData)(msg.id)
  local VitGetData = ((TableData.gTable).BaseVitGetData)[msg.id]
  if VitGetData then
    (MessageMgr.OpenItemBuyTipsWindowByStr)(VitGetData.reward)
  end
  SendActivityWindowMessage((ActivityWindowName.ActivityCakeView).name, 1, msg.id)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ReqLoginAct = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqLoginAct, m, (Proto.MsgName).ResLoginAct)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResLoginAct = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  (ActivityMgr.InitSevenLoginData)(msg)
  ;
  (ActivityMgr.ServiceOpenWindow)((WindowMsgEnum.ActivityMainWindow).SEVEN_DAY)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ReqLoginActGet = function(day, ...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  m.day = day
  ;
  (Net.Send)((Proto.MsgName).ReqLoginActGet, m, (Proto.MsgName).ResLoginActGet)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResLoginActGet = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  (ActivityMgr.InitSevenLoginData)(msg)
  SendActivityWindowMessage((ActivityWindowName.ActivitySevenDayView).name, 1)
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.ActivityMainWindow).name, RedDotComID.Activity_SevenLogin)
  local data = (TableData.gTable).BaseActivityLoginData
  for _,v in pairs(data) do
    if v.day == msg.day then
      (MessageMgr.OpenItemBuyTipsWindowByStr)(v.rewards)
      return 
    end
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnReqActivityList = function(...)
  -- function num : 0_15 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqActivityList, m, (Proto.MsgName).ResActivityList)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResActivityList = function(msg, ...)
  -- function num : 0_16 , upvalues : _ENV
  (ActivityMgr.SetOpenActivityList)(msg.actIdList)
  UIMgr:SendWindowMessage((WinResConfig.HomeWindow).name, (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_ACTIVITY_VISIBLE)
  for _,v in ipairs(msg.actIdList) do
    local activityData = ((TableData.gTable).BaseActivityData)[v]
    loge("开放的活动TYPE:" .. activityData.type)
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnReqActivityInfo = function(type, mark, aId, ...)
  -- function num : 0_17 , upvalues : _ENV
  print("=======================请求活动信息", type, aId)
  local actId = aId
  if actId == nil then
    actId = (ActivityMgr.GetOpenActivityByType)(type)
  end
  if actId and actId > 0 then
    local m = {}
    m.actId = actId
    m.mark = mark
    ;
    (Net.Send)((Proto.MsgName).ReqActivityInfo, m, (Proto.MsgName).ResActivityInfo)
  else
    do
      loge("活动" .. type .. "未开启")
      if type == (ActivityMgr.ActivityType).Total_Login then
        ld("BrithDay", function(...)
    -- function num : 0_17_0 , upvalues : _ENV
    (BrithDayService.ReqBirthdayList)()
  end
)
      end
    end
  end
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResActivityInfo = function(msg, ...)
  -- function num : 0_18 , upvalues : _ENV
  print("=================活动信息返回")
  if (msg.baseActivityInfo).type == (ActivityMgr.ActivityType).SevenTask then
    (ActivityMgr.InitSevenDayTaskData)(msg)
    OpenWindow((WinResConfig.ActivityCarnivalWindow).name, UILayer.HUD)
  else
    if (msg.baseActivityInfo).type == (ActivityMgr.ActivityType).ActivityDungeon or (msg.baseActivityInfo).type == (ActivityMgr.ActivityType).NewActivityDungeon then
      (ActivityMgr.InitActivityDungeonData)(msg)
      ;
      (ActivityDungeonData.Init)(msg.baseActivityInfo)
      OpenWindow((WinResConfig.ActivityDungeonMainWindow).name, UILayer.HUD, ActivityDungeonData.IsFirstOpen or 0)
      UIMgr:SendWindowMessage((WinResConfig.ActivityDungeonMainWindow).name, (WindowMsgEnum.ActivityMainDungeon).E_MSG_SET_TIME)
    else
      if (msg.baseActivityInfo).type == (ActivityMgr.ActivityType).Drop_Multiple then
        (CommonWinMgr.SetCountDown)((msg.baseActivityInfo).actId, (msg.baseActivityInfo).endTime)
      else
        if (msg.baseActivityInfo).type == (ActivityMgr.ActivityType).Total_Login then
          if (msg.loginDayActInfo).todayGet == false then
            OpenWindow((WinResConfig.SignActivityMainWindow).name, UILayer.HUD, msg)
          else
            ld("BrithDay", function(...)
    -- function num : 0_18_0 , upvalues : _ENV
    (BrithDayService.ReqBirthdayList)()
  end
)
          end
        else
          if (msg.baseActivityInfo).type == (ActivityMgr.ActivityType).Prize then
            (ActivityMgr.InitPrizeData)(msg)
            ld("Slots")
            ;
            (SlotsService.ReqSlotsData)((SlotsData.SlotType).PRIZE_SLOT)
          else
            if (msg.baseActivityInfo).type == (ActivityMgr.ActivityType).LotteryIntergral then
              (ActivityMgr.InitLotteryIntegralData)(msg)
            else
              if (msg.baseActivityInfo).type == (ActivityMgr.ActivityType).Relic then
                (ActivityMgr.InitRelicData)(msg)
                ld("Relic", function(...)
    -- function num : 0_18_1 , upvalues : _ENV
    (RelicService.ReqTempleInit)()
  end
)
              else
                if (msg.baseActivityInfo).type == (ActivityMgr.ActivityType).Return then
                  (ActivityReturnMgr.RecvActivityData)(msg)
                else
                  if (msg.baseActivityInfo).type == (ActivityMgr.ActivityType).TowerExpand then
                    (ActivityMgr.InitTowerExpandData)(msg)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnReqTaskGroup = function(actId, group, ...)
  -- function num : 0_19 , upvalues : _ENV
  local m = {}
  m.actId = actId
  m.group = group
  ;
  (Net.Send)((Proto.MsgName).ReqTaskGroup, m, (Proto.MsgName).ResTaskGroup)
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResTaskGroup = function(msg, ...)
  -- function num : 0_20 , upvalues : _ENV
  local activityData = ((TableData.gTable).BaseActivityData)[msg.actId]
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  if activityData.type == (ActivityMgr.ActivityType).SevenTask then
    (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).taskList = msg.taskList
    UIMgr:SendWindowMessage((WinResConfig.ActivityCarnivalWindow).name, (WindowMsgEnum.ActivityCarnival).E_MSG_CHANGE_GROUP, msg.group)
  else
    if activityData.type == (ActivityMgr.ActivityType).Relic then
      (ActivityMgr.InitRelicTaskData)(msg.taskList)
      UIMgr:SendWindowMessage((WinResConfig.RelicMainWindow).name, (WindowMsgEnum.Relic).E_MSG_INIT_TASK)
    end
  end
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnReqTaskReward = function(actId, group, taskId, ...)
  -- function num : 0_21 , upvalues : _ENV
  local m = {}
  m.actId = actId
  m.group = group
  m.taskId = taskId
  ;
  (Net.Send)((Proto.MsgName).ReqTaskReward, m, (Proto.MsgName).ResTaskReward)
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResTaskReward = function(msg, ...)
  -- function num : 0_22 , upvalues : _ENV
  local activityData = ((TableData.gTable).BaseActivityData)[msg.actId]
  if activityData.type == (ActivityMgr.ActivityType).Relic then
    local taskList = (ActivityMgr.InitRelicTaskData)()
    local isCanGet = false
    for index,value in ipairs(taskList) do
      if value.id == msg.taskId then
        value.status = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS
      end
      isCanGet = isCanGet or value.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN
    end
    if not isCanGet then
      (RedDotMgr.EliminateRedDot)((WinResConfig.RelicMainWindow).name, RedDotComID.Relic_Reward)
    end
    ;
    (ActivityMgr.InitRelicTaskData)(taskList)
    UIMgr:SendWindowMessage((WinResConfig.RelicMainWindow).name, (WindowMsgEnum.Relic).E_MSG_GET_TASKREWARD)
  else
    local taskList = (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).taskList
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).canGet = msg.canGet
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).points = msg.points
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).undoneTask = msg.undoneTask
    for _,v in ipairs(taskList) do
      if v.id == msg.taskId then
        v.status = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS
      end
    end
    UIMgr:SendWindowMessage((WinResConfig.ActivityCarnivalWindow).name, (WindowMsgEnum.ActivityCarnival).E_MSG_GET_TASK)
    local haveRot = false
    for _,v in ipairs(taskList) do
      if v.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
        haveRot = true
      end
    end
    if not haveRot then
      (RedDotMgr.EliminateRedDot)((WinResConfig.ActivityCarnivalWindow).name, RedDotComID.SevenTask_BtnList, msg.group)
    end
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnReqPointReward = function(actId, rewId, ...)
  -- function num : 0_23 , upvalues : _ENV
  local m = {}
  m.actId = actId
  m.rewId = rewId
  ;
  (Net.Send)((Proto.MsgName).ReqPointReward, m, (Proto.MsgName).ResPointReward)
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResPointReward = function(msg, ...)
  -- function num : 0_24 , upvalues : _ENV
  local activityData = ((TableData.gTable).BaseActivityData)[msg.actId]
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  if activityData.type == (ActivityMgr.ActivityType).SevenTask then
    (((ActivityMgr.InitSevenDayTaskData)()).SevenDayActInfo).canGet = 0
    UIMgr:SendWindowMessage((WinResConfig.ActivityCarnivalWindow).name, (WindowMsgEnum.ActivityCarnival).E_MSG_GET_INTEGER)
  else
    if activityData.type == (ActivityMgr.ActivityType).Return then
      (ActivityReturnMgr.RecvPointReward)(msg)
    end
  end
  local actId = (ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).SevenTask)
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.ActivityCarnivalWindow).name, RedDotComID.SevenTask_GetBtn, actId)
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResDecActivity = function(msg, ...)
  -- function num : 0_25 , upvalues : _ENV
  (ActivityMgr.RemoveActivity)(msg.actId)
  UIMgr:SendWindowMessage((WinResConfig.HomeWindow).name, (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_ACTIVITY_VISIBLE)
  local activityData = ((TableData.gTable).BaseActivityData)[msg.actId]
  if activityData.type == (ActivityMgr.ActivityType).SevenTask then
    UIMgr:CloseWindow((WinResConfig.ActivityCarnivalWindow).name)
  end
  ;
  (CommonWinMgr.HideCountDown)(msg.actId)
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ReqSetYJCode = function(passWord, ...)
  -- function num : 0_26 , upvalues : _ENV
  local m = {}
  m.password = passWord
  ;
  (Net.Send)((Proto.MsgName).ReqSetYjCode, m, (Proto.MsgName).ResSetYjCode)
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ResSetYjCode = function(...)
  -- function num : 0_27 , upvalues : _ENV
  (MessageMgr.SendCenterTips)((PUtil.get)(20000339))
  UIMgr:CloseWindow((WinResConfig.ActivityPassWordWindow).name)
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ReqGiftCode = function(giftCode, ...)
  -- function num : 0_28 , upvalues : _ENV
  if giftCode then
    local m = {}
    m.giftCode = giftCode
    m.opId = (SuperSDKData.GetLoginOpId)()
    m.gameId = (SuperSDKData.GetLoginGameId)()
    ;
    (Net.Send)((Proto.MsgName).ReqGiftCode, m, (Proto.MsgName).ResGiftCode)
  end
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnResGiftCode = function(msg, ...)
  -- function num : 0_29 , upvalues : _ENV
  PrintTable(msg, "OnResGiftCode: ")
  if msg then
    if msg.code == 0 then
      SendActivityWindowMessage((ActivityWindowName.ActivityGiftCodeView).name, 1)
    else
      if msg.code == 5 then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000411))
      else
        if msg.code == 11 or msg.code == 35 then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000412))
        else
          if msg.code == 19 or msg.code == 601 then
            (MessageMgr.SendCenterTips)((PUtil.get)(20000413))
          else
            if msg.code == 602 or msg.code == 603 or msg.code == 604 or msg.code == 703 then
              (MessageMgr.SendCenterTips)((PUtil.get)(20000414))
            else
              ;
              (MessageMgr.SendCenterTips)((PUtil.get)(20000415))
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ReqBannerIdList = function(...)
  -- function num : 0_30 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqBannerIdList, m, (Proto.MsgName).ResBannerIdList)
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.RecvBannerIdList = function(msg, ...)
  -- function num : 0_31 , upvalues : _ENV
  (ActivityMgr.InitBannerRedDot)(msg.bannerId)
  UIMgr:SendWindowMessage((WinResConfig.HomeWindow).name, (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_BANNER_REDDOT)
end

-- DECOMPILER ERROR at PC100: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ReqSaveBannerId = function(bannerId, ...)
  -- function num : 0_32 , upvalues : _ENV
  local m = {}
  m.bannerId = bannerId
  ;
  (Net.Send)((Proto.MsgName).ReqSaveBannerId, m, (Proto.MsgName).ResSaveBannerId)
end

-- DECOMPILER ERROR at PC103: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.RecvSaveBannerId = function(msg, ...)
  -- function num : 0_33 , upvalues : _ENV
  (ActivityMgr.AddBannerRedDot)(msg.bannerId)
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ReqRemoveBannerId = function(bannerId, ...)
  -- function num : 0_34 , upvalues : _ENV
  local m = {}
  m.bannerId = bannerId
  ;
  (Net.Send)((Proto.MsgName).ReqRemoveBannerId, m, (Proto.MsgName).ResRemoveBannerId)
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.RecvRemoveBannerId = function(msg, ...)
  -- function num : 0_35 , upvalues : _ENV
  (ActivityMgr.RemoveBannerRedDot)(msg.bannerId)
end

-- DECOMPILER ERROR at PC112: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ReqGetReward = function(actId, rewId, ...)
  -- function num : 0_36 , upvalues : _ENV
  local m = {}
  m.actId = actId
  m.rewId = rewId
  ;
  (Net.Send)((Proto.MsgName).ReqGetReward, m, (Proto.MsgName).ResGetReward)
end

-- DECOMPILER ERROR at PC115: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.OnResGetReward = function(msg, ...)
  -- function num : 0_37 , upvalues : _ENV
  if msg.result then
    local activityData = ((TableData.gTable).BaseActivityData)[msg.actId]
    do
      if activityData.type == (ActivityMgr.ActivityType).Return then
        (ActivityReturnMgr.RecvGetReward)(msg)
      end
      local rewardConfig = nil
      if activityData.type == (ActivityMgr.ActivityType).Total_Login or activityData.type == (ActivityMgr.ActivityType).Return then
        rewardConfig = ((TableData.gTable).BaseActivityLoginData)[msg.rewId]
      else
        if activityData.type == (ActivityMgr.ActivityType).LotteryIntergral then
          rewardConfig = ((TableData.gTable).BaseActivityPointsRewardData)[msg.rewId]
        end
      end
      local rewards = split(rewardConfig.rewards, ",")
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
      (MessageMgr.OpenRewardShowWindow)(items, function(...)
    -- function num : 0_37_0 , upvalues : activityData, _ENV, msg
    if activityData.type == (ActivityMgr.ActivityType).Total_Login then
      UIMgr:CloseWindow((WinResConfig.SignActivityMainWindow).name)
      ld("BrithDay", function(...)
      -- function num : 0_37_0_0 , upvalues : _ENV
      (BrithDayService.ReqBirthdayList)()
    end
)
    else
      if activityData.type == (ActivityMgr.ActivityType).LotteryIntergral then
        UIMgr:SendWindowMessage((WinResConfig.LotteryIntegralWindow).name, (WindowMsgEnum.LotteryIntegral).E_MSG_GET_REWARD, {data = msg.rewId})
      end
    end
  end
)
    end
  end
end

-- DECOMPILER ERROR at PC118: Confused about usage of register: R0 in 'UnsetPending'

ActivityService.ReqCurrentActivityDungeonInfo = function(...)
  -- function num : 0_38 , upvalues : _ENV
  local actId = (ActivityMgr.GetCurrentActivityDungeonId)()
  if not actId or actId == -1 then
    loge("当前没有开启的后动副本信息")
    return 
  end
  ;
  (Net.Send)((Proto.MsgName).ReqActivityInfo, {actId = actId}, (Proto.MsgName).ResActivityInfo)
end

;
(ActivityService.Init)()

