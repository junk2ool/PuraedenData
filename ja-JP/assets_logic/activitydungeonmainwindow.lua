-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_ActivityMainByName")
local ActivityDungeonMainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local mListData = {}
local activityFirstOpen = nil
ActivityDungeonMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, activityFirstOpen, ActivityDungeonMainWindow
  bridgeObj:SetView((WinResConfig.ActivityDungeonMainWindow).package, (WinResConfig.ActivityDungeonMainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivityDungeon_ActivityMainUis(contentPane)
  if not argTable[1] then
    activityFirstOpen = activityFirstOpen ~= nil or 0
    if activityFirstOpen == 0 then
      activityFirstOpen = 1
      ;
      (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_0_0 , upvalues : ActivityDungeonMainWindow
    (ActivityDungeonMainWindow.OpenExplainWindow)()
  end
)
    end
    ;
    (ActivityService.ReqCurrentActivityDungeonInfo)()
    ;
    (ActivityDungeonMainWindow.InitAssetStrip)()
    ;
    (ActivityDungeonMainWindow.InitInvariable)()
    ;
    ((uis.BattleBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    if not (ActivityDungeonData.HasInitDungeonInfo)() then
      (ActivityService.ReqCurrentActivityDungeonInfo)()
      return 
    end
    local result, data = (ActivityDungeonData.TryGetChapterDataByIndex)(1)
    if not result then
      return 
    end
    local hard = (PlotDungeonMgr.ChapterIsOpen)(data.hard_chapter)
    local normal = (PlotDungeonMgr.ChapterIsOpen)(data.normal_chapter)
    local unlock = normal or hard
    if unlock then
      (PlotDungeonMgr.ActivityDungeonRecodeID)(data.id)
      ;
      (ActivityDungeonMgr.OpenActivityDungeonWindow)()
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000389))
    end
  end
)
    ;
    ((uis.ChoiceShopBtn).onClick):Set(function(...)
    -- function num : 0_0_2 , upvalues : _ENV
    if ShopService == nil then
      ld("Shop")
    end
    ;
    (ShopService.OnReqShopGridData)(ShopType.ActivityDungeonShop)
  end
)
    ;
    (ActivityDungeonMainWindow.BindingUI)()
    if (ActivityMgr.GetCurrentActivityDungeonType)() == (ActivityMgr.ActivityType).NewActivityDungeon then
      (ActivityDungeonService.ReqAssistFightInit)()
    end
  end
end

ActivityDungeonMainWindow.BindingUI = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.ActivityDungeonMainWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.ActivityDungeon_Btn, uis.BattleBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

ActivityDungeonMainWindow.RefreshList = function(...)
  -- function num : 0_2 , upvalues : _ENV, mListData
  local activityData = (TableData.gTable).BaseActivityChapterData
  local chapterData = (TableData.gTable).BaseChapterData
  mListData = {}
  local config = nil
  for _,v in pairs(activityData) do
    config = chapterData[v.normal_chapter]
    if config.type == PlayType.ACTIVITY then
      (table.insert)(mListData, v)
    end
  end
  ;
  (table.sort)(mListData, function(a, b, ...)
    -- function num : 0_2_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

ActivityDungeonMainWindow.GetOpenIndex = function(...)
  -- function num : 0_3 , upvalues : _ENV, mListData
  local index = 0
  for i,v in ipairs(mListData) do
    local normal = (PlotDungeonMgr.ChapterIsOpen)(v.normal_chapter)
    local hard = (PlotDungeonMgr.ChapterIsOpen)(v.hard_chapter)
    if (normal or hard) and index < i then
      index = i
    end
  end
  return index
end

ActivityDungeonMainWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_4 , upvalues : mListData, _ENV
  local data = mListData[index + 1]
  if data == nil then
    return 
  end
  ;
  (obj:GetChild("PicLoader")).url = (Util.GetItemUrl)(data.icon)
  local normal = (PlotDungeonMgr.ChapterIsOpen)(data.normal_chapter)
  local hard = (PlotDungeonMgr.ChapterIsOpen)(data.hard_chapter)
  local unlock = normal or hard
  if unlock then
    ChangeUIController(obj, "c1", 0)
  else
    ChangeUIController(obj, "c1", 1)
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : unlock, _ENV, data
    if unlock then
      (PlotDungeonMgr.ActivityDungeonRecodeID)(data.id)
      OpenWindow((WinResConfig.ActivityDungeonWindow).name, UILayer.HUD)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000389))
    end
  end
)
end

ActivityDungeonMainWindow.InitInvariable = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis, ActivityDungeonMainWindow
  local acID = (ActivityMgr.GetCachedActivityDungeonId)()
  local activityData = ((TableData.gTable).BaseActivityData)[acID]
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.WordTxt).text = activityData.remark
  ;
  ((uis.PlotBtn).onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : _ENV, activityData
    (HandBookService.OnReqAdventureStoryChapter)((ProtoEnum.E_BATTLE_TYPE).ACTIVITY, activityData.story_type)
  end
)
  ;
  ((uis.ExchangeBtn).onClick):Set(function(...)
    -- function num : 0_5_1 , upvalues : _ENV
    ld("Slots")
    local slotsData = (SlotsData.GetCurrentSlotsData)()
    if slotsData == nil then
      loge("Can Not Find Slots Data With Activity Id:" .. tostring((ActivityDungeonData.GetCurrentActivityDungeonId)()))
      return 
    end
    ;
    (SlotsService.ReqSlotsData)(slotsData.type)
  end
)
  ;
  (Util.CreateShowModel)(activityData.fashion_id, uis.CardLoader)
  local fashionData = ((TableData.gTable).BaseFashionData)[activityData.fashion_id]
  local cardData = ((TableData.gTable).BaseCardData)[fashionData.card_id]
  ;
  ((((uis.root):GetChild("CardInfoBtn")):GetChild("CardName")):GetController("c1")).selectedIndex = cardData.intelligence - 2
  ;
  ((((uis.root):GetChild("CardInfoBtn")):GetChild("CardName")):GetChild("CardTxt")).text = cardData.name
  ;
  ((((uis.root):GetChild("CardInfoBtn")):GetChild("CardName")):GetChild("CVTxt")).text = cardData.cv_name
  local spineLoader = ((uis.root):GetChild("CardInfoBtn")):GetChild("CardQLoader")
  ;
  (Util.RecycleUIModel)(spineLoader)
  local boneModel = (Util.ShowUIModel)(fashionData.spd_bundle, spineLoader, fashionData.show_spine_type)
  ;
  (SkeletonAnimationUtil.SetAnimation)(boneModel, 0, "idle", true)
  local scale = 20
  ;
  (CSLuaUtil.SetGOScale)(boneModel, -scale, scale, scale)
  ;
  (SkeletonAnimationUtil.SetFlip)(boneModel, true, false)
  ;
  (CSLuaUtil.SetGOLocalPos)(boneModel, spineLoader.width * 0.5, -spineLoader.height, 0)
  ;
  (((uis.root):GetChild("CardInfoBtn")).onClick):Set(function(...)
    -- function num : 0_5_2 , upvalues : _ENV, activityData
    local FashionData = ((TableData.gTable).BaseFashionData)[activityData.fashion_id]
    OpenWindow((WinResConfig.CardDetailsWindow).name, UILayer.HUD, FashionData.card_id)
  end
)
  ;
  ((uis.ExchangeBtn):GetChild("RedDot")).visible = (ActorData.GetAssetCount)(AssetType.ACTIVITY_SCORE_NEW) > 0
  ;
  ((uis.PlotBtn):GetChild("RedDot")).visible = (ActivityMgr.PlotRedDotShow)()
  ;
  (GuideData.RegisterGuideAndControl)(ControlID.HandBook_Album, uis.PlotBtn, (WinResConfig.ActivityDungeonMainWindow).name)
  ;
  (ActivityDungeonMainWindow.InitPanelIcons)(acID)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityDungeonMainWindow.InitPanelIcons = function(activityId, ...)
  -- function num : 0_6 , upvalues : _ENV, uis
  local bgLoader = (FairyUIUtils.FindLoader)(uis.root, "BgLoader")
  local logoLoader = (FairyUIUtils.FindLoader)(uis.root, "LogoLoader")
  local cardTipsLoader = (FairyUIUtils.FindLoader)(uis.CardInfoBtn, "CardTipsLoader")
  local imageConfigData = ((TableData.gTable).BaseActivityImageConfigData)[activityId]
  if imageConfigData then
    bgLoader.url = (Util.GetItemUrl)(imageConfigData.activity_bkg)
    logoLoader.url = (Util.GetItemUrl)(imageConfigData.activity_title)
  else
    loge("Can Not Find Activity Image Config With " .. tostring(activityId))
  end
end

ActivityDungeonMainWindow.SetTime = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis
  local data = (ActivityMgr.InitActivityDungeonData)()
  local startTime = (data.baseActivityInfo).beginTime
  local endTime = (data.baseActivityInfo).endTime
  local startStr = (LuaTime.GetFormatTimeStr)("%m-%d %H:%M", startTime)
  local endStr = (LuaTime.GetFormatTimeStr)("%m-%d %H:%M", endTime)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.Time).TimeTxt).text = (PUtil.get)(20000388, startStr, endStr)
end

ActivityDungeonMainWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : ActivityDungeonMainWindow
  (ActivityDungeonMainWindow.SetArrowShow)()
end

ActivityDungeonMainWindow.SetArrowShow = function(...)
  -- function num : 0_9
end

ActivityDungeonMainWindow.OnHide = function(...)
  -- function num : 0_10
end

ActivityDungeonMainWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : uis, contentPane, argTable, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ActivityDungeonMainWindow).name)
end

ActivityDungeonMainWindow.OpenExplainWindow = function(...)
  -- function num : 0_12 , upvalues : _ENV
  local activityId = (ActivityMgr.GetCachedActivityDungeonId)()
  local activityData = ((TableData.gTable).BaseActivityData)[activityId]
  do
    if activityData.help_type and activityData.help_type == 0 and activityData.desc_str then
      local ruleDes = activityData.desc_str
      OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, tostring(ruleDes))
    end
    OpenWindow((WinResConfig.ActivityExplainWindow).name, UILayer.HUD)
  end
end

ActivityDungeonMainWindow.InitAssetStrip = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis, ActivityDungeonMainWindow
  local m = {}
  m.windowName = (WinResConfig.ActivityDungeonMainWindow).name
  m.Tip = (PUtil.get)(20000216)
  m.model = uis.AssetStrip
  m.explainFunc = ActivityDungeonMainWindow.OpenExplainWindow
  local activityId = (ActivityMgr.GetCachedActivityDungeonId)()
  local imageConfigData = ((TableData.gTable).BaseActivityImageConfigData)[activityId]
  if imageConfigData then
    m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, tonumber(imageConfigData.activity_shop_asset), tonumber(imageConfigData.activity_slot_asset)}
    ;
    (CommonWinMgr.RegisterAssets)(m)
  else
    loge("Can Not Find Image Config Data With Activity Id " .. tostring(activityId))
  end
end

ActivityDungeonMainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14 , upvalues : _ENV, ActivityDungeonMainWindow
  if msgId == (WindowMsgEnum.ActivityMainDungeon).E_MSG_SET_TIME then
    (ActivityDungeonMainWindow.SetTime)()
  end
end

return ActivityDungeonMainWindow

