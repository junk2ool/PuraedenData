-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityReturn_ReturnMainByName")
local ActivityReturnWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _effect, _titleImg = nil, nil
local _loginIndex = 0
local _scoreIndex = 0
local _timer = nil
ActivityReturnWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ActivityReturnWindow
  bridgeObj:SetView((WinResConfig.ActivityReturnWindow).package, (WinResConfig.ActivityReturnWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argTable.Auto = argTable[1]
  uis = GetActivityReturn_ReturnMainUis(contentPane)
  ;
  (ActivityReturnWindow.InitVariable)()
  ;
  (ActivityReturnWindow.InitTopMenu)()
  ;
  (ActivityReturnWindow.InitText)()
  ;
  (ActivityReturnWindow.InitList)()
  ;
  (ActivityReturnWindow.BindingUI)()
  ;
  (ActivityReturnWindow.InitButtonEvent)()
end

ActivityReturnWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _titleImg, uis
  _titleImg = (((uis.LogonMain).WordContent).root):GetChild("n7")
end

ActivityReturnWindow.InitTopMenu = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ActivityReturnWindow).name
  m.model = uis.AssetStripGrp
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ActivityReturnWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  ((uis.LogonBtn):GetChild("NameTxt")).text = (PUtil.get)(60000641)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.LogonMain).WordContent).WordTxt).text = (PUtil.get)(60000636)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.LogonMain).Decorate_04_Image).TipsTxt).text = (PUtil.get)(60000637)
  ;
  ((uis.PlanBtn):GetChild("NameTxt")).text = (PUtil.get)(60000640)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.PlanMain).PlanReward).WordTxt).text = (PUtil.get)(60000639)
end

ActivityReturnWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, ActivityReturnWindow
  (((uis.LogonMain).LogonReward).TimeList):SetVirtual()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.LogonMain).LogonReward).TimeList).itemRenderer = ActivityReturnWindow.RefreshLoginTagItem
  ;
  (((uis.LogonMain).LogonReward).ItemList):SetVirtual()
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.LogonMain).LogonReward).ItemList).itemRenderer = ActivityReturnWindow.RefreshLoginRewardItem
  ;
  (((uis.PlanMain).PlanReward).ItemList):SetVirtual()
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.PlanMain).PlanReward).ItemList).itemRenderer = ActivityReturnWindow.RefreshScoreRewardItem
end

ActivityReturnWindow.BindingUI = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis
  (RedDotMgr.BindingUI)((WinResConfig.ActivityReturnWindow).name, RedDotComID.ActivityReturn_Vigour_Reward, uis.PlanBtn)
end

ActivityReturnWindow.InitButtonEvent = function(...)
  -- function num : 0_6 , upvalues : uis, ActivityReturnWindow
  ((uis.LogonBtn).onClick):Set(ActivityReturnWindow.ClickLoginBtn)
  ;
  ((uis.PlanBtn).onClick):Set(ActivityReturnWindow.ClickPlanBtn)
  ;
  ((((uis.PlanMain).PicShow).LeftBtn).onClick):Set(ActivityReturnWindow.ClickLeftBtn)
  ;
  ((((uis.PlanMain).PicShow).RightBtn).onClick):Set(ActivityReturnWindow.ClickRightBtn)
end

ActivityReturnWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : ActivityReturnWindow
  (ActivityReturnWindow.Init)()
end

ActivityReturnWindow.OnHide = function(...)
  -- function num : 0_8
end

ActivityReturnWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis, _effect, _timer, _titleImg, _scoreIndex, contentPane, argTable
  (Util.RecycleUIModel)((uis.LogonMain).AnimationLoader, true)
  _effect = nil
  if ((uis.LogonMain).PicLoader).texture ~= nil then
    (ResHelper.UnloadTexture)((((uis.LogonMain).PicLoader).texture).nativeTexture)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.LogonMain).PicLoader).texture = nil
  end
  if ((((uis.PlanMain).PicShow).Pic).PicLoader).texture ~= nil then
    (ResHelper.UnloadTexture)((((((uis.PlanMain).PicShow).Pic).PicLoader).texture).nativeTexture)
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((((uis.PlanMain).PicShow).Pic).PicLoader).texture = nil
  end
  if _timer ~= nil then
    _timer:stop()
    _timer = nil
  end
  _titleImg = nil
  _scoreIndex = 0
  uis = nil
  contentPane = nil
  argTable = {}
end

ActivityReturnWindow.Init = function(...)
  -- function num : 0_10 , upvalues : ActivityReturnWindow, argTable, uis, _ENV
  (ActivityReturnWindow.HandleLoginUI)(not argTable.Auto)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  if argTable.Auto then
    (uis.c1Ctr).selectedIndex = 0
    ;
    (ActivityReturnWindow.RefreshLogin)()
  else
    ;
    (ActivityReturnWindow.ClickPlanBtn)()
  end
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.ActivityReturnWindow).name)
end

ActivityReturnWindow.HandleLoginUI = function(show, ...)
  -- function num : 0_11 , upvalues : uis
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.AssetStripGrp).root).visible = show
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.LogonBtn).visible = show
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.PlanBtn).visible = show
end

ActivityReturnWindow.RefreshLogin = function(...)
  -- function num : 0_12 , upvalues : _effect, uis, argTable, _titleImg, _ENV, _loginIndex, ActivityReturnWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  if _effect == nil then
    ((uis.LogonMain).AnimationLoader).x = 690
    if argTable.Auto then
      _titleImg.visible = false
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (((uis.LogonMain).WordContent).WordTxt).visible = false
      ;
      (SimpleTimer.setTimeout)(1.3, function(...)
    -- function num : 0_12_0 , upvalues : uis
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (((uis.LogonMain).WordContent).WordTxt).visible = true
  end
)
      ;
      (SimpleTimer.setTimeout)(0.2, function(...)
    -- function num : 0_12_1 , upvalues : _effect, _ENV, uis, _titleImg
    _effect = (Util.ShowUIModel)("ui_huigui", (uis.LogonMain).AnimationLoader)
    ;
    (CSLuaUtil.SetGOScale)(_effect, 1.25, 1.25, 1.25, true)
    ;
    (SkeletonAnimationUtil.SetAnimation)(_effect, 0, "in", false, function(...)
      -- function num : 0_12_1_0 , upvalues : _titleImg, _ENV, _effect
      _titleImg.visible = true
      ;
      (SkeletonAnimationUtil.SetAnimation)(_effect, 0, "", true)
    end
)
  end
)
    else
      _effect = (Util.ShowUIModel)("ui_huigui", (uis.LogonMain).AnimationLoader)
      ;
      (CSLuaUtil.SetGOScale)(_effect, 1.25, 1.25, 1.25, true)
      ;
      (SkeletonAnimationUtil.SetAnimation)(_effect, 0, "in", true)
      local sgp = _effect:GetComponent("SkeletonAnimation")
      local trackEntry = (sgp.AnimationState):GetCurrent(0)
      trackEntry.AnimationStart = 2
      trackEntry.AnimationEnd = trackEntry.AnimationTime
    end
  end
  do
    _loginIndex = (ActivityReturnData.GetLoginRewardIndex)()
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.LogonMain).LogonReward).TimeList).numItems = #ActivityReturnData.LoginConfigs
    local texture = (ResHelper.LoadTexture)((((TableData.gTable).BaseFixedData)[ActivityReturnData.RETURN_BG]).array_value)
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R1 in 'UnsetPending'

    if texture ~= nil then
      ((uis.LogonMain).PicLoader).texture = (FairyGUI.NTexture)(texture)
    end
    ;
    (ActivityReturnWindow.RefreshLoginItemList)(_loginIndex)
    ;
    (ActivityReturnWindow.RefreshLoginBtn)()
  end
end

ActivityReturnWindow.RefreshLoginBtn = function(...)
  -- function num : 0_13 , upvalues : _ENV, _loginIndex, uis
  local config = (ActivityReturnData.LoginConfigs)[_loginIndex]
  if (ActivityReturnData.LoginRewardsStatus)[config.id] == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
    (((uis.LogonMain).root).onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : _ENV, config
    (ActivityReturnMgr.ReqGetReward)(config.id)
  end
)
  else
    ;
    (((uis.LogonMain).root).onClick):Set(function(...)
    -- function num : 0_13_1 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(60000643))
  end
)
  end
end

ActivityReturnWindow.RefreshLoginTagItem = function(index, item, ...)
  -- function num : 0_14 , upvalues : _ENV, _loginIndex, ActivityReturnWindow, uis
  index = index + 1
  local config = (ActivityReturnData.LoginConfigs)[index]
  ;
  (item:GetChild("DayTime")).text = (PUtil.get)(60000638, config.day)
  item.selected = index == _loginIndex
  if (ActivityReturnData.LoginRewardsStatus)[config.id] == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT then
    (item:GetController("c1")).selectedIndex = 1
    ;
    (item.onClick):Clear()
  else
    (item:GetController("c1")).selectedIndex = 0
    ;
    (item.onClick):Set(function(context, ...)
    -- function num : 0_14_0 , upvalues : _loginIndex, index, ActivityReturnWindow, uis
    context:StopPropagation()
    _loginIndex = index
    ;
    (ActivityReturnWindow.RefreshLoginBtn)()
    ;
    (((uis.LogonMain).LogonReward).TimeList):RefreshVirtualList()
    ;
    (ActivityReturnWindow.RefreshLoginItemList)(index)
  end
)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ActivityReturnWindow.RefreshLoginItemList = function(index, ...)
  -- function num : 0_15 , upvalues : _ENV, uis
  local config = (ActivityReturnData.LoginConfigs)[index]
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  if (ActivityReturnData.LoginRewardsStatus)[config.id] == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
    (((uis.LogonMain).LogonReward).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((uis.LogonMain).LogonReward).c1Ctr).selectedIndex = 0
  end
  ;
  (ActivityReturnData.SetRewards)(index, true)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.LogonMain).LogonReward).ItemList).numItems = #ActivityReturnData.LoginRewards
end

ActivityReturnWindow.RefreshLoginRewardItem = function(index, item, ...)
  -- function num : 0_16 , upvalues : _ENV
  local data = (ActivityReturnData.LoginRewards)[index + 1]
  ;
  (Util.SetAllItemIconByConfig)(item, data)
end

ActivityReturnWindow.RefreshScore = function(...)
  -- function num : 0_17 , upvalues : _scoreIndex, _ENV, ActivityReturnWindow
  _scoreIndex = (ActivityReturnData.GetScoreRewardIndex)()
  ;
  (ActivityReturnWindow.RefreshLeftTime)()
  ;
  (ActivityReturnWindow.RefreshScoreContent)()
end

ActivityReturnWindow.RefreshScoreContent = function(...)
  -- function num : 0_18 , upvalues : ActivityReturnWindow
  (ActivityReturnWindow.RefreshScoreDetail)()
  ;
  (ActivityReturnWindow.RefreshScoreRewards)()
end

ActivityReturnWindow.RefreshLeftTime = function(...)
  -- function num : 0_19 , upvalues : _ENV, uis, _timer, ActivityReturnWindow
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  if (ActivityReturnData.BasicData).endTime <= (LuaTime.GetTimeStamp)() then
    (((uis.PlanMain).PicShow).TimeTxt).text = (PUtil.get)(20000221)
  else
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.PlanMain).PicShow).TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetLeftTimeStr)((math.floor)((ActivityReturnData.BasicData).endTime * 0.001), true))
    local leftTime = (ActivityReturnData.BasicData).endTime - (LuaTime.GetTimeStamp)()
    if leftTime < 3600 then
      local modSeconds = (math.mod)(leftTime, 60)
      if modSeconds == 0 then
        modSeconds = 60
      end
      _timer = (SimpleTimer.SetTimeOut)(modSeconds, function(...)
    -- function num : 0_19_0 , upvalues : ActivityReturnWindow
    (ActivityReturnWindow.RefreshLeftTime)()
  end
)
    end
  end
end

ActivityReturnWindow.RefreshScoreDetail = function(...)
  -- function num : 0_20 , upvalues : _ENV, _scoreIndex, uis
  local config = (ActivityReturnData.LoginConfigs)[_scoreIndex]
  if ((((uis.PlanMain).PicShow).Pic).PicLoader).texture ~= nil then
    (ResHelper.UnloadTexture)((((((uis.PlanMain).PicShow).Pic).PicLoader).texture).nativeTexture)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((((uis.PlanMain).PicShow).Pic).PicLoader).texture = nil
  end
  local texture = (ResHelper.LoadTexture)(config.pointBackground)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

  if texture ~= nil then
    ((((uis.PlanMain).PicShow).Pic).PicLoader).texture = (FairyGUI.NTexture)(texture)
  end
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.PlanMain).PicShow).LeftBtn).visible = _scoreIndex > 1
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.PlanMain).PicShow).RightBtn).visible = _scoreIndex < #ActivityReturnData.LoginConfigs
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((((uis.PlanMain).PicShow).TimeWord).TimeTxt).text = (PUtil.get)(60000638, config.day)
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((((uis.PlanMain).PicShow).TimeWord).WordTxt).text = config.pointDesc
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ActivityReturnWindow.RefreshScoreRewards = function(...)
  -- function num : 0_21 , upvalues : _ENV, _scoreIndex, uis
  (ActivityReturnData.SetRewards)(_scoreIndex)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.PlanMain).PlanReward).ItemList).numItems = #ActivityReturnData.ScoreRewards
  ;
  ((((uis.PlanMain).PlanReward).TouchBtn).onClick):Clear()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.PlanMain).PlanReward).TouchBtn).visible = false
  local config = (ActivityReturnData.LoginConfigs)[_scoreIndex]
  local status = (ActivityReturnData.ScoreRewardsStatus)[config.id]
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  if ActivityReturnData.Day < config.day then
    (((uis.PlanMain).PlanReward).c1Ctr).selectedIndex = 2
  else
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

    if status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
      (((uis.PlanMain).PlanReward).c1Ctr).selectedIndex = 0
    else
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((uis.PlanMain).PlanReward).c1Ctr).selectedIndex = 1
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

      if config.point <= ActivityReturnData.TotalScore then
        (((uis.PlanMain).PlanReward).c2Ctr).selectedIndex = 1
        -- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (((uis.PlanMain).PlanReward).TouchBtn).visible = true
        ;
        ((((uis.PlanMain).PlanReward).TouchBtn).onClick):Set(function(...)
    -- function num : 0_21_0 , upvalues : _ENV, config
    (ActivityReturnMgr.ReqPointReward)(config.id)
  end
)
      else
        -- DECOMPILER ERROR at PC77: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (((uis.PlanMain).PlanReward).c2Ctr).selectedIndex = 0
        -- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (((uis.PlanMain).PlanReward).PlanProgressBar).value = (math.ceil)(ActivityReturnData.TotalScore / config.point * 100)
        ;
        ((((uis.PlanMain).PlanReward).PlanProgressBar):GetChild("NumberTxt")).text = (PUtil.get)(60000642, ActivityReturnData.TotalScore, config.point)
      end
    end
  end
end

ActivityReturnWindow.RefreshScoreRewardItem = function(index, item, ...)
  -- function num : 0_22 , upvalues : _ENV
  local data = (ActivityReturnData.ScoreRewards)[index + 1]
  ;
  (Util.SetAllItemIconByConfig)(item, data)
end

ActivityReturnWindow.ClickLoginBtn = function(...)
  -- function num : 0_23 , upvalues : _effect, ActivityReturnWindow, uis
  if _effect == nil then
    (ActivityReturnWindow.RefreshLogin)()
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = 0
end

ActivityReturnWindow.ClickPlanBtn = function(...)
  -- function num : 0_24 , upvalues : _scoreIndex, _ENV, ActivityReturnWindow, uis
  if _scoreIndex == 0 then
    _scoreIndex = (ActivityReturnData.GetScoreRewardIndex)()
    ;
    (ActivityReturnWindow.RefreshScore)()
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = 1
end

ActivityReturnWindow.ClickLeftBtn = function(...)
  -- function num : 0_25 , upvalues : _scoreIndex, ActivityReturnWindow
  if _scoreIndex <= 1 then
    return 
  end
  _scoreIndex = _scoreIndex - 1
  ;
  (ActivityReturnWindow.RefreshScoreContent)()
end

ActivityReturnWindow.ClickRightBtn = function(...)
  -- function num : 0_26 , upvalues : _scoreIndex, _ENV, ActivityReturnWindow
  if #ActivityReturnData.LoginConfigs <= _scoreIndex then
    return 
  end
  _scoreIndex = _scoreIndex + 1
  ;
  (ActivityReturnWindow.RefreshScoreContent)()
end

ActivityReturnWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_27 , upvalues : _ENV, argTable, ActivityReturnWindow
  if msgId == (WindowMsgEnum.ActivityReturn).E_MSG_REFRESH_LOGIN then
    if argTable.Auto then
      UIMgr:CloseWindow((WinResConfig.ActivityReturnWindow).name)
    else
      ;
      (ActivityReturnWindow.RefreshLoginBtn)()
    end
  else
    if msgId == (WindowMsgEnum.ActivityReturn).E_MSG_REFRESH_SCORE then
      (ActivityReturnWindow.RefreshScoreRewards)()
    end
  end
end

return ActivityReturnWindow

