-- params : ...
-- function num : 0 , upvalues : _ENV
require("Prize_PrizeByName")
local PrizeWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local configData, isSkipAni, ItemDataList, poolType, QuestTime = nil, nil, nil, nil, nil
PrizeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, PrizeWindow
  bridgeObj:SetView((WinResConfig.PrizeWindow).package, (WinResConfig.PrizeWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetPrize_PrizeUis(contentPane)
  ;
  (PrizeWindow.InitAssetStrip)()
  ;
  (PrizeWindow.GetConfigData)()
  ;
  (PrizeWindow.InitInvariable)()
  ;
  (PrizeWindow.SetBtn)()
  ;
  (PrizeWindow.InitSkipAni)()
  ;
  (PrizeWindow.SetRewardShowPanel)()
  ;
  (PrizeWindow.RefreshRewardPanel)()
end

PrizeWindow.SetRewardShowPanel = function(...)
  -- function num : 0_1 , upvalues : _ENV, configData, poolType, ItemDataList, PrizeWindow
  local mData = (TableData.gTable).BaseSlotsRoundData
  for _,v in pairs(mData) do
    if v.type == configData.type then
      poolType = v.pool
    end
  end
  ItemDataList = {}
  local PoolData = (TableData.gTable).BaseSlotsPoolData
  for _,v in pairs(PoolData) do
    if v.type == poolType then
      local contain = (PrizeWindow.ContainSameSort)(v)
      if contain then
        for _,v2 in ipairs(ItemDataList) do
          if (v2.data).sort == v.sort then
            v2.count = v2.count + v.reward_max
          end
        end
      else
        do
          do
            ;
            (table.insert)(ItemDataList, {data = v, count = v.reward_max})
            -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

PrizeWindow.ContainSameSort = function(data, ...)
  -- function num : 0_2 , upvalues : _ENV, ItemDataList
  for _,v in ipairs(ItemDataList) do
    if (v.data).sort == data.sort then
      return true, v
    end
  end
  return false
end

PrizeWindow.GetCountRemainTime = function(...)
  -- function num : 0_3 , upvalues : _ENV, ItemDataList, PrizeWindow
  local count = 0
  for _,v in ipairs(ItemDataList) do
    local times = (PrizeWindow.GetItemTimes)((v.data).id)
    if times == -1 then
      times = v.count
    end
    local remain = v.count - times
    count = count + remain
  end
  return count
end

PrizeWindow.GetItemTimes = function(poolID, ...)
  -- function num : 0_4 , upvalues : _ENV, poolType
  local count = 0
  local PoolData = (TableData.gTable).BaseSlotsPoolData
  local mData = ((TableData.gTable).BaseSlotsPoolData)[poolID]
  local round = (SlotsData.SlotRound)()
  for _,v in pairs(PoolData) do
    if v.type == poolType and mData.sort == v.sort then
      local time = (SlotsData.GetItemTimes)(round, v.id)
      if time == -1 then
        return time
      end
      count = count + time
    end
  end
  return count
end

PrizeWindow.RefreshRewardPanel = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV, ItemDataList, PrizeWindow
  local rewardPanel = (uis.RewardShow).root
  for _,v in ipairs(ItemDataList) do
    local data = v.data
    local item = rewardPanel:GetChild("Item_" .. data.sort)
    local times = (PrizeWindow.GetItemTimes)(data.id)
    local maxTime = v.count
    if times == -1 then
      times = maxTime
    end
    local remain = maxTime - times
    if remain <= 0 then
      ChangeUIController(item, "c2", 1)
    else
      ChangeUIController(item, "c2", 0)
    end
    local name = item:GetChild("NameTxt")
    local icon = item:GetChild("ItemLoader")
    local Number = item:GetChild("NumberTxt")
    local reward = split(data.reward, ":")
    if data.group_name and not (Util.StringIsNullOrEmpty)(data.group_name) then
      name.text = data.group_name
    else
      local configData = (Util.GetConfigDataByID)(tonumber(reward[2]))
      name.text = configData.name
    end
    do
      do
        if data.group_icon and not (Util.StringIsNullOrEmpty)(data.group_icon) then
          icon.url = (Util.GetItemUrl)(data.group_icon)
        else
          icon.url = (Util.GetIconPathByID)(tonumber(reward[2]))
        end
        Number.text = remain
        -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  (PrizeWindow.SetBtn)()
end

PrizeWindow.InitSkipAni = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis, isSkipAni
  local isOpen = (Util.GetPlayerSetting)(PlayerPrefsKeyName.PRIZE_SKIP_ANI, "0") == "1"
  local skipBtn = (uis.Skip).SkipBtn
  skipBtn.selected = isOpen
  isSkipAni = isOpen
  ;
  (skipBtn.onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : isSkipAni, _ENV
    isSkipAni = not isSkipAni
    local value = "0"
    if isSkipAni then
      value = "1"
    end
    ;
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.PRIZE_SKIP_ANI, value)
  end
)
  local txt = (uis.Skip).SkipTxt
  txt.text = (PUtil.get)(20000522)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

PrizeWindow.InitInvariable = function(...)
  -- function num : 0_7 , upvalues : uis, _ENV, configData, PrizeWindow
  ((uis.RewardBtn):GetChild("WordTxt")).text = (PUtil.get)(20000629)
  ;
  ((uis.ResultBtn):GetChild("WordTxt")).text = (PUtil.get)(20000630)
  ;
  ((uis.RewardBtn).onClick):Set(function(...)
    -- function num : 0_7_0 , upvalues : _ENV, configData
    OpenWindow((WinResConfig.PrizeInformationWindow).name, UILayer.HUD1, configData.id)
  end
)
  ;
  ((uis.ResultBtn).onClick):Set(function(...)
    -- function num : 0_7_1 , upvalues : _ENV
    (SlotsService.ReqSlotsRecord)((SlotsData.SlotType).PRIZE_SLOT)
  end
)
  ;
  (PrizeWindow.SetActivityTime)()
end

PrizeWindow.GetConfigData = function(...)
  -- function num : 0_8 , upvalues : _ENV, configData
  local type = (SlotsData.GetCurrentType)()
  local ShowData = (TableData.gTable).BaseSlotsData
  for _,v in pairs(ShowData) do
    if v.type == type then
      configData = v
    end
  end
end

PrizeWindow.SetActivityTime = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis
  local ActivityData = (ActivityMgr.InitPrizeData)()
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Time).StartTxt).text = (PUtil.get)(20000632, (LuaTime.GetFormatTimeStr)("%Y/%m/%d %H:%M", (ActivityData.baseActivityInfo).beginTime))
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Time).EndTxt).text = (PUtil.get)(20000633, (LuaTime.GetFormatTimeStr)("%Y/%m/%d %H:%M", (ActivityData.baseActivityInfo).endTime))
end

PrizeWindow.SetBtn = function(...)
  -- function num : 0_10 , upvalues : _ENV, configData, PrizeWindow, uis
  local times = split(configData.mode, ":")
  ;
  (PrizeWindow.SetBtnContent)(uis.OneBtn, tonumber(times[1]))
  ;
  (PrizeWindow.SetBtnContent)(uis.TenBtn, tonumber(times[2]))
end

PrizeWindow.SetBtnContent = function(btnUI, times, ...)
  -- function num : 0_11 , upvalues : _ENV, configData, PrizeWindow, QuestTime
  local singleCost = split(configData.cost, ":")
  local Const = singleCost[1] .. ":" .. singleCost[2] .. ":" .. tonumber(singleCost[3]) * times
  do
    if not (Util.CheckCostResources)(Const, nil, nil, true) then
      local singleCostSe = split(configData.second_cost, ":")
      Const = singleCostSe[1] .. ":" .. singleCostSe[2] .. ":" .. tonumber(singleCostSe[3]) * times
    end
    ;
    (Util.SetConsumption)(Const, btnUI:GetChild("Number_01_Loader"), btnUI:GetChild("Number_01_Txt"), false, true)
    ;
    (btnUI.onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : PrizeWindow, _ENV, Const, configData, times, QuestTime, singleCost
    if (PrizeWindow.GetCountRemainTime)() <= 0 then
      (MessageMgr.SendCenterTipsByWordID)(20000635)
      return 
    end
    local ActivityData = (ActivityMgr.InitPrizeData)()
    if (ActivityData.baseActivityInfo).endTime - (ActorData.GetServerTime)() <= 0 then
      (MessageMgr.SendCenterTipsByWordID)(20000638)
      return 
    end
    if (Util.CheckCostResources)(Const, nil, nil, false) then
      (MessageMgr.OpenCostResConfirmWindow)(224, Const, function(...)
      -- function num : 0_11_0_0 , upvalues : _ENV, configData, times, QuestTime
      (SlotsService.ReqSlotsOperation)(configData.type, times)
      QuestTime = times
    end
)
    else
      local data = (Util.GetConfigDataByID)(singleCost[2])
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(177, data.name))
    end
  end
)
  end
end

PrizeWindow.OnShown = function(...)
  -- function num : 0_12
end

PrizeWindow.OnHide = function(...)
  -- function num : 0_13
end

PrizeWindow.ShowRewardPanel = function(poolsID, ...)
  -- function num : 0_14 , upvalues : _ENV
  local goods = {}
  for _,v in ipairs(poolsID) do
    local PoolData = ((TableData.gTable).BaseSlotsPoolData)[v]
    local reward = PoolData.reward
    local rewards = (Util.ParseConfigStr)(reward)
    for _,v in ipairs(rewards) do
      local re = {}
      re.type = tonumber(v[1])
      re.id = tonumber(v[2])
      re.value = tonumber(v[3])
      ;
      (table.insert)(goods, re)
    end
  end
  ;
  (ActorService.OtherWayToGetCardShow)(goods, function(...)
    -- function num : 0_14_0 , upvalues : _ENV, goods
    (MessageMgr.OpenRewardByGoods)(goods)
  end
)
end

PrizeWindow.PlaySingleAni = function(poolID, func, ...)
  -- function num : 0_15 , upvalues : _ENV, uis, PrizeWindow
  local PoolData = ((TableData.gTable).BaseSlotsPoolData)[poolID]
  if PoolData == nil then
    func()
    return 
  end
  local RewardShow = (uis.RewardShow).root
  local item = RewardShow:GetChild("Item_" .. PoolData.sort)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (GRoot.inst).touchable = false
  ;
  (LuaEffect.CreateEffectToObj)("FX_ui_yifanshang_2", true, item, Vector2(90, 100))
  ;
  (SimpleTimer.setTimeout)(0.7, function(...)
    -- function num : 0_15_0 , upvalues : _ENV, func, PrizeWindow
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = true
    func()
    ;
    (PrizeWindow.RefreshRewardPanel)()
  end
)
end

PrizeWindow.PlayTenAni = function(poolsID, func, ...)
  -- function num : 0_16 , upvalues : uis, _ENV, PrizeWindow
  local RewardShow = (uis.RewardShow).root
  local freeItem = {}
  for i = 1, 15 do
    local item = RewardShow:GetChild("Item_" .. i)
    local control = item:GetController("c2")
    if control.selectedIndex == 0 then
      (table.insert)(freeItem, item)
    end
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (GRoot.inst).touchable = false
  local freeNum = #freeItem
  local shakeNum = (math.ceil)((math.min)(freeNum, 10) * 3)
  ;
  (SimpleTimer.setInterval)(0.07, shakeNum, function(...)
    -- function num : 0_16_0 , upvalues : _ENV, freeNum, freeItem
    local num = (math.random)(1, freeNum)
    local item = freeItem[num]
    ;
    (LuaEffect.CreateEffectToObj)("FX_ui_yifanshang_1", true, item, Vector2(90, 100))
  end
, function(...)
    -- function num : 0_16_1 , upvalues : _ENV, poolsID, RewardShow, func, PrizeWindow
    (SimpleTimer.setTimeout)(0.3, function(...)
      -- function num : 0_16_1_0 , upvalues : _ENV, poolsID, RewardShow, func, PrizeWindow
      for _,v in ipairs(poolsID) do
        local poolData = ((TableData.gTable).BaseSlotsPoolData)[v]
        local item = RewardShow:GetChild("Item_" .. poolData.sort)
        ;
        (LuaEffect.CreateEffectToObj)("FX_ui_yifanshang_2", true, item, Vector2(90, 100))
      end
      ;
      (SimpleTimer.setTimeout)(1, function(...)
        -- function num : 0_16_1_0_0 , upvalues : _ENV, func, PrizeWindow
        -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

        (GRoot.inst).touchable = true
        func()
        ;
        (PrizeWindow.RefreshRewardPanel)()
      end
)
    end
)
  end
)
end

PrizeWindow.InitAssetStrip = function(...)
  -- function num : 0_17 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.PrizeWindow).name
  m.Tip = (PUtil.get)(20000628)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, ParticularAssetType.SLOTS_ASSET}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

PrizeWindow.OnClose = function(...)
  -- function num : 0_18 , upvalues : uis, contentPane, argTable, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.PrizeWindow).name)
end

local choosePool, chooseItem = nil, nil
PrizeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_19 , upvalues : _ENV, isSkipAni, PrizeWindow
  if msgId == (WindowMsgEnum.PrizeWindow).E_MSG_SLOTS_RESULT then
    local data = para
    do
      local goods = data[1]
      local equip = data[2]
    end
  else
    do
      if msgId == (WindowMsgEnum.PrizeWindow).E_MSG_SLOTS_REFRESH and isSkipAni then
        (PrizeWindow.RefreshRewardPanel)()
      end
      if msgId == (WindowMsgEnum.PrizeWindow).E_MSG_SLOTS_SET_POOLS then
        local data = para
        if not isSkipAni then
          if #data == 1 then
            (PrizeWindow.PlaySingleAni)((data[1]).poolId, function(...)
    -- function num : 0_19_0 , upvalues : _ENV, data
    OpenWindow((WinResConfig.PrizeRewardShowWindow).name, UILayer.HUD1, data)
  end
)
          else
            local pools = {}
            for _,v in ipairs(data) do
              if not (PrizeWindow.TableContainValue)(pools, v.poolId) then
                (table.insert)(pools, v.poolId)
              end
            end
            ;
            (PrizeWindow.PlayTenAni)(pools, function(...)
    -- function num : 0_19_1 , upvalues : _ENV, data
    OpenWindow((WinResConfig.PrizeRewardShowWindow).name, UILayer.HUD1, data)
  end
)
          end
        else
          do
            OpenWindow((WinResConfig.PrizeRewardShowWindow).name, UILayer.HUD1, data)
          end
        end
      end
    end
  end
end

PrizeWindow.TableContainValue = function(table, value, ...)
  -- function num : 0_20 , upvalues : _ENV
  for _,v in ipairs(table) do
    if v == value then
      return true
    end
  end
  return false
end

return PrizeWindow

