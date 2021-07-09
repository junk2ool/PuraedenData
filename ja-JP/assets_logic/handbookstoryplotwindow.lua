-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_StoryPlotByName")
local HBChapterConfigs = (TableData.gTable).BaseHandbookAdventureChapterData
local HandBookStoryPlotWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local chapterS = {}
local stageList = {}
local chapterIndex = 1
local selectIndex = 0
local unlockAll = false
HandBookStoryPlotWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HandBookStoryPlotWindow, chapterS
  bridgeObj:SetView((WinResConfig.HandBookStoryPlotWindow).package, (WinResConfig.HandBookStoryPlotWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetHandBook_StoryPlotUis(contentPane)
  ;
  (HandBookStoryPlotWindow.InitAssetStrip)()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.StoryPlotChapterList).itemRenderer = HandBookStoryPlotWindow.OnRenderChapterList
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.DetailsList).itemRenderer = HandBookStoryPlotWindow.OnRenderDetailList
  ;
  (uis.DetailsList):SetVirtual()
  ;
  (uis.DetailsList):SetBeginAnim(false, "up", 0.1, 0.1, true)
  local chapterData = nil
  local openType = argTable[1]
  if openType == (HandBookMgr.AdventureStoryType).MainStory then
    chapterS = argTable[2]
  else
    if openType == (HandBookMgr.AdventureStoryType).Activity then
      local activityType = tonumber(argTable[2])
      local ActivityChapterList = (HandBookMgr.GetChapterActivityType)()
      local chapterList = ActivityChapterList[activityType]
      for _,v2 in ipairs(chapterList) do
        if (HandBookMgr.ActivityChapterIsUnlock)(v2.id) then
          (table.insert)(chapterS, v2)
        end
      end
      ;
      (Util.SetPlayerSetting)(PlayerPrefsKeyName.ACTIVITY_DUNGEON_PLOT_DOT, 0)
    end
  end
  do
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.StoryPlotChapterList).numItems = #chapterS
    ;
    (LuaSound.PlaySound)(LuaSound.COMMON_SLIDE_2, SoundBank.OTHER)
    local index = 1
    if argTable[3] and argTable[3] > 0 then
      if openType == (HandBookMgr.AdventureStoryType).Activity then
        local RecordID = argTable[3]
        index = (HandBookStoryPlotWindow.GetRecordIDPos)(RecordID)
      else
        do
          index = argTable[3]
          ;
          (HandBookStoryPlotWindow.OnSelectChapter)(index, true)
        end
      end
    end
  end
end

HandBookStoryPlotWindow.GetRecordIDPos = function(id, ...)
  -- function num : 0_1 , upvalues : _ENV, chapterS
  for i,v in ipairs(chapterS) do
    local record_ids = split(v.record_ids, ":")
    for _,v2 in ipairs(record_ids) do
      if id == tonumber(v2) then
        return i
      end
    end
  end
end

HandBookStoryPlotWindow.ChapterIsUnlock = function(config, ...)
  -- function num : 0_2 , upvalues : argTable, _ENV
  local openType = argTable[1]
  if config.unlockPoints > 0 then
    -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

    if (HandBookData.ScoreChapterStatus)[config.id] and config.unlockPoints > ((HandBookData.ScoreChapterStatus)[config.id]).point then
      do return openType ~= (HandBookMgr.AdventureStoryType).MainStory end
      do return (HandBookData.UnlockedChapter)[config.id] end
      if openType == (HandBookMgr.AdventureStoryType).Activity then
        return (HandBookMgr.ActivityChapterIsUnlock)(config.id)
      end
      -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end
  end
end

HandBookStoryPlotWindow.OnRenderChapterList = function(index, obj, ...)
  -- function num : 0_3 , upvalues : chapterS, _ENV, HBChapterConfigs, argTable, HandBookStoryPlotWindow, chapterIndex
  index = #chapterS - index
  local data = nil
  if type(chapterS[index]) == "number" then
    data = HBChapterConfigs[chapterS[index]]
  else
    data = chapterS[index]
  end
  local openType = argTable[1]
  if openType == (HandBookMgr.AdventureStoryType).Activity then
    (obj:GetChild("NameTxt")).text = (PUtil.get)(20000517)
  else
    ;
    (obj:GetChild("NameTxt")).text = (PUtil.get)(20000127, index)
  end
  ;
  (obj:GetChild("WordTxt")).text = data.name
  local line = obj:GetChild("StoryLine")
  line.visible = index < #chapterS
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : HandBookStoryPlotWindow, data, chapterIndex, index, _ENV
    -- DECOMPILER ERROR at PC11: Unhandled construct in 'MakeBoolean' P1

    if (HandBookStoryPlotWindow.ChapterIsUnlock)(data) and chapterIndex ~= index then
      (HandBookStoryPlotWindow.OnSelectChapter)(index)
    end
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(20000251))
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HandBookStoryPlotWindow.OnRenderDetailList = function(index, obj, ...)
  -- function num : 0_4 , upvalues : _ENV, stageList, unlockAll, argTable
  obj = obj:GetChild("DetailsGrp")
  index = index + 1
  local stageId = tonumber(stageList[index])
  if unlockAll or (HandBookMgr.AdventureStoryStageIsOpen)(stageId) then
    ChangeUIController(obj, "c1", 0)
    ChangeUIController(obj:GetChild("DetailsIconGrp"), "c1", 0)
  else
    ChangeUIController(obj, "c1", 1)
    ChangeUIController(obj:GetChild("DetailsIconGrp"), "c1", 1)
  end
  local RecordData = ((TableData.gTable).BaseHandbookAdventureRecordData)[stageId]
  local bg = (obj:GetChild("DetailsIconGrp")):GetChild("IconImage")
  bg.url = (Util.GetItemUrl)(RecordData.icon)
  bg.fill = 5
  ;
  (obj:GetChild("NumberTxt")).text = (PUtil.get)(20000249, index)
  ;
  (obj:GetChild("WordTxt")).text = RecordData.remark
  ;
  (obj:GetChild("LockTxt")).text = (PUtil.get)(60000085)
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : unlockAll, _ENV, stageId, argTable, RecordData
    if unlockAll or (HandBookMgr.AdventureStoryStageIsOpen)(stageId) then
      local openType = argTable[1]
      if openType == (HandBookMgr.AdventureStoryType).Activity then
        OpenPlotPlay(RecordData.story_id, PlotPlayTriggerType.INSTANTLY_PLAY, nil, true)
      else
        OpenPlotPlay(RecordData.story_id, PlotPlayTriggerType.INSTANTLY_PLAY)
      end
    else
      do
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000252))
      end
    end
  end
)
end

HandBookStoryPlotWindow.OnSelectChapter = function(index, scroll, ...)
  -- function num : 0_5 , upvalues : _ENV, chapterS, HBChapterConfigs, chapterIndex, stageList, unlockAll, uis
  local chapterData = nil
  if type(chapterS[index]) == "number" then
    chapterData = HBChapterConfigs[chapterS[index]]
  else
    chapterData = chapterS[index]
  end
  chapterIndex = index
  stageList = split(chapterData.record_ids, ":")
  if chapterData.unlockPoints == 0 then
    unlockAll = false
    ;
    (HandBookService.OnReqAdventureStoryStage)(chapterData.id)
  else
    unlockAll = true
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.DetailsList).numItems = #stageList
  end
  index = #chapterS - index + 1
  if scroll then
    (uis.StoryPlotChapterList):ScrollToView(index - 1)
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.StoryPlotChapterList).selectedIndex = index - 1
  ;
  (Util.SetOnClickDelay)(0.5)
end

HandBookStoryPlotWindow.OnShown = function(...)
  -- function num : 0_6
end

HandBookStoryPlotWindow.OnHide = function(...)
  -- function num : 0_7
end

HandBookStoryPlotWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis, contentPane, argTable, chapterS, stageList, chapterIndex
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookStoryPlotWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
  chapterS = {}
  stageList = {}
  chapterIndex = 1
end

HandBookStoryPlotWindow.InitAssetStrip = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.HandBookStoryPlotWindow).name
  m.Tip = (PUtil.get)(20000128)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HandBookMainWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookStoryPlotWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_10 , upvalues : uis, stageList, _ENV, selectIndex
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  if msgId == 1 then
    (uis.DetailsList).numItems = #stageList
    ;
    (LuaSound.PlaySound)(LuaSound.COMMON_SLIDE_2, SoundBank.OTHER)
  else
    if msgId == 2 then
      ChangeController((uis.StoryPlotChoiceButtonGrp).c1Ctr, selectIndex)
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000381))
    end
  end
end

return HandBookStoryPlotWindow

