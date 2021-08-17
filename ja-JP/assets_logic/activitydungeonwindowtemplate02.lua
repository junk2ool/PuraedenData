-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_BattleMainByName")
local ActivityDungeonWindow = extends(require("ActivityDungeonWindowBase"))
local this = ActivityDungeonWindow
local base = this.__base
local components, mask, book, bookBg, decorate, pageBtns, pageLines, defaultStage, adventureBtns, defaultOffset, bossId, bossModel, assistTimer, updateTimer, countdownTimer = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
local dungeonInit = false
local openFromClose = false
local challengeBoss = false
local BOOK, BOOK_BG = "ui_tushuguan_shu", "ui_tushuguan_bg"
local BEGIN_ANIM, IDLE_ANIM, IDLE2_ANIM, PAGE_UP, PAGE_DOWN = "begin", "idle", "idle2", "up", "down"
local PageType = {MainDungeon = 1, Exploration = 2, BossFight = 3}
local StageData = (TableData.gTable).BaseStageData
local RiskStageData = (TableData.gTable).BaseActivityRiskStageData
local RiskEventData = (TableData.gTable).BaseActivityRiskEventData
local currentExplorationId = nil
local pageIndex = 1
ActivityDungeonWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : base, openFromClose, components, _ENV, this
  (base.OnInit)(bridgeObj)
  openFromClose = bridgeObj.OpenFromClose
  components = GetActivityDungeonTwo_BattleMainUis((this.GetContentPane)())
  ;
  (this.InitComponents)()
  ;
  (this.InitAssetStrip)({}, components.AssetStrip)
  ;
  (this.BindingUI)()
  ;
  (ActivityDungeonService.ReqRiskDataInit)()
  ;
  (ActivityDungeonService.ReqAssistFightInit)()
end

ActivityDungeonWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : base, openFromClose, challengeBoss, this, PageType, components
  (base.OnShown)()
  if openFromClose and not challengeBoss then
    (this.ClickPageBtn)(PageType.MainDungeon)
    ;
    (this.PlayBookStill)()
  else
    if openFromClose and challengeBoss then
      challengeBoss = false
      ;
      (this.ClickPageBtn)(PageType.BossFight)
      ;
      (this.PlayBookOpen)(function(...)
    -- function num : 0_1_0 , upvalues : components
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((components.LabelList).root).visible = false
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((components.AssistBattleMain).BattleTips).root).visible = false
  end
, function(...)
    -- function num : 0_1_1 , upvalues : components
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((components.LabelList).root).visible = true
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((components.AssistBattleMain).BattleTips).root).visible = true
  end
)
    else
      ;
      (this.ClickPageBtn)(PageType.MainDungeon)
      ;
      (this.PlayBookOpen)(function(...)
    -- function num : 0_1_2 , upvalues : components
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((components.PlotMain).root).visible = false
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((components.LabelList).root).visible = false
  end
, function(...)
    -- function num : 0_1_3 , upvalues : components
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((components.PlotMain).root).visible = true
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((components.LabelList).root).visible = true
  end
)
    end
  end
end

ActivityDungeonWindow.OnClose = function(...)
  -- function num : 0_2 , upvalues : book, _ENV, bookBg, bossModel, bossId, updateTimer, this, components, dungeonInit, base
  if book then
    (ResHelper.DestroyGameObject)(book, false)
    book = nil
  end
  if bookBg then
    (ResHelper.DestroyGameObject)(bookBg, false)
    bookBg = nil
  end
  if bossModel then
    (ResHelper.DestroyGameObject)(bossModel, false)
    bossModel = nil
  end
  bossId = nil
  if updateTimer then
    updateTimer:stop()
    updateTimer = nil
  end
  ;
  (this.ClearCountdownTimer)()
  components = nil
  dungeonInit = false
  ;
  (base.OnClose)()
end

ActivityDungeonWindow.BindingUI = function(...)
  -- function num : 0_3 , upvalues : this, _ENV, components, pageBtns, PageType
  local winName = ((this.GetWindowConfig)()).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  local battleMain = components.AssistBattleMain
  BindingUI(winName, RedDotComID.NAD_Exploration, pageBtns[PageType.Exploration])
  BindingUI(winName, RedDotComID.NAD_BossFight, pageBtns[PageType.BossFight])
  BindingUI(winName, RedDotComID.NAD_Reward, battleMain.BattleRewardBtn)
  BindingUI(winName, RedDotComID.NAD_GuildHelp, battleMain.BattleHelpBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

ActivityDungeonWindow.InitComponents = function(...)
  -- function num : 0_4 , upvalues : mask, _ENV, components, decorate, pageBtns, pageLines, adventureBtns, RiskStageData, defaultStage, PageType, this, pageIndex
  mask = (FairyUIUtils.FindImage)((components.AssistBattleMain).root, "n1")
  decorate = (FairyUIUtils.FindImage)((components.PlotMain).root, "n11")
  local labelList = (components.LabelList).LabelButtonList
  labelList:RemoveChildrenToPool()
  pageBtns = {}
  pageLines = {}
  adventureBtns = {}
  local package = (WinResConfig.NewActivityDungeonMainWindow).package
  local labelLine = "LabelLine"
  local line = labelList:AddItemFromPool((UIPackage.GetItemURL)(package, labelLine))
  ;
  (table.insert)(pageLines, line)
  local btn = labelList:AddItemFromPool((UIPackage.GetItemURL)(package, "LabelABtn"))
  ;
  (table.insert)(pageBtns, btn)
  line = labelList:AddItemFromPool((UIPackage.GetItemURL)(package, labelLine))
  ;
  (table.insert)(pageLines, line)
  btn = labelList:AddItemFromPool((UIPackage.GetItemURL)(package, "LabelBBtn"))
  ;
  (table.insert)(pageBtns, btn)
  line = labelList:AddItemFromPool((UIPackage.GetItemURL)(package, labelLine))
  ;
  (table.insert)(pageLines, line)
  btn = labelList:AddItemFromPool((UIPackage.GetItemURL)(package, "LabelCBtn"))
  ;
  (table.insert)(pageBtns, btn)
  line = labelList:AddItemFromPool((UIPackage.GetItemURL)(package, labelLine))
  ;
  (table.insert)(pageLines, line)
  local btns = {}
  ;
  (table.insert)(btns, (components.ExploreMain).ABtn)
  ;
  (table.insert)(btns, (components.ExploreMain).BBtn)
  ;
  (table.insert)(btns, (components.ExploreMain).CBtn)
  local index = 1
  for k,v in pairs(RiskStageData) do
    if index == 1 then
      defaultStage = k
    end
    adventureBtns[k] = btns[index]
    index = index + 1
  end
  local exploreMain = components.ExploreMain
  -- DECOMPILER ERROR at PC156: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((exploreMain.RewardShow).ImportantTxt).text = (PUtil.get)(60000619)
  -- DECOMPILER ERROR at PC163: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((exploreMain.RewardShow).ImportantTxt).text = (PUtil.get)(60000620)
  ;
  ((pageBtns[PageType.MainDungeon]).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : this, PageType
    (this.ClickPageBtn)(PageType.MainDungeon)
  end
)
  ;
  ((pageBtns[PageType.Exploration]).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : this, PageType
    (this.ClickPageBtn)(PageType.Exploration)
  end
)
  ;
  ((pageBtns[PageType.BossFight]).onClick):Set(function(...)
    -- function num : 0_4_2 , upvalues : this, PageType
    (this.ClickPageBtn)(PageType.BossFight)
  end
)
  local exploreSpend = exploreMain.Spend
  ;
  ((exploreSpend.AddBtn).onClick):Set(this.ClickAddBtn)
  ;
  ((exploreSpend.MaxBtn).onClick):Set(this.ClickMaxBtn)
  ;
  ((exploreSpend.ReduceBtn).onClick):Set(this.ClickMinusBtn)
  local assistBattleMain = components.AssistBattleMain
  ;
  ((assistBattleMain.BattleHelpBtn).onClick):Set(this.ClickGuildAssistBtn)
  ;
  ((assistBattleMain.BattleRewardBtn).onClick):Set(this.ClickRewardShowBtn)
  ;
  (((assistBattleMain.BattleTips).BattleBossBtn).onClick):Set(this.ClickChallengeBtn)
  local plotMain = components.PlotMain
  ;
  ((plotMain.LeftBtn).onClick):Set(function(...)
    -- function num : 0_4_3 , upvalues : pageIndex, this
    local index = pageIndex - 1
    ;
    (this.RefreshDungeonInfo)(index, true)
  end
)
  ;
  ((plotMain.RightBtn).onClick):Set(function(...)
    -- function num : 0_4_4 , upvalues : pageIndex, this
    local index = pageIndex + 1
    if (this.CanTurnToPage)(index) then
      (this.RefreshDungeonInfo)(index, false)
    end
  end
)
  ;
  (exploreMain.ExplainWordList):SetVirtual()
  ;
  ((exploreMain.RewardShow).ImportantList):SetVirtual()
end

ActivityDungeonWindow.CanTurnToPage = function(pageIndex, ...)
  -- function num : 0_5 , upvalues : _ENV
  local result, chapterData = (ActivityDungeonData.TryGetChapterDataByIndex)(pageIndex)
  if result then
    local chapterStageInfos = (ActivityDungeonData.GetAllChapterStageInfos)()
    local chapterStageInfo = chapterStageInfos[chapterData.id]
    local stageId = tonumber(((chapterStageInfo.normal).stages)[1])
    local status = (PlotDungeonMgr.GetDungeonStatus)(stageId)
    if status == StageStatus.Unlock and not (PlotDungeonMgr.IsCanChallenge)(stageId, false) then
      status = StageStatus.Lock
    end
    if status == StageStatus.Lock then
      local config = ((TableData.gTable).BaseStageData)[stageId]
      local preConfig = ((TableData.gTable).BaseStageData)[config.pre]
      if config.openSec ~= 0 then
        if (PlotDungeonMgr.IsPassDungeon)(config.pre) then
          local time = (math.floor)((ActivityDungeonData.GetCurrentActivityBeginTime)() * 0.001) + config.openSec
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(60000651, (LuaTime.GetLeftTimeStr)(time, true)))
        else
          do
            do
              do
                ;
                (MessageMgr.SendCenterTips)((PUtil.get)(20000058, preConfig.name))
                ;
                (MessageMgr.SendCenterTips)((PUtil.get)(20000058, preConfig.name))
                do return false end
                do return true end
                return false
              end
            end
          end
        end
      end
    end
  end
end

local GetOrCreateBook = function(...)
  -- function num : 0_6 , upvalues : book, _ENV, BOOK, components
  do
    if book == nil then
      local holder, model = (Util.AddUIModel)(BOOK, 100)
      ;
      (components.root):AddChildAt(holder, 1)
      holder:SetXY((components.root).width * 0.5, (components.root).height * 0.5)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (model.transform).localScale = Vector3.one * 100
      book = model
    end
    return book
  end
end

local GetOrCreateBookBg = function(...)
  -- function num : 0_7 , upvalues : bookBg, _ENV, BOOK_BG, components
  do
    if bookBg == nil then
      local holder, model = (Util.AddUIModel)(BOOK_BG, 100)
      ;
      (components.root):AddChildAt(holder, 1)
      holder:SetXY((components.root).width * 0.5, (components.root).height * 0.5)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (model.transform).localScale = Vector3.one * 100
      bookBg = model
    end
    return bookBg
  end
end

ActivityDungeonWindow.PlayBookStill = function(...)
  -- function num : 0_8 , upvalues : GetOrCreateBook, _ENV, IDLE_ANIM, GetOrCreateBookBg, components
  local book = GetOrCreateBook()
  ;
  (SkeletonAnimationUtil.SetAnimation)(book, 0, IDLE_ANIM, false)
  local bookBg = GetOrCreateBookBg()
  ;
  (SkeletonAnimationUtil.SetAnimation)(bookBg, 0, IDLE_ANIM, false)
  local sa = book:GetComponent(typeof(((CS.Spine).Unity).SkeletonAnimation))
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (sa.skeleton).A = 0
  ;
  (((LeanTween.value)(0, 1, 2)):setOnUpdate(function(value, ...)
    -- function num : 0_8_0 , upvalues : sa
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

    (sa.skeleton).A = value
  end
)):setDelay(0.5)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((components.LabelList).root).visible = true
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((components.PlotMain).root).visible = true
end

ActivityDungeonWindow.PlayBookOpen = function(beforeCallback, afterCallback, ...)
  -- function num : 0_9 , upvalues : GetOrCreateBook, _ENV, BEGIN_ANIM, IDLE_ANIM, GetOrCreateBookBg
  local book = GetOrCreateBook()
  ;
  (SkeletonAnimationUtil.SetAnimation)(book, 0, BEGIN_ANIM, false, function(...)
    -- function num : 0_9_0 , upvalues : _ENV, book, IDLE_ANIM
    (SkeletonAnimationUtil.SetAnimation)(book, 0, IDLE_ANIM, true)
  end
)
  if beforeCallback then
    beforeCallback()
  end
  local bookBg = GetOrCreateBookBg()
  ;
  (SkeletonAnimationUtil.SetAnimation)(bookBg, 0, BEGIN_ANIM, false, function(...)
    -- function num : 0_9_1 , upvalues : afterCallback, _ENV, bookBg, IDLE_ANIM
    if afterCallback then
      afterCallback()
    end
    ;
    (SkeletonAnimationUtil.SetAnimation)(bookBg, 0, IDLE_ANIM, true)
  end
)
end

ActivityDungeonWindow.InitExplorationInfo = function(...)
  -- function num : 0_10 , upvalues : this, currentExplorationId
  (this.InitExplorationBasicInfo)()
  ;
  (this.RefreshExplorationStatus)()
  ;
  (this.RefreshExplorationDetail)(currentExplorationId)
end

ActivityDungeonWindow.InitExplorationBasicInfo = function(...)
  -- function num : 0_11 , upvalues : _ENV, RiskStageData, adventureBtns, this
  for k,v in pairs(RiskStageData) do
    if adventureBtns[k] then
      local config = v
      do
        ((adventureBtns[k]):GetChild("ExploreNameTxt")).text = config.name
        if (Util.StringIsNullOrEmpty)(config.icon) == false then
          ((adventureBtns[k]):GetChild("PicLoader")).url = (Util.GetItemUrl)(config.icon)
        end
        ;
        ((adventureBtns[k]).onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : this, config
    (this.RefreshExplorationDetail)(config.id, true)
  end
)
      end
    end
  end
end

ActivityDungeonWindow.InitDungeonInfo = function(...)
  -- function num : 0_12 , upvalues : _ENV, this
  local chapterIndex, stageIndex = (ActivityDungeonData.GetChapterIndex)()
  ;
  (this.RefreshDungeonInfo)(chapterIndex)
end

ActivityDungeonWindow.RefreshDungeonInfo = function(index, pageDownOrPageUp, ...)
  -- function num : 0_13 , upvalues : _ENV, pageIndex, components, PAGE_DOWN, PAGE_UP, decorate, book, IDLE_ANIM, this
  if index < 1 or (ActivityDungeonData.GetChapterCount)() < index then
    return 
  end
  pageIndex = index
  local plotMain = components.PlotMain
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (plotMain.ChapterTxt).text = ((ActivityDungeonData.GetChapterByIndex)(pageIndex)).name
  ;
  (plotMain.MapList):RemoveChildrenToPool()
  do
    if not pageDownOrPageUp or not PAGE_DOWN then
      local animName = pageDownOrPageUp == nil or PAGE_UP
    end
    decorate.visible = false
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (plotMain.ChapterTxt).visible = false
    ;
    (SkeletonAnimationUtil.SetAnimation)(book, 0, animName, false, function(...)
    -- function num : 0_13_0 , upvalues : _ENV, book, IDLE_ANIM, decorate, plotMain, this, index
    (SkeletonAnimationUtil.SetAnimation)(book, 0, IDLE_ANIM, true, nil, false, "0")
    decorate.visible = true
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (plotMain.ChapterTxt).visible = true
    ;
    (this.RefreshMapItem)(index, (this.ItemProvider)(index))
    ;
    (this.RefreshChangeChapterBtn)(index)
  end
, false, "0")
    ;
    (this.RefreshMapItem)(index, (this.ItemProvider)(index))
    ;
    (this.RefreshChangeChapterBtn)(index)
  end
end

ActivityDungeonWindow.ItemProvider = function(index, ...)
  -- function num : 0_14 , upvalues : _ENV, components
  local data = (ActivityDungeonData.GetChapterByIndex)(index)
  return ((components.PlotMain).MapList):AddItemFromPool((Util.GetItemUrl)(data.set_style))
end

ActivityDungeonWindow.RefreshMapItem = function(index, item, ...)
  -- function num : 0_15 , upvalues : _ENV, StageData
  local chapterData = (ActivityDungeonData.GetChapterByIndex)(index)
  local chapterStageInfos = (ActivityDungeonData.GetAllChapterStageInfos)()
  local chapterStageInfo = chapterStageInfos[chapterData.id]
  local count = #(chapterStageInfo.normal).stages
  local stageItem, status = nil, nil
  for i = 1, count do
    stageItem = item:GetChild("Spot_" .. i)
    if stageItem then
      local stageId = tonumber(((chapterStageInfo.normal).stages)[i])
      do
        local config = StageData[stageId]
        status = (PlotDungeonMgr.GetDungeonStatus)(config.id)
        if status == StageStatus.Unlock and not (PlotDungeonMgr.IsCanChallenge)(config.id, false) then
          status = StageStatus.Lock
        end
        ;
        (stageItem:GetChild("PicLoader")).url = (Util.GetItemUrl)(config.icon)
        ;
        (stageItem:GetController("c1")).selectedIndex = status
        if config.type == StageType.STORY then
          (stageItem:GetController("c2")).selectedIndex = 1
        else
          ;
          (stageItem:GetController("c2")).selectedIndex = 0
        end
        ;
        (stageItem:GetChild("NumberTxt")).text = config.name
        ;
        (stageItem.onClick):Set(function(...)
    -- function num : 0_15_0 , upvalues : _ENV, config
    if (ActorData.GetServerTime)() >= 1628956799000 then
      (MessageMgr.SendCenterTips)((PUtil.get)(40002085))
      return 
    end
    if config.type == StageType.FIGHT then
      (ActivityDungeonMgr.SetSelectDungeon)(config.id)
    else
      ;
      (PlotDungeonMgr.OnClickStage)(config.id, nil, nil, nil, true)
    end
  end
)
      end
    end
  end
end

ActivityDungeonWindow.RefreshChangeChapterBtn = function(index, ...)
  -- function num : 0_16 , upvalues : components, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((components.PlotMain).LeftBtn).visible = index > 1
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((components.PlotMain).RightBtn).visible = index < (ActivityDungeonData.GetChapterCount)()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ActivityDungeonWindow.RefreshExploreDuration = function(msgId, data, ...)
  -- function num : 0_17 , upvalues : this, components, _ENV, countdownTimer
  (this.ClearCountdownTimer)()
  local spend = (components.ExploreMain).Spend
  local callback = function(refresh, ...)
    -- function num : 0_17_0 , upvalues : spend, _ENV, data, this, msgId
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    (spend.TimeTxt).text = (PUtil.get)(60000654)
    ;
    (ActivityRiskData.UpdateStatus)(data)
    ;
    (this.RefreshExplorationStatus)()
    ;
    (this.RefreshExplorationBtn)(msgId, data)
    if refresh then
      (ActivityDungeonService.ReqRiskData)(msgId)
    end
  end

  if data then
    if data.status ~= (ActivityRiskData.ExplorationStatus).Finish then
      local leftTime = (math.ceil)(data.endTime * 0.001) - (LuaTime.GetTimeStamp)()
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (spend.TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetTimeStrVersion2)(leftTime, true))
      -- DECOMPILER ERROR at PC43: Unhandled construct in 'MakeBoolean' P1

      if leftTime < 3600 and leftTime > 0 then
        countdownTimer = (SimpleTimer.new)(1, leftTime, function(...)
    -- function num : 0_17_1 , upvalues : data, _ENV, callback, spend
    if data.endTime <= (ActorData.GetServerTime)() then
      callback(true)
      return 
    end
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (spend.TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetTimeStrVersion2)((math.floor)(data.endTime * 0.001) - (LuaTime.GetTimeStamp)(), true))
  end
)
        countdownTimer:start()
      end
      local refreshTime = leftTime % 60
      countdownTimer = (SimpleTimer.setTimeout)(refreshTime, function(...)
    -- function num : 0_17_2 , upvalues : _ENV, data, spend, countdownTimer, this, callback
    local leftTime = (math.floor)(data.endTime * 0.001) - (LuaTime.GetTimeStamp)()
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (spend.TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetTimeStrVersion2)(leftTime, true))
    if leftTime > 0 then
      countdownTimer = (SimpleTimer.new)(60, -1, function(...)
      -- function num : 0_17_2_0 , upvalues : _ENV, data, this, countdownTimer, callback, spend
      local leftTime = (math.ceil)(data.endTime * 0.001) - (LuaTime.GetTimeStamp)()
      if leftTime < 3600 then
        (this.ClearCountdownTimer)()
        countdownTimer = (SimpleTimer.new)(1, leftTime, function(...)
        -- function num : 0_17_2_0_0 , upvalues : data, _ENV, callback, leftTime
        if data.endTime <= (ActorData.GetServerTime)() then
          callback(true)
          return 
        end
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (((uis.ExploreMain).Spend).TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetTimeStrVersion2)(leftTime, true))
      end
)
        countdownTimer:start()
      else
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (spend.TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetTimeStrVersion2)(leftTime, true))
      end
    end
)
      countdownTimer:start()
    end
  end
)
    else
      do
        callback()
      end
    end
  end
end

ActivityDungeonWindow.RefreshExploreCost = function(exploreTimes, ...)
  -- function num : 0_18 , upvalues : _ENV, RiskStageData, currentExplorationId, components
  local cost = exploreTimes * (ActivityRiskData.CurrentExploreCost).Value
  local config = RiskStageData[currentExplorationId]
  local time = (LuaTime.GetTimeStamp)()
  local changeNumText = ((components.ExploreMain).Spend).ChangeNumberTxt
  if cost <= (ActorData.GetAssetCount)((ActivityRiskData.CurrentExploreCost).Id) and (ActivityRiskData.GetExploreTimes)() * config.explore_time + time < (math.ceil)((ActivityDungeonData.GetCurrentActivityDeadline)() * 0.001) then
    changeNumText.text = cost
  else
    changeNumText.text = "[color=" .. Const.RedColor .. "]" .. cost .. "[/color]"
  end
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((components.ExploreMain).Spend).TimeTxt).text = (PUtil.get)(60000621, (LuaTime.GetTimeStrVersion2)(config.explore_time * exploreTimes, true))
end

ActivityDungeonWindow.RefreshExploreLog = function(id, data, ...)
  -- function num : 0_19 , upvalues : components, RiskEventData, defaultOffset, _ENV, updateTimer, RiskStageData
  local count = nil
  if data then
    if not data.event then
      local eventIds = {}
      do
        count = #eventIds
        -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((components.ExploreMain).ExplainWordList).itemRenderer = function(index, item, ...)
    -- function num : 0_19_0 , upvalues : eventIds, RiskEventData, defaultOffset, _ENV
    local subData = eventIds[index + 1]
    local subConfig = RiskEventData[subData.eventId]
    local txt = item:GetChild("ExplainWordTxt")
    if defaultOffset == nil then
      defaultOffset = item.height - txt.height
    end
    if subConfig then
      if subData.reward ~= nil and (_G.next)(subData.reward) ~= nil then
        txt.text = (PUtil.get)(subConfig.event, (Util.GetGoodsStr)(subData.reward))
      else
        txt.text = (PUtil.get)(subConfig.event)
      end
    else
      txt.text = ""
    end
    item.height = txt.textHeight + defaultOffset
  end

        if updateTimer then
          updateTimer:stop()
          updateTimer = nil
        end
        local timestamp = (ActorData.GetServerTime)()
        if data.endTime ~= nil and timestamp < data.endTime then
          if data.updateTime <= timestamp then
            (ActivityDungeonService.ReqRiskData)(data.id)
          else
            updateTimer = (SimpleTimer.setTimeout)((math.ceil)((data.updateTime - timestamp) * 0.001), function(...)
    -- function num : 0_19_1 , upvalues : _ENV, data
    (ActivityDungeonService.ReqRiskData)(data.id)
  end
)
          end
        end
      end
      do
        count = 1
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((components.ExploreMain).ExplainWordList).itemRenderer = function(index, item, ...)
    -- function num : 0_19_2 , upvalues : RiskStageData, id, defaultOffset
    local subConfig = RiskStageData[id]
    local txt = item:GetChild("ExplainWordTxt")
    if defaultOffset == nil then
      defaultOffset = item.height - txt.height
    end
    txt.text = subConfig.remark
    item.height = txt.height + defaultOffset
  end

        -- DECOMPILER ERROR at PC57: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((components.ExploreMain).ExplainWordList).numItems = count
        ;
        ((components.ExploreMain).ExplainWordList):ScrollToView(count - 1)
      end
    end
  end
end

ActivityDungeonWindow.RefreshExploreRewards = function(id, data, ...)
  -- function num : 0_20 , upvalues : components, _ENV, RiskStageData
  local rewards = nil
  local exploreMain = components.ExploreMain
  local rewardShow = exploreMain.RewardShow
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

  if data then
    (exploreMain.c2Ctr).selectedIndex = 1
    if not data.reward then
      rewards = {}
    end
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (rewardShow.ImportantList).itemRenderer = function(index, item, ...)
    -- function num : 0_20_0 , upvalues : rewards, _ENV
    local data = rewards[index + 1]
    ;
    (Util.SetAllItemIcon)(item, data.id, data.value)
  end

    -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

    if #rewards == 0 then
      (rewardShow.c1Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (rewardShow.c1Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (rewardShow.ImportantList).numItems = #rewards
    end
  else
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (exploreMain.c2Ctr).selectedIndex = 0
    local config = RiskStageData[id]
    rewards = split(config.reward_view, ",")
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((exploreMain.RewardShow).ImportantList).itemRenderer = function(index, item, ...)
    -- function num : 0_20_1 , upvalues : rewards, _ENV
    local data = rewards[index + 1]
    ;
    (Util.SetAllItemIconByConfig)(item, data)
  end

    -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (rewardShow.c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (rewardShow.ImportantList).numItems = #rewards
  end
end

ActivityDungeonWindow.InitExploreCost = function(data, ...)
  -- function num : 0_21 , upvalues : components, _ENV
  local ctrl = ((components.ExploreMain).Spend).c1Ctr
  if not data then
    ctrl.selectedIndex = 1
    ;
    (ActivityDungeonMgr.SetExploreTimes)(1)
  else
    ctrl.selectedIndex = 0
  end
end

ActivityDungeonWindow.RefreshExplorationDetail = function(id, notRefreshWhenSame, ...)
  -- function num : 0_22 , upvalues : defaultStage, currentExplorationId, _ENV, RiskStageData, this
  if not id then
    id = defaultStage
  end
  if notRefreshWhenSame and currentExplorationId == id then
    return 
  end
  currentExplorationId = id
  local data = (ActivityRiskData.GetRiskDataById)(id)
  if data and data.updateTime and data.updateTime < (ActorData.GetServerTime)() then
    (ActivityDungeonService.ReqRiskData)(data.id)
  end
  ;
  (ActivityRiskData.RefreshEachExploreCost)(RiskStageData[id])
  ;
  (ActivityRiskData.UpdateStatus)(data)
  ;
  (this.RefreshExploreLog)(id, data)
  ;
  (this.RefreshExploreRewards)(id, data)
  ;
  (this.InitExploreCost)(data)
  ;
  (this.RefreshExploreDuration)(id, data)
  ;
  (this.RefreshExplorationBtn)(id, data)
  ;
  (this.RefreshActiveRole)(id)
end

ActivityDungeonWindow.RefreshExplorationStatus = function(...)
  -- function num : 0_23 , upvalues : _ENV, adventureBtns
  local timestamp = ((ActorData.GetServerTime)())
  local data = nil
  for id,v in pairs(adventureBtns) do
    data = (ActivityRiskData.GetRiskDataById)(id)
    local ctrl = v:GetController("c1")
    if data then
      if data.endTime ~= nil and data.endTime < timestamp then
        ctrl.selectedIndex = (ActivityRiskData.ExplorationStatus).Finish
      else
        ctrl.selectedIndex = (ActivityRiskData.ExplorationStatus).Exploring
      end
    else
      ctrl.selectedIndex = (ActivityRiskData.ExplorationStatus).None
    end
  end
end

ActivityDungeonWindow.RefreshExplorationBtn = function(id, data, ...)
  -- function num : 0_24 , upvalues : components, _ENV
  local startBtn = ((components.ExploreMain).Spend).StartBtn
  if data.status ~= (ActivityRiskData.ExplorationStatus).Finish then
    startBtn.visible = not data
    startBtn.text = (PUtil.get)(20000370)
    ;
    (startBtn.onClick):Set(function(...)
    -- function num : 0_24_0 , upvalues : _ENV, id
    (ActivityDungeonMgr.ReqEndRisk)(id)
  end
)
    startBtn.visible = true
    startBtn.text = (PUtil.get)(60000623)
    ;
    (startBtn.onClick):Set(function(...)
    -- function num : 0_24_1 , upvalues : _ENV, id
    if (ActorData.GetServerTime)() >= 1628956799000 then
      (MessageMgr.SendCenterTips)((PUtil.get)(40002085))
      return 
    end
    ;
    (ActivityDungeonMgr.ReqBeginRisk)(id)
  end
)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

ActivityDungeonWindow.RefreshActiveRole = function(id, ...)
  -- function num : 0_25 , upvalues : RiskStageData, components, _ENV, this
  local config = RiskStageData[id]
  ;
  (((components.ExploreMain).UpCard).CardList):RemoveChildrenToPool()
  if (Util.StringIsNullOrEmpty)(config.card_group) then
    return 
  end
  local roleInfo = split(config.card_group, ",")
  local count = #roleInfo
  local item = nil
  local enhance = 0
  for i = 1, count do
    item = (((components.ExploreMain).UpCard).CardList):AddItemFromPool()
    enhance = enhance + (this.RefreshActiveRoleItem)(roleInfo[i], item)
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((components.ExploreMain).UpCard).WordTxt).text = (PUtil.get)(60000652, enhance)
end

ActivityDungeonWindow.RefreshActiveRoleItem = function(data, item, ...)
  -- function num : 0_26 , upvalues : _ENV
  data = split(data, ":")
  local cardId = tonumber(data[1])
  local cardInfo = (CardData.GetCardData)(cardId)
  ;
  (Util.SetShowHeadFrame)(item, cardId, nil, nil, nil, true)
  if cardInfo then
    (item:GetController("c3")).selectedIndex = 0
    return (math.floor)(tonumber(data[2]) * 0.01)
  else
    ;
    (item:GetController("c3")).selectedIndex = 8
    return 0
  end
end

ActivityDungeonWindow.RefreshBossHp = function(...)
  -- function num : 0_27 , upvalues : components, _ENV
  local battleTips = (components.AssistBattleMain).BattleTips
  local assistData = (ActivityRiskData.GetAssistData)()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (battleTips.HpTxt).text = (PUtil.get)(60000653, (math.ceil)(assistData.remainHp))
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (battleTips.HpProgressBar).value = assistData.remainHp
end

ActivityDungeonWindow.RefreshBossFightInfo = function(...)
  -- function num : 0_28 , upvalues : _ENV, assistTimer, components, this, bossId, mask, bossModel
  local assistData = (ActivityRiskData.GetAssistData)()
  if assistData == nil then
    return 
  end
  if assistTimer ~= nil then
    assistTimer:Stop()
  end
  assistTimer = (LuaTime.CountDown)((math.ceil)((ActivityDungeonData.GetCurrentActivityDeadline)() * 0.001) - (LuaTime.GetTimeStamp)(), (components.AssistBattleMain).TimeTxt, nil, true, nil, 60000627)
  ;
  (this.RefreshBossHp)()
  local config = ((TableData.gTable).BaseActivityAidData)[assistData.id]
  if bossId == config.fashionID_show then
    return 
  else
    bossId = config.fashionID_show
    local fashionConfig = ((TableData.gTable).BaseFashionData)[config.fashionID_show]
    local offset = {x = 0, y = 0}
    do
      if not (Util.StringIsNullOrEmpty)(config.location) then
        local offsetStr = split(config.location, ":")
        offset.x = offset.x + tonumber(offsetStr[1])
        offset.y = offset.y + tonumber(offsetStr[2])
      end
      local battleTips = (components.AssistBattleMain).BattleTips
      if (Util.StringIsNullOrEmpty)(fashionConfig.show_cg) then
        (Util.RecycleUIModel)((battleTips.BossPic).ImageLoader)
        ;
        (Util.CreateShowModel)(config.fashionID_show, (battleTips.BossPic).ImageLoader)
        ;
        (Util.SetModelClip)((battleTips.BossPic).ImageLoader, mask, true)
        -- DECOMPILER ERROR at PC107: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((battleTips.BossPic).ImageLoader).x = offset.x
        -- DECOMPILER ERROR at PC111: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((battleTips.BossPic).ImageLoader).y = offset.y
      else
        if bossModel then
          (ResHelper.DestroyGameObject)(bossModel, false)
        end
        local holder = nil
        holder = (LuaEffect.AddUIEffect)(fashionConfig.show_cg, false, false, Vector3.zero, 1)
        ;
        ((battleTips.BossPic).root):AddChildAt(holder, 1)
        holder:SetXY(((battleTips.BossPic).root).width / 2 + offset.x, ((battleTips.BossPic).root).height / 2 + offset.y)
      end
    end
  end
end

ActivityDungeonWindow.ClickMinusBtn = function(...)
  -- function num : 0_29 , upvalues : _ENV, RiskStageData, currentExplorationId
  (ActivityDungeonMgr.ChangeExploreTimes)(-1, RiskStageData[currentExplorationId])
end

ActivityDungeonWindow.ClickAddBtn = function(...)
  -- function num : 0_30 , upvalues : _ENV, RiskStageData, currentExplorationId
  (ActivityDungeonMgr.ChangeExploreTimes)(1, RiskStageData[currentExplorationId])
end

ActivityDungeonWindow.ClickMaxBtn = function(...)
  -- function num : 0_31 , upvalues : _ENV, RiskStageData, currentExplorationId
  (ActivityDungeonMgr.ChangeExploreTimes)(0, RiskStageData[currentExplorationId])
end

ActivityDungeonWindow.ClickGuildAssistBtn = function(...)
  -- function num : 0_32 , upvalues : _ENV
  if (ActorData.GetServerTime)() >= 1628956799000 then
    (MessageMgr.SendCenterTips)((PUtil.get)(40002085))
    return 
  end
  ;
  (ActivityDungeonMgr.OpenGuildAssist)()
end

ActivityDungeonWindow.ClickRewardShowBtn = function(...)
  -- function num : 0_33 , upvalues : _ENV
  (ActivityDungeonMgr.OpenPhaseRewardShow)()
end

ActivityDungeonWindow.ClickChallengeBtn = function(...)
  -- function num : 0_34 , upvalues : _ENV, challengeBoss
  if (ActorData.GetServerTime)() >= 1628956799000 then
    (MessageMgr.SendCenterTips)((PUtil.get)(40002085))
    return 
  end
  if (ActivityDungeonMgr.TryChallengeBoss)() then
    challengeBoss = true
  end
end

ActivityDungeonWindow.RefreshPageLine = function(type, ...)
  -- function num : 0_35 , upvalues : pageLines
  local count = #pageLines
  for i = 1, count do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (pageLines[i]).visible = type ~= i and type + 1 ~= i
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityDungeonWindow.ClickPageBtn = function(btnType, ...)
  -- function num : 0_36 , upvalues : components, pageBtns, this, PageType, _ENV, book, IDLE2_ANIM, IDLE_ANIM, dungeonInit
  local controller = components.c1Ctr
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (pageBtns[controller.selectedIndex + 1]).selected = false
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (pageBtns[btnType]).selected = true
  ;
  (this.RefreshPageLine)(btnType)
  if ((components.c1Ctr).selectedIndex == PageType.BossFight - 1 and btnType ~= PageType.BossFight) or (components.c1Ctr).selectedIndex ~= PageType.BossFight - 1 and btnType == PageType.BossFight then
    if btnType == PageType.BossFight then
      (SkeletonAnimationUtil.SetAnimation)(book, 0, IDLE2_ANIM, true)
    else
      ;
      (SkeletonAnimationUtil.SetAnimation)(book, 0, IDLE_ANIM, true)
    end
  end
  controller.selectedIndex = btnType - 1
  if controller.selectedIndex == PageType.Exploration - 1 then
    (this.InitExplorationInfo)()
  else
    ;
    (this.ClearCountdownTimer)()
    if controller.selectedIndex == PageType.BossFight - 1 then
      (ActivityDungeonMgr.InitAssistData)()
      ;
      (this.RefreshBossFightInfo)()
    else
      if not dungeonInit then
        (this.InitDungeonInfo)()
        dungeonInit = true
      end
    end
  end
end

ActivityDungeonWindow.ClearCountdownTimer = function(...)
  -- function num : 0_37 , upvalues : countdownTimer
  if countdownTimer then
    countdownTimer:stop()
    countdownTimer = nil
  end
end

ActivityDungeonWindow.HandleMessage = function(msgId, param, ...)
  -- function num : 0_38 , upvalues : _ENV, this, components, PageType, RiskStageData, currentExplorationId, pageIndex
  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE_COST then
    (this.RefreshExploreCost)((ActivityRiskData.GetExploreTimes)())
  else
    -- DECOMPILER ERROR at PC23: Unhandled construct in 'MakeBoolean' P1

    if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE and (components.c1Ctr).selectedIndex + 1 == PageType.Exploration then
      (this.InitExplorationInfo)()
    end
  end
  -- DECOMPILER ERROR at PC40: Unhandled construct in 'MakeBoolean' P1

  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_AFTER_PURCHASE and (components.c1Ctr).selectedIndex + 1 == PageType.Exploration then
    (ActivityRiskData.RefreshEachExploreCost)(RiskStageData[currentExplorationId])
    ;
    (this.RefreshExploreCost)((ActivityRiskData.GetExploreTimes)())
  end
  -- DECOMPILER ERROR at PC59: Unhandled construct in 'MakeBoolean' P1

  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_ASSIST_FIGHT and (components.c1Ctr).selectedIndex + 1 == PageType.BossFight then
    (this.RefreshBossFightInfo)()
  end
  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_BOSS_HP then
    (this.RefreshBossHp)()
  else
    if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH then
      (this.RefreshDungeonInfo)(pageIndex)
    end
  end
end

return ActivityDungeonWindow

