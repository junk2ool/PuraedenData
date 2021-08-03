-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_ActivityMainByName")
local ActivityDungeonMainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local mListData = {}
local activityFirstOpen = nil
ActivityDungeonMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, activityFirstOpen, ActivityDungeonMainWindow, mListData
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
    -- function num : 0_0_0 , upvalues : _ENV
    OpenWindow((WinResConfig.ActivityExplainWindow).name, UILayer.HUD)
  end
)
    end
    ;
    (ActivityService.OnReqActivityInfo)((ActivityMgr.ActivityType).ActivityDungeon)
    ;
    (ActivityDungeonMainWindow.InitAssetStrip)()
    ;
    (ActivityDungeonMainWindow.InitInvariable)()
    ;
    ((uis.BattleBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : mListData, _ENV
    local data = mListData[1]
    if data == nil then
      return 
    end
    local normal = (PlotDungeonMgr.ChapterIsOpen)(data.normal_chapter)
    local hard = (PlotDungeonMgr.ChapterIsOpen)(data.hard_chapter)
    local unlock = normal or hard
    if unlock then
      (PlotDungeonMgr.ActivityDungeonRecodeID)(data.id)
      OpenWindow((WinResConfig.ActivityDungeonWindow).name, UILayer.HUD)
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
    (ActivityDungeonMainWindow.RefreshList)()
  end
end

ActivityDungeonMainWindow.RefreshList = function(...)
  -- function num : 0_1 , upvalues : _ENV, mListData, ActivityDungeonMainWindow
  local ActivityData = (TableData.gTable).BaseActivityChapterData
  local chapterData = (TableData.gTable).BaseChapterData
  mListData = {}
  local config = nil
  for _,v in pairs(ActivityData) do
    config = chapterData[v.normal_chapter]
    if config.type == PlayType.ACTIVITY then
      (table.insert)(mListData, v)
    end
  end
  ;
  (table.sort)(mListData, function(a, b, ...)
    -- function num : 0_1_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local index = (ActivityDungeonMainWindow.GetOpenIndex)()
end

ActivityDungeonMainWindow.GetOpenIndex = function(...)
  -- function num : 0_2 , upvalues : _ENV, mListData
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
  -- function num : 0_3 , upvalues : mListData, _ENV
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
    -- function num : 0_3_0 , upvalues : unlock, _ENV, data
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
  -- function num : 0_4 , upvalues : _ENV, uis, ActivityDungeonMainWindow
  local acID = (ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).ActivityDungeon)
  local ActivityData = ((TableData.gTable).BaseActivityData)[acID]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.WordTxt).text = ActivityData.remark
  ;
  ((uis.PlotBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV, ActivityData
    (HandBookService.OnReqAdventureStoryChapter)((ProtoEnum.E_BATTLE_TYPE).ACTIVITY, ActivityData.story_type)
  end
)
  ;
  ((uis.ExchangeBtn).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    ld("Slots")
    ;
    (SlotsService.ReqSlotsData)((SlotsData.SlotType).ACTIVITY_SLOT)
  end
)
  ;
  (Util.CreateShowModel)(ActivityData.fashion_id, uis.CardLoader)
  local fashionData = ((TableData.gTable).BaseFashionData)[ActivityData.fashion_id]
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
    -- function num : 0_4_2 , upvalues : _ENV, ActivityData
    local FashionData = ((TableData.gTable).BaseFashionData)[ActivityData.fashion_id]
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

ActivityDungeonMainWindow.SetTime = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis
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
  -- function num : 0_7 , upvalues : ActivityDungeonMainWindow
  (ActivityDungeonMainWindow.SetArrowShow)()
end

ActivityDungeonMainWindow.SetArrowShow = function(...)
  -- function num : 0_8
end

ActivityDungeonMainWindow.OnHide = function(...)
  -- function num : 0_9
end

ActivityDungeonMainWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : uis, contentPane, argTable, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ActivityDungeonMainWindow).name)
end

ActivityDungeonMainWindow.InitAssetStrip = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ActivityDungeonMainWindow).name
  m.Tip = (PUtil.get)(20000216)
  m.model = uis.AssetStrip
  m.explainFunc = function(...)
    -- function num : 0_11_0 , upvalues : _ENV
    OpenWindow((WinResConfig.ActivityExplainWindow).name, UILayer.HUD)
  end

  local activityId = (ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).ActivityDungeon)
  local imageConfigData = ((TableData.gTable).BaseActivityImageConfigData)[activityId]
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, tonumber(imageConfigData.activity_shop_asset), tonumber(imageConfigData.activity_slot_asset)}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ActivityDungeonMainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12 , upvalues : _ENV, ActivityDungeonMainWindow
  if msgId == (WindowMsgEnum.ActivityMainDungeon).E_MSG_SET_TIME then
    (ActivityDungeonMainWindow.SetTime)()
  end
end

return ActivityDungeonMainWindow

