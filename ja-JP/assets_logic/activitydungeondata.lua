-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityDungeonData = {}
local ActivityDungeonChapterStageInfos, ActivityDungeonChapterData, ActivityDungeonInfo = nil, nil, nil
local SelectedStageId = -1
local ActivityAdventureData, ActivityRewardShowData = nil, nil
local Reset = function(...)
  -- function num : 0_0 , upvalues : SelectedStageId, ActivityDungeonInfo, ActivityAdventureData, ActivityRewardShowData, ActivityDungeonChapterData, ActivityDungeonChapterStageInfos
  SelectedStageId = -1
  ActivityDungeonInfo = nil
  ActivityAdventureData = {}
  ActivityRewardShowData = {}
  ActivityDungeonChapterData = {}
  ActivityDungeonChapterStageInfos = {}
end

local Comparer = function(lhs, rhs, ...)
  -- function num : 0_1
  do return lhs.sort < rhs.sort end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local GetNextRefreshTimestamp = function(beginTime, exploreTime, eventRefreshTime, ...)
  -- function num : 0_2 , upvalues : _ENV
  exploreTime = exploreTime * 1000
  eventRefreshTime = eventRefreshTime * 1000
  local curTime = (ActorData.GetServerTime)()
  local passedTime = curTime - beginTime
  local nextInterval1 = exploreTime - passedTime % (exploreTime)
  local nextInterval2 = eventRefreshTime - passedTime % (eventRefreshTime)
  local nextInterval = (math.min)(nextInterval1, nextInterval2)
  return curTime + nextInterval
end

ActivityDungeonData.Init = function(dungeonInfo, ...)
  -- function num : 0_3 , upvalues : Reset, ActivityDungeonInfo, ActivityDungeonData
  Reset()
  ActivityDungeonInfo = dungeonInfo
  ;
  (ActivityDungeonData.InitCurrentActivityDungeonChapters)()
end

ActivityDungeonData.InitCurrentActivityDungeonChapters = function(...)
  -- function num : 0_4 , upvalues : ActivityDungeonData, _ENV, ActivityDungeonChapterData, Comparer, ActivityDungeonChapterStageInfos
  local activityDungeonId = (ActivityDungeonData.GetCurrentActivityDungeonId)()
  if activityDungeonId == -1 then
    return 
  end
  local activityChapterData = (TableData.gTable).BaseActivityChapterData
  for _,item in pairs(activityChapterData) do
    if item and item.activity_id == activityDungeonId then
      (table.insert)(ActivityDungeonChapterData, item)
    end
  end
  ;
  (table.sort)(ActivityDungeonChapterData, Comparer)
  local count = #ActivityDungeonChapterData
  for i = 1, count do
    local chapterData = ActivityDungeonChapterData[i]
    local hardChapter = ((TableData.gTable).BaseChapterData)[chapterData.hard_chapter]
    local normalChapter = ((TableData.gTable).BaseChapterData)[chapterData.normal_chapter]
    local stages = nil
    if hardChapter then
      stages = split(hardChapter.stages, ":")
      if not ActivityDungeonChapterStageInfos[chapterData.id] then
        ActivityDungeonChapterStageInfos[chapterData.id] = {}
      end
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (ActivityDungeonChapterStageInfos[chapterData.id]).hard = {chapterId = hardChapter.id, stages = stages}
    end
    if normalChapter then
      stages = split(normalChapter.stages, ":")
      if not ActivityDungeonChapterStageInfos[chapterData.id] then
        ActivityDungeonChapterStageInfos[chapterData.id] = {}
      end
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (ActivityDungeonChapterStageInfos[chapterData.id]).normal = {chapterId = normalChapter.id, stages = stages}
    end
  end
end

ActivityDungeonData.GetCurrentActivityDungeonId = function(...)
  -- function num : 0_5 , upvalues : ActivityDungeonInfo
  return ActivityDungeonInfo and ActivityDungeonInfo.actId or -1
end

ActivityDungeonData.GetCurrentActivityBeginTime = function(...)
  -- function num : 0_6 , upvalues : ActivityDungeonInfo
  return ActivityDungeonInfo and ActivityDungeonInfo.beginTime or -1
end

ActivityDungeonData.GetCurrentActivityDeadline = function(...)
  -- function num : 0_7 , upvalues : ActivityDungeonInfo
  return ActivityDungeonInfo and ActivityDungeonInfo.endTime or -1
end

ActivityDungeonData.WithoutChapterInfos = function(...)
  -- function num : 0_8 , upvalues : ActivityDungeonChapterData
  do return #ActivityDungeonChapterData == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityDungeonData.TryGetChapterDataByIndex = function(index, ...)
  -- function num : 0_9 , upvalues : _ENV, ActivityDungeonChapterData
  local result, chapterData = false, nil
  if type(index) == "number" and ActivityDungeonChapterData and ActivityDungeonChapterData[index] then
    result = true
    chapterData = ActivityDungeonChapterData[index]
  end
  return result, chapterData
end

ActivityDungeonData.TryGetChapterStageInfo = function(chapterId, ...)
  -- function num : 0_10 , upvalues : ActivityDungeonChapterStageInfos, _ENV
  local result, chapterData = false, ActivityDungeonChapterStageInfos[chapterId]
  if type(chapterId) == "number" and chapterData then
    result = true
  end
  return result, chapterData
end

ActivityDungeonData.GetAllChapterStageInfos = function(...)
  -- function num : 0_11 , upvalues : ActivityDungeonChapterStageInfos
  return ActivityDungeonChapterStageInfos
end

ActivityDungeonData.GetChapterByIndex = function(index, ...)
  -- function num : 0_12 , upvalues : ActivityDungeonChapterData
  return ActivityDungeonChapterData[index]
end

ActivityDungeonData.GetChapterCount = function(...)
  -- function num : 0_13 , upvalues : ActivityDungeonChapterData
  return #ActivityDungeonChapterData
end

ActivityDungeonData.GetChapterIndex = function(...)
  -- function num : 0_14 , upvalues : ActivityDungeonData, ActivityDungeonChapterData, ActivityDungeonChapterStageInfos, _ENV
  local stageIndex = nil
  local chapterIndex = 1
  local chapterItem, subCount = nil, nil
  local count = (ActivityDungeonData.GetChapterCount)()
  for i = 1, count do
    local chapterData = ActivityDungeonChapterData[i]
    chapterItem = (ActivityDungeonChapterStageInfos[chapterData.id]).normal
    subCount = #chapterItem.stages
    for j = 1, subCount do
      if (PlotDungeonMgr.GetDungeonStatus)(tonumber((chapterItem.stages)[j])) ~= StageStatus.Lock and (PlotDungeonMgr.IsCanChallenge)(tonumber((chapterItem.stages)[j]), false) then
        chapterIndex = i
        stageIndex = j
      end
    end
  end
  if stageIndex == nil then
    chapterIndex = count
    stageIndex = #((ActivityDungeonChapterStageInfos[(ActivityDungeonChapterData[chapterIndex]).id]).normal).stages
  end
  return chapterIndex, stageIndex
end

ActivityDungeonData.CurrentActivityIsNew = function(...)
  -- function num : 0_15 , upvalues : _ENV, ActivityDungeonData
  local activityData = ((TableData.gTable).BaseActivityData)[(ActivityDungeonData.GetCurrentActivityDungeonId)()]
  if activityData then
    if activityData.type == 14 then
      return true
    end
    if activityData.type == 2 then
      return false
    end
  end
end

ActivityDungeonData.DungeonIsOpen = function(...)
  -- function num : 0_16 , upvalues : ActivityDungeonInfo, _ENV
  do
    if ActivityDungeonInfo then
      local time = ActivityDungeonInfo.endTime
      return time - (ActorData.GetServerTime)() > 0
    end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

ActivityDungeonData.HasInitDungeonInfo = function(...)
  -- function num : 0_17 , upvalues : ActivityDungeonInfo
  do return ActivityDungeonInfo ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityDungeonData.SetSelectedStageId = function(stageId, ...)
  -- function num : 0_18 , upvalues : SelectedStageId
  SelectedStageId = stageId
end

ActivityDungeonData.GetSelectedStageId = function(...)
  -- function num : 0_19 , upvalues : SelectedStageId
  return SelectedStageId
end

return ActivityDungeonData

