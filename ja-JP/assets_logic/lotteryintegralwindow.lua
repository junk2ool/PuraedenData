-- params : ...
-- function num : 0 , upvalues : _ENV
require("LotteryIntegral_LotteryIntegralByName")
local LotteryIntegralWindow = {}
local uis, contentPane, bridge, argTable, integralData, create = nil, nil, nil, nil, nil, nil
local canEffect = {}
local mTime = nil
LotteryIntegralWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, uis
  bridgeObj:SetView((WinResConfig.LotteryIntegralWindow).package, (WinResConfig.LotteryIntegralWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetLotteryIntegral_LotteryIntegralUis(contentPane)
  local m = {}
  m.windowName = (WinResConfig.LotteryIntegralWindow).name
  m.Tip = (PUtil.get)(305)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  ;
  (ActivityService.OnReqActivityInfo)((ActivityMgr.ActivityType).LotteryIntergral)
end

LotteryIntegralWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, integralData, mTime, create, canEffect
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.Integral).NameTxt).text = (PUtil.get)(306)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Integral).IntegralTxt).text = (integralData.lotteryIntegralActInfo).points
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Tips).TipsTxt).text = (PUtil.get)(310)
  ;
  ((uis.GoBtn):GetChild("title")).text = (PUtil.get)(302)
  ;
  ((uis.GoBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    ld("Lottery", function(...)
      -- function num : 0_1_0_0 , upvalues : _ENV
      (Util.SetDelayCall)(function(...)
        -- function num : 0_1_0_0_0 , upvalues : _ENV
        (ActorService.ReqActivityLottery)()
      end
)
    end
)
  end
)
  local startTime = (integralData.baseActivityInfo).beginTime
  local endTime = (integralData.baseActivityInfo).endTime
  local destoryTime = (integralData.baseActivityInfo).destroyTime
  local startStr = (LuaTime.GetFormatTimeStr)("%m-%d %H:%M", startTime)
  local endStr = (LuaTime.GetFormatTimeStr)("%m-%d %H:%M", endTime)
  local destoryStr = (LuaTime.GetFormatTimeStr)("%m-%d %H:%M", destoryTime)
  local curTime = (ActorData.GetServerTime)()
  if endTime <= curTime then
    if mTime then
      mTime:Stop()
    end
    mTime = (LuaTime.CountDown)(destoryTime * 0.001 - (ActorData.GetServerTime)() * 0.001, (uis.Integral).TimeTxt, function(...)
    -- function num : 0_1_1 , upvalues : uis, _ENV
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.Integral).TimeTxt).text = (PUtil.get)(20000221)
  end
, true, nil, 312)
  else
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((uis.Integral).TimeTxt).text = (PUtil.get)(20000388, startStr, endStr)
  end
  local rewards = (integralData.lotteryIntegralActInfo).rewardList
  ;
  (table.sort)(rewards, function(a, b, ...)
    -- function num : 0_1_2
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if create then
    create:stop()
    create = nil
  end
  ;
  ((uis.Integral).RewardList):RemoveChildrenToPool()
  local shopNum = #rewards
  local shopGrpNum = (math.ceil)(shopNum / 5)
  local t = 1
  for index,value in ipairs(canEffect) do
    if value ~= nil then
      (LuaEffect.DestroyEffect)(value)
    end
  end
  canEffect = {}
  for i = 1, shopGrpNum do
    local rewardItemList = (((uis.Integral).RewardList):AddItemFromPool()):GetChild("RewardItemList")
    do
      rewardItemList:RemoveChildrenToPool()
      for j = 1, 5 do
        local shopIndex = (t - 1) * 5 + j
        if shopNum < shopIndex then
          return 
        end
        print("id", (rewards[shopIndex]).id)
        local shopItem = rewardItemList:AddItemFromPool()
        local rewardConfig = ((TableData.gTable).BaseActivityPointsRewardData)[(rewards[shopIndex]).id]
        local rewardId = tonumber((split(rewardConfig.rewards_show, ":"))[2])
        local rewardShowConfig = (Util.GetConfigDataByID)(rewardId)
        print("111111111111111", rewardId, rewardShowConfig.icon, rewardShowConfig.icon_path)
        if not rewardShowConfig.icon then
          (shopItem:GetChild("IconLoader")).url = (Util.GetItemUrl)(rewardShowConfig.icon_path)
          ;
          (CommonWinMgr.RegisterItemLongPress)(shopItem:GetChild("IconLoader"), rewardId)
          ;
          (shopItem:GetController("c1")).selectedIndex = (rewards[shopIndex]).status
          local itemNumber = ""
          if tonumber((split(rewardConfig.rewards_show, ":"))[3]) > 1 then
            itemNumber = (split(rewardConfig.rewards_show, ":"))[3]
          end
          ;
          (shopItem:GetChild("ItemNumberTxt")).text = itemNumber
          ;
          (shopItem:GetChild("NumberTxt")).text = rewardConfig.need
          do
            if (rewards[shopIndex]).status ~= (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT or (rewards[shopIndex]).status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
              local holder, effect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERYINTERGRAL_LOOP, true, shopItem, Vector2(shopItem.width / 2, shopItem.height / 2))
              -- DECOMPILER ERROR at PC267: Confused about usage of register: R28 in 'UnsetPending'

              ;
              (effect.transform).localPosition = Vector3(0, ((effect.transform).localPosition).y, 0)
              ;
              (table.insert)(canEffect, holder)
            else
            end
            if (rewards[shopIndex]).status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
              do
                (shopItem.onClick):Set(function(...)
    -- function num : 0_1_3 , upvalues : rewards, shopIndex, _ENV, rewardConfig, rewardId, integralData, shopItem, canEffect
    if (rewards[shopIndex]).status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
      (MessageMgr.SendCenterTips)((PUtil.get)(303))
    else
      if (rewards[shopIndex]).status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
        local isCan = true
        for index,value in ipairs(split(rewardConfig.rewards, ",")) do
          local str = split(value, ":")
          local rId = tonumber(str[2])
          local rNum = tonumber(str[3])
          local max = (Util.GetMaxAssetNum)(rId)
          isCan = not isCan or rNum + (ActorData.GetAssetCount)(rId) <= max
          print("rewardId", rewardId, rNum + (ActorData.GetAssetCount)(rId), max, isCan)
        end
        if isCan == false then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000184))
          return 
        end
        ;
        (ActivityService.ReqGetReward)((integralData.baseActivityInfo).actId, (rewards[shopIndex]).id)
        local holder, effect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERYINTERGRAL, true, shopItem, Vector2(shopItem.width / 2, shopItem.height / 2))
        -- DECOMPILER ERROR at PC104: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (effect.transform).localPosition = Vector3.zero
        ;
        (table.insert)(canEffect, holder)
      elseif (rewards[shopIndex]).status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
        (MessageMgr.SendCenterTips)((PUtil.get)(304))
      end
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
)
                -- DECOMPILER ERROR at PC286: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC286: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC286: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC286: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC286: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
      t = t + 1
    end
  end
end

LotteryIntegralWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_2 , upvalues : _ENV, integralData, LotteryIntegralWindow
  local windowMsgEnum = WindowMsgEnum.LotteryIntegral
  if msgId == windowMsgEnum.E_MSG_GET_REWARD then
    local isGoOn = false
    for index,value in ipairs((integralData.lotteryIntegralActInfo).rewardList) do
      if value.id == para.data then
        value.status = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS
      end
      isGoOn = isGoOn or value.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN
    end
    if isGoOn == false then
      (RedDotMgr.EliminateRedDot)((WinResConfig.HomeWindow).name, RedDotComID.Home_LotteryIntegral)
    end
    ;
    (LotteryIntegralWindow.RefreshWindow)()
  elseif msgId == windowMsgEnum.E_MSG_INIT_REWARD then
    integralData = para.data
    print(" windowMsgEnum.E_MSG_INIT_REWARD windowMsgEnum.E_MSG_INIT_REWARD")
    ;
    (LotteryIntegralWindow.RefreshWindow)()
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

LotteryIntegralWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : _ENV, canEffect, mTime, uis, contentPane, bridge, argTable, create
  (CommonWinMgr.RemoveAssets)((WinResConfig.LotteryIntegralWindow).name)
  for index,value in ipairs(canEffect) do
    if value ~= nil then
      (LuaEffect.DestroyEffect)(value)
    end
  end
  if mTime then
    mTime:Stop()
  end
  canEffect = {}
  uis = nil
  contentPane = nil
  bridge = nil
  argTable = nil
  if create then
    create:stop()
    create = nil
  end
end

return LotteryIntegralWindow

