-- params : ...
-- function num : 0 , upvalues : _ENV
BattleChoose = {}
local self = BattleChoose
local t_insert = table.insert
local t_remove = table.remove
local t_sort = table.sort
local ipairs = ipairs
local math = math
-- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetAtkTarget = function(atkCard, skillInfo, ...)
  -- function num : 0_0 , upvalues : self
  if not skillInfo or not (self.GetTargetCardsByTargetId)(atkCard, skillInfo.targetType, nil, nil, skillInfo) then
    return {}
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetAssistCardList = function(atkCard, assistNum, notIncludeCannotMove, ...)
  -- function num : 0_1 , upvalues : self, _ENV, t_remove, ipairs, t_insert
  local returnCardTable = {}
  local cardTable = (self.GetRandomCards)(atkCard, true, 10, true, notIncludeCannotMove or true)
  for i = #cardTable, 1, -1 do
    local card = cardTable[i]
    if (BattleBuff.IsForbiddenAssistPassive)(card) == true then
      t_remove(cardTable, i)
    end
  end
  for i,v in ipairs(cardTable) do
    if i <= assistNum then
      t_insert(returnCardTable, v)
    end
  end
  return returnCardTable
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCardsBySide = function(atkCard, isSameSide, notIncludeSelf, notIncludeCannotMove, ...)
  -- function num : 0_2 , upvalues : self, _ENV, ipairs, t_insert
  local cards = {}
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  for i,v in ipairs(cardList) do
    -- DECOMPILER ERROR at PC42: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC42: Unhandled construct in 'MakeBoolean' P1

    if v:GetHp() > 0 and (notIncludeCannotMove ~= true or v:IsDisplayAlive() == true) and isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (not notIncludeSelf or v:GetPosIndex() ~= atkCard:GetPosIndex()) then
      t_insert(cards, v)
    end
    -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P1

    if isSameSide == false and v:GetCampFlag() ~= atkCard:GetCampFlag() then
      t_insert(cards, v)
    end
    if isSameSide == nil and (not notIncludeSelf or v:GetPosIndex() ~= atkCard:GetPosIndex()) then
      t_insert(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCardsByCross = function(atkCard, isSameSide, includeSelf, ...)
  -- function num : 0_3 , upvalues : self, _ENV, ipairs, t_insert
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  local cards = {}
  local targetPos = nil
  if isSameSide ~= true then
    local targetCard = (self.GetNormalAttackCard)(atkCard)
    targetPos = targetCard:GetPosIndex()
  else
    do
      targetPos = atkCard:GetPosIndex()
      for i,v in ipairs(cardList) do
        if v:GetHp() > 0 then
          local posIndex = v:GetPosIndex()
          -- DECOMPILER ERROR at PC61: Unhandled construct in 'MakeBoolean' P1

          -- DECOMPILER ERROR at PC61: Unhandled construct in 'MakeBoolean' P1

          if (includeSelf or posIndex ~= targetPos) and isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 10 or posIndex == targetPos - 10) then
            t_insert(cards, v)
          end
        end
        if v:GetCampFlag() ~= atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 10 or posIndex == targetPos - 10) then
          t_insert(cards, v)
        end
      end
      return cards
    end
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCrossCards = function(atkCard, isSameSide, notIncludeSelf, ...)
  -- function num : 0_4 , upvalues : self, _ENV, ipairs, t_insert
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  local cards = {}
  local targetPos = nil
  if isSameSide ~= true then
    if atkCard:GetPosIndex() <= 100 or not atkCard:GetPosIndex() - 100 then
      targetPos = atkCard:GetPosIndex() + 100
      targetPos = atkCard:GetPosIndex()
      for i,v in ipairs(cardList) do
        if v:GetHp() > 0 then
          local posIndex = v:GetPosIndex()
          -- DECOMPILER ERROR at PC71: Unhandled construct in 'MakeBoolean' P1

          if isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (posIndex == targetPos - 1 or posIndex == targetPos - 2 or posIndex == targetPos + 1 or posIndex == targetPos + 2 or posIndex == targetPos + 10 or posIndex == targetPos - 10 or posIndex ~= targetPos or notIncludeSelf ~= true) then
            t_insert(cards, v)
          end
        end
        if v:GetCampFlag() ~= atkCard:GetCampFlag() and (posIndex == targetPos - 1 or posIndex == targetPos - 2 or posIndex == targetPos + 1 or posIndex == targetPos + 2 or posIndex == targetPos + 10 or posIndex == targetPos - 10 or posIndex ~= targetPos or notIncludeSelf ~= true) then
          t_insert(cards, v)
        end
      end
      return cards
    end
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCardsByAround = function(atkCard, isSameSide, ...)
  -- function num : 0_5 , upvalues : self, _ENV, ipairs, t_insert
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  local cards = {}
  local targetPos = nil
  if isSameSide ~= true then
    if atkCard:GetPosIndex() <= 100 or not atkCard:GetPosIndex() - 100 then
      targetPos = atkCard:GetPosIndex() + 100
      targetPos = atkCard:GetPosIndex()
      for i,v in ipairs(cardList) do
        if v:GetHp() > 0 then
          local posIndex = v:GetPosIndex()
          -- DECOMPILER ERROR at PC75: Unhandled construct in 'MakeBoolean' P1

          if isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 10 or posIndex == targetPos - 10 or posIndex == targetPos - 11 or posIndex == targetPos + 11 or posIndex == targetPos - 9 or posIndex == targetPos + 9) then
            t_insert(cards, v)
          end
        end
        if v:GetCampFlag() ~= atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 10 or posIndex == targetPos - 10 or posIndex == targetPos - 11 or posIndex == targetPos + 11 or posIndex == targetPos - 9 or posIndex == targetPos + 9) then
          t_insert(cards, v)
        end
      end
      return cards
    end
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetRandomCardsByAround = function(atkCard, isSameSide, randomNum, ...)
  -- function num : 0_6 , upvalues : _ENV
  local cardList = (BattleChoose.GetCardsByAround)(atkCard, isSameSide)
  local cards = (BattleChoose.GetRandomCards)(nil, nil, randomNum, true, nil, cardList)
  return cards
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetFrontCards = function(atkCard, isSameSide, notIncludeSelf, ...)
  -- function num : 0_7 , upvalues : self, ipairs, t_insert
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf)
  local cards = {}
  for i,v in ipairs(cardList) do
    local posIndex = v:GetPosIndex()
    if (posIndex > 0 and posIndex < 4) or posIndex > 100 and posIndex < 104 then
      t_insert(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetBehindCards = function(atkCard, isSameSide, notIncludeSelf, ...)
  -- function num : 0_8 , upvalues : self, ipairs, t_insert
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf)
  local cards = {}
  for i,v in ipairs(cardList) do
    local posIndex = v:GetPosIndex()
    if (posIndex > 10 and posIndex < 14) or posIndex > 110 and posIndex < 114 then
      t_insert(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCardHaveEffect = function(atkCard, effectId, isSameSide, ...)
  -- function num : 0_9 , upvalues : self, ipairs, _ENV, t_insert
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  local cards = {}
  for i,v in ipairs(cardList) do
    if (BattleBuff.ContainEffectId)(v, effectId) == true then
      t_insert(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCardNotHaveEffect = function(atkCard, effectId, num, isSameSide, ...)
  -- function num : 0_10 , upvalues : self, ipairs, _ENV, t_insert, t_sort
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  local cards = {}
  for i,v in ipairs(cardList) do
    if (BattleBuff.ContainEffectId)(v, effectId) == false then
      t_insert(cards, v)
    end
  end
  for _,v in ipairs(cards) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cards, function(a, b, ...)
    -- function num : 0_10_0
    do return a.tempRandom < b.tempRandom end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local mCards = {}
  local count = num or 6
  for i = 1, count do
    if cards[i] then
      t_insert(mCards, cards[i])
    end
  end
  return mCards
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCardHaveBuffId = function(atkCard, buffId, isSameSide, ...)
  -- function num : 0_11 , upvalues : self, ipairs, _ENV, t_insert
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  local cards = {}
  for i,v in ipairs(cardList) do
    if (BattleBuff.ContainBuffId)(v, buffId) == true then
      t_insert(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetNormalAttackCard = function(atkCard, ...)
  -- function num : 0_12 , upvalues : self, t_insert, ipairs
  local otherCards = (self.GetCardsBySide)(atkCard, false)
  local posIndex = atkCard:GetPosIndex()
  local addPos = posIndex > 100 and 0 or 100
  local tPos = posIndex % 10
  local posLst = {}
  for i = 1, tPos do
    t_insert(posLst, tPos - i + 1 + addPos)
  end
  for i = tPos + 1, 3 do
    t_insert(posLst, i + addPos)
  end
  for i = 1, tPos do
    t_insert(posLst, tPos - i + 1 + 10 + addPos)
  end
  for i = tPos + 1, 3 do
    t_insert(posLst, i + 10 + addPos)
  end
  for k,v in ipairs(posLst) do
    for i,card in ipairs(otherCards) do
      if card:GetPosIndex() == v and card:GetHp() > 0 then
        return card
      end
    end
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetAttackCardBehind = function(atkCard, ...)
  -- function num : 0_13 , upvalues : self, t_insert, ipairs
  local otherCards = (self.GetCardsBySide)(atkCard, false)
  local posIndex = atkCard:GetPosIndex()
  local addPos = posIndex > 100 and 0 or 100
  local tPos = posIndex % 10
  local posLst = {}
  for i = 1, tPos do
    t_insert(posLst, tPos - i + 1 + 10 + addPos)
  end
  for i = tPos + 1, 3 do
    t_insert(posLst, i + 10 + addPos)
  end
  for i = 1, tPos do
    t_insert(posLst, tPos - i + 1 + addPos)
  end
  for i = tPos + 1, 3 do
    t_insert(posLst, i + addPos)
  end
  for k,v in ipairs(posLst) do
    for i,card in ipairs(otherCards) do
      if card:GetPosIndex() == v and card:GetHp() > 0 then
        return card
      end
    end
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetVerticalCards = function(atkCard, isSameSide, notIncludeSelf, ...)
  -- function num : 0_14 , upvalues : self, _ENV, ipairs, t_insert
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  local cards = {}
  local targetPos = nil
  if isSameSide ~= true then
    local targetCard = (self.GetNormalAttackCard)(atkCard)
    targetPos = targetCard:GetPosIndex()
  else
    do
      targetPos = atkCard:GetPosIndex()
      for _,v in ipairs(cardList) do
        if v:GetHp() > 0 then
          local posIndex = v:GetPosIndex()
          -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P1

          -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P1

          -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P1

          if isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (posIndex == targetPos + 10 or posIndex == targetPos - 10 or posIndex == targetPos) and notIncludeSelf == true and targetPos ~= posIndex then
            t_insert(cards, v)
          end
        end
        t_insert(cards, v)
        if v:GetCampFlag() ~= atkCard:GetCampFlag() and (posIndex == targetPos + 10 or posIndex == targetPos - 10 or posIndex == targetPos) then
          t_insert(cards, v)
        end
      end
      return cards
    end
  end
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetHorizontalCards = function(atkCard, isSameSide, ...)
  -- function num : 0_15 , upvalues : self, _ENV, ipairs, t_insert
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  local cards = {}
  local targetPos = nil
  if isSameSide ~= true then
    local targetCard = (self.GetNormalAttackCard)(atkCard)
    targetPos = targetCard:GetPosIndex()
  else
    do
      targetPos = atkCard:GetPosIndex()
      for i,v in ipairs(cardList) do
        if v:GetHp() > 0 then
          local posIndex = v:GetPosIndex()
          -- DECOMPILER ERROR at PC57: Unhandled construct in 'MakeBoolean' P1

          if isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 2 or posIndex == targetPos - 2) then
            t_insert(cards, v)
          end
        end
        if v:GetCampFlag() ~= atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 2 or posIndex == targetPos - 2) then
          t_insert(cards, v)
        end
      end
      return cards
    end
  end
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTopDanderCards = function(atkCard, isSameSide, topNum, isReverse, ...)
  -- function num : 0_16 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  for _,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_16_0 , upvalues : isReverse
    if a.tempRandom >= b.tempRandom then
      do return a:GetDander() ~= b:GetDander() end
      if a:GetDander() >= b:GetDander() then
        do return not isReverse end
        do return b:GetDander() < a:GetDander() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  if not topNum then
    topNum = 6
  end
  for i = 1, topNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTopHpCards = function(atkCard, isSameSide, topNum, isReverse, notIncludeSelf, ...)
  -- function num : 0_17 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf)
  for _,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_17_0 , upvalues : isReverse
    if a.tempRandom >= b.tempRandom then
      do return a:GetHp() / a:GetMaxHp() ~= b:GetHp() / b:GetMaxHp() end
      if a:GetHp() / a:GetMaxHp() >= b:GetHp() / b:GetMaxHp() then
        do return not isReverse end
        do return b:GetHp() / b:GetMaxHp() < a:GetHp() / a:GetMaxHp() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  if not topNum then
    topNum = 6
  end
  for i = 1, topNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTopSpeedCards = function(atkCard, isSameSide, topNum, isReverse, ...)
  -- function num : 0_18 , upvalues : self, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_18_0 , upvalues : isReverse
    if a:GetPosIndex() >= b:GetPosIndex() then
      do return a:GetSpd() ~= b:GetSpd() end
      if a:GetSpd() >= b:GetSpd() then
        do return not isReverse end
        do return b:GetSpd() < a:GetSpd() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  if not topNum then
    topNum = 6
  end
  for i = 1, topNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetNextSpeedCard = function(atkCard, isSameSide, ...)
  -- function num : 0_19 , upvalues : self, t_sort, ipairs
  if self.onlyChoosePos == true then
    return {}
  end
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_19_0
    if a:GetPosIndex() >= b:GetPosIndex() then
      do return a:GetSpd() ~= b:GetSpd() end
      do return b:GetSpd() < a:GetSpd() end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  local isFind = false
  for i,v in ipairs(cardList) do
    if v:GetPosIndex() == atkCard:GetPosIndex() then
      isFind = true
    else
      if isFind == true then
        return v
      end
    end
  end
  return atkCard
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTopAtkCards = function(atkCard, isSameSide, topNum, isReverse, ...)
  -- function num : 0_20 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  for _,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_20_0 , upvalues : isReverse
    if a.tempRandom >= b.tempRandom then
      do return a:GetAtk() ~= b:GetAtk() end
      if a:GetAtk() >= b:GetAtk() then
        do return not isReverse end
        do return b:GetAtk() < a:GetAtk() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  if not topNum then
    topNum = 6
  end
  for i = 1, topNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTopDefCards = function(atkCard, isSameSide, topNum, isReverse, ...)
  -- function num : 0_21 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  for _,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_21_0 , upvalues : isReverse
    if a.tempRandom >= b.tempRandom then
      do return a:GetDef() ~= b:GetDef() end
      if a:GetDef() >= b:GetDef() then
        do return not isReverse end
        do return b:GetDef() < a:GetDef() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  if not topNum then
    topNum = 6
  end
  for i = 1, topNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetContainEffectCards = function(atkCard, isSameSide, effectID, notIncludeSelf, notIncludeCannotMove, ...)
  -- function num : 0_22 , upvalues : self, ipairs, _ENV
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf, notIncludeCannotMove)
  for _,v in ipairs(cardList) do
    local buffTable = (BattleBuffMgr.GetBuffList)()
    for _,v2 in ipairs(buffTable) do
      local defPos = v2:GetCurDefPos()
      local buffConfig = v2:GetBuffConfig()
      local effectTable = split(buffConfig.value, ":")
      if defPos == v:GetPosIndex() and tonumber(effectTable[1]) == effectID then
        (table.insert)(cards, v)
        break
      end
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetRandomCards = function(atkCard, isSameSide, randomNum, notIncludeSelf, notIncludeCannotMove, cardsList, ...)
  -- function num : 0_23 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  if not cardsList then
    local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf, notIncludeCannotMove)
  end
  for i,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_23_0
    do return a.tempRandom < b.tempRandom end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if not randomNum then
    randomNum = 6
  end
  for i = 1, randomNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetRandomCardsPrecedenceNotEffect = function(atkCard, isSameSide, randomNum, effectID, notIncludeSelf, ...)
  -- function num : 0_24 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf, false)
  for i,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_24_0 , upvalues : _ENV, effectID
    local containA = (BattleBuff.ContainEffectId)(a, effectID)
    if containA then
      return false
    end
    do return a.tempRandom < b.tempRandom end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if not randomNum then
    randomNum = 6
  end
  for i = 1, randomNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetContainEffectGroupCards = function(atkCard, isSameSide, groupID, notIncludeSelf, ...)
  -- function num : 0_25 , upvalues : self, ipairs, _ENV
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf, false)
  for _,v in ipairs(cardList) do
    local contain = (BattleBuff.ContainBuffGroup)(v, groupID)
    if contain then
      (table.insert)(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTargetPosByTargetId = function(atkPos, targetId, allCardPos, ...)
  -- function num : 0_26 , upvalues : self, ipairs, _ENV, t_insert
  self.onlyChoosePos = true
  self.allCardList = {}
  local atkCard = nil
  for _,pos in ipairs(allCardPos) do
    if pos <= 100 or not BattleCardCamp.RIGHT then
      local campFlag = BattleCardCamp.LEFT
    end
    local card = {posIndex = pos, campFlag = campFlag}
    card.GetPosIndex = function(self, ...)
    -- function num : 0_26_0
    return self.posIndex
  end

    card.GetCampFlag = function(self, ...)
    -- function num : 0_26_1
    return self.campFlag
  end

    card.GetHp = function(self, ...)
    -- function num : 0_26_2
    return 100
  end

    card.IsDisplayAlive = function(self, ...)
    -- function num : 0_26_3
    return true
  end

    if atkPos == pos then
      atkCard = card
    end
    t_insert(self.allCardList, card)
  end
  local targetCards = (BattleChoose.GetTargetCardsByTargetId)(atkCard, targetId, nil, nil, nil, nil, true)
  self.onlyChoosePos = false
  self.allCardList = {}
  return targetCards
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTargetCardsByTargetId = function(atkCard, targetId, defCards, isBuff, skillConfig, atkInfo, banMultiple, ...)
  -- function num : 0_27 , upvalues : self, _ENV, t_insert, ipairs, math, t_sort
  local targetCards = {}
  local switch = {[1000] = function(...)
    -- function num : 0_27_0 , upvalues : self, targetCards, defCards
    if self.onlyChoosePos == true then
      targetCards = {}
      return 
    end
    targetCards = defCards
  end
, [1003] = function(...)
    -- function num : 0_27_1 , upvalues : atkInfo, _ENV, t_insert, targetCards
    local atkCardUid = atkInfo.atkCardUid
    local card = (BattleData.GetCardInfoByUid)(atkCardUid)
    t_insert(targetCards, card)
  end
, [1004] = function(...)
    -- function num : 0_27_2 , upvalues : ipairs, defCards, self, _ENV, targetCards
    for _,v in ipairs(defCards) do
      local Cards = (self.GetCardsByCross)(v, true, false)
      for _,v2 in ipairs(Cards) do
        (table.insert)(targetCards, v2)
      end
    end
  end
, [2001] = function(...)
    -- function num : 0_27_3 , upvalues : self, atkCard, t_insert, targetCards
    local card = (self.GetNormalAttackCard)(atkCard)
    t_insert(targetCards, card)
  end
, [2002] = function(...)
    -- function num : 0_27_4 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsBySide)(atkCard, false)
  end
, [2003] = function(...)
    -- function num : 0_27_5 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsByCross)(atkCard, false, true)
  end
, [2004] = function(...)
    -- function num : 0_27_6 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsByAround)(atkCard, false)
  end
, [2005] = function(...)
    -- function num : 0_27_7 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetFrontCards)(atkCard, false)
    if #targetCards == 0 then
      targetCards = (self.GetBehindCards)(atkCard, false)
    end
  end
, [2006] = function(...)
    -- function num : 0_27_8 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetBehindCards)(atkCard, false)
    if #targetCards == 0 then
      targetCards = (self.GetFrontCards)(atkCard, false)
    end
  end
, [2007] = function(...)
    -- function num : 0_27_9 , upvalues : self, atkCard, t_insert, targetCards
    local card = (self.GetAttackCardBehind)(atkCard)
    t_insert(targetCards, card)
  end
, [2008] = function(...)
    -- function num : 0_27_10 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetVerticalCards)(atkCard, false)
  end
, [2009] = function(...)
    -- function num : 0_27_11 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetHorizontalCards)(atkCard, false)
  end
, [2111] = function(...)
    -- function num : 0_27_12 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, false, 1)
  end
, [2112] = function(...)
    -- function num : 0_27_13 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, false, 2)
  end
, [2113] = function(...)
    -- function num : 0_27_14 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, false, 3)
  end
, [2120] = function(...)
    -- function num : 0_27_15 , upvalues : math, _ENV, targetCards, self, atkCard
    local randomNum = (math.ceil)((BattleData.GetRandomSeed)() * 6 / 10000)
    targetCards = (self.GetRandomCards)(atkCard, false, randomNum)
  end
, [2121] = function(...)
    -- function num : 0_27_16 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 1)
  end
, [2122] = function(...)
    -- function num : 0_27_17 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 2)
  end
, [2123] = function(...)
    -- function num : 0_27_18 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 3)
  end
, [2124] = function(...)
    -- function num : 0_27_19 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 4)
  end
, [2125] = function(...)
    -- function num : 0_27_20 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 5)
  end
, [2126] = function(...)
    -- function num : 0_27_21 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 6)
  end
, [2127] = function(...)
    -- function num : 0_27_22 , upvalues : self, targetCards, atkCard
    if self.onlyChoosePos == true then
      targetCards = {}
      return 
    end
    targetCards = (self.GetBehindCards)(atkCard, false)
    if #targetCards == 0 then
      targetCards = (self.GetFrontCards)(atkCard, false)
    end
    targetCards = (self.GetRandomCards)(atkCard, false, 1, nil, nil, targetCards)
  end
, [2128] = function(...)
    -- function num : 0_27_23 , upvalues : self, targetCards, atkCard
    if self.onlyChoosePos == true then
      targetCards = {}
      return 
    end
    targetCards = (self.GetBehindCards)(atkCard, false)
    if #targetCards == 0 then
      targetCards = (self.GetFrontCards)(atkCard, false)
    end
    targetCards = (self.GetRandomCards)(atkCard, false, 2, nil, nil, targetCards)
  end
, [2131] = function(...)
    -- function num : 0_27_24 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, false, 1)
  end
, [2132] = function(...)
    -- function num : 0_27_25 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, false, 2)
  end
, [2133] = function(...)
    -- function num : 0_27_26 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, false, 3)
  end
, [2141] = function(...)
    -- function num : 0_27_27 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, false, 1, true)
  end
, [2142] = function(...)
    -- function num : 0_27_28 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, false, 2, true)
  end
, [2151] = function(...)
    -- function num : 0_27_29 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDefCards)(atkCard, false, 1)
  end
, [2153] = function(...)
    -- function num : 0_27_30 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDefCards)(atkCard, false, 3)
  end
, [2161] = function(...)
    -- function num : 0_27_31 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopAtkCards)(atkCard, false, 1)
  end
, [2162] = function(...)
    -- function num : 0_27_32 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopAtkCards)(atkCard, false, 2)
  end
, [2163] = function(...)
    -- function num : 0_27_33 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopAtkCards)(atkCard, false, 3)
  end
, [2164] = function(...)
    -- function num : 0_27_34 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopAtkCards)(atkCard, false, 4)
  end
, [2171] = function(...)
    -- function num : 0_27_35 , upvalues : self, targetCards, defCards, _ENV
    if self.onlyChoosePos == true then
      targetCards = {}
      return 
    end
    local card = not defCards or defCards[1]
    if card then
      targetCards = (BattleChoose.GetRandomCardsByAround)(card, true, 1)
    end
  end
, [2181] = function(...)
    -- function num : 0_27_36 , upvalues : self, targetCards, _ENV, atkCard
    if self.onlyChoosePos == true then
      targetCards = {}
      return 
    end
    local card = (BattleChoose.GetContainEffectCards)(atkCard, false, BattleDisplayEffect.STAMP_DEPEND_ROUND)
    if #card <= 0 then
      local normalCard = (self.GetNormalAttackCard)(atkCard)
      ;
      (table.insert)(targetCards, normalCard)
    else
      do
        targetCards = card
      end
    end
  end
, [2191] = function(...)
    -- function num : 0_27_37 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsByCross)(atkCard, false, false)
  end
, [2201] = function(...)
    -- function num : 0_27_38 , upvalues : targetCards, _ENV, atkCard
    targetCards = (BattleChoose.GetRandomCardsPrecedenceNotEffect)(atkCard, false, 3, BattleDisplayEffect.DAMAGE_PERSIST_EXTRA)
  end
, [2211] = function(...)
    -- function num : 0_27_39 , upvalues : targetCards, _ENV, atkCard, self
    targetCards = (BattleChoose.GetContainEffectCards)(atkCard, false, 906, true)
    if #targetCards <= 0 then
      local card = (self.GetNormalAttackCard)(atkCard)
      ;
      (table.insert)(targetCards, card)
    end
  end
, [2221] = function(...)
    -- function num : 0_27_40 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDefCards)(atkCard, false, 1, true)
  end
, [2231] = function(...)
    -- function num : 0_27_41 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopSpeedCards)(atkCard, false, 1)
  end
, [3001] = function(...)
    -- function num : 0_27_42 , upvalues : t_insert, targetCards, atkCard
    t_insert(targetCards, atkCard)
  end
, [3002] = function(...)
    -- function num : 0_27_43 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsByCross)(atkCard, true, true)
  end
, [3003] = function(...)
    -- function num : 0_27_44 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsByAround)(atkCard, true)
  end
, [3004] = function(...)
    -- function num : 0_27_45 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsBySide)(atkCard, true)
  end
, [3005] = function(...)
    -- function num : 0_27_46 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetFrontCards)(atkCard, true)
    if #targetCards == 0 then
      targetCards = (self.GetBehindCards)(atkCard, true)
    end
  end
, [3006] = function(...)
    -- function num : 0_27_47 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetBehindCards)(atkCard, true)
    if #targetCards == 0 then
      targetCards = (self.GetFrontCards)(atkCard, true)
    end
  end
, [3007] = function(...)
    -- function num : 0_27_48 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetVerticalCards)(atkCard, true)
  end
, [3008] = function(...)
    -- function num : 0_27_49 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetHorizontalCards)(atkCard, true)
  end
, [3009] = function(...)
    -- function num : 0_27_50 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetVerticalCards)(atkCard, true, true)
  end
, [3011] = function(...)
    -- function num : 0_27_51 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, true, 1, true)
  end
, [3012] = function(...)
    -- function num : 0_27_52 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, true, 2, true)
  end
, [3013] = function(...)
    -- function num : 0_27_53 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, true, 3, true)
  end
, [3016] = function(...)
    -- function num : 0_27_54 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, true, 1, true, true)
  end
, [3017] = function(...)
    -- function num : 0_27_55 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetFrontCards)(atkCard, true, true)
  end
, [3018] = function(...)
    -- function num : 0_27_56 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetBehindCards)(atkCard, true, true)
  end
, [3019] = function(...)
    -- function num : 0_27_57 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsBySide)(atkCard, true, true)
  end
, [3021] = function(...)
    -- function num : 0_27_58 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, true, 1, true)
  end
, [3022] = function(...)
    -- function num : 0_27_59 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, true, 2, true)
  end
, [3023] = function(...)
    -- function num : 0_27_60 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, true, 3, true)
  end
, [3031] = function(...)
    -- function num : 0_27_61 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, true, 1)
  end
, [3032] = function(...)
    -- function num : 0_27_62 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, true, 2)
  end
, [3033] = function(...)
    -- function num : 0_27_63 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, true, 3)
  end
, [3034] = function(...)
    -- function num : 0_27_64 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, true, 1, true)
  end
, [3041] = function(...)
    -- function num : 0_27_65 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, true, 1)
  end
, [3051] = function(...)
    -- function num : 0_27_66 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopSpeedCards)(atkCard, true, 1)
  end
, [3061] = function(...)
    -- function num : 0_27_67 , upvalues : _ENV, targetCards, self, atkCard
    (table.insert)(targetCards, (self.GetNextSpeedCard)(atkCard, true))
  end
, [3071] = function(...)
    -- function num : 0_27_68 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCrossCards)(atkCard, true)
  end
, [3081] = function(...)
    -- function num : 0_27_69 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, true, 1, false)
  end
, [3091] = function(...)
    -- function num : 0_27_70 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopAtkCards)(atkCard, true, 1, false)
  end
, [4001] = function(...)
    -- function num : 0_27_71 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, nil, 1, true)
  end
, [5002] = function(...)
    -- function num : 0_27_72 , upvalues : atkCard, _ENV, t_insert, targetCards
    local pos = atkCard:GetFoePos()
    if pos then
      local card = (BattleData.GetCardInfoByPos)(pos)
      if card and card:IsDead() ~= true then
        t_insert(targetCards, card)
      end
    end
  end
, [5003] = function(...)
    -- function num : 0_27_73 , upvalues : _ENV, atkCard, targetCards, self, t_insert
    local cards = (BattleChoose.GetCardHaveEffect)(atkCard, BattleDisplayEffect.OFFER_REWARD, false)
    if #cards > 0 then
      targetCards = cards
    else
      local card = (self.GetNormalAttackCard)(atkCard)
      t_insert(targetCards, card)
    end
  end
, [5005] = function(...)
    -- function num : 0_27_74 , upvalues : _ENV, atkCard, targetCards, self, t_insert
    local cards = (BattleChoose.GetCardHaveEffect)(atkCard, BattleDisplayEffect.FOCUS_ATTACK, false)
    if #cards > 0 then
      targetCards = cards
    else
      local card = (self.GetNormalAttackCard)(atkCard)
      t_insert(targetCards, card)
    end
  end
, [5006] = function(...)
    -- function num : 0_27_75 , upvalues : _ENV, atkCard, targetCards, self, t_insert
    local cards = (BattleChoose.GetCardHaveEffect)(atkCard, 809, false)
    if #cards > 0 then
      targetCards = cards
    else
      local card = (self.GetNormalAttackCard)(atkCard)
      t_insert(targetCards, card)
    end
  end
, [5007] = function(...)
    -- function num : 0_27_76 , upvalues : _ENV, atkCard, targetCards, self, t_insert
    local cards = (BattleChoose.GetCardNotHaveEffect)(atkCard, 809, 1, false)
    if #cards > 0 then
      targetCards = cards
    else
      local card = (self.GetNormalAttackCard)(atkCard)
      t_insert(targetCards, card)
    end
  end
, [5008] = function(...)
    -- function num : 0_27_77 , upvalues : _ENV, atkCard, targetCards, t_insert
    local cards = (BattleChoose.GetCardNotHaveEffect)(atkCard, 809, 1, true)
    if #cards > 0 then
      targetCards = cards
    else
      t_insert(targetCards, atkCard)
    end
  end
, [5009] = function(...)
    -- function num : 0_27_78 , upvalues : skillConfig, _ENV, self, atkCard, t_insert, t_sort, ipairs, targetCards
    if skillConfig and skillConfig.target_buff then
      local strArr = split(skillConfig.target_buff, ":")
      local preChooseId = tonumber(strArr[2])
      local tarBuffId = tonumber(strArr[1])
      local preChooseCards = {}
      print("备用选址type", preChooseId)
      if preChooseId == 2142 then
        preChooseCards = (self.GetTopHpCards)(atkCard, false, 2, true)
      else
        if preChooseId == 2001 then
          local card = (self.GetNormalAttackCard)(atkCard)
          t_insert(preChooseCards, card)
        end
      end
      do
        t_sort(preChooseCards, function(a, b, ...)
      -- function num : 0_27_78_0
      if a.tempRandom >= b.tempRandom then
        do return a:GetHp() / a:GetMaxHp() ~= b:GetHp() / b:GetMaxHp() end
        do return b:GetHp() / b:GetMaxHp() < a:GetHp() / a:GetMaxHp() end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
)
        for index,value in ipairs(preChooseCards) do
          print("备用选址", value:GetPosIndex())
        end
        local buffedCards = (BattleChoose.GetCardHaveBuffId)(atkCard, tarBuffId, false)
        local t_buffedCards = {}
        for index,value in ipairs(buffedCards) do
          print("携带buffid为", tarBuffId, "的卡片位置为", value:GetPosIndex())
          ;
          (table.insert)(t_buffedCards, {card = value, isExsit = false})
        end
        local t_preChooseCards = {}
        for index,value in ipairs(preChooseCards) do
          (table.insert)(t_preChooseCards, {card = value, isBuffed = false})
        end
        local exsitNum = 0
        for i,j in ipairs(t_preChooseCards) do
          for n,m in ipairs(t_buffedCards) do
            if (m.card):GetPosIndex() == (j.card):GetPosIndex() then
              m.isExsit = true
              j.isBuffed = true
              exsitNum = exsitNum + 1
            end
          end
        end
        for i,j in ipairs(t_preChooseCards) do
          print("备用选址卡片位置", (j.card):GetPosIndex(), "是否拥有buffid", j.isBuffed)
        end
        for index,value in ipairs(t_buffedCards) do
          print("实际拥有buffid的卡片位置", (value.card):GetPosIndex(), "是否已存在备选卡片中", value.isExsit)
        end
        if exsitNum == #preChooseCards then
          targetCards = preChooseCards
        else
          for i,j in ipairs(t_preChooseCards) do
            for n,m in ipairs(t_buffedCards) do
              if j.isBuffed == false and m.isExsit == false then
                j.card = m.card
                j.isBuffed = true
                m.isExsit = true
              end
            end
          end
          for index,value in ipairs(t_preChooseCards) do
            t_insert(targetCards, value.card)
          end
        end
      end
    end
  end
, [5010] = function(...)
    -- function num : 0_27_79 , upvalues : skillConfig, _ENV, self, atkCard, t_sort, ipairs, targetCards, t_insert
    if skillConfig and skillConfig.target_buff then
      local strArr = split(skillConfig.target_buff, ":")
      local preChooseId = tonumber(strArr[2])
      local tarBuffId = tonumber(strArr[1])
      local preChooseCards = {}
      print("备用选址5010type", preChooseId)
      if preChooseId == 2111 then
        preChooseCards = (self.GetTopDanderCards)(atkCard, false, 1)
      end
      t_sort(preChooseCards, function(a, b, ...)
      -- function num : 0_27_79_0
      if a.tempRandom >= b.tempRandom then
        do return a:GetHp() / a:GetMaxHp() ~= b:GetHp() / b:GetMaxHp() end
        do return b:GetHp() / b:GetMaxHp() < a:GetHp() / a:GetMaxHp() end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
)
      for index,value in ipairs(preChooseCards) do
        print("备用选址", value:GetPosIndex())
      end
      local buffedCards = (BattleChoose.GetCardHaveBuffId)(atkCard, tarBuffId, false)
      local t_buffedCards = {}
      for index,value in ipairs(buffedCards) do
        print("携带buffid为", tarBuffId, "的卡片位置为", value:GetPosIndex())
        ;
        (table.insert)(t_buffedCards, {card = value, isExsit = false})
      end
      local t_preChooseCards = {}
      for index,value in ipairs(preChooseCards) do
        (table.insert)(t_preChooseCards, {card = value, isBuffed = false})
      end
      local exsitNum = 0
      for i,j in ipairs(t_preChooseCards) do
        for n,m in ipairs(t_buffedCards) do
          if (m.card):GetPosIndex() == (j.card):GetPosIndex() then
            m.isExsit = true
            j.isBuffed = true
            exsitNum = exsitNum + 1
          end
        end
      end
      for i,j in ipairs(t_preChooseCards) do
        print("备用选址卡片位置", (j.card):GetPosIndex(), "是否拥有buffid", j.isBuffed)
      end
      for index,value in ipairs(t_buffedCards) do
        print("实际拥有buffid的卡片位置", (value.card):GetPosIndex(), "是否已存在备选卡片中", value.isExsit)
      end
      if exsitNum == #preChooseCards then
        targetCards = preChooseCards
      else
        for i,j in ipairs(t_preChooseCards) do
          for n,m in ipairs(t_buffedCards) do
            if j.isBuffed == false and m.isExsit == false then
              j.card = m.card
              j.isBuffed = true
              m.isExsit = true
            end
          end
        end
        for index,value in ipairs(t_preChooseCards) do
          t_insert(targetCards, value.card)
        end
      end
    end
  end
}
  if self.onlyChoosePos ~= true and isBuff ~= true and (BattleSkill.IsAttackSkill)(skillConfig) == true then
    local isAttract, buff = (BattleBuff.IsAttract)(atkCard)
    if isAttract == true then
      local atkPos = buff:GetAtkPos()
      local card = (BattleData.GetCardInfoByPos)(atkPos)
      if card and card:IsDead() ~= true then
        t_insert(targetCards, card)
        return targetCards
      end
    end
    do
      if (BattleBuff.IsBuffEnchantment)(atkCard) then
        targetId = 3034
      else
        if (BattleBuff.IsBuffConfusion)(atkCard) then
          targetId = 4001
        else
          if targetId ~= 5005 and (skillConfig.type == BattleSkillType.NORMAL or skillConfig.type == BattleSkillType.SMALL) then
            local cards = (BattleChoose.GetCardHaveEffect)(atkCard, BattleDisplayEffect.FOCUS_ATTACK, false)
            if #cards > 0 then
              targetCards = cards
              return targetCards
            end
          end
        end
      end
      do
        local func = switch[targetId]
        if func then
          func()
        end
        local temp = (Util.clone)(targetCards)
        if not banMultiple then
          for _,v in ipairs(temp) do
            local target_type = v:GetBossIsMultiplyChoose()
            do
              -- DECOMPILER ERROR at PC265: Unhandled construct in 'MakeBoolean' P1

              if target_type and target_type == 1 and isBuff and targetId == 1000 then
                local data = (Util.clone)(targetCards[1])
                if data ~= nil then
                  targetCards = {}
                  ;
                  (table.insert)(targetCards, data)
                  break
                end
              end
              local Target = ((TableData.gTable).BaseMonsterTargetData)[targetId]
              if Target and tonumber(Target.target_num) > 1 then
                for i = 1, Target.target_num - 1 do
                  local data = (Util.clone)(v)
                  ;
                  (table.insert)(targetCards, data)
                end
              end
              do
                -- DECOMPILER ERROR at PC302: LeaveBlock: unexpected jumping out DO_STMT

              end
            end
          end
        end
        return targetCards
      end
    end
  end
end


