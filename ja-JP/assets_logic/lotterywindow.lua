-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_LotteryByName")
require("LotteryWindow_Card")
require("LotteryWindow_Coupon")
require("LotteryWindow_Fresh")
require("LotteryWindow_Sure")
require("LotteryWindow_Activity")
require("LotteryWindow_Activity2")
require("LotteryWindow_Activity3")
require("LotteryWindow_Activity4")
require("LotteryWindow_YouChangActivity")
require("LotteryWindow_YouChangActivity2")
require("LotteryWindow_YouChangActivity3")
require("LotteryWindow_YouChangActivity4")
local lotteryType = LotteryType.Fresh
local LotteryWindow = {}
local uis, contentPane, drawResult = nil, nil, nil
local cardIndex = 1
local cardResults = {}
local isAutoPlay = false
local timeLineTimer = nil
local FxManager = require("FxManager")
local noviceLottery = false
local video = (CS.VideoManager).Instance
local UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END = nil, nil
local lotteryBtns = {}
LotteryWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, LotteryWindow
  bridgeObj:SetView((WinResConfig.LotteryWindow).package, (WinResConfig.LotteryWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetLottery_LotteryUis(contentPane)
  ResHelper = CS.ResHelper
  ;
  (ResHelper.ClearAllCache)()
  if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp4) then
    (LotteryWindow_Activity4.PreLoadFxMain)(uis)
  end
  if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp3) then
    (LotteryWindow_Activity3.PreLoadFxMain)(uis)
  end
  if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp2) then
    (LotteryWindow_Activity2.PreLoadFxMain)(uis)
  end
  if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp) then
    (LotteryWindow_Activity.PreLoadFxMain)(uis)
  end
  ;
  (LotteryWindow.ClassicInit)(true)
  ;
  (LotteryWindow.BindingUI)()
  ;
  (LotteryWindow.InitFunctionControl)()
end

LotteryWindow.BindingUI = function(...)
  -- function num : 0_1 , upvalues : _ENV, lotteryBtns
  local winName = (WinResConfig.LotteryWindow).name
  if lotteryBtns[LotteryType.Card] then
    (RedDotMgr.BindingUI)(winName, RedDotComID.Lottery_Character, lotteryBtns[LotteryType.Card])
  end
  if lotteryBtns[LotteryType.Coupon] then
    (RedDotMgr.BindingUI)(winName, RedDotComID.Lottery_Card, lotteryBtns[LotteryType.Coupon])
  end
  if lotteryBtns[LotteryType.HuoDongUp] then
    (RedDotMgr.BindingUI)(winName, RedDotComID.LotteryActivty_Score1, lotteryBtns[LotteryType.HuoDongUp])
  end
  if lotteryBtns[LotteryType.HuoDongUp2] then
    (RedDotMgr.BindingUI)(winName, RedDotComID.LotteryActivty_Score2, lotteryBtns[LotteryType.HuoDongUp2])
  end
  if lotteryBtns[LotteryType.HuoDongUp3] then
    (RedDotMgr.BindingUI)(winName, RedDotComID.LotteryActivty_Score3, lotteryBtns[LotteryType.HuoDongUp3])
  end
  if lotteryBtns[LotteryType.HuoDongUp4] then
    (RedDotMgr.BindingUI)(winName, RedDotComID.LotteryActivty_Score4, lotteryBtns[LotteryType.HuoDongUp4])
  end
  local freeType = nil
  local configs = (TableData.gTable).BaseActivityData
  for k,v in pairs(configs) do
    if v.type == (ActivityMgr.ActivityType).Free_Lottery then
      freeType = (((TableData.gTable).BaseLotteryData)[tonumber(v.parameter1)]).type
      break
    end
  end
  do
    if lotteryBtns[freeType] then
      (RedDotMgr.BindingUI)(winName, RedDotComID.Lottery_FreeMultiple, lotteryBtns[freeType])
    end
    ;
    (RedDotMgr.RefreshTreeUI)(winName)
  end
end

LotteryWindow.InitFunctionControl = function(...)
  -- function num : 0_2 , upvalues : _ENV, lotteryBtns, uis
  local winName = (WinResConfig.LotteryWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Lottery_Part, lotteryBtns[LotteryType.Card], winName)
  RegisterGuideAndControl(ControlID.Lottery_Card, lotteryBtns[LotteryType.Coupon], winName)
  RegisterGuideAndControl(ControlID.Lottery_NoviceSingle, ((uis.LotteryPanelGrp).GetCha_NewCardGrp).OneTimeBtn, winName)
  RegisterGuideAndControl(ControlID.Lottery_NoviceTen, ((uis.LotteryPanelGrp).GetCha_NewCardGrp).TenTimeBtn, winName)
  RegisterGuideAndControl(ControlID.Lottery_Back, (uis.AssetStripGrp).BackBtn, winName)
end

LotteryWindow.ClassicInit = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, lotteryType, LotteryWindow
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.GechaCardEffectGrp).root).visible = false
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.LotteryPanelGrp).BgImage).visible = false
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.StartWord).root).visible = false
  local uiMap = (uis.StartWord).root
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERYDIALOG_SHOW, false, false)
  holder:SetXY(uiMap.width / 2, uiMap.height / 2)
  uiMap:AddChild(holder)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.TouchScreenBtn).visible = false
  local m = {}
  m.windowName = (WinResConfig.LotteryWindow).name
  m.Tip = (PUtil.get)(84)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  ;
  (((uis.LotteryPanelGrp).ProbabilityBtn):GetChild("WordTxt")).text = (PUtil.get)(187)
  ;
  (((uis.LotteryPanelGrp).ProbabilityBtn).onClick):ClearCallFunc()
  ;
  (((uis.LotteryPanelGrp).ProbabilityBtn).onClick):Add(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, lotteryType
    OpenWindow("LotteryProbabilityWindow", UILayer.HUD, lotteryType)
  end
)
  ;
  (((uis.LotteryPanelGrp).RecordBtn):GetChild("WordTxt")).text = (PUtil.get)(232)
  ;
  (((uis.LotteryPanelGrp).RecordBtn).onClick):ClearCallFunc()
  ;
  (((uis.LotteryPanelGrp).RecordBtn).onClick):Add(function(...)
    -- function num : 0_3_1 , upvalues : _ENV
    (LotteryService.ReqLotteryRecord)()
  end
)
  ;
  (LotteryWindow.LotteryButtonRefresh)()
end

LotteryWindow.LotteryButtonRefresh = function(...)
  -- function num : 0_4 , upvalues : noviceLottery, _ENV, uis, lotteryBtns, lotteryType, LotteryWindow
  noviceLottery = (ActorData.GetNoviceLottery)()
  ;
  ((uis.LotteryPanelGrp).ButtonList):RemoveChildrenToPool()
  local btnTab = {}
  ;
  (table.insert)(btnTab, LotteryType.Coupon)
  if noviceLottery then
    (table.insert)(btnTab, LotteryType.Fresh)
  else
    ;
    (table.insert)(btnTab, LotteryType.Card)
    if IsIOSReview ~= true then
      if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp) then
        (table.insert)(btnTab, LotteryType.HuoDongUp)
      end
      if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp2) then
        (table.insert)(btnTab, LotteryType.HuoDongUp2)
      end
      if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp3) then
        (table.insert)(btnTab, LotteryType.HuoDongUp3)
      end
      if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp4) then
        (table.insert)(btnTab, LotteryType.HuoDongUp4)
      end
      if (ActorData.GetLotteryActivityNum)(LotteryType.YouChangHuoDongUp) then
        (table.insert)(btnTab, LotteryType.YouChangHuoDongUp)
      end
      if (ActorData.GetLotteryActivityNum)(LotteryType.YouChangHuoDongUp2) then
        (table.insert)(btnTab, LotteryType.YouChangHuoDongUp2)
      end
      if (ActorData.GetLotteryActivityNum)(LotteryType.YouChangHuoDongUp3) then
        (table.insert)(btnTab, LotteryType.YouChangHuoDongUp3)
      end
      if (ActorData.GetLotteryActivityNum)(LotteryType.YouChangHuoDongUp4) then
        (table.insert)(btnTab, LotteryType.YouChangHuoDongUp4)
      end
    end
  end
  if (ActorData.GetLotteryActivityNum)(LotteryType.ShilianBiChu) then
    (table.insert)(btnTab, LotteryType.ShilianBiChu)
  end
  ;
  (table.sort)(btnTab, function(a, b, ...)
    -- function num : 0_4_0 , upvalues : _ENV
    do return (((TableData.gTable).BaseLotteryShowData)[a]).sort < (((TableData.gTable).BaseLotteryShowData)[b]).sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  lotteryBtns = {}
  local isStillChooseThisType = false
  for index,value in ipairs(btnTab) do
    do
      local showData = ((TableData.gTable).BaseLotteryShowData)[value]
      if lotteryType == value then
        do
          isStillChooseThisType = true
          do break end
          -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for index,value in ipairs(btnTab) do
    local showData = ((TableData.gTable).BaseLotteryShowData)[value]
    if index == 1 and isStillChooseThisType == false then
      lotteryType = value
    end
    local button = ((uis.LotteryPanelGrp).ButtonList):AddItemFromPool((UIPackage.GetItemURL)("Lottery", showData.button_asset))
    lotteryBtns[value] = button
    -- DECOMPILER ERROR at PC203: Confused about usage of register: R9 in 'UnsetPending'

    if value == lotteryType then
      ((uis.LotteryPanelGrp).ButtonList).selectedIndex = index - 1
      -- DECOMPILER ERROR at PC207: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((uis.LotteryPanelGrp).c1Ctr).selectedIndex = showData.selected_index
      ;
      (LotteryWindow.RefreshLotteryPanel)()
    end
    ;
    (button.onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : lotteryType, value, uis, index, showData, LotteryWindow
    if lotteryType == value then
      return 
    end
    lotteryType = value
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.LotteryPanelGrp).ButtonList).selectedIndex = index - 1
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.LotteryPanelGrp).c1Ctr).selectedIndex = showData.selected_index
    ;
    (LotteryWindow.RefreshLotteryPanel)()
  end
)
  end
end

LotteryWindow.RefreshLotteryPanel = function(...)
  -- function num : 0_5 , upvalues : lotteryType, _ENV, uis, LotteryWindow
  if (((lotteryType == LotteryType.Fresh and lotteryType ~= LotteryType.Card) or lotteryType == LotteryType.Coupon) and lotteryType ~= LotteryType.Equip) or lotteryType == LotteryType.HuoDongUp then
    (LotteryWindow_Activity.RefreshWindow)(uis)
  else
    if lotteryType == LotteryType.HuoDongUp2 then
      (LotteryWindow_Activity2.RefreshWindow)(uis)
    else
      if lotteryType == LotteryType.HuoDongUp3 then
        (LotteryWindow_Activity3.RefreshWindow)(uis)
      else
        if lotteryType == LotteryType.HuoDongUp4 then
          (LotteryWindow_Activity4.RefreshWindow)(uis)
        else
          if lotteryType == LotteryType.YouChangHuoDongUp then
            (LotteryWindow_YouChangActivity.RefreshWindow)(uis)
          else
            if lotteryType == LotteryType.YouChangHuoDongUp2 then
              (LotteryWindow_YouChangActivity2.RefreshWindow)(uis)
            else
              if lotteryType == LotteryType.YouChangHuoDongUp3 then
                (LotteryWindow_YouChangActivity3.RefreshWindow)(uis)
              else
                if lotteryType == LotteryType.YouChangHuoDongUp4 then
                  (LotteryWindow_YouChangActivity4.RefreshWindow)(uis)
                else
                end
              end
            end
          end
        end
      end
    end
  end
  if lotteryType == LotteryType.ShilianBiChu then
    (LotteryWindow.SetAssetType)()
    ;
    (LotteryWindow.SetLotteryDate)(lotteryType)
    ;
    (LotteryService.ReqLotteryInit)(lotteryType)
  end
end

LotteryWindow.SetLotteryDate = function(lType, ...)
  -- function num : 0_6 , upvalues : _ENV, uis, lotteryType
  local beginTime, endTime = (ActorData.GetActivityLotteryTime)(lType)
  local isShow = beginTime ~= -1 and beginTime ~= nil
  print("=============SetLotteryDate", beginTime, endTime, isShow)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((uis.LotteryPanelGrp).Time).root).visible = isShow
  local config = ((TableData.gTable).BaseLotteryShowData)[lotteryType]
  local timeSelectedIndex = lotteryType ~= LotteryType.Fresh and lotteryType ~= LotteryType.Coupon and lotteryType ~= LotteryType.ShilianBiChu and lotteryType ~= LotteryType.Card and config.integral_convert ~= "0"
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R6 in 'UnsetPending'

  if timeSelectedIndex then
    (((uis.LotteryPanelGrp).Time).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'

    (((uis.LotteryPanelGrp).Time).c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R6 in 'UnsetPending'

  if isShow then
    (((uis.LotteryPanelGrp).Time).StartTxt).text = (PUtil.get)(221) .. (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M", beginTime)
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((uis.LotteryPanelGrp).Time).EndTxt).text = (PUtil.get)(222) .. (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M", endTime)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

LotteryWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, lotteryType, _ENV, cardIndex, isAutoPlay, timeLineTimer, lotteryBtns, UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END
  uis = nil
  contentPane = nil
  lotteryType = nil
  lotteryType = LotteryType.Fresh
  cardIndex = nil
  isAutoPlay = false
  timeLineTimer = nil
  ;
  (LotteryMgr.SetIsLotterying)(false)
  lotteryBtns = {}
  if UI_LOTTERY_REWARD_TEXT ~= nil then
    (ResHelper.DestroyGameObject)(UI_LOTTERY_REWARD_TEXT)
    UI_LOTTERY_REWARD_TEXT = nil
  end
  if UI_LOTTERY_REWARD_END ~= nil then
    (ResHelper.DestroyGameObject)(UI_LOTTERY_REWARD_END)
    UI_LOTTERY_REWARD_END = nil
  end
  ;
  (LotteryMgr.RemoveAllBackGroundEffectsFromPool)()
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.LotteryWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.LotteryWindow).name)
  ;
  (LotteryWindow_Coupon.OnClose)()
  ;
  (LotteryWindow_Fresh.OnClose)()
  ;
  (LotteryWindow_Card.OnClose)()
  ;
  (LotteryWindow_Sure.OnClose)()
  ;
  (LotteryWindow_Activity.OnClose)()
  ;
  (LotteryWindow_Activity2.OnClose)()
  ;
  (LotteryWindow_Activity3.OnClose)()
  ;
  (LotteryWindow_Activity4.OnClose)()
  ;
  (LotteryWindow_YouChangActivity.OnClose)()
  ;
  (LotteryWindow_YouChangActivity2.OnClose)()
  ;
  (LotteryWindow_YouChangActivity3.OnClose)()
  ;
  (LotteryWindow_YouChangActivity4.OnClose)()
  ;
  (ResHelper.ClearAllCache)()
end

LotteryWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8 , upvalues : _ENV, lotteryType, uis, lotteryBtns, LotteryWindow, drawResult, cardIndex, cardResults, isAutoPlay
  local windowMsgEnum = WindowMsgEnum.Lottery
  if msgId == windowMsgEnum.E_MSG_LOTTERY_INIT then
    print("=======初始化扭蛋信息========")
    ;
    (LotteryData.SaveLotteryData)(para.data, lotteryType)
    local config = ((TableData.gTable).BaseLotteryShowData)[lotteryType]
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.LotteryPanelGrp).ExchangeBtn).visible = lotteryType ~= LotteryType.Fresh and lotteryType ~= LotteryType.Coupon and lotteryType ~= LotteryType.ShilianBiChu and lotteryType ~= LotteryType.Card and config.integral_convert ~= "0"
    ;
    (((uis.LotteryPanelGrp).ExchangeBtn):GetChild("RedDot")).visible = ((lotteryBtns[lotteryType]):GetChild("RedDot")).visible
    ;
    (((uis.LotteryPanelGrp).ExchangeBtn):GetChild("WordTxt")).text = (PUtil.get)(270, (para.data).integral)
    ;
    (((uis.LotteryPanelGrp).ExchangeBtn).onClick):Set(function(...)
    -- function num : 0_8_0 , upvalues : _ENV, lotteryType
    (LotteryService.ReqInitConversion)(lotteryType)
  end
)
    if lotteryType == LotteryType.Card then
      (LotteryWindow_Card.RefreshWindow)(uis)
      ;
      (LotteryWindow_Card.ReceiveInitData)()
    elseif lotteryType == LotteryType.Coupon then
      (LotteryWindow_Coupon.RefreshWindow)(uis)
      ;
      (LotteryWindow_Coupon.ReceiveInitData)()
    elseif lotteryType == LotteryType.Fresh then
      (LotteryWindow_Fresh.RefreshWindow)(uis)
      ;
      (LotteryWindow_Fresh.ReceiveInitData)()
    elseif lotteryType == LotteryType.ShilianBiChu then
      (LotteryWindow_Sure.RefreshWindow)(uis)
    elseif lotteryType == LotteryType.HuoDongUp then
      (LotteryWindow_Activity.ReceiveInitData)()
    elseif lotteryType == LotteryType.HuoDongUp2 then
      (LotteryWindow_Activity2.ReceiveInitData)()
    elseif lotteryType == LotteryType.HuoDongUp3 then
      (LotteryWindow_Activity3.ReceiveInitData)()
    elseif lotteryType == LotteryType.HuoDongUp4 then
      (LotteryWindow_Activity4.ReceiveInitData)()
    elseif lotteryType == LotteryType.YouChangHuoDongUp then
      (LotteryWindow_YouChangActivity.ReceiveInitData)()
    elseif lotteryType == LotteryType.YouChangHuoDongUp2 then
      (LotteryWindow_YouChangActivity2.ReceiveInitData)()
    elseif lotteryType == LotteryType.YouChangHuoDongUp3 then
      (LotteryWindow_YouChangActivity3.ReceiveInitData)()
    elseif lotteryType == LotteryType.YouChangHuoDongUp4 then
      (LotteryWindow_YouChangActivity4.ReceiveInitData)()
    end
  elseif msgId == windowMsgEnum.E_MSG_LOTTERY_DRAW then
    (LotteryMgr.SetIsLotterying)(true)
    if lotteryType == LotteryType.Card then
      (LotteryWindow_Card.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.Coupon then
      (LotteryWindow_Coupon.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.Fresh then
      (LotteryWindow_Fresh.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.ShilianBiChu then
      (LotteryWindow_Sure.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.HuoDongUp then
      (LotteryWindow_Activity.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.HuoDongUp2 then
      (LotteryWindow_Activity2.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.HuoDongUp3 then
      (LotteryWindow_Activity3.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.HuoDongUp4 then
      (LotteryWindow_Activity4.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.YouChangHuoDongUp then
      (LotteryWindow_YouChangActivity.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.YouChangHuoDongUp2 then
      (LotteryWindow_YouChangActivity2.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.YouChangHuoDongUp3 then
      (LotteryWindow_YouChangActivity3.ReceiveDrawedData)(para)
    elseif lotteryType == LotteryType.YouChangHuoDongUp4 then
      (LotteryWindow_YouChangActivity4.ReceiveDrawedData)(para)
    end
    local randomCard = (Util.Shuffle)((para.data).goods)
    ;
    (LotteryWindow.BubbleSortGoods)(randomCard)
    -- DECOMPILER ERROR at PC332: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (para.data).goods = randomCard
    drawResult = para
    -- DECOMPILER ERROR at PC335: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.TouchScreenBtn).visible = true
    ;
    (LotteryWindow_Activity.HideOrShowFxMain)(false)
    ;
    (LotteryWindow_Activity2.HideOrShowFxMain)(false)
    ;
    (LotteryWindow_Activity3.HideOrShowFxMain)(false)
    ;
    (LotteryWindow_Activity4.HideOrShowFxMain)(false)
    ;
    (LotteryService.ReqLotteryInit)(lotteryType)
  else
    -- DECOMPILER ERROR at PC361: Confused about usage of register: R3 in 'UnsetPending'

    if msgId == windowMsgEnum.E_MSG_LOTTERY_REWARDCLOSE then
      (uis.TouchScreenBtn).visible = false
      -- DECOMPILER ERROR at PC364: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((uis.StartWord).root).visible = false
      -- DECOMPILER ERROR at PC367: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((uis.LotteryPanelGrp).BgImage).visible = false
      ;
      (LotteryMgr.SetIsLotterying)(false)
    end
  end
  if msgId ~= windowMsgEnum.E_MSG_THE_ENDOFTHE_FRESH or msgId == windowMsgEnum.E_MSG_LOTTERY_DRAW_ANIMATION_END then
    cardIndex = 1
    cardResults = {}
    isAutoPlay = false
    ;
    (LotteryWindow.ShowCardProcess)(drawResult)
    -- DECOMPILER ERROR at PC391: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.LotteryPanelGrp).BgImage).visible = true
  elseif msgId == windowMsgEnum.E_MSG_ONCLOSE_NEWGET then
    (LotteryWindow.DealNextCardProcess)()
  elseif msgId == windowMsgEnum.E_MSG_ONCLICKCARDGET_SKIPBTN then
    isAutoPlay = true
    -- DECOMPILER ERROR at PC406: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.GechaCardEffectGrp).SkipBtn).visible = false
  elseif msgId == windowMsgEnum.E_MSG_REFRESHLOTTERYLIST then
    (LotteryWindow.ClassicInit)()
  elseif msgId == windowMsgEnum.E_MSG_CLOSEEXCHANGE then
    (LotteryService.ReqLotteryInit)(lotteryType)
  end
  -- DECOMPILER ERROR: 33 unprocessed JMP targets
end

LotteryWindow.DealNextCardProcess = function(...)
  -- function num : 0_9 , upvalues : cardIndex, cardResults, LotteryWindow, _ENV, lotteryType, drawResult, uis
  if cardIndex < #cardResults then
    cardIndex = cardIndex + 1
    ;
    (LotteryWindow.RunCardResultEffect)(cardIndex)
  else
    loge("已到最后一个 直接显示结果")
    ;
    (LotteryWindow_Activity.HideOrShowFxMain)(true)
    ;
    (LotteryWindow_Activity2.HideOrShowFxMain)(true)
    ;
    (LotteryWindow_Activity3.HideOrShowFxMain)(true)
    ;
    (LotteryWindow_Activity4.HideOrShowFxMain)(true)
    if lotteryType == LotteryType.Card then
      (LotteryWindow_Card.ShowResult)(drawResult)
    else
      if lotteryType == LotteryType.Fresh then
        (LotteryWindow_Fresh.ShowResult)(drawResult)
        local isHaveNum = (LotteryData.CheckFreshHaveNum)()
        if not isHaveNum then
          (LotteryWindow.ClassicInit)()
        end
      else
        do
          if lotteryType == LotteryType.Coupon then
            (LotteryWindow_Coupon.ShowResult)(drawResult)
          else
            if lotteryType == LotteryType.ShilianBiChu then
              (LotteryWindow_Sure.ShowResult)(drawResult)
              ;
              (LotteryWindow.ClassicInit)()
            else
              if lotteryType == LotteryType.HuoDongUp then
                (LotteryWindow_Activity.ShowResult)(drawResult)
                ;
                (LotteryWindow.ClassicInit)()
              else
                if lotteryType == LotteryType.HuoDongUp2 then
                  (LotteryWindow_Activity2.ShowResult)(drawResult)
                  ;
                  (LotteryWindow.ClassicInit)()
                else
                  if lotteryType == LotteryType.HuoDongUp3 then
                    (LotteryWindow_Activity3.ShowResult)(drawResult)
                    ;
                    (LotteryWindow.ClassicInit)()
                  else
                    if lotteryType == LotteryType.HuoDongUp4 then
                      (LotteryWindow_Activity4.ShowResult)(drawResult)
                      ;
                      (LotteryWindow.ClassicInit)()
                    else
                      if lotteryType == LotteryType.YouChangHuoDongUp then
                        (LotteryWindow_YouChangActivity.ShowResult)(drawResult)
                        ;
                        (LotteryWindow.ClassicInit)()
                      else
                        if lotteryType == LotteryType.YouChangHuoDongUp2 then
                          (LotteryWindow_YouChangActivity2.ShowResult)(drawResult)
                          ;
                          (LotteryWindow.ClassicInit)()
                        else
                          if lotteryType == LotteryType.YouChangHuoDongUp3 then
                            (LotteryWindow_YouChangActivity3.ShowResult)(drawResult)
                            ;
                            (LotteryWindow.ClassicInit)()
                          else
                            if lotteryType == LotteryType.YouChangHuoDongUp4 then
                              (LotteryWindow_YouChangActivity4.ShowResult)(drawResult)
                              ;
                              (LotteryWindow.ClassicInit)()
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
          -- DECOMPILER ERROR at PC177: Confused about usage of register: R0 in 'UnsetPending'

          ;
          ((uis.GechaCardEffectGrp).root).visible = false
        end
      end
    end
  end
end

LotteryWindow.ShowCardProcess = function(para, isShowFirst, ...)
  -- function num : 0_10 , upvalues : _ENV, cardResults, uis, LotteryWindow, cardIndex
  for index,value in ipairs((para.data).goods) do
    if value.type == PropType.CARD then
      local cardData = ((TableData.gTable).BaseCardData)[value.id]
      local isHave = value.value == 0
      ;
      (table.insert)(cardResults, {id = value.id, intelligence = cardData.intelligence, isHave = isHave, picesNum = value.value})
    end
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.GechaCardEffectGrp).root).visible = true
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.GechaCardEffectGrp).SkipBtn).visible = true
  ;
  (LotteryWindow.RunCardResultEffect)(cardIndex)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

LotteryWindow.RunCardResultEffect = function(index, ...)
  -- function num : 0_11 , upvalues : cardResults, lotteryType, _ENV, drawResult, uis, isAutoPlay, LotteryWindow, UI_LOTTERY_REWARD_END, UI_LOTTERY_REWARD_TEXT, video
  if #cardResults < 1 then
    if lotteryType == LotteryType.Card then
      (LotteryWindow_Card.ShowResult)(drawResult)
    else
      if lotteryType == LotteryType.Coupon then
        (LotteryWindow_Coupon.ShowResult)(drawResult)
      else
        if lotteryType == LotteryType.Fresh then
          (LotteryWindow_Fresh.ShowResult)(drawResult)
        end
      end
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.GechaCardEffectGrp).root).visible = false
    isAutoPlay = false
    return 
  end
  local cardInfo = cardResults[index]
  if isAutoPlay and cardInfo.isHave then
    (LotteryWindow.DealNextCardProcess)()
    return 
  end
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
  if UI_LOTTERY_REWARD_END ~= nil then
    (ResHelper.DestroyGameObject)(UI_LOTTERY_REWARD_END)
    UI_LOTTERY_REWARD_END = nil
  end
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.GechaCardEffectGrp).SkipBtn).visible = (not isAutoPlay and cardInfo.isHave)
  local isShouldPlay = cardInfo.isHave == false or isAutoPlay == false
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.StartWord).root).visible = not isShouldPlay or cardInfo.intelligence > 1
  if isShouldPlay and cardInfo.intelligence > 1 then
    local cardExcelData = ((TableData.gTable).BaseCardData)[cardInfo.id]
    do
      -- DECOMPILER ERROR at PC103: Confused about usage of register: R4 in 'UnsetPending'

      ((uis.StartWord).c1Ctr).selectedIndex = cardExcelData.intelligence - 1
      -- DECOMPILER ERROR at PC110: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((uis.StartWord).LinesLoader).url = (Util.GetItemUrl)(cardExcelData.lottery_dialogue)
      if UI_LOTTERY_REWARD_TEXT == nil then
        local holder, effect_Txt = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_REWARD_TEXT, false, (uis.StartWord).root, (Vector2(((uis.StartWord).root).width * 0.5, ((uis.StartWord).root).height * 0.5)), nil, 1, false)
        UI_LOTTERY_REWARD_TEXT = effect_Txt
      else
        UI_LOTTERY_REWARD_TEXT:SetActive(true)
      end
      if cardExcelData.lottery_show then
        video:PreLoadVideo(cardExcelData.lottery_show)
      end
      local fairyGuiTime = (SimpleTimer.setTimeout)(3, function(...)
    -- function num : 0_11_0 , upvalues : _ENV, uis, UI_LOTTERY_REWARD_END, LotteryWindow, index
    local holder, effect_Txt = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_REWARD_END, false, (uis.StartWord).root, (Vector2(((uis.StartWord).root).width * 0.5, ((uis.StartWord).root).height * 0.5)), nil, 1, true)
    UI_LOTTERY_REWARD_END = effect_Txt
    ;
    (SimpleTimer.setTimeout)(0.5, function(...)
      -- function num : 0_11_0_0 , upvalues : LotteryWindow, index
      (LotteryWindow.PlayTimeLineOrCameraMove)(index)
    end
)
  end
)
      local trans = PlayUITrans((uis.StartWord).root, "in")
      ;
      (((uis.GechaCardEffectGrp).EffcetLoader).onClick):ClearCallFunc()
      ;
      (((uis.GechaCardEffectGrp).EffcetLoader).onClick):Add(function(...)
    -- function num : 0_11_1 , upvalues : cardInfo, trans, fairyGuiTime, _ENV
    if cardInfo.isHave then
      trans:Stop(true, true)
      if fairyGuiTime ~= nil then
        fairyGuiTime:Comp()
        fairyGuiTime = nil
      end
    else
      print("第一次获得  不能跳过独白")
    end
  end
)
      ;
      (((uis.GechaCardEffectGrp).SkipBtn).onClick):ClearCallFunc()
      ;
      (((uis.GechaCardEffectGrp).SkipBtn).onClick):Add(function(...)
    -- function num : 0_11_2 , upvalues : isAutoPlay, uis, cardInfo, trans, fairyGuiTime, _ENV
    isAutoPlay = true
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.GechaCardEffectGrp).SkipBtn).visible = false
    if cardInfo.isHave then
      trans:Stop(true, true)
      if fairyGuiTime ~= nil then
        fairyGuiTime:Comp()
        fairyGuiTime = nil
      end
    else
      print("第一次获得  不能跳过独白")
    end
  end
)
    end
  else
    (LotteryWindow.PlayTimeLineOrCameraMove)(index)
  end
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

LotteryWindow.PlayTimeLineOrCameraMove = function(index, ...)
  -- function num : 0_12 , upvalues : cardResults, _ENV, isAutoPlay, video, uis, UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END
  local isTheLast = #cardResults == index
  local isTheFirst = index == 1
  local cardInfo = cardResults[index]
  local cardExcelData = ((TableData.gTable).BaseCardData)[cardInfo.id]
  if cardExcelData.lottery_show then
    if cardInfo.isHave == false or isAutoPlay == false then
      video:PlayVideo(uis.VideoLoader, cardExcelData.lottery_show, function(...)
    -- function num : 0_12_0 , upvalues : _ENV, cardInfo, isAutoPlay, isTheLast, isTheFirst, uis
    OpenWindow((WinResConfig.CardGetShowWindow).name, UILayer.HUD, cardInfo.id, true, nil, isAutoPlay, cardInfo.isHave, cardInfo.picesNum, isTheLast, isTheFirst)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.VideoLoader).visible = false
  end
, function(...)
    -- function num : 0_12_1 , upvalues : _ENV, uis, UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END
    (SimpleTimer.setTimeout)(0.05, function(...)
      -- function num : 0_12_1_0 , upvalues : uis, UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END
      -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

      ((uis.StartWord).root).visible = false
      UI_LOTTERY_REWARD_TEXT:SetActive(false)
      UI_LOTTERY_REWARD_END:SetActive(false)
    end
)
  end
)
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (uis.VideoLoader).visible = true
      ;
      (((uis.GechaCardEffectGrp).EffcetLoader).onClick):ClearCallFunc()
      ;
      (((uis.GechaCardEffectGrp).EffcetLoader).onClick):Add(function(...)
    -- function num : 0_12_2 , upvalues : cardInfo, video, uis, _ENV
    if cardInfo.isHave then
      video:StopVideo(uis.VideoLoader, true)
    else
      print("第一次获得  不能跳过timeline")
    end
  end
)
      ;
      (((uis.GechaCardEffectGrp).SkipBtn).onClick):ClearCallFunc()
      ;
      (((uis.GechaCardEffectGrp).SkipBtn).onClick):Add(function(...)
    -- function num : 0_12_3 , upvalues : isAutoPlay, uis, cardInfo, video, _ENV
    isAutoPlay = true
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.GechaCardEffectGrp).SkipBtn).visible = false
    if cardInfo.isHave then
      video:StopVideo(uis.VideoLoader, true)
    else
      print("第一次获得  不能跳过timeline")
    end
  end
)
    else
      print("已获得 并且开启自动跳过timeline")
      OpenWindow((WinResConfig.CardGetShowWindow).name, UILayer.HUD, cardInfo.id, true, nil, isAutoPlay, cardInfo.isHave, cardInfo.picesNum, isTheLast, isTheFirst)
    end
  else
    local moveConfig = ((TableData.gTable).BaseLotteryCameraShowData)[cardExcelData.lottery_camera_id]
    OpenWindow((WinResConfig.CardGetShowWindow).name, UILayer.HUD, cardInfo.id, true, nil, isAutoPlay, cardInfo.isHave, cardInfo.picesNum, isTheLast, isTheFirst)
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((uis.StartWord).root).visible = false
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

LotteryWindow.BubbleSortGoods = function(tab, ...)
  -- function num : 0_13
  local length = #tab
  for i = 1, #tab do
    for j = i + 1, #tab do
      if (tab[i]).id == (tab[j]).id and (tab[i]).value < (tab[j]).value then
        tab[i] = tab[j]
      end
    end
  end
  return tab
end

LotteryWindow.SetAssetType = function(...)
  -- function num : 0_14 , upvalues : _ENV, lotteryType, uis
  local moneyTypes = {}
  local excelData = ((TableData.gTable).BaseLotteryShowData)[lotteryType]
  local assetIds = split(excelData.asset_ids, ":")
  for index,value in ipairs(assetIds) do
    (table.insert)(moneyTypes, tonumber(value))
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

  if lotteryType == LotteryType.Card then
    ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(84)
  else
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

    if lotteryType == LotteryType.Coupon then
      ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(85)
    else
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R3 in 'UnsetPending'

      if lotteryType == LotteryType.Equip then
        ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(86)
      else
        -- DECOMPILER ERROR at PC73: Confused about usage of register: R3 in 'UnsetPending'

        if lotteryType == LotteryType.Fresh then
          ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(184)
        else
          -- DECOMPILER ERROR at PC86: Confused about usage of register: R3 in 'UnsetPending'

          if lotteryType == LotteryType.ShilianBiChu then
            ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(219)
          else
            -- DECOMPILER ERROR at PC99: Confused about usage of register: R3 in 'UnsetPending'

            if lotteryType == LotteryType.HuoDongUp then
              ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(220)
            else
              -- DECOMPILER ERROR at PC112: Confused about usage of register: R3 in 'UnsetPending'

              if lotteryType == LotteryType.HuoDongUp2 then
                ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(220)
              else
                -- DECOMPILER ERROR at PC125: Confused about usage of register: R3 in 'UnsetPending'

                if lotteryType == LotteryType.HuoDongUp3 then
                  ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(220)
                else
                  -- DECOMPILER ERROR at PC138: Confused about usage of register: R3 in 'UnsetPending'

                  if lotteryType == LotteryType.HuoDongUp4 then
                    ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(220)
                  else
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  if lotteryType == LotteryType.Other then
    (CommonWinMgr.ChangeAssetsType)((WinResConfig.LotteryWindow).name, moneyTypes)
  end
end

return LotteryWindow

