-- params : ...
-- function num : 0 , upvalues : _ENV
RelicData = {
templeData = {}
, curSelectedType = nil, isWin = false, battleStageId = 0}
local self = RelicData
local ButtonType = {Elite = 1, Hero = 2}
RelicSub = {Elite = 20000, Hero = 10100}
-- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetCurSelectedType = function(...)
  -- function num : 0_0 , upvalues : _ENV
  return RelicData.curSelectedType
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

RelicData.SetCurSelectedType = function(type, ...)
  -- function num : 0_1 , upvalues : _ENV, ButtonType
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  RelicData.curSelectedType = type or ButtonType.Elite
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

RelicData.IsBattleWin = function(win, ...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  if win ~= nil then
    RelicData.isWin = win
  else
    return RelicData.isWin
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

RelicData.LastBattleStageId = function(stageId, ...)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  if stageId ~= nil then
    RelicData.battleStageId = stageId
  else
    return RelicData.battleStageId
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetCurClickedStageType = function(stageType, ...)
  -- function num : 0_4 , upvalues : self
  if stageType == nil then
    return self.curStageType
  else
    self.curStageType = stageType or 1
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

RelicData.SetTempleData = function(data, ...)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  RelicData.templeData = data
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetNormalStageNum = function(...)
  -- function num : 0_6 , upvalues : _ENV
  local sn = 0
  for index,value in ipairs((RelicData.templeData).stageInfo) do
    sn = value.id ~= 52600101 or value.surplusNum or 0
  end
  return sn
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

RelicData.SetNormalStageNum = function(num, ...)
  -- function num : 0_7 , upvalues : _ENV
  for index,value in ipairs((RelicData.templeData).stageInfo) do
    if value.id == 52600101 then
      if num < 0 then
        num = 0
      end
      value.surplusNum = num
    end
  end
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetTempleEndTime = function(...)
  -- function num : 0_8 , upvalues : _ENV
  return (RelicData.templeData).templeEndTime or 0
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetCurEliteTowerId = function(...)
  -- function num : 0_9 , upvalues : _ENV
  local eliteId = 0
  for index,value in ipairs((RelicData.templeData).stageInfo) do
    local templeId = value.id + RelicSub.Elite
    local templeData = ((TableData.gTable).BaseTempleData)[templeId]
    if templeData and templeData.type == 2 then
      eliteId = value.id
    end
  end
  do
    if value.isGeted ~= false then
      return eliteId
    end
  end
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

RelicData.SetCurEliteTowerId = function(...)
  -- function num : 0_10 , upvalues : _ENV
  local curEliteId = (RelicData.GetCurEliteTowerId)()
  local isHaveNext = (((TableData.gTable).BaseStageData)[curEliteId]).next ~= 0
  if isHaveNext then
    for index,value in ipairs((RelicData.templeData).stageInfo) do
      if value.id == curEliteId then
        value.isGeted = true
      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetCurBossId = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local bossId = 0
  for index,value in ipairs((RelicData.templeData).stageInfo) do
    local templeId = value.id + RelicSub.Hero
    local templeData = ((TableData.gTable).BaseTempleData)[templeId]
    if templeData and templeData.type == 3 then
      bossId = value.id
    end
  end
  do
    if value.isGeted ~= false then
      return bossId
    end
  end
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

RelicData.SetCurBossId = function(...)
  -- function num : 0_12 , upvalues : _ENV
  local curBossId = (RelicData.GetCurBossId)()
  local isHaveNext = (((TableData.gTable).BaseStageData)[curBossId]).next ~= 0
  if isHaveNext then
    for index,value in ipairs((RelicData.templeData).stageInfo) do
      if value.id == curBossId then
        value.isGeted = true
      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetCurEliteBloodPercent = function(eliteId, ...)
  -- function num : 0_13 , upvalues : _ENV
  local rivalCardStates = (RelicData.templeData).rivalCardStates
  local totalBlood = 0
  local curBlood = 0
  local percent = 1
  if eliteId then
    if rivalCardStates then
      for index,value in pairs(rivalCardStates) do
        if value.stageId == eliteId then
          local monsterState = value.rivalCard
          for j,k in pairs(monsterState) do
            totalBlood = totalBlood + k.hp
            curBlood = curBlood + k.supHp
          end
        end
      end
    end
    do
      if totalBlood ~= 0 and curBlood ~= 0 then
        percent = (curBlood) / (totalBlood)
      end
      return percent, curBlood, totalBlood
    end
  end
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

RelicData.SetCurEliteBloodPercent = function(stageId, _rivalCard, ...)
  -- function num : 0_14 , upvalues : _ENV
  local rivalCardStates = (RelicData.templeData).rivalCardStates
  if rivalCardStates then
    for index,value in pairs(rivalCardStates) do
      if value.stageId == stageId then
        value.rivalCard = _rivalCard
      end
    end
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

RelicData.SetAllEliteBloodPercent = function(rivalCardStates, ...)
  -- function num : 0_15 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (RelicData.templeData).rivalCardStates = rivalCardStates
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetEnemyState = function(stageId, eId, ...)
  -- function num : 0_16 , upvalues : _ENV
  local state = 1
  local rivalCardStates = (RelicData.templeData).rivalCardStates
  if rivalCardStates then
    for index,value in pairs(rivalCardStates) do
      if value.stageId == stageId then
        for j,k in ipairs(value.rivalCard) do
          if k.id == eId then
            state = k.state
          end
        end
      end
    end
  end
  do
    return state
  end
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetEliteEnemySubNum = function(...)
  -- function num : 0_17 , upvalues : _ENV
  local sn = (RelicData.templeData).templeWeakenNum or 0
  return sn
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R2 in 'UnsetPending'

RelicData.SetEliteEnemySubNum = function(num, ...)
  -- function num : 0_18 , upvalues : _ENV
  if num < 0 then
    num = 0
  end
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (RelicData.templeData).templeWeakenNum = num
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetCardSelfState = function(type, state, ...)
  -- function num : 0_19 , upvalues : _ENV
  if state then
    for index,value in ipairs((RelicData.templeData).cards) do
      if value.type == type then
        value.cardInfo = state
      end
    end
  else
    do
      local formation = {}
      for index,value in ipairs((RelicData.templeData).cards) do
        if value.type == type then
          for _,v in ipairs(value.cardInfo) do
            print("cardId,", v.id, "state", (RelicData.GetCardState)(v.id, type))
            if type == 1 or (RelicData.GetCardState)(v.id, type) == 1 then
              formation[v.value] = v.id
              if v.value > 6 then
                loge("此时刚总应该出问题了")
              end
            end
          end
        end
      end
      PrintTable(formation, "上阵角色@@@@@")
      do return formation end
    end
  end
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R2 in 'UnsetPending'

RelicData.SetCardSelfState = function(data, ...)
  -- function num : 0_20 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (RelicData.templeData).battleCardState = data
  ;
  (RelicData.RefreshAllCardState)()
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R2 in 'UnsetPending'

RelicData.RefreshAllCardState = function(...)
  -- function num : 0_21 , upvalues : _ENV
  for n,m in ipairs((RelicData.templeData).battleCardState) do
    local isExsit = false
    for j,k in ipairs((RelicData.templeData).yetCardState) do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R11 in 'UnsetPending'

      if m.cardId == k.cardId and m.type == k.type then
        ((RelicData.templeData).yetCardState)[j] = m
        isExsit = true
        print("@@@@@@@@@@@ m.cardId", m.cardId, m.type, m.cardState, m.supHp)
        print("kkkkkkkkkkk k.cardId", k.cardId, k.type, k.cardState, k.supHp)
      end
    end
    if isExsit == false then
      (table.insert)((RelicData.templeData).yetCardState, m)
    end
  end
  PrintTable((RelicData.templeData).yetCardState, "处理后1")
  if #(RelicData.templeData).yetCardState == 0 then
    for j,k in ipairs((RelicData.templeData).battleCardState) do
      (table.insert)((RelicData.templeData).yetCardState, k)
    end
  end
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetYetCardSate = function(type, ...)
  -- function num : 0_22 , upvalues : _ENV
  local yet = {}
  for index,value in ipairs((RelicData.templeData).yetCardState) do
    if value.type == type then
      (table.insert)(yet, value)
    end
  end
  print("==============")
  PrintTable((RelicData.templeData).yetCardState, "布阵初始化")
  return yet
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetCardState = function(cardId, type, ...)
  -- function num : 0_23 , upvalues : _ENV
  local state = 1
  for index,value in ipairs((RelicData.templeData).yetCardState) do
    if value.type == type and value.cardId == cardId then
      state = value.cardState
    end
  end
  return state
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetEliteTowerNum = function(...)
  -- function num : 0_24 , upvalues : _ENV
  local eliteNum = 0
  for index,value in ipairs((RelicData.templeData).stageInfo) do
    local templeId = value.id + RelicSub.Elite
    local templeData = ((TableData.gTable).BaseTempleData)[templeId]
    if templeData and templeData.type == 2 and value.isGeted == false then
      eliteNum = value.surplusNum
      break
    end
  end
  do
    return eliteNum
  end
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R2 in 'UnsetPending'

RelicData.SubEliteTowerNum = function(...)
  -- function num : 0_25 , upvalues : _ENV
  for index,value in ipairs((RelicData.templeData).stageInfo) do
    local templeId = value.id + RelicSub.Elite
    local templeData = ((TableData.gTable).BaseTempleData)[templeId]
    if templeData and templeData.type == 2 and value.isGeted == false then
      value.surplusNum = value.surplusNum - 1
      if value.surplusNum < 0 then
        value.surplusNum = 0
      end
      break
    end
  end
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R2 in 'UnsetPending'

RelicData.UnlockDungeon = function(data, preId, ...)
  -- function num : 0_26 , upvalues : _ENV
  for index,value in ipairs(data) do
    (table.insert)((RelicData.templeData).stageInfo, value)
  end
  for index,value in ipairs((RelicData.templeData).stageInfo) do
    if value.id == preId then
      value.isGeted = true
    end
  end
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetIsGeted = function(stageId, ...)
  -- function num : 0_27 , upvalues : _ENV
  local isGeted = false
  for index,value in ipairs((RelicData.templeData).stageInfo) do
    if value.id == stageId then
      isGeted = value.isGeted
    end
  end
  return isGeted
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetIsLocked = function(stageId, ...)
  -- function num : 0_28 , upvalues : _ENV
  local isLock = true
  for index,value in ipairs((RelicData.templeData).stageInfo) do
    if value.id == stageId then
      isLock = false
    end
  end
  return isLock
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetRelicPlayerFc = function(changeFc, ...)
  -- function num : 0_29 , upvalues : _ENV
  if changeFc == nil then
    print("战力改变值", (RelicData.templeData).changeFc)
    return (RelicData.templeData).changeFc
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (RelicData.templeData).changeFc = changeFc
  end
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetRelicCardState = function(cardId, ...)
  -- function num : 0_30 , upvalues : _ENV
  local state = 1
  local curStageType = (RelicData.GetCurClickedStageType)()
  if curStageType == 1 then
    state = 1
  else
    if curStageType == 2 then
      local cardLvl = ((CardData.GetCardData)(cardId)).level
      local LEVELLIMIT = (((TableData.gTable).BaseFixedData)[Const.RELIC_LVL_LIMIT]).int_value
      if cardLvl < (((TableData.gTable).BaseFixedData)[Const.RELIC_LVL_LIMIT]).int_value then
        state = 0
      else
        for index,value in ipairs((RelicData.templeData).yetCardState) do
          if value.cardId == cardId and value.type == curStageType then
            state = value.cardState
          end
        end
      end
    else
      do
        if curStageType == 3 then
          for index,value in ipairs((RelicData.templeData).yetCardState) do
            if value.cardId == cardId and value.type == curStageType then
              state = value.cardState
            end
          end
        end
        do
          return state
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetRelicClickStageId = function(stageId, ...)
  -- function num : 0_31 , upvalues : self
  if stageId == nil then
    return self.curClickedStageId
  else
    self.curClickedStageId = stageId
  end
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R2 in 'UnsetPending'

RelicData.GetRelicNormalWave = function(wave, ...)
  -- function num : 0_32 , upvalues : self
  if wave == nil then
    return self.curNormalWave
  else
    self.curNormalWave = wave
  end
end


