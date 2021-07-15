-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_BattleMainByName")
local PageType = {MainDungeon = 0, Exploration = 1, AssistFight = 2}
local BTN_LINE = "LabelLine"
local BTN_NAME = {"LabelABtn", "LabelBBtn", "LabelCBtn"}
local BEGIN_ANIM = "begin"
local IDLE_ANIM = "idle"
local IDLE2_ANIM = "idle2"
local PAGE_UP = "up"
local PAGE_DOWN = "down"
local BOOK_BG = "ui_tushuguan_bg"
local BOOK = "ui_tushuguan_shu"
local NewActivityDungeonMainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _riskStageConfigs = (TableData.gTable).BaseActivityRiskStageData
local _riskEventConfigs = (TableData.gTable).BaseActivityRiskEventData
local _chapterConfigs = (TableData.gTable).BaseChapterData
local _stageConfigs = (TableData.gTable).BaseStageData
local NewActivityDungeonData = NewActivityDungeonData
local _pageBtns = {}
local _pageLines = {}
local _adventureBtns = {}
local _defaultStage, _currentType, _defaultOffset, _currentStageId, _countDownTimer, _updateTimer, _assistTimer, _currentMapIndex, _mask, _bossId, _bossModel, _book, _bookBg, _decorate = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
local _challengeBoss = false
local _openFromClose = nil
local _dungeonInited = false
NewActivityDungeonMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, _openFromClose, uis, NewActivityDungeonMainWindow
  bridgeObj:SetView((WinResConfig.NewActivityDungeonMainWindow).package, (WinResConfig.NewActivityDungeonMainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  _openFromClose = bridgeObj.OpenFromClose
  uis = GetActivityDungeonTwo_BattleMainUis(contentPane)
  ;
  (NewActivityDungeonMainWindow.InitVariable)()
  ;
  (NewActivityDungeonMainWindow.InitTopMenu)()
  ;
  (NewActivityDungeonMainWindow.InitText)()
  ;
  (NewActivityDungeonMainWindow.InitButtonEvent)()
  ;
  (NewActivityDungeonMainWindow.InitList)()
  ;
  (NewActivityDungeonMainWindow.BindingUI)()
end

NewActivityDungeonMainWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _mask, uis, _decorate, _pageLines, _pageBtns, _ENV, NewActivityDungeonMainWindow, PageType, _riskStageConfigs, _defaultStage, _adventureBtns
  _mask = ((((uis.AssistBattleMain).BattleTips).BossPic).root):GetChild("n1")
  _decorate = ((uis.PlotMain).root):GetChild("n11")
  ;
  ((uis.LabelList).LabelButtonList):RemoveChildrenToPool()
  _pageLines = {}
  _pageBtns = {}
  ;
  (table.insert)(_pageLines, (NewActivityDungeonMainWindow.InitPageLine)())
  _pageBtns[PageType.MainDungeon] = (NewActivityDungeonMainWindow.InitPageBtns)(PageType.MainDungeon)
  ;
  (table.insert)(_pageLines, (NewActivityDungeonMainWindow.InitPageLine)())
  _pageBtns[PageType.Exploration] = (NewActivityDungeonMainWindow.InitPageBtns)(PageType.Exploration)
  ;
  (table.insert)(_pageLines, (NewActivityDungeonMainWindow.InitPageLine)())
  _pageBtns[PageType.AssistFight] = (NewActivityDungeonMainWindow.InitPageBtns)(PageType.AssistFight)
  ;
  (table.insert)(_pageLines, (NewActivityDungeonMainWindow.InitPageLine)())
  local btns = {}
  ;
  (table.insert)(btns, (uis.ExploreMain).ABtn)
  ;
  (table.insert)(btns, (uis.ExploreMain).BBtn)
  ;
  (table.insert)(btns, (uis.ExploreMain).CBtn)
  local index = 1
  for k,v in pairs(_riskStageConfigs) do
    if index == 1 then
      _defaultStage = k
    end
    _adventureBtns[k] = btns[index]
    index = index + 1
  end
end

NewActivityDungeonMainWindow.InitPageLine = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, BTN_LINE
  local com = ((uis.LabelList).LabelButtonList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.NewActivityDungeonMainWindow).package, BTN_LINE))
  return com:GetChild("n0")
end

NewActivityDungeonMainWindow.InitPageBtns = function(type, ...)
  -- function num : 0_3 , upvalues : uis, _ENV, BTN_NAME
  return ((uis.LabelList).LabelButtonList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.NewActivityDungeonMainWindow).package, BTN_NAME[type + 1]))
end

NewActivityDungeonMainWindow.InitTopMenu = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.NewActivityDungeonMainWindow).name
  m.Tip = (PUtil.get)(20000216)
  m.model = uis.AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

NewActivityDungeonMainWindow.InitText = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.ExploreMain).RewardShow).ImportantTxt).text = (PUtil.get)(60000619)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.ExploreMain).Spend).WordTxt).text = (PUtil.get)(60000620)
end

NewActivityDungeonMainWindow.InitButtonEvent = function(...)
  -- function num : 0_6 , upvalues : _pageBtns, PageType, NewActivityDungeonMainWindow, uis
  ((_pageBtns[PageType.MainDungeon]).onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : NewActivityDungeonMainWindow, PageType
    (NewActivityDungeonMainWindow.ClickPageBtn)(PageType.MainDungeon)
  end
)
  ;
  ((_pageBtns[PageType.Exploration]).onClick):Set(function(...)
    -- function num : 0_6_1 , upvalues : NewActivityDungeonMainWindow, PageType
    (NewActivityDungeonMainWindow.ClickPageBtn)(PageType.Exploration)
  end
)
  ;
  ((_pageBtns[PageType.AssistFight]).onClick):Set(function(...)
    -- function num : 0_6_2 , upvalues : NewActivityDungeonMainWindow, PageType
    (NewActivityDungeonMainWindow.ClickPageBtn)(PageType.AssistFight)
  end
)
  ;
  ((((uis.ExploreMain).Spend).ReduceBtn).onClick):Set(NewActivityDungeonMainWindow.ClickMinusBtn)
  ;
  ((((uis.ExploreMain).Spend).AddBtn).onClick):Set(NewActivityDungeonMainWindow.ClickAddBtn)
  ;
  ((((uis.ExploreMain).Spend).MaxBtn).onClick):Set(NewActivityDungeonMainWindow.ClickMaxBtn)
  ;
  (((uis.AssistBattleMain).BattleRewardBtn).onClick):Set(NewActivityDungeonMainWindow.ClickRewardShowBtn)
  ;
  (((uis.AssistBattleMain).BattleHelpBtn).onClick):Set(NewActivityDungeonMainWindow.ClickGulidAssistBtn)
  ;
  ((((uis.AssistBattleMain).BattleTips).BattleBossBtn).onClick):Set(NewActivityDungeonMainWindow.ClickChallengeBtn)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.AssistBattleMain).BattleHelpBtn).visible = false
  ;
  (((uis.PlotMain).LeftBtn).onClick):Set(NewActivityDungeonMainWindow.ClickLeftBtn)
  ;
  (((uis.PlotMain).RightBtn).onClick):Set(NewActivityDungeonMainWindow.ClickRightBtn)
end

NewActivityDungeonMainWindow.InitList = function(...)
  -- function num : 0_7 , upvalues : uis
  ((uis.ExploreMain).ExplainWordList):SetVirtual()
  ;
  (((uis.ExploreMain).RewardShow).ImportantList):SetVirtual()
end

NewActivityDungeonMainWindow.BindingUI = function(...)
  -- function num : 0_8 , upvalues : _ENV, _pageBtns, PageType
  local winName = (WinResConfig.NewActivityDungeonMainWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.NAD_Exploration, _pageBtns[PageType.Exploration])
  BindingUI(winName, RedDotComID.NAD_AssitsFight, _pageBtns[PageType.AssistFight])
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

NewActivityDungeonMainWindow.OnShown = function(...)
  -- function num : 0_9 , upvalues : NewActivityDungeonMainWindow
  (NewActivityDungeonMainWindow.Init)()
end

NewActivityDungeonMainWindow.OnHide = function(...)
  -- function num : 0_10
end

NewActivityDungeonMainWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis, _book, _bookBg, _bossModel, _bossId, NewActivityDungeonMainWindow, _updateTimer, _assistTimer, _currentStageId, _dungeonInited, _decorate, _mask, _pageBtns, _pageLines, _adventureBtns, contentPane, argTable
  (NewActivityDungeonMgr.CancelNotify)()
  ;
  (Util.RecycleUIModel)((((uis.AssistBattleMain).BattleTips).BossPic).ImageLoader)
  if _book then
    (ResHelper.DestroyGameObject)(_book, false)
    _book = nil
  end
  if _bookBg then
    (ResHelper.DestroyGameObject)(_bookBg, false)
    _bookBg = nil
  end
  if _bossModel then
    (ResHelper.DestroyGameObject)(_bossModel, false)
    _bossModel = nil
  end
  _bossId = nil
  ;
  (NewActivityDungeonMainWindow.StopCountDownTimer)()
  if _updateTimer then
    _updateTimer:stop()
    _updateTimer = nil
  end
  if _assistTimer then
    _assistTimer:Stop()
    _assistTimer = nil
  end
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.NewActivityDungeonMainWindow).name)
  _currentStageId = nil
  _dungeonInited = false
  _decorate = nil
  _mask = nil
  _pageBtns = {}
  _pageLines = {}
  _adventureBtns = {}
  uis = nil
  contentPane = nil
  argTable = {}
end

NewActivityDungeonMainWindow.Init = function(...)
  -- function num : 0_12 , upvalues : _openFromClose, _challengeBoss, NewActivityDungeonMainWindow, PageType, uis
  if _openFromClose and _challengeBoss then
    _challengeBoss = false
    ;
    (NewActivityDungeonMainWindow.ClickPageBtn)(PageType.AssistFight)
    ;
    (NewActivityDungeonMainWindow.InitEffect)(function(...)
    -- function num : 0_12_0 , upvalues : uis
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.LabelList).root).visible = false
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.AssistBattleMain).BattleTips).root).visible = false
  end
, function(...)
    -- function num : 0_12_1 , upvalues : uis
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.LabelList).root).visible = true
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.AssistBattleMain).BattleTips).root).visible = true
  end
)
  else
    ;
    (NewActivityDungeonMainWindow.ClickPageBtn)(PageType.MainDungeon)
    ;
    (NewActivityDungeonMainWindow.InitEffect)(function(...)
    -- function num : 0_12_2 , upvalues : uis
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.LabelList).root).visible = false
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.PlotMain).root).visible = false
  end
, function(...)
    -- function num : 0_12_3 , upvalues : uis
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.LabelList).root).visible = true
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.PlotMain).root).visible = true
  end
)
  end
end

NewActivityDungeonMainWindow.InitEffect = function(beforeFun, afterFun, ...)
  -- function num : 0_13 , upvalues : _book, _ENV, BOOK, uis, BEGIN_ANIM, IDLE_ANIM, _bookBg, BOOK_BG
  do
    if _book == nil then
      local holder, model = (Util.AddUIModel)(BOOK, 100)
      ;
      (uis.root):AddChildAt(holder, 1)
      holder:SetXY((uis.root).width * 0.5, (uis.root).height * 0.5)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (model.transform).localScale = Vector3.one * 100
      _book = model
    end
    ;
    (SkeletonAnimationUtil.SetAnimation)(_book, 0, BEGIN_ANIM, false, function(...)
    -- function num : 0_13_0 , upvalues : _ENV, _book, IDLE_ANIM
    (SkeletonAnimationUtil.SetAnimation)(_book, 0, IDLE_ANIM, true)
  end
)
    if beforeFun then
      beforeFun()
    end
    do
      if _bookBg == nil then
        local holder, model = (Util.AddUIModel)(BOOK_BG, 100)
        ;
        (uis.root):AddChildAt(holder, 1)
        holder:SetXY((uis.root).width * 0.5, (uis.root).height * 0.5)
        -- DECOMPILER ERROR at PC64: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (model.transform).localScale = Vector3.one * 100
        _bookBg = model
      end
      ;
      (SkeletonAnimationUtil.SetAnimation)(_bookBg, 0, BEGIN_ANIM, false, function(...)
    -- function num : 0_13_1 , upvalues : afterFun, _ENV, _bookBg, IDLE_ANIM
    if afterFun then
      afterFun()
    end
    ;
    (SkeletonAnimationUtil.SetAnimation)(_bookBg, 0, IDLE_ANIM, true)
  end
)
    end
  end
end

NewActivityDungeonMainWindow.RefreshPageLine = function(type, ...)
  -- function num : 0_14 , upvalues : _pageLines
  local count = #_pageLines
  for i = 1, count do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (_pageLines[i]).visible = type + 1 ~= i and type + 2 ~= i
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

NewActivityDungeonMainWindow.InitDungeonInfo = function(...)
  -- function num : 0_15 , upvalues : _dungeonInited, NewActivityDungeonData, NewActivityDungeonMainWindow
  _dungeonInited = true
  ;
  (NewActivityDungeonData.InitChapterData)()
  local index = (NewActivityDungeonData.GetChapterIndex)()
  ;
  (NewActivityDungeonMainWindow.RefreshDungeonInfo)(index)
end

NewActivityDungeonMainWindow.RefreshDungeonInfo = function(index, anim, ...)
  -- function num : 0_16 , upvalues : NewActivityDungeonData, _currentMapIndex, uis, PAGE_DOWN, PAGE_UP, _decorate, _ENV, _book, IDLE_ANIM, NewActivityDungeonMainWindow
  if index < 1 or #NewActivityDungeonData.ChapterData < index then
    return 
  end
  _currentMapIndex = index
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.PlotMain).ChapterTxt).text = ((NewActivityDungeonData.ChapterData)[_currentMapIndex]).Name
  ;
  ((uis.PlotMain).MapList):RemoveChildrenToPool()
  if anim ~= 1 or not PAGE_DOWN then
    anim = not anim or PAGE_UP
  end
  _decorate.visible = false
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.PlotMain).ChapterTxt).visible = false
  ;
  (SkeletonAnimationUtil.SetAnimation)(_book, 0, anim, false, function(...)
    -- function num : 0_16_0 , upvalues : _ENV, _book, IDLE_ANIM, _decorate, uis, NewActivityDungeonMainWindow, index
    (SkeletonAnimationUtil.SetAnimation)(_book, 0, IDLE_ANIM, true, nil, false, "0")
    _decorate.visible = true
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.PlotMain).ChapterTxt).visible = true
    ;
    (NewActivityDungeonMainWindow.RefreshMapItem)(index, (NewActivityDungeonMainWindow.MapProvider)(index))
    ;
    (NewActivityDungeonMainWindow.RefreshChangeChapterBtn)(index)
  end
, false, "0")
  ;
  (NewActivityDungeonMainWindow.RefreshMapItem)(index, (NewActivityDungeonMainWindow.MapProvider)(index))
  ;
  (NewActivityDungeonMainWindow.RefreshChangeChapterBtn)(index)
end

NewActivityDungeonMainWindow.RefreshChangeChapterBtn = function(index, ...)
  -- function num : 0_17 , upvalues : uis, NewActivityDungeonData
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.PlotMain).LeftBtn).visible = index ~= 1
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.PlotMain).RightBtn).visible = index ~= #NewActivityDungeonData.ChapterData
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

NewActivityDungeonMainWindow.MapProvider = function(index, ...)
  -- function num : 0_18 , upvalues : NewActivityDungeonData, uis, _ENV
  local data = (NewActivityDungeonData.ChapterData)[index]
  return ((uis.PlotMain).MapList):AddItemFromPool((Util.GetItemUrl)(data.Map))
end

NewActivityDungeonMainWindow.RefreshMapItem = function(index, item, ...)
  -- function num : 0_19 , upvalues : NewActivityDungeonData, _stageConfigs, _ENV
  local data = (NewActivityDungeonData.ChapterData)[index]
  local count = #data.Stages
  local stageItem, status = nil, nil
  for i = 1, count do
    stageItem = item:GetChild("Spot_" .. i)
    if stageItem then
      local config = _stageConfigs[(data.Stages)[i]]
      do
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
    -- function num : 0_19_0 , upvalues : config, _ENV
    if config.type == StageType.FIGHT then
      (NewActivityDungeonMgr.SetSelectDungeon)(config.id)
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

NewActivityDungeonMainWindow.InitExplorationInfo = function(...)
  -- function num : 0_20 , upvalues : NewActivityDungeonMainWindow, _currentStageId
  (NewActivityDungeonMainWindow.InitExplorationBasicInfo)()
  ;
  (NewActivityDungeonMainWindow.RefreshExplorationStatus)()
  ;
  (NewActivityDungeonMainWindow.RefreshExplorationDetail)(_currentStageId)
end

NewActivityDungeonMainWindow.InitExplorationBasicInfo = function(...)
  -- function num : 0_21 , upvalues : _ENV, _riskStageConfigs, _adventureBtns, NewActivityDungeonMainWindow
  for k,v in pairs(_riskStageConfigs) do
    if _adventureBtns[k] then
      local config = v
      do
        ((_adventureBtns[k]):GetChild("ExploreNameTxt")).text = config.name
        if (Util.StringIsNullOrEmpty)(config.icon) == false then
          ((_adventureBtns[k]):GetChild("PicLoader")).url = (Util.GetItemUrl)(config.icon)
        end
        ;
        ((_adventureBtns[k]).onClick):Set(function(...)
    -- function num : 0_21_0 , upvalues : NewActivityDungeonMainWindow, config
    (NewActivityDungeonMainWindow.RefreshExplorationDetail)(config.id, true)
  end
)
      end
    end
  end
end

NewActivityDungeonMainWindow.RefreshExplorationStatus = function(...)
  -- function num : 0_22 , upvalues : _ENV, _adventureBtns, NewActivityDungeonData
  local timeStamp = ((ActorData.GetServerTime)())
  local data = nil
  for k,v in pairs(_adventureBtns) do
    data = (NewActivityDungeonData.AdventureData)[k]
    if data then
      if data.endTime ~= nil and data.endTime < timeStamp then
        (v:GetController("c1")).selectedIndex = NADAdventueStatus.Finish
      else
        ;
        (v:GetController("c1")).selectedIndex = NADAdventueStatus.Exploring
      end
    else
      ;
      (v:GetController("c1")).selectedIndex = NADAdventueStatus.None
    end
  end
end

NewActivityDungeonMainWindow.RefreshExplorationDetail = function(id, notRefreshWhenSame, ...)
  -- function num : 0_23 , upvalues : _defaultStage, _currentStageId, NewActivityDungeonData, _ENV, _riskStageConfigs, NewActivityDungeonMainWindow
  if not id then
    id = _defaultStage
  end
  if notRefreshWhenSame and _currentStageId == id then
    return 
  end
  _currentStageId = id
  local data = (NewActivityDungeonData.AdventureData)[id]
  if data and data.updateTime and data.updateTime < (ActorData.GetServerTime)() then
    (NewActivityDungeonService.ReqRiskData)(data.id)
  end
  ;
  (NewActivityDungeonData.RefreshEachExploreCost)(_riskStageConfigs[id])
  ;
  (NewActivityDungeonData.UpdateStatus)(data)
  ;
  (NewActivityDungeonMainWindow.RefreshExploreLog)(id, data)
  ;
  (NewActivityDungeonMainWindow.RefreshExploreRewards)(id, data)
  ;
  (NewActivityDungeonMainWindow.InitExploreCost)(data)
  ;
  (NewActivityDungeonMainWindow.RefreshExploreDuration)(id, data)
  ;
  (NewActivityDungeonMainWindow.RefreshExploreBtn)(id, data)
  ;
  (NewActivityDungeonMainWindow.RefreshActiveRole)(id)
end

NewActivityDungeonMainWindow.RefreshExploreLog = function(id, data, ...)
  -- function num : 0_24 , upvalues : uis, _riskEventConfigs, _defaultOffset, _ENV, _updateTimer, _riskStageConfigs
  local count = nil
  if data then
    if not data.event then
      local eventIds = {}
      do
        count = #eventIds
        -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((uis.ExploreMain).ExplainWordList).itemRenderer = function(index, item, ...)
    -- function num : 0_24_0 , upvalues : eventIds, _riskEventConfigs, _defaultOffset, _ENV
    local subData = eventIds[index + 1]
    local subConfig = _riskEventConfigs[subData.eventId]
    local txt = item:GetChild("ExplainWordTxt")
    if _defaultOffset == nil then
      _defaultOffset = item.height - txt.height
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
    item.height = txt.textHeight + _defaultOffset
  end

        if _updateTimer then
          _updateTimer:stop()
        end
        local timeStamp = (ActorData.GetServerTime)()
        if data.endTime ~= nil and timeStamp < data.endTime then
          if data.updateTime <= timeStamp then
            (NewActivityDungeonService.ReqRiskData)(data.id)
          else
            _updateTimer = (SimpleTimer.setTimeout)((math.ceil)((data.updateTime - timeStamp) * 0.001), function(...)
    -- function num : 0_24_1 , upvalues : _ENV, data
    (NewActivityDungeonService.ReqRiskData)(data.id)
  end
)
          end
        end
      end
      do
        count = 1
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((uis.ExploreMain).ExplainWordList).itemRenderer = function(index, item, ...)
    -- function num : 0_24_2 , upvalues : _riskStageConfigs, id, _defaultOffset
    local subConfig = _riskStageConfigs[id]
    local txt = item:GetChild("ExplainWordTxt")
    if _defaultOffset == nil then
      _defaultOffset = item.height - txt.height
    end
    txt.text = subConfig.remark
    item.height = txt.height + _defaultOffset
  end

        -- DECOMPILER ERROR at PC55: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((uis.ExploreMain).ExplainWordList).numItems = count
        ;
        ((uis.ExploreMain).ExplainWordList):ScrollToView(count - 1)
      end
    end
  end
end

NewActivityDungeonMainWindow.RefreshExploreRewards = function(id, data, ...)
  -- function num : 0_25 , upvalues : uis, _ENV, _riskStageConfigs
  local rewards = nil
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if data then
    ((uis.ExploreMain).c2Ctr).selectedIndex = 1
    if not data.reward then
      rewards = {}
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((uis.ExploreMain).RewardShow).ImportantList).itemRenderer = function(index, item, ...)
    -- function num : 0_25_0 , upvalues : rewards, _ENV
    local data = rewards[index + 1]
    ;
    (Util.SetAllItemIcon)(item, data.id, data.value)
  end

    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    if #rewards == 0 then
      (((uis.ExploreMain).RewardShow).c1Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (((uis.ExploreMain).RewardShow).c1Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (((uis.ExploreMain).RewardShow).ImportantList).numItems = #rewards
    end
  else
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.ExploreMain).c2Ctr).selectedIndex = 0
    local config = _riskStageConfigs[id]
    rewards = split(config.reward_view, ",")
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((uis.ExploreMain).RewardShow).ImportantList).itemRenderer = function(index, item, ...)
    -- function num : 0_25_1 , upvalues : rewards, _ENV
    local data = rewards[index + 1]
    ;
    (Util.SetAllItemIconByConfig)(item, data)
  end

    -- DECOMPILER ERROR at PC51: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((uis.ExploreMain).RewardShow).c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((uis.ExploreMain).RewardShow).ImportantList).numItems = #rewards
  end
end

NewActivityDungeonMainWindow.InitExploreCost = function(data, ...)
  -- function num : 0_26 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  if not data then
    (((uis.ExploreMain).Spend).c1Ctr).selectedIndex = 1
    ;
    (NewActivityDungeonMgr.SetExploreTimes)(1)
  else
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.ExploreMain).Spend).c1Ctr).selectedIndex = 0
  end
end

NewActivityDungeonMainWindow.RefreshExploreCost = function(...)
  -- function num : 0_27 , upvalues : NewActivityDungeonData, _riskStageConfigs, _currentStageId, _ENV, uis
  local cost = NewActivityDungeonData.CurrentTimes * (NewActivityDungeonData.CurrentEachCost).Value
  local config = _riskStageConfigs[_currentStageId]
  local time = (LuaTime.GetTimeStamp)()
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  if cost <= (ActorData.GetAssetCount)((NewActivityDungeonData.CurrentEachCost).Id) and NewActivityDungeonData.CurrentTimes * config.explore_time + time < (math.ceil)((NewActivityDungeonData.NADData).endTime * 0.001) then
    (((uis.ExploreMain).Spend).ChangeNumberTxt).text = cost
  else
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((uis.ExploreMain).Spend).ChangeNumberTxt).text = "[color=" .. Const.RedColor .. "]" .. cost .. "[/color]"
  end
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((uis.ExploreMain).Spend).TimeTxt).text = (PUtil.get)(60000621, (LuaTime.GetTimeStrVersion2)(config.explore_time * NewActivityDungeonData.CurrentTimes, true))
end

NewActivityDungeonMainWindow.RefreshExploreDuration = function(id, data, ...)
  -- function num : 0_28 , upvalues : NewActivityDungeonMainWindow, uis, _ENV, NewActivityDungeonData, _countDownTimer
  (NewActivityDungeonMainWindow.StopCountDownTimer)()
  local finish = function(needRefresh, ...)
    -- function num : 0_28_0 , upvalues : uis, _ENV, NewActivityDungeonData, data, NewActivityDungeonMainWindow, id
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    (((uis.ExploreMain).Spend).TimeTxt).text = (PUtil.get)(60000654)
    ;
    (NewActivityDungeonData.UpdateStatus)(data)
    ;
    (NewActivityDungeonMainWindow.RefreshExplorationStatus)()
    ;
    (NewActivityDungeonMainWindow.RefreshExploreBtn)(id, data)
    if needRefresh then
      (NewActivityDungeonService.ReqRiskData)(id)
    end
  end

  if data then
    if data.status ~= NADAdventueStatus.Finish then
      local leftTime = (math.ceil)(data.endTime * 0.001) - (LuaTime.GetTimeStamp)()
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (((uis.ExploreMain).Spend).TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetTimeStrVersion2)(leftTime, true))
      -- DECOMPILER ERROR at PC42: Unhandled construct in 'MakeBoolean' P1

      if leftTime < 3600 and leftTime > 0 then
        _countDownTimer = (SimpleTimer.new)(1, leftTime, function(...)
    -- function num : 0_28_1 , upvalues : data, _ENV, finish, uis
    if data.endTime <= (ActorData.GetServerTime)() then
      finish(true)
      return 
    end
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.ExploreMain).Spend).TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetTimeStrVersion2)((math.floor)(data.endTime * 0.001) - (LuaTime.GetTimeStamp)(), true))
  end
)
        _countDownTimer:start()
      end
      local refreshTime = leftTime % 60
      _countDownTimer = (SimpleTimer.setTimeout)(refreshTime, function(...)
    -- function num : 0_28_2 , upvalues : _ENV, data, uis, _countDownTimer, NewActivityDungeonMainWindow, finish
    local leftTime = (math.floor)(data.endTime * 0.001) - (LuaTime.GetTimeStamp)()
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.ExploreMain).Spend).TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetTimeStrVersion2)(leftTime, true))
    if leftTime > 0 then
      _countDownTimer = (SimpleTimer.new)(60, -1, function(...)
      -- function num : 0_28_2_0 , upvalues : _ENV, data, NewActivityDungeonMainWindow, _countDownTimer, finish, uis
      local leftTime = (math.ceil)(data.endTime * 0.001) - (LuaTime.GetTimeStamp)()
      if leftTime < 3600 then
        (NewActivityDungeonMainWindow.StopCountDownTimer)()
        _countDownTimer = (SimpleTimer.new)(1, leftTime, function(...)
        -- function num : 0_28_2_0_0 , upvalues : data, _ENV, finish, uis, leftTime
        if data.endTime <= (ActorData.GetServerTime)() then
          finish(true)
          return 
        end
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (((uis.ExploreMain).Spend).TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetTimeStrVersion2)(leftTime, true))
      end
)
        _countDownTimer:start()
      else
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (((uis.ExploreMain).Spend).TimeTxt).text = (PUtil.get)(60000622, (LuaTime.GetTimeStrVersion2)(leftTime, true))
      end
    end
)
      _countDownTimer:start()
    end
  end
)
    else
      do
        finish()
      end
    end
  end
end

NewActivityDungeonMainWindow.StopCountDownTimer = function(...)
  -- function num : 0_29 , upvalues : _countDownTimer
  if _countDownTimer then
    _countDownTimer:stop()
    _countDownTimer = nil
  end
end

NewActivityDungeonMainWindow.RefreshExploreBtn = function(id, data, ...)
  -- function num : 0_30 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if data.status ~= NADAdventueStatus.Finish then
    (((uis.ExploreMain).Spend).StartBtn).visible = not data
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((uis.ExploreMain).Spend).StartBtn).text = (PUtil.get)(20000370)
    ;
    ((((uis.ExploreMain).Spend).StartBtn).onClick):Set(function(...)
    -- function num : 0_30_0 , upvalues : _ENV, id
    (NewActivityDungeonMgr.ReqEndRisk)(id)
  end
)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((uis.ExploreMain).Spend).StartBtn).visible = true
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((uis.ExploreMain).Spend).StartBtn).text = (PUtil.get)(60000623)
    ;
    ((((uis.ExploreMain).Spend).StartBtn).onClick):Set(function(...)
    -- function num : 0_30_1 , upvalues : _ENV, id
    (NewActivityDungeonMgr.ReqBeginRisk)(id)
  end
)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

NewActivityDungeonMainWindow.RefreshActiveRole = function(id, ...)
  -- function num : 0_31 , upvalues : _riskStageConfigs, uis, _ENV, NewActivityDungeonMainWindow
  local config = _riskStageConfigs[id]
  ;
  (((uis.ExploreMain).UpCard).CardList):RemoveChildrenToPool()
  if (Util.StringIsNullOrEmpty)(config.card_group) then
    return 
  end
  local roleInfo = split(config.card_group, ",")
  local count = #roleInfo
  local item = nil
  local enhance = 0
  for i = 1, count do
    item = (((uis.ExploreMain).UpCard).CardList):AddItemFromPool()
    enhance = enhance + (NewActivityDungeonMainWindow.RefreshActiveRoleItem)(roleInfo[i], item)
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((uis.ExploreMain).UpCard).WordTxt).text = (PUtil.get)(60000652, enhance)
end

NewActivityDungeonMainWindow.RefreshActiveRoleItem = function(data, item, ...)
  -- function num : 0_32 , upvalues : _ENV
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

NewActivityDungeonMainWindow.RefreshAssistFightInfo = function(...)
  -- function num : 0_33 , upvalues : NewActivityDungeonData, _assistTimer, _ENV, uis, NewActivityDungeonMainWindow, _bossId, _mask, _bossModel
  if NewActivityDungeonData.AssistData == nil or NewActivityDungeonData.NADData == nil then
    return 
  end
  if _assistTimer ~= nil then
    _assistTimer:Stop()
  end
  _assistTimer = (LuaTime.CountDown)((math.ceil)((NewActivityDungeonData.NADData).endTime * 0.001) - (LuaTime.GetTimeStamp)(), (uis.AssistBattleMain).TimeTxt, nil, true, nil, 60000627)
  ;
  (NewActivityDungeonMainWindow.RefreshBossHP)()
  local config = ((TableData.gTable).BaseActivityAidData)[(NewActivityDungeonData.AssistData).id]
  if _bossId == config.fashionID_show then
    return 
  else
    _bossId = config.fashionID_show
    local fashionConfig = ((TableData.gTable).BaseFashionData)[config.fashionID_show]
    local offset = {x = 0, y = 0}
    do
      if not (Util.StringIsNullOrEmpty)(config.location) then
        local offsetStr = split(config.location, ":")
        offset.x = offset.x + tonumber(offsetStr[1])
        offset.y = offset.y + tonumber(offsetStr[2])
      end
      if (Util.StringIsNullOrEmpty)(fashionConfig.show_cg) then
        (Util.RecycleUIModel)((((uis.AssistBattleMain).BattleTips).BossPic).ImageLoader)
        ;
        (Util.CreateShowModel)(config.fashionID_show, (((uis.AssistBattleMain).BattleTips).BossPic).ImageLoader)
        ;
        (Util.SetModelClip)((((uis.AssistBattleMain).BattleTips).BossPic).ImageLoader, _mask, true)
        -- DECOMPILER ERROR at PC114: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((((uis.AssistBattleMain).BattleTips).BossPic).ImageLoader).x = offset.x
        -- DECOMPILER ERROR at PC120: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((((uis.AssistBattleMain).BattleTips).BossPic).ImageLoader).y = offset.y
      else
        if _bossModel then
          (ResHelper.DestroyGameObject)(_bossModel, false)
        end
        local holder = nil
        holder = (LuaEffect.AddUIEffect)(fashionConfig.show_cg, false, false, Vector3.zero, 1)
        ;
        ((((uis.AssistBattleMain).BattleTips).BossPic).root):AddChildAt(holder, 1)
        holder:SetXY(((((uis.AssistBattleMain).BattleTips).BossPic).root).width / 2 + offset.x, ((((uis.AssistBattleMain).BattleTips).BossPic).root).height / 2 + offset.y)
      end
    end
  end
end

NewActivityDungeonMainWindow.RefreshBossHP = function(...)
  -- function num : 0_34 , upvalues : uis, _ENV, NewActivityDungeonData
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.AssistBattleMain).BattleTips).HpTxt).text = (PUtil.get)(60000653, (math.ceil)((NewActivityDungeonData.AssistData).remainHp))
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.AssistBattleMain).BattleTips).HpProgressBar).value = (NewActivityDungeonData.AssistData).remainHp
end

NewActivityDungeonMainWindow.ClickMinusBtn = function(...)
  -- function num : 0_35 , upvalues : _ENV, _riskStageConfigs, _currentStageId
  (NewActivityDungeonMgr.ChangeExploreTimes)(-1, _riskStageConfigs[_currentStageId])
end

NewActivityDungeonMainWindow.ClickAddBtn = function(...)
  -- function num : 0_36 , upvalues : _ENV, _riskStageConfigs, _currentStageId
  (NewActivityDungeonMgr.ChangeExploreTimes)(1, _riskStageConfigs[_currentStageId])
end

NewActivityDungeonMainWindow.ClickMaxBtn = function(...)
  -- function num : 0_37 , upvalues : _ENV, _riskStageConfigs, _currentStageId
  (NewActivityDungeonMgr.ChangeExploreTimes)(0, _riskStageConfigs[_currentStageId])
end

NewActivityDungeonMainWindow.ClickPageBtn = function(type, ...)
  -- function num : 0_38 , upvalues : _pageBtns, uis, NewActivityDungeonMainWindow, PageType, _ENV, _book, IDLE2_ANIM, IDLE_ANIM, _dungeonInited
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (_pageBtns[(uis.c1Ctr).selectedIndex]).selected = false
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_pageBtns[type]).selected = true
  ;
  (NewActivityDungeonMainWindow.RefreshPageLine)(type)
  if ((uis.c1Ctr).selectedIndex == PageType.AssistFight and type ~= PageType.AssistFight) or (uis.c1Ctr).selectedIndex ~= PageType.AssistFight and type == PageType.AssistFight then
    if type == PageType.AssistFight then
      (SkeletonAnimationUtil.SetAnimation)(_book, 0, IDLE2_ANIM, true)
    else
      ;
      (SkeletonAnimationUtil.SetAnimation)(_book, 0, IDLE_ANIM, true)
    end
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = type
  if (uis.c1Ctr).selectedIndex == PageType.Exploration then
    (NewActivityDungeonMainWindow.InitExplorationInfo)()
  else
    ;
    (NewActivityDungeonMainWindow.StopCountDownTimer)()
    if (uis.c1Ctr).selectedIndex == PageType.AssistFight then
      (NewActivityDungeonMgr.InitAssistData)()
      ;
      (NewActivityDungeonMainWindow.RefreshAssistFightInfo)()
    else
      if not _dungeonInited then
        (NewActivityDungeonMainWindow.InitDungeonInfo)()
      end
    end
  end
end

NewActivityDungeonMainWindow.ClickRewardShowBtn = function(...)
  -- function num : 0_39 , upvalues : _ENV
  (NewActivityDungeonMgr.OpenPhaseRewardShow)()
end

NewActivityDungeonMainWindow.ClickGulidAssistBtn = function(...)
  -- function num : 0_40 , upvalues : _ENV
  (NewActivityDungeonMgr.OpenGuildAssist)()
end

NewActivityDungeonMainWindow.ClickChallengeBtn = function(...)
  -- function num : 0_41 , upvalues : _ENV, _challengeBoss
  if (NewActivityDungeonMgr.TryChallengeBoss)() then
    _challengeBoss = true
  end
end

NewActivityDungeonMainWindow.ClickLeftBtn = function(...)
  -- function num : 0_42 , upvalues : NewActivityDungeonMainWindow, _currentMapIndex
  (NewActivityDungeonMainWindow.RefreshDungeonInfo)(_currentMapIndex - 1, 1)
end

NewActivityDungeonMainWindow.ClickRightBtn = function(...)
  -- function num : 0_43 , upvalues : _ENV, _currentMapIndex, NewActivityDungeonMainWindow
  if (NewActivityDungeonMgr.CheckNextChapter)(_currentMapIndex + 1) then
    (NewActivityDungeonMainWindow.RefreshDungeonInfo)(_currentMapIndex + 1, 2)
  end
end

NewActivityDungeonMainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_44 , upvalues : _ENV, NewActivityDungeonMainWindow, uis, PageType, NewActivityDungeonData, _riskStageConfigs, _currentStageId, _currentMapIndex
  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE_COST then
    (NewActivityDungeonMainWindow.RefreshExploreCost)()
  else
    -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

    if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_EXPLORE and (uis.c1Ctr).selectedIndex == PageType.Exploration then
      (NewActivityDungeonMainWindow.InitExplorationInfo)()
    end
  end
  -- DECOMPILER ERROR at PC34: Unhandled construct in 'MakeBoolean' P1

  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_AFTER_PURCHASE and (uis.c1Ctr).selectedIndex == PageType.Exploration then
    (NewActivityDungeonData.RefreshEachExploreCost)(_riskStageConfigs[_currentStageId])
    ;
    (NewActivityDungeonMainWindow.RefreshExploreCost)()
  end
  -- DECOMPILER ERROR at PC49: Unhandled construct in 'MakeBoolean' P1

  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_ASSIST_FIGHT and (uis.c1Ctr).selectedIndex == PageType.AssistFight then
    (NewActivityDungeonMainWindow.RefreshAssistFightInfo)()
  end
  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_BOSS_HP then
    (NewActivityDungeonMainWindow.RefreshBossHP)()
  else
    if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH then
      (NewActivityDungeonMainWindow.RefreshDungeonInfo)(_currentMapIndex)
    end
  end
end

return NewActivityDungeonMainWindow

