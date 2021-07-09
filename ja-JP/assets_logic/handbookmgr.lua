-- params : ...
-- function num : 0 , upvalues : _ENV
HandBookMgr = {}
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

HandBookMgr.AdventureStoryType = {MainStory = 1, HeroStory = 2, Activity = 3}
-- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

HandBookMgr.SwitchCardDirection = {Left = -1, Right = 1}
-- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

HandBookMgr.CardPlotWinType = {Story = 1, Intimacy = 2}
local self = HandBookMgr
-- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.SetHandBookMain = function(msg, ...)
  -- function num : 0_0 , upvalues : _ENV
  UIMgr:SendWindowMessage((WinResConfig.HandBookMainWindow).name, 1, {msg.cardId, msg.fashionId, msg.intimacyLv})
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.HandleAdventureStoryChapter = function(data, ...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  if #data.chapterId > 0 or #data.pointPlotInfo > 0 then
    HandBookData.StoryChapter = {}
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    HandBookData.UnlockedChapter = {}
    local count = #data.chapterId
    for i = 1, count do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

      (HandBookData.UnlockedChapter)[(data.chapterId)[i]] = true
    end
    local configs = (TableData.gTable).BaseHandbookAdventureChapterData
    for k,v in pairs(configs) do
      if v.type == (HandBookMgr.AdventureStoryType).MainStory and (HandBookData.UnlockedChapter)[k] then
        (table.insert)(HandBookData.StoryChapter, k)
      end
    end
    count = #data.pointPlotInfo
    local each = nil
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R4 in 'UnsetPending'

    HandBookData.ScoreChapterStatus = {}
    for i = 1, count do
      each = (data.pointPlotInfo)[i]
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (HandBookData.ScoreChapterStatus)[each.plotId] = each
      ;
      (table.insert)(HandBookData.StoryChapter, each.plotId)
    end
    ;
    (table.sort)(HandBookData.StoryChapter, function(x, y, ...)
    -- function num : 0_1_0 , upvalues : _ENV
    local xConfig = ((TableData.gTable).BaseHandbookAdventureChapterData)[x]
    local yConfig = ((TableData.gTable).BaseHandbookAdventureChapterData)[y]
    if xConfig.sort == yConfig.sort then
      return false
    else
      return xConfig.sort < yConfig.sort
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
    local lastChapter = (HandBookData.StoryChapter)[#HandBookData.StoryChapter]
    local config = ((TableData.gTable).BaseHandbookAdventureChapterData)[lastChapter]
    if config.unlockPoints == 0 then
      (HandBookService.OnReqAdventureStoryStage)(lastChapter)
    else
      local data = (HandBookData.ScoreChapterStatus)[lastChapter]
      if data and config.unlockPoints <= data.point then
        for k,v in pairs(configs) do
          if v.type == (HandBookMgr.AdventureStoryType).MainStory and v.sort == config.sort + 1 then
            (table.insert)(HandBookData.StoryChapter, k)
            -- DECOMPILER ERROR at PC130: Confused about usage of register: R12 in 'UnsetPending'

            HandBookData.QueryingId = k
            -- DECOMPILER ERROR at PC135: Confused about usage of register: R12 in 'UnsetPending'

            HandBookData.UnlockState = (HandBookData.PlotLockState).Lock
          end
        end
      end
    end
    do
      do
        OpenWindow((WinResConfig.HandbookMainPlotWindow).name, UILayer.HUD)
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000250))
      end
    end
  end
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.HandleActivityStoryChapter = function(ids, type, JumpToType, JumpToID, ...)
  -- function num : 0_2 , upvalues : _ENV
  if #ids > 0 then
    (HandBookMgr.ActivityStoryChapter)(ids)
    if JumpToType and JumpToType > 0 then
      if (HandBookMgr.ActivityStoryChapterIsOpen)(JumpToType) then
        OpenWindow((WinResConfig.HandBookStoryPlotWindow).name, UILayer.HUD, (HandBookMgr.AdventureStoryType).Activity, JumpToType, JumpToID)
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000405))
        ;
        (Util.SetPlayerSetting)(PlayerPrefsKeyName.ACTIVITY_DUNGEON_PLOT_DOT, 0)
      end
    else
      OpenWindow((WinResConfig.HandBookActivityPlotWindow).name, UILayer.HUD)
    end
  else
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(20000250))
  end
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.ActivityStoryChapterIsOpen = function(Type, ...)
  -- function num : 0_3 , upvalues : _ENV
  local ActivityChapterList = (HandBookMgr.GetChapterActivityType)()
  local ActData = (TableData.gTable).BaseHandbookAdventureChapterActData
  for _,v in pairs(ActData) do
    local activityType = v.activity_type
    local chapterList = ActivityChapterList[activityType]
    for _,v2 in ipairs(chapterList) do
      if (HandBookMgr.ActivityChapterIsUnlock)(v2.id) and activityType == Type then
        return true
      end
    end
  end
  return false
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.AdventureStoryChapter = function(data, ...)
  -- function num : 0_4 , upvalues : self
  if data == nil then
    return self.StoryChapters
  else
    self.StoryChapters = data
  end
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.ActivityStoryChapter = function(data, ...)
  -- function num : 0_5 , upvalues : self
  if data == nil then
    return self.ActivityChapters
  else
    self.ActivityChapters = data
  end
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.ChapterIsUnlock = function(id, ...)
  -- function num : 0_6 , upvalues : self, _ENV
  if not self.StoryChapters then
    return 
  end
  for _,v in ipairs(self.StoryChapters) do
    if v == id then
      return true
    end
  end
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.ActivityChapterIsUnlock = function(id, ...)
  -- function num : 0_7 , upvalues : self, _ENV
  if not self.ActivityChapters then
    return 
  end
  for _,v in ipairs(self.ActivityChapters) do
    if v == id then
      return true
    end
  end
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetChapterActivityType = function(...)
  -- function num : 0_8 , upvalues : self, _ENV
  if self.ActivityChapterList ~= nil then
    return self.ActivityChapterList
  end
  self.ActivityChapterList = {}
  local ActData = (TableData.gTable).BaseHandbookAdventureChapterData
  for _,v in pairs(ActData) do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

    if v.type == (HandBookMgr.AdventureStoryType).Activity then
      if (self.ActivityChapterList)[v.activity_type] == nil then
        (self.ActivityChapterList)[v.activity_type] = {}
      end
      ;
      (table.insert)((self.ActivityChapterList)[v.activity_type], v)
    end
  end
  return self.ActivityChapterList
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.AdventureStoryStage = function(data, ...)
  -- function num : 0_9 , upvalues : self
  if data == nil then
    return self.StoryStage
  else
    self.StoryStage = data
  end
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.ReserveStagePos = function(pos, ...)
  -- function num : 0_10 , upvalues : self
  if not self.ReservePos then
    do return pos ~= nil or -1 end
    self.ReservePos = pos
  end
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.AdventureStoryStageIsOpen = function(stageId, ...)
  -- function num : 0_11 , upvalues : _ENV, self
  for _,v in pairs(self.StoryStage) do
    if v == stageId then
      return true
    end
  end
end

self.ChapterData = {}
-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetChapter = function(type, ...)
  -- function num : 0_12 , upvalues : self, _ENV
  if (self.ChapterData)[type] == nil then
    local chapterS = {}
    local ChapterData = (TableData.gTable).BaseHandbookAdventureChapterData
    for _,v in pairs(ChapterData) do
      if v.type == type then
        (table.insert)(chapterS, v)
      end
    end
    ;
    (table.sort)(chapterS, function(a, b, ...)
    -- function num : 0_12_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.ChapterData)[type] = chapterS
  end
  do
    return (self.ChapterData)[type]
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.CGCopySummaryData = function(data, ...)
  -- function num : 0_13 , upvalues : self, _ENV
  if data == nil then
    local summaryData = {}
    local count = #self.CGCopySummary
    local limitConfig = nil
    for i = 1, count do
      limitConfig = ((TableData.gTable).BaseCardLimitData)[((self.CGCopySummary)[i]).cardId]
      if limitConfig == nil or limitConfig.handbook_display ~= 0 and (limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time)) then
        (table.insert)(summaryData, (self.CGCopySummary)[i])
      end
    end
    return summaryData
  else
    do
      self.CGCopySummary = data
    end
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.IntimacyCardData = function(data, ...)
  -- function num : 0_14 , upvalues : self
  if data == nil then
    return self.IntimacyData
  else
    self.IntimacyData = data
  end
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.InitHandBookStage = function(...)
  -- function num : 0_15 , upvalues : _ENV, self
  local StageData = (TableData.gTable).BaseHandbookStageData
  self.StageData = {}
  for _,v in pairs(StageData) do
    local data = (self.StageData)[v.card_id]
    if data == nil then
      local stages = {}
      ;
      (table.insert)(stages, v)
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.StageData)[v.card_id] = stages
    else
      do
        do
          ;
          (table.insert)(data, v)
          -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self.StageData)[v.card_id] = data
          -- DECOMPILER ERROR at PC32: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC32: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC32: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetCardMaxNumStage = function(cardId, ...)
  -- function num : 0_16 , upvalues : self, _ENV
  if self.StageData == nil then
    (HandBookMgr.InitHandBookStage)()
  end
  local stages = (self.StageData)[cardId]
  if stages then
    return #stages
  else
    return 0
  end
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetCardStageList = function(cardId, ...)
  -- function num : 0_17 , upvalues : self, _ENV
  if self.StageData == nil then
    (HandBookMgr.InitHandBookStage)()
  end
  local stages = (self.StageData)[cardId]
  ;
  (table.sort)(stages, function(a, b, ...)
    -- function num : 0_17_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return stages
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.CGSummaryToggleState = function(up, intimacy, ...)
  -- function num : 0_18 , upvalues : self
  if up == nil and intimacy == nil then
    return self.UpToggleState, self.intimacyToggleState
  else
    self.UpToggleState = up
    self.intimacyToggleState = intimacy
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.AlbumToggleState = function(new, up, ...)
  -- function num : 0_19 , upvalues : self
  if new == nil and up == nil then
    return self.AlbumNewToggle, self.AlbumUpToggle
  else
    self.AlbumUpToggle = up
    self.AlbumNewToggle = new
  end
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.LetterToggleState = function(new, up, ...)
  -- function num : 0_20 , upvalues : self
  if new == nil and up == nil then
    return self.LetterNewToggle, self.LetterUpToggle
  else
    self.LetterUpToggle = up
    self.LetterNewToggle = new
  end
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.SetAlbumData = function(data, ...)
  -- function num : 0_21 , upvalues : self, _ENV
  self.AlbumData = data
  if UIMgr:IsWindowOpen((WinResConfig.HandBookAlbumWindow).name) then
    UIMgr:SendWindowMessage((WinResConfig.HandBookAlbumWindow).name, 1)
  else
    OpenWindow((WinResConfig.HandBookAlbumWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.SetLetterData = function(data, ...)
  -- function num : 0_22 , upvalues : self, _ENV
  self.LetterData = data
  UIMgr:SendWindowMessage((WinResConfig.HandBookAlbumWindow).name, 1)
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.SetAlbumNotNew = function(id, ...)
  -- function num : 0_23 , upvalues : _ENV, self
  for _,v in ipairs(self.AlbumData) do
    if v.CGId == id then
      v.isNew = false
    end
  end
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetAlbumState = function(id, ...)
  -- function num : 0_24 , upvalues : _ENV, self
  for _,v in ipairs(self.AlbumData) do
    if v.CGId == id then
      return true, v.isNew
    end
  end
  return false, false
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetLetterState = function(id, ...)
  -- function num : 0_25 , upvalues : _ENV, self
  for _,v in ipairs(self.LetterData) do
    if v.letterId == id then
      return true, v.isNew
    end
  end
  return false, false
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetAlbumCollectionNum = function(...)
  -- function num : 0_26 , upvalues : self
  return #self.AlbumData
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetAlbumCollectionNumByType = function(type, ...)
  -- function num : 0_27 , upvalues : _ENV, self
  local Amount = 0
  for _,v in ipairs(self.AlbumData) do
    local data = ((TableData.gTable).BaseHandbookCGData)[v.CGId]
    if data ~= nil and data.type == type then
      Amount = Amount + 1
    end
  end
  return Amount
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetLetterCollectionNum = function(...)
  -- function num : 0_28 , upvalues : self
  return #self.LetterData
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetIntimacyAddAttr = function(type1, type2, type3, ...)
  -- function num : 0_29 , upvalues : _ENV
  local cards = ((CardData.GetObtainedCardList)())
  local limitConfig = nil
  local attrCount = {}
  for _,v in ipairs(cards) do
    limitConfig = ((TableData.gTable).BaseCardLimitData)[v.id]
    if limitConfig == nil or limitConfig.handbook_display ~= 0 and (limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time)) then
      local data = (HandBookMgr.GetCardIntimacyData)(v.id, v.intimacyLv)
      local attrStr = data.team_add_attr
      local attr = (Util.ParseConfigStr)(attrStr)
      for _,v2 in ipairs(attr) do
        local addType = tonumber(v2[1])
        local attrType = tonumber(v2[2])
        local attrValue = tonumber(v2[3])
        if addType == 1 then
          local value = attrCount[attrType]
          if value == nil then
            attrCount[attrType] = attrValue
          else
            attrCount[attrType] = value + attrValue
          end
        end
      end
    end
  end
  do
    return attrCount[type1] or 0, attrCount[type2] or 0, attrCount[type3] or 0
  end
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetCardIntimacyAttr = function(cardID, lv, type1, type2, type3, ...)
  -- function num : 0_30 , upvalues : _ENV
  local attrCount = {}
  local data = (HandBookMgr.GetCardIntimacyData)(cardID, lv)
  local attrStr = data.team_add_attr
  local attr = (Util.ParseConfigStr)(attrStr)
  for _,v2 in ipairs(attr) do
    local addType = tonumber(v2[1])
    local attrType = tonumber(v2[2])
    local attrValue = tonumber(v2[3])
    if addType == 1 then
      local value = attrCount[attrType]
      if value == nil then
        attrCount[attrType] = attrValue
      else
        attrCount[attrType] = value + attrValue
      end
    end
  end
  do
    return attrCount[type1] or 0, attrCount[type2] or 0, attrCount[type3] or 0
  end
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetCardIntimacyData = function(cardID, level, ...)
  -- function num : 0_31 , upvalues : _ENV
  local IntimacyUpData = ((TableData.gTable).BaseCardData)[cardID]
  local intimacyType = IntimacyUpData.intimacy_grow_type
  local IntimacyUpData = (TableData.gTable).BaseIntimacyUpData
  for _,v in pairs(IntimacyUpData) do
    if v.level == level and v.type == tonumber(intimacyType) then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetCardIntimacyMaxLevel = function(cardID, ...)
  -- function num : 0_32 , upvalues : _ENV
  local IntimacyUpData = ((TableData.gTable).BaseCardData)[cardID]
  local intimacyType = IntimacyUpData.intimacy_grow_type
  local IntimacyUpData = (TableData.gTable).BaseIntimacyUpData
  local maxLv = 0
  for _,v in pairs(IntimacyUpData) do
    if v.type == tonumber(intimacyType) then
      maxLv = (math.max)(maxLv, v.level)
    end
  end
  return maxLv
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetCardIntimacyDataByType = function(type, level, ...)
  -- function num : 0_33 , upvalues : _ENV
  local IntimacyUpData = (TableData.gTable).BaseIntimacyUpData
  for _,v in pairs(IntimacyUpData) do
    if v.level == level and v.type == tonumber(type) then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.SetCardPlotBattleData = function(data, ...)
  -- function num : 0_34 , upvalues : self
  self.BattleData = data
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetStageIsUnlock = function(stageID, ...)
  -- function num : 0_35 , upvalues : _ENV, self
  for _,v in ipairs((self.BattleData).stageList) do
    if v.stageId == stageID then
      return true
    end
  end
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetStageIsGetReward = function(stageID, ...)
  -- function num : 0_36 , upvalues : _ENV, self
  for _,v in ipairs((self.BattleData).stageList) do
    if v.stageId == stageID then
      return v.status
    end
  end
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetStagePassNum = function(...)
  -- function num : 0_37 , upvalues : _ENV, self
  local num = 0
  for _,v in ipairs((self.BattleData).stageList) do
    if v.status then
      num = num + 1
    end
  end
  return num
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetSelfCardFormation = function(...)
  -- function num : 0_38 , upvalues : self
  return (self.BattleData).cardList
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetFightStateList = function(...)
  -- function num : 0_39 , upvalues : _ENV, self
  local stageList = (HandBookMgr.GetCardStageList)((self.BattleData).cardId)
  local mTable = {}
  for _,v in ipairs(stageList) do
    if v.type == 1 then
      (table.insert)(mTable, v)
    end
  end
  return mTable
end

-- DECOMPILER ERROR at PC143: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetCurrentFightStage = function(...)
  -- function num : 0_40 , upvalues : _ENV
  local stageList = (HandBookMgr.GetFightStateList)()
  for _,v in ipairs(stageList) do
    if not (HandBookMgr.GetStageIsGetReward)(v.id) and (HandBookMgr.GetStageIsUnlock)(v.id) then
      return v.id
    end
  end
  return (stageList[#stageList]).id
end

-- DECOMPILER ERROR at PC146: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.OpenMonsterDetailWindow = function(...)
  -- function num : 0_41 , upvalues : _ENV
  local defaultStage = (HandBookMgr.GetCurrentFightStage)()
  local fightStage = (HandBookMgr.GetFightStateList)()
  local setStageItem = function(index, item, ...)
    -- function num : 0_41_0 , upvalues : fightStage, _ENV
    local config = fightStage[index]
    local layerCutGrp = item:GetChild("LayerCutGrp")
    ;
    (layerCutGrp:GetChild("ImageLoader")).url = (Util.GetItemUrl)(config.icon)
    ;
    (item:GetChild("NumberTxt")).visible = false
    return config.id
  end

  local stageLockChecker = function(index, ...)
    -- function num : 0_41_1 , upvalues : _ENV, fightStage
    return (HandBookMgr.GetStageIsUnlock)(fightStage[index])
  end

  local getStageTip = function(stageId, ...)
    -- function num : 0_41_2 , upvalues : _ENV
    return (((TableData.gTable).BaseHandbookStageData)[stageId]).remark
  end

  local getMonsterGroups = function(stageId, ...)
    -- function num : 0_41_3 , upvalues : _ENV
    return (((TableData.gTable).BaseHandbookStageData)[stageId]).monster_group_list
  end

  ;
  (MessageMgr.OpenMonsterDetailWindow)(defaultStage, {}, #fightStage, setStageItem, stageLockChecker, getStageTip, getMonsterGroups)
end

-- DECOMPILER ERROR at PC149: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.OnClickBoxEvent = function(data, ...)
  -- function num : 0_42 , upvalues : _ENV
  local reward = data.first_reward
  if data.cg_reward and tonumber(data.cg_reward) > 0 then
    reward = reward .. ",1:" .. data.cg_reward .. ":1"
  end
  if data.letter_reward and tonumber(data.letter_reward) > 0 then
    reward = reward .. ",1:" .. data.letter_reward .. ":1"
  end
  if (HandBookMgr.GetStageIsGetReward)(data.id) then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000036))
  else
    local btnData = {}
    btnData.btnTxt = (PUtil.get)(20000010)
    btnData.fun = function(...)
    -- function num : 0_42_0 , upvalues : _ENV, data
    (HandBookService.OnReqCGCopyStage)(data.id)
  end

    ;
    (MessageMgr.OpenRewardWindow)(reward, btnData, data.id, (PUtil.get)(20000045))
  end
end

-- DECOMPILER ERROR at PC152: Confused about usage of register: R1 in 'UnsetPending'

HandBookMgr.GetUpIntimacyForcePlaySfx = function(cardID, level, ...)
  -- function num : 0_43 , upvalues : _ENV
  local current = (HandBookMgr.GetCardIntimacyData)(cardID, level)
  local former = (HandBookMgr.GetCardIntimacyData)(cardID, level - 1)
  if current and former and former.rank < current.rank then
    return true
  end
  return false
end


