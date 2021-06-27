-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_ExchangeByName")
local NewActivityDungeonExchangeWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local ANIM_NAME = {"white", "blue", "green", "purple", "gold", "ten"}
local _cardLoader, _centerPos, _skipAnim, _slots, _cardModel, _timer = nil, nil, nil, nil, nil, nil
NewActivityDungeonExchangeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, NewActivityDungeonExchangeWindow
  bridgeObj:SetView((WinResConfig.NewActivityDungeonExchangeWindow).package, (WinResConfig.NewActivityDungeonExchangeWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivityDungeonTwo_ExchangeUis(contentPane)
  ;
  (NewActivityDungeonExchangeWindow.InitVariable)()
  ;
  (NewActivityDungeonExchangeWindow.InitTopMenu)()
  ;
  (NewActivityDungeonExchangeWindow.InitText)()
  ;
  (NewActivityDungeonExchangeWindow.InitButtonEvent)()
  ;
  (NewActivityDungeonExchangeWindow.InitSfx)()
end

NewActivityDungeonExchangeWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _skipAnim, _ENV, _centerPos, _cardLoader, uis
  _skipAnim = (Util.GetPlayerSetting)(PlayerPrefsKeyName.ACTIVITY_EXCHANGE_SKIP_ANI, "0") == "1"
  _centerPos = Vector2(DesignScreen.width / 2 + (ResolutionHandler.AdaptOffset).X, DesignScreen.height / 2 + (ResolutionHandler.AdaptOffset).Y)
  _cardLoader = (uis.root):GetChild("CardTxt")
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

NewActivityDungeonExchangeWindow.InitTopMenu = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.NewActivityDungeonExchangeWindow).name
  m.Tip = (PUtil.get)(20000216)
  m.model = uis.AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.ACTIVITY_SCORE_NEW}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

NewActivityDungeonExchangeWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.SkipTxt).text = (PUtil.get)(20000522)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ResetBtn).text = (PUtil.get)(20000519)
end

NewActivityDungeonExchangeWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, NewActivityDungeonExchangeWindow
  ((uis.ResetBtn).onClick):Set(NewActivityDungeonExchangeWindow.ClickResetBtn)
  ;
  ((uis.SkipBtn).onClick):Set(NewActivityDungeonExchangeWindow.ClickSkipBtn)
end

NewActivityDungeonExchangeWindow.InitSfx = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis, _centerPos
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_ACTIVITY_EXCHANGE_BG, false, uis.root, _centerPos)
end

NewActivityDungeonExchangeWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : NewActivityDungeonExchangeWindow
  (NewActivityDungeonExchangeWindow.Init)()
end

NewActivityDungeonExchangeWindow.OnHide = function(...)
  -- function num : 0_7
end

NewActivityDungeonExchangeWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : _timer, _ENV, uis, _cardLoader, contentPane, argTable
  if _timer then
    _timer:Stop()
  end
  ;
  (Util.RecycleUIModel)(uis.ALoader)
  ;
  (Util.RecycleUIModel)(_cardLoader)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.NewActivityDungeonExchangeWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
end

NewActivityDungeonExchangeWindow.Init = function(...)
  -- function num : 0_9 , upvalues : NewActivityDungeonExchangeWindow, _ENV
  (NewActivityDungeonExchangeWindow.InitModel)()
  ;
  (NewActivityDungeonExchangeWindow.InitSkipAni)()
  ;
  (NewActivityDungeonExchangeWindow.InitLabelList)()
  ;
  (NewActivityDungeonExchangeWindow.SetRoundShow)((SlotsData.SlotRound)())
  ;
  (NewActivityDungeonExchangeWindow.SetCountDown)()
  ;
  (NewActivityDungeonExchangeWindow.ModifyLastLabel)()
  ;
  (NewActivityDungeonExchangeWindow.SetResetShow)()
  ;
  (NewActivityDungeonExchangeWindow.RefreshBtnContent)()
end

NewActivityDungeonExchangeWindow.SetCountDown = function(...)
  -- function num : 0_10 , upvalues : _ENV, _timer, uis
  local time = (NewActivityDungeonData.NADData).destroyTime
  if _timer then
    _timer:Stop()
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  if time - (ActorData.GetServerTime)() <= 0 then
    ((uis.RewardShow).EndTimeTxt).text = (PUtil.get)(20000221)
  else
    _timer = (LuaTime.CountDown)(time * 0.001 - (ActorData.GetServerTime)() * 0.001, (uis.RewardShow).EndTimeTxt, function(...)
    -- function num : 0_10_0 , upvalues : uis, _ENV
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.RewardShow).EndTimeTxt).text = (PUtil.get)(20000221)
  end
, true)
  end
end

NewActivityDungeonExchangeWindow.InitModel = function(...)
  -- function num : 0_11 , upvalues : _slots, _ENV, uis, _cardModel, _cardLoader
  _slots = (Util.ShowUIModel)("ui_laba", uis.ALoader, nil, false, function(object, ...)
    -- function num : 0_11_0 , upvalues : _ENV
    (SkeletonAnimationUtil.SetAnimation)(object, 0, "idle", true, nil, true)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((object.gameObject).transform).localScale = Vector3(100, 100, 100)
  end
)
  _cardModel = (Util.ShowUIModel)("CardSpine_11101002", _cardLoader, nil, false, function(model, ...)
    -- function num : 0_11_1 , upvalues : _ENV
    (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle", true, nil, true)
    ;
    (CSLuaUtil.SetGOScale)(model, 20, 20, 20)
  end
)
end

NewActivityDungeonExchangeWindow.RefreshBtnContent = function(...)
  -- function num : 0_12 , upvalues : _ENV, NewActivityDungeonExchangeWindow, uis
  local times = split((NewActivityDungeonData.SlotsConfig).mode, ":")
  ;
  (NewActivityDungeonExchangeWindow.SetBtnContent)((uis.GetReward_A).root, times[1])
  ;
  (NewActivityDungeonExchangeWindow.SetBtnContent)((uis.GetReward_B).root, times[2], tonumber(times[1]))
  ;
  (NewActivityDungeonExchangeWindow.SetBtnContent)((uis.GetReward_C).root, times[3], tonumber(times[2]))
end

NewActivityDungeonExchangeWindow.InitSkipAni = function(...)
  -- function num : 0_13 , upvalues : uis, _skipAnim
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  (uis.SkipBtn).selected = _skipAnim
end

NewActivityDungeonExchangeWindow.SetResetShow = function(...)
  -- function num : 0_14 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ResetBtn).visible = (SlotsData.CanReset)()
end

NewActivityDungeonExchangeWindow.SetRoundShow = function(round, ...)
  -- function num : 0_15 , upvalues : _ENV, uis
  for i,v in ipairs(NewActivityDungeonData.RoundDataList) do
    if v.num_round == round then
      (NewActivityDungeonMgr.SetRoundData)(v)
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

      if ((uis.RewardShow).LabelList).selectedIndex ~= i - 1 then
        ((uis.RewardShow).LabelList).selectedIndex = i - 1
        ;
        ((uis.RewardShow).LabelList):ScrollToView(i - 1)
      end
    end
  end
  local count = ((uis.RewardShow).LabelList).numItems
  for i = 1, count do
    local obj = ((uis.RewardShow).LabelList):GetChildAt(i - 1)
    if obj then
      if i - 1 == round then
        ChangeUIController(obj, "c1", 1)
      else
        ChangeUIController(obj, "c1", 0)
      end
    end
  end
end

NewActivityDungeonExchangeWindow.ModifyLastLabel = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis
  local total = (SlotsData.ChangeTotalRound)()
  local curr = (SlotsData.SlotRound)()
  if total <= curr then
    return 
  end
  local labelList = (uis.RewardShow).LabelList
  local obj = labelList:GetChildAt(labelList.numItems - 1)
  ;
  (obj:GetChild("NameTxt")).text = (PUtil.get)(20000459, total + 1)
end

NewActivityDungeonExchangeWindow.SetBtnContent = function(com, times, preTimes, ...)
  -- function num : 0_17 , upvalues : _ENV
  if times == nil or tonumber(times) <= 0 then
    com.visible = false
  end
  times = tonumber(times)
  local icon = com:GetChild("IconLoader")
  local txt = com:GetChild("NumberTxt")
  local singleCost = split((NewActivityDungeonData.SlotsConfig).cost, ":")
  local count = (ActorData.GetAssetCount)(tonumber(singleCost[2]))
  local Const = singleCost[1] .. ":" .. singleCost[2] .. ":" .. tonumber(singleCost[3]) * times
  if not (Util.CheckCostResources)(Const, nil, nil, true) and count > 0 and times > 1 and preTimes and preTimes > 0 then
    local preConst = singleCost[1] .. ":" .. singleCost[2] .. ":" .. tonumber(singleCost[3]) * preTimes
    if (Util.CheckCostResources)(preConst, nil, nil, true) then
      local mTimes = (math.floor)(count / tonumber(singleCost[3]))
      if preTimes < mTimes then
        times = mTimes
      end
    end
  end
  do
    times = (math.min)(times, (NewActivityDungeonData.GetRemainCount)())
    local btn = com:GetChild("n4")
    btn.text = (PUtil.get)(20000458, times)
    local Const = singleCost[1] .. ":" .. singleCost[2] .. ":" .. tonumber(singleCost[3]) * times
    ;
    (Util.SetConsumption)(Const, icon, txt, false, true)
    ;
    (btn.onClick):Set(function(...)
    -- function num : 0_17_0 , upvalues : singleCost, _ENV, times
    local Const = singleCost[1] .. ":" .. singleCost[2] .. ":" .. 1
    if (Util.CheckCostResources)(Const, nil, nil, true) then
      (SlotsService.ReqSlotsOperation)((NewActivityDungeonData.SlotsConfig).type, times)
    else
      local data = (Util.GetConfigDataByID)(singleCost[2])
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(177, data.name))
    end
  end
)
  end
end

NewActivityDungeonExchangeWindow.RefreshRewardList = function(...)
  -- function num : 0_18 , upvalues : uis, _ENV, NewActivityDungeonExchangeWindow
  ((uis.RewardShow).RewardList):RemoveChildrenToPool()
  if #NewActivityDungeonData.AimListData > 0 then
    (NewActivityDungeonExchangeWindow.SetListShow)(NewActivityDungeonData.AimListData, true)
  end
  if #NewActivityDungeonData.BasicListData > 0 then
    (NewActivityDungeonExchangeWindow.SetListShow)(NewActivityDungeonData.BasicListData, false)
  end
end

NewActivityDungeonExchangeWindow.SetListShow = function(mList, isAim, ...)
  -- function num : 0_19 , upvalues : uis, _ENV
  local line = ((uis.RewardShow).RewardList):AddItemFromPool((UIPackage.GetItemURL)("ActivityDungeon", "RewardTitle"))
  if isAim then
    (line:GetChild("NameTxt")).text = (PUtil.get)(20000460)
  else
    ;
    (line:GetChild("NameTxt")).text = (PUtil.get)(20000461)
  end
  local count, getCount = (NewActivityDungeonData.GetAimCount)(mList)
  if count - getCount > 0 then
    (line:GetChild("NumberTxt")).text = (PUtil.get)(20000462, count - getCount, count)
  else
    ;
    (line:GetChild("NumberTxt")).text = (PUtil.get)(20000515, count - getCount, count)
  end
  for i,v in ipairs(mList) do
    local item = split(v.reward, ":")
    local itemID = tonumber(item[2])
    local propData = (Util.GetConfigDataByID)(itemID)
    local reward = ((uis.RewardShow).RewardList):AddItemFromPool((UIPackage.GetItemURL)("ActivityDungeon", "Reward"))
    ;
    (Util.SetAllItemIcon)(reward:GetChild("AllItemIcon"), itemID, 1, false, false, true)
    ;
    (reward:GetChild("NameTxt")).text = propData.name .. "x" .. item[3]
    local roundNum = ((SlotsData.SlotRound)())
    local getCount = nil
    local times = (SlotsData.GetItemTimes)((NewActivityDungeonData.RoundData).num_round, v.id)
    if times == -1 then
      times = v.reward_max
    end
    if roundNum == (NewActivityDungeonData.RoundData).num_round then
      getCount = times
    else
      if roundNum < (NewActivityDungeonData.RoundData).num_round then
        getCount = 0
      else
        getCount = times
      end
    end
    local max = v.reward_max
    if max - getCount > 0 then
      (reward:GetChild("ItemNumberTxt")).text = (PUtil.get)(20000463, max - getCount, max)
    else
      ;
      (reward:GetChild("ItemNumberTxt")).text = (PUtil.get)(20000516, max - getCount, max)
    end
    if i < #mList then
      ((uis.RewardShow).RewardList):AddItemFromPool((UIPackage.GetItemURL)("ActivityDungeon", "RewardLine"))
    end
  end
end

NewActivityDungeonExchangeWindow.InitLabelList = function(...)
  -- function num : 0_20 , upvalues : uis, _ENV
  ((uis.RewardShow).LabelList):RemoveChildrenToPool()
  for i,v in ipairs(NewActivityDungeonData.RoundDataList) do
    do
      local obj = ((uis.RewardShow).LabelList):AddItemFromPool()
      ;
      (obj:GetChild("NameTxt")).text = (PUtil.get)(20000459, i)
      if i == #NewActivityDungeonData.RoundDataList then
        (obj:GetChild("n12")).visible = false
      end
      ;
      (obj.onClick):Set(function(...)
    -- function num : 0_20_0 , upvalues : _ENV, v, uis, i
    (NewActivityDungeonMgr.SetRoundData)(v)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    if ((uis.RewardShow).LabelList).selectedIndex ~= i - 1 then
      ((uis.RewardShow).LabelList).selectedIndex = i - 1
    end
  end
)
    end
  end
end

NewActivityDungeonExchangeWindow.PlayAnimation = function(name, goods, equip, ...)
  -- function num : 0_21 , upvalues : _skipAnim, _ENV, _slots, _cardModel, uis, _centerPos
  if _skipAnim then
    (ActorService.OtherWayToGetCardShow)(goods, function(...)
    -- function num : 0_21_0 , upvalues : _ENV, goods, equip
    (MessageMgr.ShowGetGoods)(goods, equip)
  end
)
    return 
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (GRoot.inst).touchable = false
  ;
  (SkeletonAnimationUtil.SetAnimation)(_slots, 0, name, false, function(...)
    -- function num : 0_21_1 , upvalues : name, _ENV, goods, equip
    if name == "ten" then
      (SimpleTimer.setTimeout)(0.4, function(...)
      -- function num : 0_21_1_0 , upvalues : _ENV, goods, equip
      -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

      (GRoot.inst).touchable = true
      ;
      (ActorService.OtherWayToGetCardShow)(goods, function(...)
        -- function num : 0_21_1_0_0 , upvalues : _ENV, goods, equip
        (MessageMgr.ShowGetGoods)(goods, equip)
      end
)
    end
)
    else
      ;
      (ActorService.OtherWayToGetCardShow)(goods, function(...)
      -- function num : 0_21_1_1 , upvalues : _ENV, goods, equip
      (MessageMgr.ShowGetGoods)(goods, equip)
    end
)
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (GRoot.inst).touchable = true
    end
  end
, true)
  ;
  (SkeletonAnimationUtil.AddEvent)(_slots, function(trackEntry, event, ...)
    -- function num : 0_21_2 , upvalues : _ENV, _cardModel
    if (event.Data).Name == "hanggezuishuai" then
      (SkeletonAnimationUtil.SetAnimation)(_cardModel, 0, "idle", true)
    end
  end
)
  ;
  (SkeletonAnimationUtil.SetAnimation)(_cardModel, 0, "run", true)
  if name == "ten" then
    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_ACTIVITY_EXCHANGE_TEN, true, uis.root, _centerPos)
  else
    ;
    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_ACTIVITY_EXCHANGE_SINGLE, true, uis.root, _centerPos)
  end
end

NewActivityDungeonExchangeWindow.ClickSkipBtn = function(...)
  -- function num : 0_22 , upvalues : _skipAnim, _ENV
  _skipAnim = not _skipAnim
  ;
  (Util.SetPlayerSetting)(PlayerPrefsKeyName.ACTIVITY_EXCHANGE_SKIP_ANI, _skipAnim and "1" or "0")
end

NewActivityDungeonExchangeWindow.ClickResetBtn = function(...)
  -- function num : 0_23 , upvalues : _ENV
  (MessageMgr.OpenConfirmWindow)((PUtil.get)(20000514), function(...)
    -- function num : 0_23_0 , upvalues : _ENV
    (SlotsService.ReqSlotsReset)((NewActivityDungeonData.SlotsConfig).type)
  end
)
end

NewActivityDungeonExchangeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_24 , upvalues : _ENV, NewActivityDungeonExchangeWindow, ANIM_NAME, _skipAnim
  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_REWARD_LIST then
    (NewActivityDungeonExchangeWindow.RefreshRewardList)()
  else
    if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_SHOW_RESULT then
      local data = para
      local goods = data[1]
      local equip = data[2]
      if #goods + #equip >= 10 then
        (NewActivityDungeonExchangeWindow.PlayAnimation)("ten", goods, equip)
      else
        local colorNum = (NewActivityDungeonData.GetLotteryColor)(goods, equip) or 1
        ;
        (NewActivityDungeonExchangeWindow.PlayAnimation)(ANIM_NAME[colorNum + 1], goods, equip)
      end
    else
      do
        if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_RESET then
          (NewActivityDungeonExchangeWindow.SetRoundShow)((SlotsData.SlotRound)())
          ;
          (NewActivityDungeonExchangeWindow.SetResetShow)()
          ;
          (NewActivityDungeonExchangeWindow.RefreshBtnContent)()
        else
          if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH then
            (NewActivityDungeonExchangeWindow.RefreshBtnContent)()
            local waitTime = _skipAnim and 0 or 5
            ;
            (SimpleTimer.setTimeout)(waitTime, function(...)
    -- function num : 0_24_0 , upvalues : NewActivityDungeonExchangeWindow, _ENV
    (NewActivityDungeonExchangeWindow.SetRoundShow)((SlotsData.SlotRound)())
    ;
    (NewActivityDungeonExchangeWindow.SetResetShow)()
  end
)
            local isChange = (SlotsData.ChangeRound)()
            if isChange then
              (NewActivityDungeonExchangeWindow.ModifyLastLabel)()
              ;
              (SlotsData.ChangeRound)(false)
              UIMgr:SetOnHideComplete((WinResConfig.RewardShowWindow).name, function(...)
    -- function num : 0_24_1 , upvalues : _ENV
    local content = (PUtil.get)(20000512, (SlotsData.ChangeTotalRound)() + 1)
    ;
    (SimpleTimer.setTimeout)(0.01, function(...)
      -- function num : 0_24_1_0 , upvalues : _ENV, content
      (MessageMgr.OpenSoloConfirmWindow)(content, nil, (PUtil.get)(20000513))
    end
)
  end
)
            end
          else
            do
              if msgId == (WindowMsgEnum.ActivityDungeonExchange).E_MSG_BTN_REFRESH then
                (NewActivityDungeonExchangeWindow.InitBtn)()
              else
                if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
                  (NewActivityDungeonExchangeWindow.SetRoundShow)((SlotsData.SlotRound)())
                  ;
                  (NewActivityDungeonExchangeWindow.SetResetShow)()
                  ;
                  (NewActivityDungeonExchangeWindow.RefreshBtnContent)()
                end
              end
            end
          end
        end
      end
    end
  end
end

return NewActivityDungeonExchangeWindow

