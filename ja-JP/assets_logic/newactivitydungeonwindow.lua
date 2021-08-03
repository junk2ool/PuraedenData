-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_ActivityMainByName")
local MODEL_SCALE = 20
local NewActivityDungeonWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _cardInfoBtn, _miniLoader = nil, nil
NewActivityDungeonWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, NewActivityDungeonWindow
  bridgeObj:SetView((WinResConfig.NewActivityDungeonWindow).package, (WinResConfig.NewActivityDungeonWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivityDungeonTwo_ActivityMainUis(contentPane)
  ;
  (NewActivityDungeonWindow.InitTopMenu)()
  ;
  (NewActivityDungeonWindow.InitInvariable)()
  ;
  (NewActivityDungeonWindow.InitButtonEvent)()
  ;
  (NewActivityDungeonWindow.InitFunctionControl)()
  ;
  (NewActivityDungeonWindow.InitPanelIcons)((ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).NewActivityDungeon))
  ;
  (NewActivityDungeonWindow.BindingUI)()
end

NewActivityDungeonWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.NewActivityDungeonWindow).name
  m.Tip = (PUtil.get)(20000216)
  m.model = uis.AssetStrip
  m.explainFunc = function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    (NewActivityDungeonMgr.OpenActivityExplatin)()
  end

  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.ACTIVITYDUNGEON_COIN, AssetType.ACTIVITY_SCORE_NEW}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

NewActivityDungeonWindow.InitInvariable = function(...)
  -- function num : 0_2 , upvalues : _cardInfoBtn, uis, _miniLoader
  _cardInfoBtn = (uis.root):GetChild("CardInfoBtn")
  _miniLoader = _cardInfoBtn:GetChild("CardQLoader")
end

NewActivityDungeonWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, NewActivityDungeonWindow, _cardInfoBtn
  ((uis.BattleBtn).onClick):Set(NewActivityDungeonWindow.ClickBattleBtn)
  ;
  ((uis.PlotBtn).onClick):Set(NewActivityDungeonWindow.ClickPlotBtn)
  ;
  ((uis.ExchangeBtn).onClick):Set(NewActivityDungeonWindow.ClickExchangeBtn)
  ;
  ((uis.ChoiceShopBtn).onClick):Set(NewActivityDungeonWindow.ClickChoiceShopBtn)
  ;
  (_cardInfoBtn.onClick):Set(NewActivityDungeonWindow.ClickCardInfoBtn)
end

NewActivityDungeonWindow.InitFunctionControl = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis
  (GuideData.RegisterGuideAndControl)(ControlID.HandBook_Album, uis.PlotBtn, (WinResConfig.NewActivityDungeonWindow).name)
end

NewActivityDungeonWindow.InitPanelIcons = function(activityId, ...)
  -- function num : 0_5 , upvalues : _ENV, uis
  local bgLoader = (FairyUIUtils.FindLoader)(uis.root, "BgLoader")
  local logoLoader = (FairyUIUtils.FindLoader)(uis.root, "LogoLoader")
  local cardTipsLoader = (FairyUIUtils.FindLoader)(uis.CardInfoBtn, "CardTipsLoader")
  local imageConfigData = ((TableData.gTable).BaseActivityImageConfigData)[activityId]
  if imageConfigData then
    bgLoader.url = (Util.GetItemUrl)(imageConfigData.activity_bkg)
    logoLoader.url = (Util.GetItemUrl)(imageConfigData.activity_title)
    cardTipsLoader.url = (Util.GetItemUrl)(imageConfigData.activity_actor)
  else
    loge("Can Not Find Activity Image Config With " .. tostring(activityId))
  end
end

NewActivityDungeonWindow.BindingUI = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis
  local winName = (WinResConfig.NewActivityDungeonWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.ActivityDungeon_Btn, uis.BattleBtn)
  local config = ((TableData.gTable).BaseActivityAidData)[(NewActivityDungeonData.AssistData).id]
  if config.assist_num <= (NewActivityDungeonData.AssistData).assistedTime then
    (RedDotMgr.EliminateRedDot)((WinResConfig.NewActivityDungeonMainWindow).name, RedDotComID.NAD_GuildHlep)
    ;
    (RedDotMgr.RefreshTreeUI)((WinResConfig.NewActivityDungeonMainWindow).name)
  end
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

NewActivityDungeonWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : NewActivityDungeonWindow
  (NewActivityDungeonWindow.Init)()
end

NewActivityDungeonWindow.OnHide = function(...)
  -- function num : 0_8
end

NewActivityDungeonWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis, _miniLoader, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.NewActivityDungeonWindow).name)
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  ;
  (Util.RecycleUIModel)(_miniLoader)
  uis = nil
  contentPane = nil
  argTable = {}
end

NewActivityDungeonWindow.Init = function(...)
  -- function num : 0_10 , upvalues : NewActivityDungeonWindow
  (NewActivityDungeonWindow.ShowExplainWindow)()
  ;
  (NewActivityDungeonWindow.Refresh)()
end

NewActivityDungeonWindow.ShowExplainWindow = function(...)
  -- function num : 0_11 , upvalues : argTable, _ENV
  if argTable[1] == 0 then
    argTable[1] = 1
    ;
    (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_11_0 , upvalues : _ENV
    (NewActivityDungeonMgr.OpenActivityExplatin)()
  end
)
  end
end

NewActivityDungeonWindow.Refresh = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis, _miniLoader, MODEL_SCALE
  if NewActivityDungeonData.NADData == nil then
    return 
  end
  local ActivityData = ((TableData.gTable).BaseActivityData)[(NewActivityDungeonData.NADData).actId]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.WordTxt).text = ActivityData.remark
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Time).TimeTxt).text = (PUtil.get)(20000388, (LuaTime.GetFormatTimeStr)("%m-%d %H:%M", (NewActivityDungeonData.NADData).beginTime), (LuaTime.GetFormatTimeStr)("%m-%d %H:%M", (NewActivityDungeonData.NADData).endTime))
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  ;
  (Util.CreateShowModel)(ActivityData.fashion_id, uis.CardLoader)
  local fashionData = ((TableData.gTable).BaseFashionData)[ActivityData.fashion_id]
  ;
  (Util.RecycleUIModel)(_miniLoader)
  local boneModel = (Util.ShowUIModel)(fashionData.spd_bundle, _miniLoader, fashionData.show_spine_type)
  ;
  (SkeletonAnimationUtil.SetAnimation)(boneModel, 0, "idle", true)
  ;
  (CSLuaUtil.SetGOScale)(boneModel, -MODEL_SCALE, MODEL_SCALE, MODEL_SCALE)
  ;
  (SkeletonAnimationUtil.SetFlip)(boneModel, true, false)
  ;
  (CSLuaUtil.SetGOLocalPos)(boneModel, _miniLoader.width * 0.5, -_miniLoader.height, 0)
  ;
  ((uis.ExchangeBtn):GetChild("RedDot")).visible = (ActorData.GetAssetCount)(AssetType.ACTIVITY_SCORE_NEW) > 0
  ;
  ((uis.PlotBtn):GetChild("RedDot")).visible = (ActivityMgr.PlotRedDotShow)()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

NewActivityDungeonWindow.ClickBattleBtn = function(...)
  -- function num : 0_13 , upvalues : _ENV
  (NewActivityDungeonMgr.OpenMainNADUI)()
end

NewActivityDungeonWindow.ClickExchangeBtn = function(...)
  -- function num : 0_14 , upvalues : _ENV
  ld("Slots")
  ;
  (SlotsService.ReqSlotsData)((SlotsData.SlotType).ACTIVITY_SLOT)
end

NewActivityDungeonWindow.ClickCardInfoBtn = function(...)
  -- function num : 0_15 , upvalues : _ENV
  if NewActivityDungeonData.NADData == nil then
    return 
  end
  local ActivityData = ((TableData.gTable).BaseActivityData)[(NewActivityDungeonData.NADData).actId]
  local FashionData = ((TableData.gTable).BaseFashionData)[ActivityData.fashion_id]
  OpenWindow((WinResConfig.CardDetailsWindow).name, UILayer.HUD, FashionData.card_id)
end

NewActivityDungeonWindow.ClickChoiceShopBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV
  if ShopService == nil then
    ld("Shop")
  end
  ;
  (ShopService.OnReqShopGridData)(ShopType.ActivityDungeonShop)
end

NewActivityDungeonWindow.ClickPlotBtn = function(...)
  -- function num : 0_17 , upvalues : _ENV
  (HandBookService.OnReqAdventureStoryChapter)((ProtoEnum.E_BATTLE_TYPE).ACTIVITY, ActivityData.story_type)
end

NewActivityDungeonWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_18 , upvalues : _ENV, NewActivityDungeonWindow
  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_UI then
    (NewActivityDungeonWindow.Refresh)()
  end
end

return NewActivityDungeonWindow

