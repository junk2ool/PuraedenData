-- params : ...
-- function num : 0 , upvalues : _ENV
ActivityReturnData = {}
local self = ActivityReturnData
self.RETURN_BG = 72010100
self.ReasonType = {Auto = 1, Manual = 2}
self.ActivityId = 0
self.BasicData = {}
self.LoginConfigs = {}
self.TodayGet = false
self.TotalScore = 0
self.InitLevel = 0
self.Day = 0
self.Reason = (self.ReasonType).Auto
self.LoginRewards = {}
self.ScoreRewards = {}
self.LoginRewardsStatus = {}
self.ScoreRewardsStatus = {}
-- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnData.InitLoginRewardConfigs = function(...)
  -- function num : 0_0 , upvalues : self, _ENV
  self.LoginConfigs = {}
  local config = ((TableData.gTable).BaseActivityData)[self.ActivityId]
  if config == nil then
    return 
  end
  local type = tonumber(config.parameter1)
  local loginConfigs = (TableData.gTable).BaseActivityLoginData
  local lowerLv, upperLv, lvLimit = nil, nil, nil
  for k,v in pairs(loginConfigs) do
    if v.type == type then
      if not (Util.StringIsNullOrEmpty)(v.levelLimit) then
        lvLimit = split(v.levelLimit, ",")
        lowerLv = tonumber(lvLimit[1])
        upperLv = tonumber(lvLimit[2])
      else
        lowerLv = 0
        upperLv = 99999
      end
      if lowerLv <= ActivityReturnData.InitLevel and ActivityReturnData.InitLevel <= upperLv then
        (table.insert)(self.LoginConfigs, v)
      end
    end
  end
  ;
  (table.sort)(self.LoginConfigs, function(x, y, ...)
    -- function num : 0_0_0
    if x.day == y.day then
      return false
    else
      return x.day < y.day
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnData.SetRewards = function(index, login, ...)
  -- function num : 0_1 , upvalues : self, _ENV
  if #self.LoginConfigs < index then
    return 
  end
  if login then
    self.LoginRewards = split(((self.LoginConfigs)[index]).rewards, ",")
  else
    self.ScoreRewards = split(((self.LoginConfigs)[index]).pointRewards, ",")
  end
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnData.GetLoginRewardIndex = function(...)
  -- function num : 0_2 , upvalues : self, _ENV
  local count = #self.LoginConfigs
  local config = nil
  local index = 0
  local day = 0
  local dayIndex = 0
  for i = count, 1, -1 do
    config = (self.LoginConfigs)[i]
    if config.day <= ActivityReturnData.Day then
      if day < config.day then
        day = config.day
        dayIndex = i
      end
      if (self.LoginRewardsStatus)[config.id] ~= (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
        index = i
      end
    end
  end
  if index == 0 then
    index = dayIndex
  end
  return index
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

ActivityReturnData.GetScoreRewardIndex = function(...)
  -- function num : 0_3 , upvalues : self, _ENV
  local count = #self.LoginConfigs
  local config = nil
  local index = 0
  local day = 0
  local dayIndex = 0
  for i = count, 1, -1 do
    config = (self.LoginConfigs)[i]
    if config.day <= ActivityReturnData.Day then
      if day < config.day then
        day = config.day
        dayIndex = i
      end
      if (self.ScoreRewardsStatus)[config.id] ~= (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
        index = i
      end
    end
  end
  if index == 0 then
    index = dayIndex
  end
  return index
end


