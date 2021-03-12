-- params : ...
-- function num : 0 , upvalues : _ENV
require("Home_HomeWindowByName")
require("Home_ActivityBtnByName")
require("Tool_sendChatByName")
local HomeWindow = {}
local homeUis, uis, contentPane, showModel, holder, holderEffectBack, holderEffectFront, cvVoiceTimer = nil, nil, nil, nil, nil, nil, nil, nil
local AUTOCVTIME = 60
local _bubbleDefaultSizeY = 0
local assetType = AssetType
local GmCommand = {ALL = "gm,addExp,1000000", physical = "gm,addAsset,21100004,10000", bind = "gm,addAsset,21100001,10000", gold = "gm,addAsset,21100003,10000000", uplevel = "gm,addExp,100000", diamond = "gm,addAsset,21100002,10000", UpStarMax = "gm,superCard,0:gm,superCard,0,skill"}
HomeWindow.ReInitData = function(...)
  -- function num : 0_0
end

local popup = nil
local curStateIndex = 1
local stateRepeatCount = 1
local curState = ""
local fashionID, playWelcome = nil, nil
local BannerAniTime = 1
local BannerTimer = nil
local BannerIndex = 1
local ActivityPos = {}
local ActivityTimer = nil
HomeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_1 , upvalues : _ENV, contentPane, curStateIndex, stateRepeatCount, curState, homeUis, uis, HomeWindow, popup, fashionID
  bridgeObj:SetView((WinResConfig.HomeWindow).package, (WinResConfig.HomeWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  curStateIndex = 1
  stateRepeatCount = 1
  curState = ""
  homeUis = GetHome_HomeWindowUis(contentPane)
  uis = homeUis.HomeCtrl
  ;
  ((uis.AdventureBtn).onClick):Set(HomeWindow.onClickAdventureBtn)
  ;
  ((uis.TeamBtn).onClick):Set(HomeWindow.onClickTeamBtn)
  ;
  ((uis.CardBtn).onClick):Set(HomeWindow.onClickCardBtn)
  ;
  ((uis.HandbookBtn).onClick):Set(HomeWindow.onClickHandbookBtn)
  ;
  ((uis.LotteryBtn).onClick):Set(HomeWindow.onClickLotteryBtn)
  ;
  ((uis.EquipmentBtn).onClick):Set(HomeWindow.onClickEquipmentBtn)
  ;
  ((uis.GuildBtn).onClick):Set(HomeWindow.onClickGuildBtn)
  ;
  ((((uis.BtnPanel).root):GetChild("n3")).onClick):Set(HomeWindow.onClickBannerShow)
  ;
  ((((uis.HeadGrp).Gold).root).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).GOLD_BUY_TIME_TYPE)
  end
)
  ;
  ((((uis.HeadGrp).Diamonds).root).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    ld("Shop", function(...)
      -- function num : 0_1_1_0 , upvalues : _ENV
      (ShopMgr.ExternalGotoShop)(ShopType.Recharge)
    end
)
  end
)
  ;
  ((((uis.HeadGrp).Power).root).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : _ENV
    (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).VIT_BUY_TIME_TYPE)
  end
)
  if (FunctionControlMgr.GetFunctionState)(ControlID.Adventure_Hero, false) and not (PlotDungeonMgr.IsQuestHeroData)() then
    (PlotDungeonService.ReqStoryInfo)(DungeonType.HeroDungeon, true)
    ;
    (PlotDungeonMgr.IsQuestHeroData)(true)
  end
  ;
  (HomeWindow.CheckActivityIcon)()
  ;
  ((uis.FriendBtn).onClick):Set(HomeWindow.OnClickFriend)
  ;
  ((uis.ShopBtn).onClick):Set(HomeWindow.OnClickShop)
  ;
  ((uis.Top_BagBtn).onClick):Set(HomeWindow.OnClickBag)
  ;
  ((uis.TaskBtn).onClick):Set(HomeWindow.onClickTask)
  ;
  ((uis.Top_MailBtn).onClick):Set(HomeWindow.onClickMail)
  ;
  ((uis.DailyBtn).onClick):Set(HomeWindow.onClickActivityBtn)
  ;
  ((homeUis.ShowLoader).onClick):Set(HomeWindow.onClickShowLoader)
  ;
  ((uis.ActorInfoBtn).onClick):Set(HomeWindow.ClickPlayerInfoBtn)
  ;
  ((uis.FamilyBtn).onClick):Set(HomeWindow.ClickHomelandBtn)
  ;
  ((uis.AnnouncementBtn).onClick):Set(HomeWindow.ClickAnnouncementBtn)
  -- DECOMPILER ERROR at PC169: Confused about usage of register: R1 in 'UnsetPending'

  if IsIOSReview == true then
    (uis.AnnouncementBtn).visible = false
  end
  ;
  ((uis.ActivityDungeonBtn).onClick):Set(function(...)
    -- function num : 0_1_3 , upvalues : _ENV
    (PlotDungeonService.ReqStoryInfo)(DungeonType.ActivityDungeon)
  end
)
  ;
  (HomeWindow.RecordActivityPos)()
  ;
  (HomeWindow.RefreshActivityBtnVisible)()
  ;
  ((uis.CarnivalBtn).onClick):Set(function(...)
    -- function num : 0_1_4 , upvalues : _ENV
    (ActivityService.OnReqActivityInfo)((ActivityMgr.ActivityType).SevenTask)
  end
)
  ;
  (((uis.BtnPanel).HideBtn).onClick):Set(HomeWindow.onClickHideBtn)
  ;
  ((uis.TouchScreenBtn).onClick):Set(HomeWindow.onClickTouchScreenBtn)
  ;
  (((uis.BtnPanel).BackGroundBtn).onClick):Set(HomeWindow.onClickBackgroundBtn)
  ;
  (((uis.BackGroundChoice).CloseBtn).onClick):Set(HomeWindow.onClickCloseBackgroundBtn)
  ;
  (HomeWindow.UpdateActor)()
  ;
  (HomeWindow.InitSend)()
  if popup and Game.enableGM == true then
    (UpdateMgr.AddUpdateHandler)(HomeWindow.Update)
    local LongPressGesture = (FairyGUI.LongPressGesture)(homeUis.ShowLoader)
    LongPressGesture.once = true
    LongPressGesture.trigger = 2
    ;
    (LongPressGesture.onAction):Set(function(...)
    -- function num : 0_1_5 , upvalues : _ENV, popup
    (GRoot.inst):ShowPopup(popup)
  end
)
  end
  do
    -- DECOMPILER ERROR at PC243: Confused about usage of register: R1 in 'UnsetPending'

    if Game.testPackage ~= true and uis.ServerNameTxt then
      (uis.ServerNameTxt).text = (LoginMgr.GetServerName)()
    end
    ;
    (HomeWindow.InitFunctionControl)()
    ;
    (HomeWindow.InitBackground)()
    ;
    (HomeWindow.InitActivityBannerList)()
    ;
    (HomeWindow.UpdateActivityList)()
    ;
    (HomeMgr.PreLoadCardSpine)()
    PlayUITrans(uis.root, "in")
    ;
    (HomeWindow.BindingUI)()
    ;
    (HomeWindow.CheckCardsRedDot)()
    ;
    (LuaSound.LoadAndPlayBGM)(1010001)
    fashionID = (ActorData.GetFashionShow)()
    ;
    (HomeWindow.FirstLoginVoiceAndBubble)()
    ;
    (HomeWindow.AutoPlayVoiceAndBubble)()
    collectgarbage("collect")
    UIMgr:RemovePackage("UIBackground495x225", true)
    UIMgr:RemovePackage("UIBackground990x450", true)
    UIMgr:LoadPackage("UIBackground495x225")
    UIMgr:LoadPackage("UIBackground990x450")
    local curHour = (LuaTime.GetGameHour)((ActorData.GetServerTime)())
    if LoginMgr.lastOnlineHour then
      if LoginMgr.lastOnlineHour < 5 and curHour >= 5 then
        local curMin = (math.floor)((os.date)("%M", (math.floor)((ActorData.GetServerTime)() / 1000)))
        if curMin >= 1 then
          (MessageMgr.OpenSoloConfirmWindow)((PUtil.get)(40000013), function(...)
    -- function num : 0_1_6 , upvalues : _ENV
    (LoginMgr.ReturnToLoginWindow)()
  end
, nil, (PUtil.get)(60000004))
          -- DECOMPILER ERROR at PC342: Confused about usage of register: R3 in 'UnsetPending'

          LoginMgr.lastOnlineHour = curHour
        end
      else
        do
          -- DECOMPILER ERROR at PC345: Confused about usage of register: R2 in 'UnsetPending'

          LoginMgr.lastOnlineHour = curHour
          -- DECOMPILER ERROR at PC348: Confused about usage of register: R2 in 'UnsetPending'

          LoginMgr.lastOnlineHour = curHour
          if ((CS.UnityEngine).Application).platform ~= ((CS.UnityEngine).RuntimePlatform).WindowsEditor and ((CS.UnityEngine).Application).platform ~= ((CS.UnityEngine).RuntimePlatform).OSXEditor then
            local updateCheck = require("UpdateCheckMgr")
            ;
            (updateCheck.CheckUpdate)()
          end
        end
      end
    end
  end
end

HomeWindow.RecordActivityPos = function(...)
  -- function num : 0_2 , upvalues : ActivityPos, _ENV, uis
  ActivityPos = {}
  ;
  (table.insert)(ActivityPos, (uis.CarnivalBtn).xy)
  ;
  (table.insert)(ActivityPos, (uis.ActivityDungeonBtn).xy)
end

HomeWindow.RefreshActivityBtnVisible = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, ActivityPos
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  (uis.CarnivalBtn).visible = (ActivityMgr.GetActivityIsOpen)((ActivityMgr.ActivityType).SevenTask)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ActivityDungeonBtn).visible = (ActivityMgr.GetActivityIsOpen)((ActivityMgr.ActivityType).ActivityDungeon)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

  if (uis.CarnivalBtn).visible == false and (uis.ActivityDungeonBtn).visible == true then
    (uis.ActivityDungeonBtn).xy = ActivityPos[1]
  end
  local TenMailID = (ActorService.RegisterMail)()
  local Appointment = (uis.LeftList):GetChild("Appointment")
  do
    -- DECOMPILER ERROR at PC45: Unhandled construct in 'MakeBoolean' P1

    if TenMailID and TenMailID > 0 and Appointment == nil then
      local AppointmentBtn = UIMgr:CreateObject("Home", "AppointmentBtn")
      AppointmentBtn.name = "Appointment"
      ;
      (uis.LeftList):AddChild(AppointmentBtn)
      ;
      (AppointmentBtn.onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    ld("Mail", function(...)
      -- function num : 0_3_0_0 , upvalues : _ENV
      OpenWindow((WinResConfig.MailWindow).name, UILayer.HUD)
    end
)
  end
)
    end
    if Appointment then
      (uis.LeftList):RemoveChild(Appointment)
    end
    local PrizeCom = (uis.LeftList):GetChild("Prize")
    local Prize = (ActivityMgr.GetActivityIsOpen)((ActivityMgr.ActivityType).Prize)
    do
      -- DECOMPILER ERROR at PC80: Unhandled construct in 'MakeBoolean' P1

      if Prize == true and PrizeCom == nil then
        local PrizeBtn = UIMgr:CreateObject("Home", "PrizeBtn")
        PrizeBtn.name = "Prize"
        ;
        (uis.LeftList):AddChild(PrizeBtn)
        ;
        (PrizeBtn.onClick):Set(function(...)
    -- function num : 0_3_1 , upvalues : _ENV
    (ActivityService.OnReqActivityInfo)((ActivityMgr.ActivityType).Prize)
  end
)
      end
      if PrizeCom then
        (uis.LeftList):RemoveChild(PrizeCom)
      end
      local lotteryIntergral = (ActivityMgr.GetActivityIsOpen)((ActivityMgr.ActivityType).LotteryIntergral)
      local lotteryIntergralCom = (uis.LeftList):GetChild("LotteryIntegral")
      if lotteryIntergral == true then
        local lotteryIntergralBtn = UIMgr:CreateObject("Home", "LotteryIntegralBtn")
        if lotteryIntergralCom == nil then
          lotteryIntergralBtn.name = "LotteryIntegral"
          ;
          (uis.LeftList):AddChild(lotteryIntergralBtn)
          ;
          (lotteryIntergralBtn.onClick):Set(function(...)
    -- function num : 0_3_2 , upvalues : _ENV
    OpenWindow((WinResConfig.LotteryIntegralWindow).name, UILayer.HUD)
  end
)
        end
        ;
        (RedDotMgr.BindingUI)((WinResConfig.HomeWindow).name, RedDotComID.Home_LotteryIntegral, lotteryIntergralBtn)
        ;
        (RedDotMgr.RefreshTreeUI)((WinResConfig.HomeWindow).name)
      else
        do
          if lotteryIntergralCom then
            (uis.LeftList):RemoveChild(lotteryIntergralCom)
          end
        end
      end
    end
  end
end

local BannerListData = {}
local PossibleBanner = {}
local _timers = {}
local isGet = false
HomeWindow.InitActivityBannerList = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV, HomeWindow, BannerListData, BannerIndex, isGet
  local list = (uis.Activity).PicList
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if IsIOSReview == true then
    ((uis.Activity).root).visible = false
  end
  list.itemRenderer = HomeWindow.ActivityBannerRenderer
  list:SetVirtualAndLoop()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (list.scrollPane).pageMode = true
  list.columnGap = 0
  ;
  ((list.scrollPane).onScrollEnd):Set(function(...)
    -- function num : 0_4_0 , upvalues : BannerListData, BannerIndex, list, HomeWindow, isGet
    local length = #BannerListData
    BannerIndex = (list.scrollPane).currentPageX % length + 1
    ;
    (HomeWindow.SetPageShow)()
    isGet = false
  end
)
end

HomeWindow.onClickBannerShow = function(...)
  -- function num : 0_5 , upvalues : _ENV, holder
  local fashionShow = (ActorData.GetFashionShow)()
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionShow]
  local cardID = fashionData.card_id
  local cardList = (CardData.GetObtainedCardList)()
  local index = 0
  for i,v in ipairs(cardList) do
    if v.id == cardID then
      index = i
      break
    end
  end
  do
    ;
    (CardData.SaveCurClickCardID)(cardID)
    ;
    (CardData.SaveCurClickCardIndex)(index)
    if holder then
      (LuaEffect.DestroyEffect)(holder)
      holder = nil
    end
    OpenWindow((WinResConfig.CardChoiceWindow).name, UILayer.HUD)
  end
end

HomeWindow.SetPageShow = function(...)
  -- function num : 0_6 , upvalues : uis, BannerIndex, _ENV
  local list = (uis.Activity).PageNumberList
  local length = list.numItems
  for i = 1, length do
    local obj = list:GetChildAt(i - 1)
    if i == BannerIndex then
      ChangeUIController(obj, "c1", 1)
    else
      ChangeUIController(obj, "c1", 0)
    end
  end
end

HomeWindow.InitPageList = function(...)
  -- function num : 0_7 , upvalues : uis, BannerListData
  ((uis.Activity).PageNumberList):RemoveChildrenToPool()
  local subList = (uis.Activity).PageNumberList
  local length = #BannerListData
  if length > 1 then
    for i = 1, length do
      ((uis.Activity).PageNumberList):AddItemFromPool()
    end
  end
end

HomeWindow.ActivityBannerRenderer = function(index, obj, ...)
  -- function num : 0_8 , upvalues : _ENV, BannerListData
  index = index + 1
  local data = ((TableData.gTable).BaseActivityBannerData)[(BannerListData[index]).Key]
  ;
  (obj:GetChild("PicLoader")).url = (Util.GetItemUrl)(data.icon)
  local redDot = obj:GetChild("RedDot")
  if data.time_type == 0 then
    redDot.visible = not (ActivityMgr.BannerRedDot)[data.id]
  else
    redDot.visible = false
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_8_0 , upvalues : _ENV, redDot, data
    ld("GetWay")
    if redDot.visible and data.time_type == 0 then
      (ActivityService.ReqSaveBannerId)({data.id})
    end
    ;
    (GetWayMgr.Goto)(data.goto_id)
  end
)
end

HomeWindow.UpdateActivityList = function(...)
  -- function num : 0_9 , upvalues : _ENV, _timers, BannerListData, PossibleBanner, HomeWindow, uis, BannerTimer, BannerAniTime, BannerIndex
  for k,v in pairs(_timers) do
    v:stop()
  end
  BannerListData = (HomeWindow.GetActivityBannerListData)()
  local list = (uis.Activity).PicList
  local count = #BannerListData
  do
    list.numItems = count
    for i = 1, count do
      local index = i
      local data = BannerListData[index]
      if data.EndTime ~= nil then
        (table.insert)(_timers, (SimpleTimer.setTimeout)(data.EndTime - (LuaTime.GetTimeStamp)(), function(...)
    -- function num : 0_9_0 , upvalues : _ENV, BannerListData, index, list, BannerTimer, HomeWindow
    loge("结束:" .. (BannerListData[index]).Key)
    ;
    (table.remove)(BannerListData, index)
    ;
    (ActivityService.ReqRemoveBannerId)({(BannerListData[index]).Key})
    list.numItems = #BannerListData
    if #BannerListData <= 1 and BannerTimer ~= nil then
      BannerTimer:stop()
      BannerTimer = nil
    end
    ;
    (HomeWindow.InitPageList)()
  end
))
      end
    end
    count = #PossibleBanner
    for i = 1, count do
      local index = i
      local data = PossibleBanner[index]
      if data.BeginTime ~= nil then
        (table.insert)(_timers, (SimpleTimer.setTimeout)(data.BeginTime - (LuaTime.GetTimeStamp)(), function(...)
    -- function num : 0_9_1 , upvalues : _ENV, PossibleBanner, index, BannerListData, data, list, BannerTimer, BannerAniTime, HomeWindow, BannerIndex
    (table.remove)(PossibleBanner, index)
    ;
    (table.insert)(BannerListData, {Key = data.Key, EndTime = data.EndTime})
    ;
    (table.sort)(BannerListData, function(a, b, ...)
      -- function num : 0_9_1_0 , upvalues : _ENV
      local aConfig = ((TableData.gTable).BaseActivityBannerData)[a.Key]
      local bConfig = ((TableData.gTable).BaseActivityBannerData)[b.Key]
      do return aConfig.sort < bConfig.sort end
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
)
    list.numItems = #BannerListData
    if BannerTimer == nil and #BannerListData > 1 then
      BannerTimer = (SimpleTimer.setInterval)(5, 9999, function(...)
      -- function num : 0_9_1_1 , upvalues : list, BannerAniTime
      (list.scrollPane):ScrollRight(1, true, BannerAniTime)
    end
)
    end
    ;
    (HomeWindow.InitPageList)()
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (list.scrollPane).currentPageX = BannerIndex - 1
  end
))
      end
    end
    if #BannerListData > 1 then
      BannerTimer = (SimpleTimer.setInterval)(5, 9999, function(...)
    -- function num : 0_9_2 , upvalues : list, BannerAniTime
    (list.scrollPane):ScrollRight(1, true, BannerAniTime)
  end
)
    end
    ;
    (HomeWindow.InitPageList)()
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (list.scrollPane).currentPageX = BannerIndex - 1
    ;
    (HomeWindow.SetPageShow)()
  end
end

HomeWindow.GetNewlyOpenFunctionBanner = function(...)
  -- function num : 0_10 , upvalues : PossibleBanner, _ENV, BannerListData, uis, BannerTimer, BannerAniTime, HomeWindow, BannerIndex
  local count = #PossibleBanner
  local data = nil
  local index = 1
  repeat
    if #PossibleBanner >= index then
      data = PossibleBanner[index]
      if data.FunctionId ~= nil and (FunctionControlMgr.GetFunctionState)(data.FunctionId) then
        (table.insert)(BannerListData, {Key = data.Key})
        ;
        (table.remove)(PossibleBanner, index)
      else
        index = index + 1
      end
    end
  until false
  ;
  (table.sort)(BannerListData, function(a, b, ...)
    -- function num : 0_10_0 , upvalues : _ENV
    local aConfig = ((TableData.gTable).BaseActivityBannerData)[a.Key]
    local bConfig = ((TableData.gTable).BaseActivityBannerData)[b.Key]
    do return aConfig.sort < bConfig.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.Activity).PicList).numItems = #BannerListData
  if BannerTimer == nil and #BannerListData > 1 then
    BannerTimer = (SimpleTimer.setInterval)(5, 9999, function(...)
    -- function num : 0_10_1 , upvalues : uis, BannerAniTime
    (((uis.Activity).PicList).scrollPane):ScrollRight(1, true, BannerAniTime)
  end
)
  end
  ;
  (HomeWindow.InitPageList)()
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((uis.Activity).PicList).scrollPane).currentPageX = BannerIndex - 1
end

HomeWindow.GetActivityBannerListData = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local tableData = (TableData.gTable).BaseActivityBannerData
  local mTable = {}
  local possible = {}
  local beginTime, endTime = nil, nil
  loge(" LuaTime.GetTimeStamp():" .. (LuaTime.GetTimeStamp)())
  for k,v in pairs(tableData) do
    if v.time_type == 1 then
      if (FunctionControlMgr.GetFunctionState)(v.goto_id) then
        (table.insert)(mTable, {Key = k})
      else
        ;
        (table.insert)(possible, {Key = k, FunctionId = v.goto_id})
      end
    else
      beginTime = tonumber(v.begin_time)
      endTime = tonumber(v.end_time)
      local timeStamp = (LuaTime.GetTimeStamp)()
      if beginTime <= timeStamp and timeStamp <= endTime then
        (table.insert)(mTable, {Key = k, EndTime = endTime})
      else
        if timeStamp < beginTime then
          (table.insert)(possible, {Key = k, BeginTime = beginTime, EndTime = endTime})
        end
      end
    end
  end
  ;
  (table.sort)(mTable, function(a, b, ...)
    -- function num : 0_11_0 , upvalues : _ENV
    local aConfig = ((TableData.gTable).BaseActivityBannerData)[a.Key]
    local bConfig = ((TableData.gTable).BaseActivityBannerData)[b.Key]
    do return aConfig.sort < bConfig.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return mTable, possible
end

HomeWindow.BindingUI = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis
  local winName = (WinResConfig.HomeWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.Home_Character, uis.CardBtn)
  BindingUI(winName, RedDotComID.Home_Talent, uis.TeamBtn)
  BindingUI(winName, RedDotComID.Home_Equip, uis.EquipmentBtn)
  BindingUI(winName, RedDotComID.Home_Adventure, uis.AdventureBtn)
  BindingUI(winName, RedDotComID.Home_Handbook, uis.HandbookBtn)
  BindingUI(winName, RedDotComID.Home_Shop, uis.ShopBtn)
  BindingUI(winName, RedDotComID.Home_Union, uis.GuildBtn)
  BindingUI(winName, RedDotComID.Home_Lottery, uis.LotteryBtn)
  BindingUI(winName, RedDotComID.Home_Task, uis.TaskBtn)
  BindingUI(winName, RedDotComID.Home_Mail, uis.Top_MailBtn)
  BindingUI(winName, RedDotComID.Home_Activity, uis.DailyBtn)
  BindingUI(winName, RedDotComID.Home_SevenTask, uis.CarnivalBtn)
  BindingUI(winName, RedDotComID.Home_Announcement, uis.AnnouncementBtn)
  BindingUI(winName, RedDotComID.Home_bag, uis.Top_BagBtn)
  BindingUI(winName, RedDotComID.Home_Setting, uis.ActorInfoBtn)
  BindingUI(winName, RedDotComID.Home_Friend, uis.FriendBtn)
  BindingUI(winName, RedDotComID.Home_Homeland, uis.FamilyBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

HomeWindow.CheckCardsRedDot = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis
  (CardData.CheckUpAllHeroRedPoint)()
  ;
  ((uis.CardBtn):GetChild("RedDot")).visible = (CardData.CheckUpSixHeroRedPoint)()
end

local texture = nil
HomeWindow.InitBackground = function(onlyBg, ...)
  -- function num : 0_14 , upvalues : _ENV, homeUis, HomeWindow, holder, contentPane, showModel, texture, holderEffectBack, holderEffectFront
  local fashionShow = (ActorData.GetFashionShow)()
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionShow]
  local cg = fashionConfig.show_cg
  local effect = nil
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (homeUis.BackgroundLoader).texture = nil
  ;
  (HomeWindow.ClearAllHolder)()
  if not onlyBg then
    (HomeWindow.RemoveShowModel)()
  end
  if cg and cg ~= "" then
    holder = (LuaEffect.AddNotDeletedUIEffect)(cg, Vector3.zero, 1)
    holder:SetXY(contentPane.width / 2, contentPane.height / 2)
    contentPane:AddChildAt(holder, 0)
    if effect then
      showModel = effect:GetComponentInChildren(typeof(((CS.Spine).Unity).SkeletonAnimation))
    end
  else
    showModel = nil
    local show_background = (ActorData.GetGeneralHomeBg)()
    local bgConfig = ((TableData.gTable).BaseHomeBackgroundData)[show_background]
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R7 in 'UnsetPending'

    if bgConfig and bgConfig ~= "" then
      (homeUis.BackgroundLoader).texture = nil
      local path_ab = bgConfig.path_ab
      if (string.find)((string.lower)(path_ab), "fx_") ~= nil then
        holder = (LuaEffect.AddNotDeletedUIEffect)(path_ab, Vector3.zero, 1)
        holder:SetXY(contentPane.width / 2, contentPane.height / 2)
        contentPane:AddChildAt(holder, 0)
      else
        if texture then
          (ResHelper.UnloadTexture)(texture)
        end
        texture = (ResHelper.LoadTexture)(path_ab)
        if texture ~= nil then
          SetLoaderTexture(homeUis.BackgroundLoader, texture)
        end
      end
      if onlyBg ~= true then
        (HomeWindow.UpdateBg)()
      end
      if bgConfig.effect_back then
        holderEffectBack = (LuaEffect.AddNotDeletedUIEffect)(bgConfig.effect_back, Vector3.zero, 1)
        holderEffectBack:SetXY(contentPane.width / 2, contentPane.height / 2)
        contentPane:AddChildAt(holderEffectBack, contentPane:GetChildIndex(homeUis.ShowLoader))
      end
      if bgConfig.effect_front then
        holderEffectFront = (LuaEffect.AddNotDeletedUIEffect)(bgConfig.effect_front, Vector3.zero, 1)
        holderEffectFront:SetXY(contentPane.width / 2, contentPane.height / 2)
        contentPane:AddChildAt(holderEffectFront, contentPane:GetChildIndex(homeUis.ShowLoader) + 1)
      end
    end
  end
end

HomeWindow.UpdateChooseBgArrow = function(...)
  -- function num : 0_15 , upvalues : uis
  local BackGroundChoice = uis.BackGroundChoice
  local leftArrow = BackGroundChoice.LeftBtn
  local rightArrow = BackGroundChoice.RightBtn
  local bgList = BackGroundChoice.BgList
  if leftArrow and rightArrow then
    if (bgList.scrollPane).contentWidth <= bgList.width then
      leftArrow.visible = false
      rightArrow.visible = false
    else
      local posX = (bgList.scrollPane).posX
      if posX <= 0 then
        leftArrow.visible = false
      else
        leftArrow.visible = true
      end
      if (bgList.scrollPane).contentWidth - bgList.width <= posX then
        rightArrow.visible = false
      else
        rightArrow.visible = true
      end
    end
  end
end

HomeWindow.InitFunctionControl = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  local HomeWindowConfig = WinResConfig.HomeWindow
  RegisterGuideAndControl(ControlID.Home_CharacterBtn, uis.CardBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_TeamBtn, uis.TeamBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_EquipBtn, uis.EquipmentBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_AdventureBtn, uis.AdventureBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_HandbookBtn, uis.HandbookBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_ShopBtn, uis.ShopBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_UnionBtn, uis.GuildBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_LotteryBtn, uis.LotteryBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_TaskBtn, uis.TaskBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_MailBtn, uis.Top_MailBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_BagBtn, uis.Top_BagBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_AssetShopBtn, uis.HeadBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_CarnivalBtn, uis.CarnivalBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_FriendBtn, uis.FriendBtn, HomeWindowConfig.name)
  RegisterGuideAndControl(ControlID.Home_FamilyBtn, uis.FamilyBtn, HomeWindowConfig.name)
end

HomeWindow.InitSend = function(...)
  -- function num : 0_17 , upvalues : popup, _ENV, GmCommand
  popup = UIMgr:CreateObject("Tool", "sendChat")
  if popup then
    popup.draggable = true
    local model = GetTool_sendChatUis(popup)
    do
      ((model.sendBtn).onClick):Set(function(...)
    -- function num : 0_17_0 , upvalues : model, _ENV
    local content = (model.NameInTxt).text
    if (string.find)(content, "gm,") then
      (LoginService.OnReqSendChar)(content)
    else
      if (string.find)(content, "lottery,") then
        ld("Lottery")
        local strs = split(content, ",")
        do
          local id = strs[2]
          local num = strs[3]
          ;
          (SimpleTimer.setInterval)(0.5, num, function(...)
      -- function num : 0_17_0_0 , upvalues : _ENV, id
      (LotteryService.ReqLotteryDraw)(id)
    end
)
        end
      end
    end
  end
)
      ;
      ((model.nextAccountBtn).onClick):Set(function(...)
    -- function num : 0_17_1 , upvalues : model, _ENV
    local content = (model.NameInTxt).text
    local title = (string.sub)(content, 0, 3)
    if title ~= ".gm" then
      (PlayerPrefs.SetString)(PlayerPrefsKeyName.LOGIN_ACCOUNT_SAVE, content)
    end
  end
)
      ;
      ((model.yifaBtn).onClick):Set(function(...)
    -- function num : 0_17_2 , upvalues : _ENV, GmCommand
    local command = split(GmCommand.ALL, ":")
    for _,v in ipairs(command) do
      (LoginService.OnReqSendChar)(v)
    end
    local DebrisStr = ""
    local BasePropData = (TableData.gTable).BasePropData
    for _,v in pairs(BasePropData) do
      if v.type <= PropItemType.UNIVERSAL_DEBRIS and PropItemType.EXP_MEDICINE <= v.type then
        DebrisStr = DebrisStr .. ":" .. "gm,addProp," .. v.id .. ",9999"
      end
    end
    local BaseAssetData = (TableData.gTable).BaseAssetData
    for _,v in pairs(BaseAssetData) do
      DebrisStr = DebrisStr .. ":" .. "gm,addAsset," .. v.id .. ",999999"
    end
    local BaseFurnitureData = (TableData.gTable).BaseFamilyFurnitureData
    for _,v in pairs(BaseFurnitureData) do
      DebrisStr = DebrisStr .. ":" .. "gm,addFurniture," .. v.id .. ",10"
    end
    ;
    (SimpleTimer.setTimeout)(1, function(...)
      -- function num : 0_17_2_0 , upvalues : _ENV, DebrisStr
      (LoginService.OnReqSendChar)(DebrisStr)
    end
)
  end
)
      ;
      ((model.physicalBtn).onClick):Set(function(...)
    -- function num : 0_17_3 , upvalues : _ENV, GmCommand
    (LoginService.OnReqSendChar)(GmCommand.physical)
  end
)
      ;
      ((model.BindBtn).onClick):Set(function(...)
    -- function num : 0_17_4 , upvalues : _ENV, GmCommand
    (LoginService.OnReqSendChar)(GmCommand.bind)
  end
)
      ;
      ((model.moneyBtn).onClick):Set(function(...)
    -- function num : 0_17_5 , upvalues : _ENV, GmCommand
    (LoginService.OnReqSendChar)(GmCommand.gold)
  end
)
      ;
      ((model.uplevelBtn).onClick):Set(function(...)
    -- function num : 0_17_6 , upvalues : _ENV, GmCommand
    (LoginService.OnReqSendChar)(GmCommand.uplevel)
  end
)
      ;
      ((model.diamondBtn).onClick):Set(function(...)
    -- function num : 0_17_7 , upvalues : _ENV, GmCommand
    (LoginService.OnReqSendChar)(GmCommand.diamond)
  end
)
      ;
      ((model.battleTestBtn).onClick):Set(function(...)
    -- function num : 0_17_8 , upvalues : _ENV
    ld("Battle", function(...)
      -- function num : 0_17_8_0 , upvalues : _ENV
      -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

      (package.loaded).BattleTest = nil
      require("BattleTest")
    end
)
  end
)
      ;
      ((model.NamingBtn).onClick):Set(function(...)
    -- function num : 0_17_9 , upvalues : _ENV
    OpenWindow((WinResConfig.NameWindow).name, UILayer.HUD)
  end
)
      ;
      ((model.GetAllCardBtn).onClick):Set(function(...)
    -- function num : 0_17_10 , upvalues : _ENV
    local cardData = (CardData.GetNotObtainedCardList)()
    local str = ""
    for _,v in pairs(cardData) do
      str = str .. ":" .. "gm,addCard," .. v.id
    end
    ;
    (LoginService.OnReqSendChar)(str)
    local DebrisStr = ""
    local BasePropData = (TableData.gTable).BasePropData
    for _,v in pairs(BasePropData) do
      if v.type == PropItemType.CHARACTER_DEBRIS then
        DebrisStr = DebrisStr .. ":" .. "gm,addProp," .. v.id .. ",1000"
      end
    end
    ;
    (LoginService.OnReqSendChar)(DebrisStr)
  end
)
      ;
      ((model.AllCardStageMaxBtn).onClick):Set(function(...)
    -- function num : 0_17_11 , upvalues : _ENV, GmCommand
    (LoginService.OnReqSendChar)(GmCommand.UpStarMax)
  end
)
      ;
      ((model.AllEquipBtn).onClick):Set(function(...)
    -- function num : 0_17_12 , upvalues : _ENV
    local BasePropData = (TableData.gTable).BaseEquipData
    local str = ""
    for _,v in pairs(BasePropData) do
      str = str .. ":" .. "gm,addEquip," .. v.id .. ",10"
    end
    ;
    (LoginService.OnReqSendChar)(str)
  end
)
      ;
      (((model.root):GetChild("closeGuide")).onClick):Set(function(...)
    -- function num : 0_17_13 , upvalues : _ENV
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.GUIDE_OPEN, 0)
  end
)
      ;
      (((model.root):GetChild("OpenGuide")).onClick):Set(function(...)
    -- function num : 0_17_14 , upvalues : _ENV
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.GUIDE_OPEN, 1)
  end
)
      ;
      (((model.root):GetChild("AllSkill")).onClick):Set(function(...)
    -- function num : 0_17_15 , upvalues : _ENV
    (LoginService.OnReqSendChar)("gm,superCard,0,skill")
  end
)
      ;
      (((model.root):GetChild("AllQuality")).onClick):Set(function(...)
    -- function num : 0_17_16 , upvalues : _ENV
    (LoginService.OnReqSendChar)("gm,superCard,0,quality")
  end
)
      ;
      (((model.root):GetChild("AllStar")).onClick):Set(function(...)
    -- function num : 0_17_17 , upvalues : _ENV
    (LoginService.OnReqSendChar)("gm,superCard,0,star")
  end
)
    end
  end
end

HomeWindow.Update = function(...)
  -- function num : 0_18 , upvalues : _ENV, popup, HomeWindow
  if (Application.platform == RuntimePlatform.WindowsEditor or Application.platform == RuntimePlatform.OSXEditor) and (Input.GetKey)(KeyCode.N) and (Input.GetKeyDown)(KeyCode.M) then
    (PlayerPrefs.DeleteAll)()
  end
  if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.X) then
    (GRoot.inst):ShowPopup(popup)
  end
  if (Input.GetKey)(KeyCode.A) and (Input.GetKeyDown)(KeyCode.S) then
    OpenWindow((WinResConfig.FriendsListWindow).name, UILayer.HUD)
  end
  if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.B) then
    ld("Relic", function(...)
    -- function num : 0_18_0 , upvalues : _ENV
    (RelicService.ReqTempleInit)()
  end
)
  end
  if (Input.GetKey)(KeyCode.Q) and (Input.GetKeyDown)(KeyCode.W) then
    OpenWindow((WinResConfig.LotteryIntegralWindow).name, UILayer.HUD)
  end
  if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.C) then
    (ActorService.RegisterMail)(0)
    ;
    (HomeWindow.RefreshActivityBtnVisible)()
  end
  if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.V) then
    ld("Homeland", function(...)
    -- function num : 0_18_1 , upvalues : _ENV
    (HomelandService.ReqInFamily)()
  end
)
  end
  if (Input.GetKey)(KeyCode.A) and (Input.GetKeyDown)(KeyCode.D) then
    ld("Homeland", function(...)
    -- function num : 0_18_2 , upvalues : _ENV
    (HomelandMgr.OpenRoom)()
  end
)
  end
end

HomeWindow.OnClickBag = function(...)
  -- function num : 0_19 , upvalues : _ENV
  ld("Bag", function(...)
    -- function num : 0_19_0 , upvalues : _ENV
    OpenWindow((WinResConfig.BagWindow).name, UILayer.HUD)
    ;
    (RedDotMgr.EliminateRedDot)((WinResConfig.HomeWindow).name, RedDotComID.Home_bag)
  end
)
end

HomeWindow.onClickTask = function(...)
  -- function num : 0_20 , upvalues : _ENV
  if (FunctionControlMgr.GetFunctionState)(ControlID.Task_Daily, false) then
    (TaskService.ReqTaskData)(TaskType.Daily)
  else
    if (FunctionControlMgr.GetFunctionState)(ControlID.Task_GrowUp, false) then
      (TaskService.ReqTaskData)(TaskType.GrowUp)
    else
      if (FunctionControlMgr.GetFunctionState)(ControlID.Task_Week, false) then
        (TaskService.ReqTaskData)(TaskType.Weekly)
      end
    end
  end
end

HomeWindow.onClickMail = function(...)
  -- function num : 0_21 , upvalues : _ENV
  ld("Mail", function(...)
    -- function num : 0_21_0 , upvalues : _ENV
    OpenWindow((WinResConfig.MailWindow).name, UILayer.HUD)
  end
)
end

HomeWindow.onClickHead = function(...)
  -- function num : 0_22 , upvalues : _ENV
  OpenWindow((WinResConfig.ActorInfoWindow).name, UILayer.HUD)
end

HomeWindow.OnClickShop = function(...)
  -- function num : 0_23 , upvalues : _ENV
  ld("Shop", function(...)
    -- function num : 0_23_0 , upvalues : _ENV
    (ShopService.OnReqShopData)()
  end
)
end

HomeWindow.OnClickFriend = function(...)
  -- function num : 0_24 , upvalues : _ENV
  OpenWindow((WinResConfig.FriendsListWindow).name, UILayer.HUD)
end

HomeWindow.ClickPlayerInfoBtn = function(...)
  -- function num : 0_25 , upvalues : _ENV
  OpenWindow((WinResConfig.ActorInfoWindow).name, UILayer.HUD)
end

HomeWindow.ClickHomelandBtn = function(...)
  -- function num : 0_26 , upvalues : _ENV
  ld("Homeland", function(...)
    -- function num : 0_26_0 , upvalues : _ENV
    (HomelandService.ReqInFamily)()
  end
)
end

HomeWindow.ClickAnnouncementBtn = function(...)
  -- function num : 0_27 , upvalues : _ENV
  (AnnouncementMgr.OpenAnnouncement)()
end

HomeWindow.onClickAdventureBtn = function(...)
  -- function num : 0_28 , upvalues : _ENV
  (Util.SetDelayCall)(function(...)
    -- function num : 0_28_0 , upvalues : _ENV
    OpenWindow((WinResConfig.AdventureWindow).name, UILayer.HUD)
  end
)
end

HomeWindow.onClickTeamBtn = function(...)
  -- function num : 0_29 , upvalues : _ENV
  ld("Talent", function(...)
    -- function num : 0_29_0 , upvalues : _ENV
    (Util.SetDelayCall)(function(...)
      -- function num : 0_29_0_0 , upvalues : _ENV
      OpenWindow((WinResConfig.TalentMainWindow).name, UILayer.HUD)
    end
)
  end
)
end

HomeWindow.onClickGuildBtn = function(...)
  -- function num : 0_30 , upvalues : _ENV
  ld("Guild", function(...)
    -- function num : 0_30_0 , upvalues : _ENV
    (GuildMgr.OpenGuild)()
  end
)
end

HomeWindow.onClickActivityBtn = function(...)
  -- function num : 0_31 , upvalues : _ENV
  (ActivityMgr.OnClickHomeActivityBtn)((WindowMsgEnum.ActivityMainWindow).SING_INIT)
end

HomeWindow.onClickCardBtn = function(...)
  -- function num : 0_32 , upvalues : _ENV
  print("open the CardListWindow")
  ld("Card", function(...)
    -- function num : 0_32_0 , upvalues : _ENV
    (Util.SetDelayCall)(function(...)
      -- function num : 0_32_0_0 , upvalues : _ENV
      OpenWindow("CardListWindow", UILayer.HUD)
    end
)
  end
)
end

HomeWindow.onClickEquipmentBtn = function(...)
  -- function num : 0_33 , upvalues : _ENV
  ld("Equipt", function(...)
    -- function num : 0_33_0 , upvalues : _ENV
    (Util.SetDelayCall)(function(...)
      -- function num : 0_33_0_0 , upvalues : _ENV
      (EquiptMgr.OpenEquipmentWindow)()
    end
)
  end
)
end

HomeWindow.onClickHandbookBtn = function(...)
  -- function num : 0_34 , upvalues : _ENV
  ld("HandBook", function(...)
    -- function num : 0_34_0 , upvalues : _ENV
    OpenWindow((WinResConfig.HandBookMainWindow).name, UILayer.HUD)
  end
)
end

HomeWindow.onClickLotteryBtn = function(...)
  -- function num : 0_35 , upvalues : _ENV
  ld("Lottery", function(...)
    -- function num : 0_35_0 , upvalues : _ENV
    (Util.SetDelayCall)(function(...)
      -- function num : 0_35_0_0 , upvalues : _ENV
      (ActorService.ReqActivityLottery)()
    end
)
  end
)
end

HomeWindow.UpdateActor = function(...)
  -- function num : 0_36 , upvalues : HomeWindow
  (HomeWindow.UpdateActorLvAndPower)()
  ;
  (HomeWindow.UpdateActorMoney)()
end

HomeWindow.UpdateBg = function(...)
  -- function num : 0_37 , upvalues : HomeWindow, _ENV, homeUis
  (HomeWindow.RemoveShowModel)()
  local isStatic = (Util.GetPlayerSetting)(PlayerPrefsKeyName.MAIN_SHOW_STATIC, "0")
  print("===============isStatic", isStatic)
  if isStatic == "0" then
    (Util.CreateSelfShowModel)(homeUis.ShowLoader, true)
  else
    local fashionShow = (ActorData.GetFashionShow)()
    local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionShow]
    local t_Object = (Util.ShowUIModel)(fashionConfig.show_texture, homeUis.ShowLoader)
    ;
    (Util.UpdateShowTextureByConfig)(t_Object, fashionConfig)
  end
end

HomeWindow.RemoveShowModel = function(...)
  -- function num : 0_38 , upvalues : _ENV, homeUis
  (Util.RecycleUIModel)(homeUis.ShowLoader)
end

HomeWindow.UpdateActorLvAndPower = function(...)
  -- function num : 0_39 , upvalues : uis, _ENV
  local levelTxt = (uis.HeadGrp).LevelTxt
  local fcTxt = (uis.HeadGrp).FcTxt
  local fcWordTxt = (uis.HeadGrp).FcWordTxt
  local ExpProgressBar = (uis.HeadGrp).ExpProgressBar
  fcWordTxt.text = (PUtil.get)(60000235)
  local actorLevel = (ActorData.GetLevel)()
  local fc = (ActorData.GetFc)()
  local curExp = (ActorData.GetExp)()
  local nextExp = (ActorData.GetNextExp)()
  if nextExp then
    if nextExp <= curExp then
      ChangeUIController(ExpProgressBar, "c1", 1)
    end
    ExpProgressBar.value = 100 * curExp / nextExp
  end
  levelTxt.text = actorLevel
  fcTxt.text = fc
end

HomeWindow.UpdateActorMoney = function(...)
  -- function num : 0_40 , upvalues : uis, _ENV, assetType
  local diamondTxt = ((uis.HeadGrp).Diamonds).IconTxt
  local goldTxt = ((uis.HeadGrp).Gold).IconTxt
  local PhysicalTxt = ((uis.HeadGrp).Power).IconTxt
  diamondTxt.text = GetFormatedCount((ActorData.GetAssetCount)(assetType.DIAMOND) + (ActorData.GetAssetCount)(assetType.DIAMOND_BIND))
  goldTxt.text = (ActorData.GetAssetText)(assetType.GOLD)
  PhysicalTxt.text = (ActorData.GetSpecifyFormatText)(AssetType.PHYSICAL)
end

HomeWindow.OnBgScrollView = function(...)
  -- function num : 0_41 , upvalues : HomeWindow
  (HomeWindow.UpdateChooseBgArrow)()
end

local bgTable = {}
HomeWindow.UpdateSelectBgPanel = function(refresh, ...)
  -- function num : 0_42 , upvalues : uis, HomeWindow, bgTable, _ENV
  if refresh ~= true then
    local TouchScreenBtn = (uis.BackGroundChoice).TouchScreenBtn
    if TouchScreenBtn then
      (TouchScreenBtn.onClick):Set(HomeWindow.TouchBgScreen)
    end
    bgTable = {}
    local bgList = (uis.BackGroundChoice).BgList
    ;
    ((bgList.scrollPane).onScroll):Set(HomeWindow.OnBgScrollView)
    bgList:RemoveChildrenToPool()
    local backgroundConfig = (TableData.gTable).BaseHomeBackgroundData
    local configTable = {}
    for _,config in pairs(backgroundConfig) do
      if config.is_open == 1 then
        local serverTime = (LuaTime.GetTimeStamp)()
        local beginTime = config.begin_time
        local endTime = config.end_time
        -- DECOMPILER ERROR at PC49: Unhandled construct in 'MakeBoolean' P1

        if beginTime ~= nil and endTime ~= nil and beginTime <= serverTime and serverTime <= endTime then
          (table.insert)(configTable, config)
        end
      end
      ;
      (table.insert)(configTable, config)
    end
    ;
    (table.sort)(configTable, function(a, b, ...)
    -- function num : 0_42_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    local selectIndex = nil
    for i,config in ipairs(configTable) do
      local oneBg = bgList:AddItemFromPool()
      ;
      (table.insert)(bgTable, {id = config.id, bg = oneBg})
      ;
      (HomeWindow.UpdateOneBg)(oneBg, config)
      local curSelect = (ActorData.GetGeneralHomeBg)()
      if curSelect == config.id then
        selectIndex = i
      end
    end
    if selectIndex then
      bgList:ScrollToView(selectIndex - 1)
    end
  else
    do
      for _,info in ipairs(bgTable) do
        local config = ((TableData.gTable).BaseHomeBackgroundData)[info.id]
        ;
        (HomeWindow.UpdateOneBg)(info.bg, config)
      end
    end
  end
end

HomeWindow.TouchBgScreen = function(...)
  -- function num : 0_43 , upvalues : uis, _ENV, HomeWindow
  local TouchScreenBtn = (uis.BackGroundChoice).TouchScreenBtn
  if TouchScreenBtn then
    (TouchScreenBtn.onClick):Clear()
  end
  local panel = (uis.BackGroundChoice).root
  if panel then
    PlayUITrans(panel, "in", function(...)
    -- function num : 0_43_0 , upvalues : TouchScreenBtn, HomeWindow
    if TouchScreenBtn then
      (TouchScreenBtn.onClick):Set(HomeWindow.TouchScreenBtnReverse)
    end
  end
, nil, nil, nil, nil, nil, true)
  end
end

HomeWindow.TouchScreenBtnReverse = function(...)
  -- function num : 0_44 , upvalues : uis, _ENV, HomeWindow
  local TouchScreenBtn = (uis.BackGroundChoice).TouchScreenBtn
  if TouchScreenBtn then
    (TouchScreenBtn.onClick):Clear()
  end
  local panel = (uis.BackGroundChoice).root
  if panel then
    PlayUITrans(panel, "in", function(...)
    -- function num : 0_44_0 , upvalues : TouchScreenBtn, HomeWindow
    if TouchScreenBtn then
      (TouchScreenBtn.onClick):Set(HomeWindow.TouchBgScreen)
    end
  end
)
  end
end

HomeWindow.UpdateOneBg = function(hand, config, ...)
  -- function num : 0_45 , upvalues : _ENV, HomeWindow
  if hand and config then
    (hand:GetChild("PictureLoader")).url = (Util.GetItemUrl)(config.path_ui)
    local curSelect = (ActorData.GetGeneralHomeBg)()
    do
      local isSelect = curSelect == config.id
      local isGet = true
      if isSelect == true then
        ChangeUIController(hand, "c2", 0)
        ChangeUIController(hand, "c1", 0)
      else
        ChangeUIController(hand, "c2", 1)
        if isGet == true then
          ChangeUIController(hand, "c1", 1)
        else
          ChangeUIController(hand, "c1", 2)
        end
      end
      ;
      (hand.onClick):Set(function(...)
    -- function num : 0_45_0 , upvalues : isSelect, isGet, _ENV, config, HomeWindow
    if isSelect ~= true and isGet == true then
      local lastBgId = (ActorData.GetGeneralHomeBg)()
      ;
      (ActorData.SetLastHomeBg)(lastBgId)
      ;
      (ActorData.SetGeneralHomeBg)(config.id)
      ;
      (HomeWindow.UpdateSelectBgPanel)(true)
      ;
      (HomeWindow.InitBackground)(true)
    end
  end
)
    end
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

HomeWindow.FirstLoginVoiceAndBubble = function(...)
  -- function num : 0_46 , upvalues : _ENV, fashionID, homeUis
  local recordFirstLogin = (AudioManager.GetRecordFirstLogin)()
  if recordFirstLogin then
    return 
  end
  fashionID = (ActorData.GetFashionShow)()
  ;
  (AudioManager.PlayBubbleAndVoice)(true, true, fashionID, CVAudioType.LoginBubble, homeUis.ShowLoader, homeUis, nil, nil, nil, false)
  ;
  (AudioManager.RecordFirstLogin)()
end

HomeWindow.AutoPlayVoiceAndBubble = function(...)
  -- function num : 0_47 , upvalues : _ENV, fashionID, cvVoiceTimer, AUTOCVTIME, homeUis
  loge("***********开启一个循环定时器 用于定时随机播放语音和气泡")
  fashionID = (ActorData.GetFashionShow)()
  cvVoiceTimer = (SimpleTimer.setInterval)(AUTOCVTIME, -1, function(...)
    -- function num : 0_47_0 , upvalues : _ENV, fashionID, homeUis
    (AudioManager.PlayBubbleAndVoice)(true, true, fashionID, CVAudioType.HomeIdleBubble, homeUis.ShowLoader, homeUis, false, true, nil, false)
  end
)
end

HomeWindow.onClickShowLoader = function(...)
  -- function num : 0_48 , upvalues : fashionID, _ENV, homeUis
  fashionID = (ActorData.GetFashionShow)()
  ;
  (AudioManager.PlayBubbleAndVoice)(true, true, fashionID, CVAudioType.HomeIdleBubble, homeUis.ShowLoader, homeUis, false, true, nil, false)
end

HomeWindow.onClickTouchScreenBtn = function(...)
  -- function num : 0_49 , upvalues : _ENV, uis
  PlayUITrans(uis.root, "in")
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TouchScreenBtn).visible = false
end

HomeWindow.onClickHideBtn = function(...)
  -- function num : 0_50 , upvalues : _ENV, uis
  PlayUITrans(uis.root, "hide")
end

HomeWindow.onClickBackgroundBtn = function(...)
  -- function num : 0_51 , upvalues : _ENV, uis, HomeWindow
  ChangeController(uis.c1Ctr, 1)
  ;
  (HomeWindow.UpdateSelectBgPanel)()
  ;
  (HomeWindow.UpdateChooseBgArrow)()
end

HomeWindow.onClickCloseBackgroundBtn = function(...)
  -- function num : 0_52 , upvalues : _ENV, uis
  ChangeController(uis.c1Ctr, 0)
end

HomeWindow.OnShown = function(...)
  -- function num : 0_53 , upvalues : _ENV, uis
  (GuideMgr.CheckIsTriggerGuide)((WinResConfig.HomeWindow).name)
  ;
  (GuideMgr.MildGuideTrigger)((WinResConfig.HomeWindow).name)
  local Bind_num = (ActorData.GetAssetCount)(AssetType.DIAMOND_BIND)
  local num = (ActorData.GetAssetCount)(AssetType.DIAMOND)
  local type = AssetType.DIAMOND_BIND
  local data = ((TableData.gTable).BaseAssetData)[tonumber(type)]
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((uis.HeadGrp).Diamonds).IconLoader).url = (Util.GetItemUrl)(data.icon)
  local dataGold = ((TableData.gTable).BaseAssetData)[tonumber(AssetType.GOLD)]
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((uis.HeadGrp).Gold).IconLoader).url = (Util.GetItemUrl)(dataGold.icon)
  local dataPower = ((TableData.gTable).BaseAssetData)[tonumber(AssetType.PHYSICAL)]
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((uis.HeadGrp).Power).IconLoader).url = (Util.GetItemUrl)(dataPower.icon)
  local TenNum = (ActorData.GetNoviceLotteryTenNum)()
  local actorLv = (ActorData.GetLevel)()
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((uis.LotteryTips).root).touchable = false
  -- DECOMPILER ERROR at PC95: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((uis.LotteryTips).root).visible = (TenNum > 0 and actorLv > 3 and (ActivityMgr.GetActivityIsOpen)((ActivityMgr.ActivityType).Newbie_Lottery))
  ;
  (SimpleTimer.setTimeout)(0.3, function(...)
    -- function num : 0_53_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    if not (GuideMgr.IsInMainGuide)() and not (FunctionControlMgr.IsPrepareFunctionOpenWindow)() then
      if AnnouncementData.AutoShowAnnouncement then
        AnnouncementData.AutoShowAnnouncement = false
        ;
        (AnnouncementMgr.OpenAnnouncement)()
      else
        ;
        (ActivityMgr.CheckPopupAfterAnnounceActivity)()
      end
    end
  end
)
  ;
  (MessageMgr.OnRegisterBackWinFunc)((WinResConfig.HomeWindow).name, function(...)
    -- function num : 0_53_1 , upvalues : uis, _ENV
    if (uis.c1Ctr).selectedIndex == 1 then
      (SimpleTimer.setTimeout)(0.01, function(...)
      -- function num : 0_53_1_0 , upvalues : uis
      (uis.c1Ctr):SetSelectedIndex(0)
    end
)
    else
      ;
      (MessageMgr.OpenConfirmWindow)((PUtil.get)(20000521), function(...)
      -- function num : 0_53_1_1 , upvalues : _ENV
      (Application.Quit)()
    end
, nil, nil, nil, nil, nil, UILayer.HUD1)
    end
  end
)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

HomeWindow.OnHide = function(...)
  -- function num : 0_54
end

HomeWindow.ClearAllHolder = function(...)
  -- function num : 0_55 , upvalues : holder, _ENV, holderEffectBack, holderEffectFront
  if holder then
    (LuaEffect.DestroyEffect)(holder)
    holder = nil
  end
  if holderEffectBack then
    (LuaEffect.DestroyEffect)(holderEffectBack)
    holderEffectBack = nil
  end
  if holderEffectFront then
    (LuaEffect.DestroyEffect)(holderEffectFront)
    holderEffectFront = nil
  end
end

HomeWindow.OnClose = function(...)
  -- function num : 0_56 , upvalues : texture, _ENV, _timers, showModel, HomeWindow, bgTable, uis, popup, homeUis, contentPane, cvVoiceTimer, BannerTimer, ActivityTimer
  if texture then
    (ResHelper.UnloadTexture)(texture)
    texture = nil
  end
  for k,v in pairs(_timers) do
    v:stop()
  end
  if showModel then
    (SkeletonAnimationUtil.RemoveExpression)(showModel.gameObject)
  end
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.HomeWindow).name)
  ;
  (HomeWindow.ClearAllHolder)()
  bgTable = {}
  local bgList = (uis.BackGroundChoice).BgList
  if bgList then
    (bgList.itemPool):Clear()
  end
  ;
  (RedDotMgr.RemoveUIRefer)((WinResConfig.HomeWindow).name)
  ;
  (HomeWindow.RemoveShowModel)()
  ;
  (UpdateMgr.RemoveUpdateHandler)(HomeWindow.Update)
  if popup then
    popup:Dispose()
    popup = nil
  end
  homeUis = nil
  uis = nil
  contentPane = nil
  showModel = nil
  if cvVoiceTimer ~= nil then
    cvVoiceTimer:stop()
    cvVoiceTimer = nil
  end
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
  if BannerTimer ~= nil then
    BannerTimer:_destroy()
    BannerTimer = nil
  end
  if ActivityTimer ~= nil then
    ActivityTimer:_destroy()
    ActivityTimer = nil
  end
end

HomeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_57 , upvalues : _ENV, HomeWindow, playWelcome, uis
  if msgId == (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_ACTOR_INFO then
    (HomeWindow.UpdateActor)()
  else
    if msgId == (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_ACTIVITY_VISIBLE then
      (HomeWindow.RefreshActivityBtnVisible)()
    else
      if msgId == (WindowMsgEnum.HomeWindow).E_MSG_RESET_TASK_SPINE then
        playWelcome = true
      else
        if msgId == (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_BG then
          (HomeWindow.InitBackground)()
        else
          if msgId == (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_BANNER then
            (HomeWindow.GetNewlyOpenFunctionBanner)()
          else
            if msgId == (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_BANNER_REDDOT then
              ((uis.Activity).PicList):RefreshVirtualList()
            end
          end
        end
      end
    end
  end
  if msgId == (WindowMsgEnum.CardWindow).E_MSG_CARD_SETMAINFASHION then
    (HomeWindow.AutoPlayVoiceAndBubble)()
  end
end

HomeWindow.CheckActivityIcon = function(...)
  -- function num : 0_58 , upvalues : _ENV, uis, ActivityTimer, HomeWindow
  local serverTime = (LuaTime.GetTimeStamp)()
  local selectedIndex = 0
  local timeMinus = 0
  for key,value in pairs((TableData.gTable).BaseHomeActivityData) do
    local beginTime = value.begin_time
    local endTime = value.end_time
    if beginTime <= serverTime and serverTime <= endTime then
      selectedIndex = value.type
      timeMinus = endTime - serverTime
      break
    end
  end
  do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.HeadGrp).ClothesCtr).selectedIndex = selectedIndex
    ;
    (((uis.BtnPanel).HideBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    (((uis.BtnPanel).BackGroundBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((((uis.BtnPanel).root):GetChild("n3")):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.CardBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.TeamBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.EquipmentBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.AdventureBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.ShopBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.LotteryBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.TaskBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.HandbookBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.FriendBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.FamilyBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.GuildBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.Top_BagBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.DailyBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.Top_MailBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.AnnouncementBtn):GetController("Clothes")).selectedIndex = selectedIndex
    ;
    ((uis.ActorInfoBtn):GetController("Clothes")).selectedIndex = selectedIndex
    -- DECOMPILER ERROR at PC128: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.Activity).ClothesCtr).selectedIndex = selectedIndex
    if selectedIndex == 0 then
      local curBgId = (ActorData.GetGeneralHomeBg)()
      local curBgData = ((TableData.gTable).BaseHomeBackgroundData)[curBgId]
      if curBgData.begin_time ~= nil then
        local lastBgId = (ActorData.GetLastHomeBg)()
        ;
        (ActorData.SetGeneralHomeBg)(lastBgId)
      end
    else
      do
        if ActivityTimer ~= nil then
          ActivityTimer:_destroy()
          ActivityTimer = nil
        end
        ActivityTimer = (SimpleTimer.setTimeout)(timeMinus, function(...)
    -- function num : 0_58_0 , upvalues : _ENV, HomeWindow
    local curBgId = (ActorData.GetGeneralHomeBg)()
    local curBgData = ((TableData.gTable).BaseHomeBackgroundData)[curBgId]
    if curBgData.begin_time ~= nil then
      local lastBgId = (ActorData.GetLastHomeBg)()
      ;
      (ActorData.SetGeneralHomeBg)(lastBgId)
      ;
      (HomeWindow.InitBackground)()
    end
  end
)
      end
    end
  end
end

return HomeWindow

