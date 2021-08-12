-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityRiskData = {}
local this = ActivityRiskData
local ExplorationStatus = {None = 0, Exploring = 1, Finish = 2}
local ExploreTimes = 0
local ActivityAssistData, ActivityRiskDataList = nil, nil
local ActivityRewardShowData = {}
local GetNextRefreshTimestamp = function(beginTime, exploreTime, eventRefreshTime, ...)
  -- function num : 0_0 , upvalues : _ENV
  exploreTime = exploreTime * 1000
  eventRefreshTime = eventRefreshTime * 1000
  local curTime = (ActorData.GetServerTime)()
  local passedTime = curTime - beginTime
  local nextInterval1 = exploreTime - passedTime % (exploreTime)
  local nextInterval2 = eventRefreshTime - passedTime % (eventRefreshTime)
  local nextInterval = (math.min)(nextInterval1, nextInterval2)
  return curTime + nextInterval
end

ActivityRiskData.InitRiskDataList = function(riskDataList, ...)
  -- function num : 0_1 , upvalues : ActivityRiskDataList, _ENV, this
  ActivityRiskDataList = {}
  for i,riskData in pairs(riskDataList) do
    (this.InitRiskData)(riskData)
  end
end

ActivityRiskData.InitRiskData = function(riskData, ...)
  -- function num : 0_2 , upvalues : this, _ENV, GetNextRefreshTimestamp, ActivityRiskDataList
  (this.UpdateRiskStatus)(riskData)
  ;
  (this.MergeRiskRewards)(riskData)
  local config = ((TableData.gTable).BaseActivityRiskStageData)[riskData.id]
  riskData.updateTime = GetNextRefreshTimestamp(riskData.beginTime, config.explore_time, config.event_refresh_time)
  ActivityRiskDataList[riskData.id] = riskData
end

ActivityRiskData.MergeRiskRewards = function(riskData, ...)
  -- function num : 0_3 , upvalues : _ENV
  riskData.reward = {}
  if riskData.event ~= nil then
    local rewards = {}
    local count = #riskData.event
    local event, item, subCount = nil, nil, nil
    for i = 1, count do
      event = (riskData.event)[i]
      if event.reward ~= nil then
        subCount = #event.reward
        for j = 1, subCount do
          item = (event.reward)[j]
          if rewards[item.id] == nil then
            rewards[item.id] = copy(item)
          else
            -- DECOMPILER ERROR at PC43: Confused about usage of register: R14 in 'UnsetPending'

            ;
            (rewards[item.id]).value = (rewards[item.id]).value + item.value
          end
        end
      end
    end
    for k,v in pairs(rewards) do
      (table.insert)(riskData.reward, v)
    end
  end
end

ActivityRiskData.UpdateRiskStatus = function(riskData, ...)
  -- function num : 0_4 , upvalues : _ENV, ExplorationStatus
  if not riskData then
    return 
  end
  local timestamp = (ActorData.GetServerTime)()
  if riskData.endTime ~= nil and riskData.endTime < timestamp then
    riskData.status = ExplorationStatus.Finish
  else
    riskData.status = ExplorationStatus.Exploring
  end
end

ActivityRiskData.GetRiskDataById = function(riskId, ...)
  -- function num : 0_5 , upvalues : ActivityRiskDataList
  return ActivityRiskDataList[riskId]
end

ActivityRiskData.RemoveRiskData = function(riskId, ...)
  -- function num : 0_6 , upvalues : ActivityRiskDataList
  if ActivityRiskDataList[riskId] then
    ActivityRiskDataList[riskId] = nil
  end
end

ActivityRiskData.GetRiskDataList = function(...)
  -- function num : 0_7 , upvalues : ActivityRiskDataList
  return ActivityRiskDataList
end

ActivityRiskData.InitAssistData = function(data, ...)
  -- function num : 0_8 , upvalues : ActivityAssistData, _ENV
  ActivityAssistData = copy(data)
  ActivityAssistData.remainHp = ActivityAssistData.remainHp * 0.01
end

ActivityRiskData.GetAssistData = function(...)
  -- function num : 0_9 , upvalues : ActivityAssistData
  return ActivityAssistData
end

ActivityRiskData.InitShowRewardData = function(...)
  -- function num : 0_10 , upvalues : _ENV, ActivityRewardShowData
  if (_G.next)(ActivityRewardShowData) ~= nil then
    return 
  end
  local configs = (TableData.gTable).BaseActivityPhaseRewardData
  for k,v in pairs(configs) do
    (table.insert)(ActivityRewardShowData, {Id = v.id, Value = v.need_hp * 0.01})
  end
  ;
  (table.sort)(ActivityRewardShowData, function(x, y, ...)
    -- function num : 0_10_0
    if x.Value == y.Value then
      return false
    else
      return y.Value < x.Value
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
end

ActivityRiskData.GetRewardShowData = function(...)
  -- function num : 0_11 , upvalues : ActivityRewardShowData
  return ActivityRewardShowData
end

ActivityRiskData.SetExploreTimes = function(exploreTimes, ...)
  -- function num : 0_12 , upvalues : ExploreTimes
  ExploreTimes = exploreTimes
end

ActivityRiskData.GetExploreTimes = function(...)
  -- function num : 0_13 , upvalues : ExploreTimes
  return ExploreTimes
end

ActivityRiskData.CheckTimeUp = function(config, times, tips, ...)
  -- function num : 0_14 , upvalues : _ENV
  local time = (LuaTime.GetTimeStamp)()
  local deadline = (math.ceil)((ActivityDungeonData.GetCurrentActivityDeadline)() * 0.001)
  do
    if deadline < time + times * config.explore_time then
      local leftTime = deadline - time
      if leftTime <= 0 then
        times = 0
        if tips then
          (MessageMgr.SendCenterTips)((PUtil.get)(60000657))
        end
      else
        times = (math.floor)(leftTime / config.explore_time)
        if tips then
          (MessageMgr.SendCenterTips)((PUtil.get)(60000656, (LuaTime.GetFormatTimeStr)("%H:%M:%S", deadline)))
        end
      end
    end
    if times == 0 then
      times = 1
    end
    return times
  end
end

ActivityRiskData.MaxTimes = 0
ActivityRiskData.ConfigMax = nil
ActivityRiskData.CurrentExploreCost = nil
ActivityRiskData.RefreshEachExploreCost = function(config, ...)
  -- function num : 0_15 , upvalues : this, _ENV
  this.CurrentExploreCost = {}
  local costInfo = split(config.need_vit, ",")
  costInfo = split(costInfo[1], ":")
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (this.CurrentExploreCost).Type = tonumber(costInfo[1])
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (this.CurrentExploreCost).Id = tonumber(costInfo[2])
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (this.CurrentExploreCost).Value = tonumber(costInfo[3])
  this.MaxTimes = (ActorData.GetAssetCount)((this.CurrentExploreCost).Id) / (this.CurrentExploreCost).Value
  this.MaxTimes = (math.floor)(this.MaxTimes)
  local configMax = (math.floor)(config.max_explore_time / config.explore_time)
  if this.MaxTimes < configMax then
    this.ConfigMax = false
  else
    this.ConfigMax = true
    this.MaxTimes = configMax
  end
  if this.MaxTimes <= 0 then
    this.MaxTimes = 1
  end
end

ActivityRiskData.UpdateStatus = function(riskData, ...)
  -- function num : 0_16 , upvalues : _ENV, ExplorationStatus
  if riskData == nil then
    return 
  end
  local timeStamp = (ActorData.GetServerTime)()
  if riskData.endTime ~= nil and riskData.endTime < timeStamp then
    riskData.status = ExplorationStatus.Finish
  else
    riskData.status = ExplorationStatus.Exploring
  end
end

ActivityRiskData.ExplorationStatus = ExplorationStatus
return ActivityRiskData

