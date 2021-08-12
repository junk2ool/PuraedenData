-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_ActivityDungeonByName")
local ActivityDungeonWindow = extends(require("ActivityDungeonWindowBase"))
local this = ActivityDungeonWindow
local base = this.__base
local stages, components, chapterType = nil, nil, nil
local isRe = false
local initFirst = false
local UntilPos = "ActivityUntilPos"
local timer = 0
local chapterRe = 0
local centerIndex = 0
local currentChapter = 0
local cachedTimer = nil
ActivityDungeonWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : base, components, _ENV, this, chapterType, initFirst, currentChapter, timer
  (base.OnInit)(bridgeObj)
  components = GetActivityDungeon_ActivityDungeonUis((this.GetContentPane)())
  local result, chapterData = (ActivityDungeonData.TryGetChapterDataByIndex)(1)
  if not result then
    return 
  end
  local found, chapter = (ActivityDungeonData.TryGetChapterStageInfo)(chapterData.id)
  if not found then
    return 
  end
  chapterType = {Simple = (chapter.normal).chapterId, Difficult = (chapter.hard).chapterId}
  initFirst = true
  ;
  (this.InitMapList)()
  ;
  (this.InitButtons)()
  local param = {CloseBtnFunc = function(...)
    -- function num : 0_0_0 , upvalues : currentChapter
    currentChapter = 0
  end
, BackBtnFunc = function(...)
    -- function num : 0_0_1 , upvalues : currentChapter
    currentChapter = 0
  end
}
  ;
  (this.InitAssetStrip)(param, components.AssetStripGrp)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R6 in 'UnsetPending'

  if currentChapter > 0 then
    if currentChapter == chapterType.Simple then
      (components.c1Ctr).selectedIndex = 0
      ;
      ((components.Difficulty_01_Btn).onClick):Call()
    else
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (components.c1Ctr).selectedIndex = 1
      ;
      ((components.Difficulty_02_Btn).onClick):Call()
    end
  else
    local hard = (PlotDungeonMgr.ChapterIsOpen)(chapterType.Difficult)
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R7 in 'UnsetPending'

    if hard then
      (components.c1Ctr).selectedIndex = 1
      ;
      ((components.Difficulty_02_Btn).onClick):Call()
    else
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (components.c1Ctr).selectedIndex = 0
      ;
      ((components.Difficulty_01_Btn).onClick):Call()
    end
  end
  do
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((components.MapList).scrollPane).bouncebackEffect = false
    timer = 0
  end
end

ActivityDungeonWindow.InitButtons = function(...)
  -- function num : 0_1 , upvalues : components, _ENV, UntilPos, currentChapter, centerIndex, chapterType, this, chapterRe
  ((components.Difficulty_01_Btn):GetChild("NameTxt")).text = (PUtil.get)(20000217)
  ;
  ((components.Difficulty_01_Btn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, UntilPos, currentChapter, centerIndex, chapterType, this, chapterRe
    (Util.SetPlayerSetting)(UntilPos .. currentChapter, centerIndex)
    currentChapter = chapterType.Simple
    ;
    (this.RefreshChapter)()
    ;
    (PlotDungeonMgr.SetSelectChapter)(currentChapter)
    chapterRe = currentChapter
  end
)
  ;
  ((components.Difficulty_02_Btn):GetChild("NameTxt")).text = (PUtil.get)(20000218)
  ;
  ((components.Difficulty_02_Btn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV, chapterType, UntilPos, currentChapter, centerIndex, this, chapterRe, components
    if (PlotDungeonMgr.ChapterIsOpen)(chapterType.Difficult) then
      (Util.SetPlayerSetting)(UntilPos .. currentChapter, centerIndex)
      currentChapter = chapterType.Difficult
      ;
      (this.RefreshChapter)()
      ;
      (PlotDungeonMgr.SetSelectChapter)(currentChapter)
      chapterRe = currentChapter
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000383))
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (components.c1Ctr).selectedIndex = 0
    end
  end
)
  ;
  ((components.SweepBtn):GetChild("title")).text = (PUtil.get)(20000400)
  ;
  ((components.SweepBtn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : _ENV
    OpenWindow((WinResConfig.FastSweepWindow).name, UILayer.HUD, DungeonType.ActivityDungeon)
  end
)
  if not (PlotDungeonMgr.ChapterIsOpen)(chapterType.Difficult) then
    ((components.Difficulty_02_Btn).onClick):AddCapture(function(eventContext, ...)
    -- function num : 0_1_3 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(20000383))
    eventContext:StopPropagation()
  end
)
    ChangeUIController(components.Difficulty_02_Btn, "lock", 1)
  else
    ChangeUIController(components.Difficulty_02_Btn, "lock", 0)
  end
end

ActivityDungeonWindow.InitMapList = function(...)
  -- function num : 0_2 , upvalues : components, this
  local list = components.MapList
  list.itemRenderer = this.OnItemRenderer
  list:SetVirtual()
  ;
  ((list.scrollPane).onScroll):Add(this.OnScroll)
end

ActivityDungeonWindow.SetDeadline = function(deadline, ...)
  -- function num : 0_3 , upvalues : cachedTimer, components, _ENV
  if cachedTimer then
    cachedTimer:Stop()
    cachedTimer = nil
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (components.Time_01_Txt).text = (PUtil.get)(20000220)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  if deadline - (ActorData.GetServerTime)() <= 0 then
    (components.Time_02_Txt).text = (PUtil.get)(20000221)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (components.SweepBtn).visible = false
  else
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (components.SweepBtn).visible = true
    cachedTimer = (LuaTime.CountDown)(deadline * 0.001 - (ActorData.GetServerTime)() * 0.001, components.Time_02_Txt, function(...)
    -- function num : 0_3_0 , upvalues : components, _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (components.SweepBtn).visible = false
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (components.Time_02_Txt).text = (PUtil.get)(20000221)
  end
, true)
  end
end

ActivityDungeonWindow.RefreshChapter = function(...)
  -- function num : 0_4 , upvalues : _ENV, currentChapter, components, stages, isRe, this, UntilPos
  local chapterData = ((TableData.gTable).BaseChapterData)[tonumber(currentChapter)]
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (components.NameTxt).text = chapterData.name
  stages = split(chapterData.stages, ":")
  local lastStage = tonumber(stages[#stages])
  ;
  (table.insert)(stages, 1, -1)
  ;
  (table.insert)(stages, 1, -1)
  ;
  (table.insert)(stages, -1)
  ;
  (table.insert)(stages, -1)
  isRe = false
  local challengeIndex = (this.GetChallengeIndex)()
  do
    if (PlotDungeonMgr.IsPassDungeon)(lastStage) then
      local index = tonumber((Util.GetPlayerSetting)(UntilPos .. currentChapter, -1))
      if index >= 0 then
        isRe = true
        challengeIndex = index - 2
      end
    end
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (components.MapList).numItems = #stages
    ;
    (SimpleTimer.setTimeout)(0.01, function(...)
    -- function num : 0_4_0 , upvalues : components, challengeIndex
    if components then
      (components.MapList):ScrollToView(challengeIndex, true)
    end
  end
)
  end
end

ActivityDungeonWindow.GetChallengeIndex = function(...)
  -- function num : 0_5 , upvalues : _ENV, stages
  for i,v in ipairs(stages) do
    local stageId = tonumber(v)
    if stageId ~= -1 and (PlotDungeonMgr.IsFirstChallengeStage)(stageId) then
      return i - 3
    end
  end
  return #stages - 3
end

ActivityDungeonWindow.OnItemRenderer = function(index, item, ...)
  -- function num : 0_6 , upvalues : _ENV, stages, centerIndex, components, this, initFirst, UntilPos, currentChapter, isRe
  local stageId = tonumber(stages[index + 1])
  if stageId == nil or stageId == -1 then
    item.visible = false
    return 
  end
  local stageData = ((TableData.gTable).BaseStageData)[stageId]
  if stageData == nil then
    return 
  end
  item.visible = true
  ;
  (item:GetChild("IconLoader")).url = (Util.GetItemUrl)(stageData.icon)
  ;
  (item:GetChild("NameLoader")).url = (Util.GetItemUrl)(stageData.name_icon)
  if (PlotDungeonMgr.IsFirstChallengeStage)(stageId) then
    ChangeUIController(item, "c1", 1)
  else
    if (PlotDungeonMgr.IsCanChallenge)(stageId, false) then
      ChangeUIController(item, "c1", 0)
    else
      ChangeUIController(item, "c1", 2)
    end
  end
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : index, centerIndex, _ENV, stageId, components
    if index == centerIndex then
      if (ActivityDungeonData.DungeonIsOpen)() then
        (PlotDungeonMgr.OnClickStage)(stageId, false)
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000520))
      end
    else
      ;
      (components.MapList):ScrollToView(index - 2, true)
    end
  end
)
  local debris = stageData.card_show
  local debrisBg = item:GetChild("n14")
  local debrisLoader = item:GetChild("RewardLoader")
  if debris and debris ~= "0" then
    debrisBg.visible = true
    debrisLoader.visible = true
    debrisLoader.url = (Util.GetItemUrl)(debris)
  else
    debrisBg.visible = false
    debrisLoader.visible = false
  end
  local challengeIndex = (this.GetChallengeIndex)()
  if index == 2 and initFirst then
    local cachedIndex = tonumber((Util.GetPlayerSetting)(UntilPos .. currentChapter, -1))
    if challengeIndex == 0 or isRe and cachedIndex == 2 then
      local ss = 1.3
      item.scale = Vector2(ss, ss)
      item.width = 236 * ss
      centerIndex = index
      initFirst = false
    end
  end
end

ActivityDungeonWindow.OnScroll = function(...)
  -- function num : 0_7 , upvalues : components, _ENV, centerIndex, timer
  if components == nil then
    return 
  end
  local middleX = -((((components.MapList).container).cachedTransform).localPosition).x + (components.MapList).viewWidth / 2
  ;
  (components.MapList):TraversalItem(function(index, item, ...)
    -- function num : 0_7_0 , upvalues : _ENV, middleX, centerIndex
    local dist = (math.abs)(middleX - item.x - item.width / 2)
    if item.width < dist then
      item.scale = Vector2.one
      item.width = 236
    else
      local ss = 1 + (math.abs)(1 - dist / item.width) * 0.3
      item.scale = Vector2(ss, ss)
      item.width = 236 * ss
      if ss > 1.2 then
        centerIndex = index
      end
    end
  end
)
  timer = timer + 1
  if timer % 2 == 0 then
    (components.MapList):RefreshVirtualList()
  end
end

ActivityDungeonWindow.HandleMessage = function(msgId, param, ...)
  -- function num : 0_8 , upvalues : _ENV, this
  if msgId == (WindowMsgEnum.ActivityDungeon).E_MSG_REFRESH then
    (this.RefreshChapter)()
  else
  end
  if msgId ~= (WindowMsgEnum.ActivityDungeon).E_MSG_SET_COUNTDOWN or msgId == (WindowMsgEnum.ActivityDungeon).E_MSG_REFRESH_RED then
    (this.SetRedDot)()
  else
  end
  if msgId == (WindowMsgEnum.ActivityDungeon).E_MSG_SHOW_DIFFICULT_RED then
  end
end

ActivityDungeonWindow.OnShown = function(...)
  -- function num : 0_9 , upvalues : base, this, _ENV
  (base.OnShown)()
  ;
  (this.SetDeadline)((ActivityDungeonData.GetCurrentActivityDeadline)())
end

ActivityDungeonWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : cachedTimer, _ENV, UntilPos, chapterRe, centerIndex, base, this
  if cachedTimer then
    cachedTimer:Stop()
    cachedTimer = nil
  end
  ;
  (Util.SetPlayerSetting)(UntilPos .. chapterRe, centerIndex)
  ;
  (base.OnClose)()
  ;
  (this.__delete)()
end

return ActivityDungeonWindow

