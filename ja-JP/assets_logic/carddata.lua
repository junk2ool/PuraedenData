-- params : ...
-- function num : 0 , upvalues : _ENV
CardData = {
cardList = {}
, 
curCardData = {}
, 
concatCardList = {}
, 
qualityFashionList = {}
, 
qualitySkillList = {}
, 
fcChangeList = {}
, 
redPointInfo = {}
}
-- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

CardData.StarUpProperty = {81050003, 81050004, 81050002, 81050005, 81050006, 81050007, 81050008}
-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

CardData.STAR_UPGRADE_ATTR_CHANGE_PANEL = "StarAttributeTips"
local pairs = pairs
local ipairs = ipairs
local ceil = math.ceil
local t_insert = table.insert
local split = split
local tonumber = tonumber
local self = CardData
-- DECOMPILER ERROR at PC40: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetBaseConfig = function(id, ...)
  -- function num : 0_0 , upvalues : _ENV
  if id == nil then
    return nil, false
  end
  local isMonster = false
  local cardConfig = ((TableData.gTable).BaseCardData)[id]
  if not cardConfig then
    cardConfig = (TableData.GetBaseMonsterData)(id)
    isMonster = true
  end
  return cardConfig, isMonster
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

CardData.InitCardAttr = function(card, cardData, battleType, battleAttrData, isSelfCard, cardDetailInfo, ...)
  -- function num : 0_1 , upvalues : self, _ENV, pairs, ipairs, ceil
  local cardId = cardData.id
  local cardConfig, isMonster = (self.GetBaseConfig)(cardId)
  if not cardConfig then
    loge("出错，未找到对应卡片")
    return 
  end
  for i,v in pairs(cardConfig) do
    card[i] = v
  end
  local baseAttributeData = (TableData.gTable).BaseAttributeData
  local needAddPercent = false
  if cardData.posIndex then
    if not cardData.uid then
      card.uid = card.uid
      if not cardData.posIndex then
        card.posIndex = card.posIndex
        if not cardData.dander then
          card.dander = card.dander
          if not cardData.hp then
            card.hp = card.hp
            if not cardData.spd then
              card.spd = card.spd
              if card.posIndex > 100 then
                needAddPercent = true
              end
              card.RoundDamage = 0
              if not cardData.level then
                card.level = card.level
                if not cardData.id then
                  card.id = card.id
                  if not cardData.fashionId then
                    card.fashionId = card.fashionId
                    if not cardData.star then
                      card.star = card.star
                      if not cardData.quality then
                        card.quality = card.quality
                        if not cardData.exp then
                          card.exp = card.exp
                          if not cardData.equipInfo then
                            card.equipInfo = card.equipInfo
                            if not cardData.skillInfo then
                              card.skillInfo = card.skillInfo
                              if not cardData.intimacyLv then
                                card.intimacyLv = card.intimacyLv
                                if not cardData.lastStageId then
                                  card.lastStageId = card.lastStageId
                                  if not cardData.sealLv then
                                    card.sealLv = card.sealLv
                                    if not cardData.sealSkillInfo then
                                      card.sealSkillInfo = card.sealSkillInfo
                                      do
                                        if isSelfCard == false and cardDetailInfo ~= nil then
                                          local fc = 0
                                          for _,attrTable in ipairs(cardDetailInfo.attr) do
                                            local id = attrTable.id
                                            local value = attrTable.value
                                            if id and value and id ~= 81050001 then
                                              local attrConfig = baseAttributeData[id]
                                              if card[attrConfig.name] then
                                                card[attrConfig.name] = card[attrConfig.name] + value
                                              else
                                                card[attrConfig.name] = value
                                              end
                                              fc = fc + value * attrConfig.fc_base / 10000
                                            end
                                          end
                                          card.fc = ceil(fc)
                                          return 
                                        end
                                        if isMonster then
                                          local add_attr_ratio = cardConfig.add_attr_ratio
                                          if not cardData.spd then
                                            card.spd = card.spd
                                            if needAddPercent == true and battleType and IsBattleTest ~= true then
                                              if battleType == (ProtoEnum.E_BATTLE_TYPE).EXPEDITION then
                                                (self.AddExpeditionAttrPercent)(card, add_attr_ratio)
                                              else
                                                if battleType == (ProtoEnum.E_BATTLE_TYPE).ACTIVITY then
                                                  (self.AddActivityAttrPercent)(card, add_attr_ratio)
                                                else
                                                  if battleType == (ProtoEnum.E_BATTLE_TYPE).TEMPLE then
                                                    print("00000000000ProtoEnum.E_BATTLE_TYPE.TEMPLE")
                                                    ;
                                                    (self.AddRelicAttrPercent)(card, add_attr_ratio)
                                                  end
                                                end
                                              end
                                            end
                                            if cardData.posIndex and battleType == (ProtoEnum.E_BATTLE_TYPE).ARENA then
                                              card.max_hp = card.hp
                                            end
                                            if battleType == (ProtoEnum.E_BATTLE_TYPE).ACTIVITY or battleType == (ProtoEnum.E_BATTLE_TYPE).TEMPLE and (CardData.GetTempleStageType)() == 1 then
                                              card.hp = card.max_hp
                                            else
                                              if not card.hp then
                                                do
                                                  card.hp = card.max_hp
                                                  do return  end
                                                  if not cardData.level then
                                                    local cardLevelConfig = (self.GetCardLevelUpConfig)(cardConfig.grow_type, card.level)
                                                    if not cardData.star then
                                                      local cardStarConfig = (self.GetCardStarUpConfig)(cardConfig.id, card.star)
                                                      if not cardData.quality then
                                                        local cardQualityConfig = (self.GetCardQualityUpConfig)(cardConfig.id, card.quality)
                                                        local levelUpAddAttrs = (self.GetAddAttrList)(cardLevelConfig.add_attr)
                                                        local starUpToLevelUpAddAttrs = (self.GetAddAttrList)(cardStarConfig.add_levelup_attr)
                                                        local starUpAddAttrs = (self.GetAddAttrList)(cardStarConfig.add_attr)
                                                        local stageUpAddAttrs = (self.GetAddAttrList)(cardQualityConfig.add_attr)
                                                        local skillUpAddAttrs = (self.GetSkillAddAttrList)(card.skillInfo)
                                                        local sealAddAttrs = (self.GetCardSealLevelUpAttr)(card.id, card.sealLv)
                                                        local sealSkillAddAttrs = (self.GetSealSkillUpAttr)(card.sealSkillInfo)
                                                        local fc = 0
                                                        local equipAddAttrs = (self.GetEquipAddAttrList)(card.equipInfo)
                                                        PrintTable(equipAddAttrs, "装备属性加成：")
                                                        local talentAttr = {}
                                                        ld("Talent")
                                                        local talentAllAttr = nil
                                                        if cardData.posIndex and (not battleAttrData or not battleAttrData.talentAllAttr) then
                                                          talentAllAttr = {}
                                                          talentAllAttr = TalentData.talentAllAttr
                                                          if not talentAllAttr then
                                                            for _,v in ipairs({}) do
                                                              talentAttr[v.id] = v.value
                                                            end
                                                            local intimacyAttrTable = nil
                                                            if cardData.posIndex and (not battleAttrData or not battleAttrData.intimacyAttrTable) then
                                                              intimacyAttrTable = {}
                                                              intimacyAttrTable = ActorData.intimacyAttrTable
                                                              local cardStarTeamAttrTable = nil
                                                              if CardData.testStarTeamAttr then
                                                                cardStarTeamAttrTable = CardData.testStarTeamAttr
                                                              else
                                                                if cardData.posIndex and (not battleAttrData or not battleAttrData.cardStarTeamAttrTable) then
                                                                  cardStarTeamAttrTable = {}
                                                                  cardStarTeamAttrTable = ActorData.cardStarTeamAttrTable
                                                                  local fetterTeamAttrTable = nil
                                                                  if cardData.posIndex and (not battleAttrData or not battleAttrData.fetterTeamAttrTable) then
                                                                    fetterTeamAttrTable = {}
                                                                    fetterTeamAttrTable = ActorData.fetterTeamAttrTable
                                                                    for _,v in pairs(baseAttributeData) do
                                                                      local id = v.id
                                                                      if id ~= 81050001 and card[v.name] then
                                                                        local attr_v = nil
                                                                        if cardData.posIndex and id == 81050021 then
                                                                          attr_v = card[v.name]
                                                                        else
                                                                          if cardData.posIndex and id == 81050002 and battleType == (ProtoEnum.E_BATTLE_TYPE).ARENA then
                                                                            attr_v = card.hp
                                                                          else
                                                                            attr_v = card[v.name] * (1 + (levelUpAddAttrs[id] and (levelUpAddAttrs[id]).value or 0) / 10000) * (1 + (starUpToLevelUpAddAttrs[id] and (starUpToLevelUpAddAttrs[id]).value or 0) / 10000) + (stageUpAddAttrs[id] and (stageUpAddAttrs[id]).value or 0) + (starUpAddAttrs[id] and (starUpAddAttrs[id]).value or 0) + (skillUpAddAttrs[id] and (skillUpAddAttrs[id]).value or 0) + (equipAddAttrs[id] and (equipAddAttrs[id]).value or 0) + (talentAttr[id] or 0) + (intimacyAttrTable[id] and (intimacyAttrTable[id]).value or 0) + (cardStarTeamAttrTable[id] and (cardStarTeamAttrTable[id]).value or 0) + (fetterTeamAttrTable[id] and (fetterTeamAttrTable[id]).value or 0) + (sealAddAttrs[id] and (sealAddAttrs[id]).value or 0) + (sealSkillAddAttrs[id] and (sealSkillAddAttrs[id]).value or 0)
                                                                          end
                                                                        end
                                                                        card[v.name] = ceil(attr_v)
                                                                        if v.fc_base and cardData.posIndex == nil then
                                                                          fc = fc + (attr_v) * v.fc_base / 10000
                                                                        end
                                                                      end
                                                                    end
                                                                    if IsBattleTest == true and cardData.addAttr then
                                                                      for _,attrTable in ipairs(cardData.addAttr) do
                                                                        local id = attrTable.id
                                                                        local value = attrTable.value
                                                                        if id and value then
                                                                          local attrConfig = baseAttributeData[id]
                                                                          if card[attrConfig.name] then
                                                                            card[attrConfig.name] = card[attrConfig.name] + value
                                                                          else
                                                                            card[attrConfig.name] = value
                                                                          end
                                                                          fc = fc + value * attrConfig.fc_base / 10000
                                                                        end
                                                                      end
                                                                    end
                                                                    do
                                                                      card.equipAddAttrs = equipAddAttrs
                                                                      if cardData.posIndex == nil then
                                                                        fc = fc + (self.GetSkillFc)(card.skillInfo)
                                                                        fc = ceil(fc)
                                                                        card.fc = fc
                                                                      end
                                                                      if needAddPercent == true and battleType and IsBattleTest ~= true then
                                                                        if battleType == (ProtoEnum.E_BATTLE_TYPE).EXPEDITION then
                                                                          (self.AddExpeditionAttrPercent)(card)
                                                                        else
                                                                          if battleType == (ProtoEnum.E_BATTLE_TYPE).ADVENTURE then
                                                                            (self.AddAdventureAttrPercent)(card)
                                                                          else
                                                                            if battleType == (ProtoEnum.E_BATTLE_TYPE).TOWER_ENCOUNTER then
                                                                              (self.AddTowerEncounterAttrPercent)(card)
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                      if not card.hp then
                                                                        card.hp = card.max_hp
                                                                        if IsBattleTest == true then
                                                                          card.hp = card.max_hp
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R7 in 'UnsetPending'

CardData.UpdateAllCardAttr = function(...)
  -- function num : 0_2 , upvalues : self, ipairs
  local allCard = (self.GetObtainedCardList)()
  for i,v in ipairs(allCard) do
    (self.ResetCardData)(v)
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetTempleStageType = function(...)
  -- function num : 0_3 , upvalues : _ENV, pairs
  if IsBattleServer == true then
    local stageId = (BattleData.expeditionBattleData).stageId
    for key,value in pairs((TableData.gTable).BaseTempleData) do
      if value.stage_id == stageId then
        return value.type
      end
    end
  else
    do
      do return (RelicData.GetCurClickedStageType)() end
    end
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R7 in 'UnsetPending'

CardData.AddExpeditionAttrPercent = function(card, add_attr_ratio, ...)
  -- function num : 0_4 , upvalues : _ENV
  local changeFc, selfMaxFc = nil, nil
  if IsBattleServer == true then
    local expeditionBattleData = BattleData.expeditionBattleData
    if expeditionBattleData then
      changeFc = expeditionBattleData.changeFc
      selfMaxFc = expeditionBattleData.selfMaxFc
    end
  else
    do
      changeFc = (ExpeditionMgr.GetExpeditionChangeFc)()
      selfMaxFc = (ExpeditionMgr.GetExpeditionSelfMaxFc)()
      ;
      (CardData.AddAttrWithFc)(changeFc, selfMaxFc, card, add_attr_ratio, (ProtoEnum.E_BATTLE_TYPE).EXPEDITION)
      local stageId = nil
      if IsBattleServer == true then
        local expeditionBattleData = BattleData.expeditionBattleData
        if expeditionBattleData then
          stageId = expeditionBattleData.stageId
        end
      else
        do
          stageId = (ExpeditionMgr.GetCurrentStage)()
          local stageConfig = ((TableData.gTable).BaseExpeditionStageData)[stageId]
          if stageConfig then
            (CardData.AddAttr)(card, stageConfig.attr_power)
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R7 in 'UnsetPending'

CardData.AddActivityAttrPercent = function(card, add_attr_ratio, ...)
  -- function num : 0_5 , upvalues : _ENV
  local changeFc, selfMaxFc = nil, nil
  if IsBattleServer == true then
    local expeditionBattleData = BattleData.expeditionBattleData
    if expeditionBattleData then
      changeFc = expeditionBattleData.changeFc
      selfMaxFc = expeditionBattleData.selfMaxFc
    end
  else
    do
      selfMaxFc = (PlotDungeonMgr.GetActivityDungeonPlayerFc)()
      changeFc = selfMaxFc - (PlotDungeonMgr.ActivityDungeonEnemyFc)()
      ;
      (CardData.AddAttrWithFc)(changeFc, selfMaxFc, card, add_attr_ratio, (ProtoEnum.E_BATTLE_TYPE).ACTIVITY)
      local stageId = nil
      if IsBattleServer == true then
        local expeditionBattleData = BattleData.expeditionBattleData
        if expeditionBattleData then
          stageId = expeditionBattleData.stageId
        end
      else
        do
          stageId = (PlotDungeonMgr.GetSelectDungeon)()
          local stageConfig = ((TableData.gTable).BaseStageData)[stageId]
          if stageConfig then
            (CardData.AddAttr)(card, stageConfig.attr_power)
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R7 in 'UnsetPending'

CardData.AddRelicAttrPercent = function(card, add_attr_ratio, ...)
  -- function num : 0_6 , upvalues : _ENV
  local changeFc, selfMaxFc = nil, nil
  if IsBattleServer == true then
    local expeditionBattleData = BattleData.expeditionBattleData
    if expeditionBattleData then
      changeFc = expeditionBattleData.changeFc
      selfMaxFc = expeditionBattleData.selfMaxFc
    end
  else
    do
      selfMaxFc = (RelicData.GetRelicPlayerFc)()
      changeFc = selfMaxFc - (PlotDungeonMgr.ActivityDungeonEnemyFc)()
      ;
      (CardData.AddAttrWithFc)(changeFc, selfMaxFc, card, add_attr_ratio, (ProtoEnum.E_BATTLE_TYPE).TEMPLE)
      local stageId = nil
      if IsBattleServer == true then
        local expeditionBattleData = BattleData.expeditionBattleData
        if expeditionBattleData then
          stageId = expeditionBattleData.stageId
        end
      else
        do
          stageId = (RelicData.GetRelicClickStageId)()
          local stageConfig = ((TableData.gTable).BaseStageData)[stageId]
          if stageConfig then
            (CardData.AddAttr)(card, stageConfig.attr_power)
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R7 in 'UnsetPending'

CardData.AddAdventureAttrPercent = function(card, ...)
  -- function num : 0_7 , upvalues : _ENV
  local stageId = BattleData.stageId
  local stageConfig = ((TableData.gTable).BaseAdventureGameBattleData)[stageId]
  if stageConfig then
    (CardData.AddAttr)(card, stageConfig.attr_power)
  end
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R7 in 'UnsetPending'

CardData.AddTowerEncounterAttrPercent = function(card, ...)
  -- function num : 0_8 , upvalues : _ENV
  local stageId = BattleData.stageId
  local stageConfig = ((TableData.gTable).BaseTowerData)[stageId]
  if stageConfig then
    (CardData.AddAttr)(card, stageConfig.attr_power)
  end
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R7 in 'UnsetPending'

CardData.AddAttr = function(card, attr_power, ...)
  -- function num : 0_9 , upvalues : _ENV, self, pairs, ceil
  local baseAttributeData = (TableData.gTable).BaseAttributeData
  local attr_power = (self.GetAddAttrList)(attr_power)
  for _,v in pairs(baseAttributeData) do
    local id = v.id
    if attr_power[id] then
      card[v.name] = card[v.name] * (attr_power[id]).value / 10000
      card[v.name] = ceil(card[v.name])
    end
  end
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R7 in 'UnsetPending'

CardData.AddAttrWithFc = function(changeFc, selfMaxFc, card, add_attr_ratio, battleType, ...)
  -- function num : 0_10 , upvalues : split, ipairs, tonumber, _ENV, self, pairs
  if changeFc and selfMaxFc and changeFc > 0 then
    local ratio = {}
    if add_attr_ratio then
      local t = split(add_attr_ratio, ",")
      for _,v in ipairs(t) do
        local m = split(v, ":")
        ratio[tonumber(m[1])] = tonumber(m[2])
      end
    end
    do
      local config = (TableData.GetMonsterFcConfig)(selfMaxFc, battleType)
      if config then
        local baseAttributeData = (TableData.gTable).BaseAttributeData
        local addAttr = config.add_attr
        local attrTable = (self.GetAddAttrList)(addAttr)
        for _,v in pairs(baseAttributeData) do
          local id = v.id
          if not ratio[id] then
            do
              card[v.name] = card[v.name] + (not attrTable[id] or 10000) * (attrTable[id]).value * changeFc / config.fc_unit / 10000
              -- DECOMPILER ERROR at PC68: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC68: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      do
        if battleType == (ProtoEnum.E_BATTLE_TYPE).TEMPLE and (CardData.GetTempleStageType)() == 2 then
          local weakNum = nil
          if IsBattleServer == true then
            weakNum = (BattleData.expeditionBattleData).challengeTimes
          else
            weakNum = (RelicData.GetEliteEnemySubNum)()
          end
          local weakenConfig = nil
          print("------------1", weakNum)
          for index,value in pairs((TableData.gTable).BaseTempleWeakenData) do
            if value.time_min <= weakNum and weakNum <= value.time_max and weakNum > 0 then
              weakenConfig = value
              break
            end
          end
          do
            if weakenConfig then
              local attrs = split(weakenConfig.weakenNum, ",")
              print("------------2", weakenConfig.weakenNum, attrs, #attrs)
              for index,value in ipairs(attrs) do
                local strs = split(value, ":")
                local attrId = tonumber(strs[1])
                print("-------2.5", value)
                local weakNum = (10000 + tonumber(strs[2])) * 0.0001
                local attrConfig = ((TableData.gTable).BaseAttributeData)[attrId]
                print("----------3", attrConfig.name, card[attrConfig.name], weakNum)
                card[attrConfig.name] = card[attrConfig.name] * weakNum
                print("----------4", attrConfig.name, card[attrConfig.name], weakNum)
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetEquipAddAttrList = function(equipInfo, ...)
  -- function num : 0_11 , upvalues : ipairs, self, _ENV, pairs
  local addAttrList = {}
  if equipInfo then
    for _,info in ipairs(equipInfo) do
      local mainAttrId = info.mainAttrId
      local randomAttrIds = info.randomAttrId
      ;
      (self.GetAddAttrById)(addAttrList, mainAttrId)
      for _,randomId in ipairs(randomAttrIds) do
        (self.GetAddAttrById)(addAttrList, randomId)
      end
    end
    local suitIds = (EquiptData.GetSuitInfobyEquipts)(equipInfo)
    if suitIds then
      for _,id in pairs(suitIds) do
        local suitConfig = ((TableData.gTable).BaseEquipSuitData)[id]
        if suitConfig then
          local tempAttrList = (self.GetAddAttrList)(suitConfig.add_attr)
          ;
          (self.MergeAttrList)(addAttrList, tempAttrList)
          loge("激活的套装id: " .. id)
          PrintTable(tempAttrList, "套装属性：")
        end
      end
    end
  end
  do
    return addAttrList
  end
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetAddAttrById = function(addAttrList, attrId, ...)
  -- function num : 0_12 , upvalues : _ENV, self
  if attrId and addAttrList then
    local equipAttrConfig = ((TableData.gTable).BaseEquipAttributeData)[attrId]
    if equipAttrConfig then
      local tempAttrList = (self.GetAddAttrList)(equipAttrConfig.value)
      ;
      (self.MergeAttrList)(addAttrList, tempAttrList)
    end
  end
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R7 in 'UnsetPending'

CardData.MergeAttrList = function(addAttrList, tempAttrList, ...)
  -- function num : 0_13 , upvalues : pairs
  for id,info in pairs(tempAttrList) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    if addAttrList[id] then
      (addAttrList[id]).value = info.value + (addAttrList[id]).value
    else
      addAttrList[id] = info
    end
  end
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetSkillFc = function(skillInfo, ...)
  -- function num : 0_14 , upvalues : ipairs, _ENV, self
  local fc = 0
  if skillInfo then
    for _,info in ipairs(skillInfo) do
      local skillId = info.id
      local skillLevel = info.value
      local skillConfig = (TableData.GetBaseSkillData)(skillId)
      if not skillConfig.fc then
        fc = fc + (not skillConfig or 0) * skillLevel
        do
          if not (self.GetBaseSkillAttrData)(skillConfig.add_attr_type, skillLevel) then
            local attrConfig = {}
          end
          fc = fc + (attrConfig.fc or 0)
          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return fc
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetSkillAddAttrList = function(skillInfos, ...)
  -- function num : 0_15 , upvalues : _ENV, ipairs, self, pairs
  local attrList = {}
  do
    if skillInfos then
      local GetBaseSkillData = TableData.GetBaseSkillData
      for _,info in ipairs(skillInfos) do
        local skillId = info.id
        local skillLevel = info.value
        local skillConfig = GetBaseSkillData(skillId)
        if skillConfig then
          if skillConfig.add_attr ~= "" and skillConfig.add_attr ~= "0" then
            local tempAttrList = (self.GetAddAttrList)(skillConfig.add_attr)
            for id,data in pairs(tempAttrList) do
              -- DECOMPILER ERROR at PC38: Confused about usage of register: R17 in 'UnsetPending'

              if attrList[id] then
                (attrList[id]).value = (attrList[id]).value + data.value * skillLevel
              else
                data.value = data.value * skillLevel
                attrList[id] = data
              end
            end
          end
          do
            if skillConfig.add_attr_type ~= 0 then
              if not (self.GetBaseSkillAttrData)(skillConfig.add_attr_type, skillLevel) then
                local attrConfig = {}
              end
              local add_attr = attrConfig.add_attr
              if add_attr ~= "" and add_attr ~= "0" then
                local tempAttrList = (self.GetAddAttrList)(add_attr)
                for id,data in pairs(tempAttrList) do
                  -- DECOMPILER ERROR at PC76: Confused about usage of register: R19 in 'UnsetPending'

                  if attrList[id] then
                    (attrList[id]).value = (attrList[id]).value + data.value
                  else
                    data.value = data.value
                    attrList[id] = data
                  end
                end
              end
            end
            do
              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    return attrList
  end
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R7 in 'UnsetPending'

CardData.UpdateCardLevelInfo = function(levelInfo, ...)
  -- function num : 0_16 , upvalues : self
  local id = levelInfo.id
  local level = levelInfo.level
  local exp = levelInfo.exp
  local cardData = (self.GetCardData)(id)
  if cardData then
    cardData.level = level
    cardData.exp = exp
    ;
    (self.ResetCardData)(cardData)
  end
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveAllCard = function(cardInfoList, ...)
  -- function num : 0_17 , upvalues : ipairs, self, t_insert, _ENV
  local cardList = {}
  for _,v in ipairs(cardInfoList) do
    local oneCard = (self.InitOneCard)(v)
    t_insert(cardList, oneCard)
  end
  ;
  (table.sort)(cardList, function(a, b, ...)
    -- function num : 0_17_0
    do return b.fc < a.fc end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self.cardList = cardList
  ;
  (self.SaveNotObtainCardList)()
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetCardData = function(cardId, ...)
  -- function num : 0_18 , upvalues : ipairs, self
  for _,v in ipairs(self.cardList) do
    if v.id == cardId then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetCardIndexByCardId = function(cardId, ...)
  -- function num : 0_19 , upvalues : ipairs, self
  local index = 1
  for i,v in ipairs(self.cardList) do
    if v.id ~= cardId then
      do
        index = index + 1
        -- DECOMPILER ERROR at PC9: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC9: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return index
end

-- DECOMPILER ERROR at PC100: Confused about usage of register: R7 in 'UnsetPending'

CardData.ObtainNewCard = function(cardInfo, ...)
  -- function num : 0_20 , upvalues : self, t_insert, _ENV
  local oneCard = (self.InitOneCard)(cardInfo)
  t_insert(self.cardList, oneCard)
  ;
  (self.SaveNotObtainCardList)()
  ;
  (HandBookData.CheckFetterData)()
  if (HandBookData.GetCanActiveBySingleCardId)(oneCard.id) then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockNewFetter)
  end
end

-- DECOMPILER ERROR at PC103: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveNotObtainCardList = function(...)
  -- function num : 0_21 , upvalues : _ENV, pairs, self, tonumber, t_insert
  local canMergeCardList = {}
  local notObtainCardList = {}
  local allCardConfig = (TableData.gTable).BaseCardData
  for id,v in pairs(allCardConfig) do
    if v.is_display_in_uncall == 1 and not (self.IsObtained)(id) then
      local pieceInfo = (ActorData.GetCardPieceInfo)(id)
      if pieceInfo then
        if pieceInfo.haveNum < pieceInfo.needNum then
          local configTime = v.open_time
          local isSatisfy = true
          do
            do
              do
                if configTime then
                  local serverTime = (LuaTime.GetTimeStamp)()
                  isSatisfy = tonumber(configTime) <= tonumber(serverTime)
                end
                if isSatisfy then
                  t_insert(notObtainCardList, v)
                end
                t_insert(canMergeCardList, v)
                -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  self.canMergeCardList = canMergeCardList
  self.notObtainCardList = notObtainCardList
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R7 in 'UnsetPending'

CardData.InitOneCard = function(cardInfo, ...)
  -- function num : 0_22 , upvalues : self
  local oneCardData = {}
  ;
  (self.InitCardAttr)(oneCardData, cardInfo)
  oneCardData.hp = oneCardData.max_hp
  oneCardData.equipScheme = cardInfo.equipScheme
  oneCardData.GetEquipAddAttrByType = function(self, type, ...)
    -- function num : 0_22_0
    if self == nil or self.equipAddAttrs == nil then
      return 0
    end
    if (self.equipAddAttrs)[type] ~= nil then
      return ((self.equipAddAttrs)[type]).value
    else
      return 0
    end
  end

  return oneCardData
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetObtainedCardList = function(...)
  -- function num : 0_23 , upvalues : self
  return self.cardList
end

-- DECOMPILER ERROR at PC112: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetCardListWithLimit = function(...)
  -- function num : 0_24 , upvalues : _ENV, ipairs, tonumber
  local List = (CardData.GetObtainedCardList)()
  local cardList = {}
  local limitConfig = nil
  for _,v in ipairs(List) do
    limitConfig = ((TableData.gTable).BaseCardLimitData)[v.id]
    if limitConfig == nil or limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time) then
      (table.insert)(cardList, v)
    end
  end
  return cardList
end

-- DECOMPILER ERROR at PC115: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetFormationCards = function(...)
  -- function num : 0_25 , upvalues : _ENV, ipairs, tonumber
  local List = (CardData.GetObtainedCardList)()
  local cardList = {}
  local limitConfig = nil
  for _,v in ipairs(List) do
    limitConfig = ((TableData.gTable).BaseCardLimitData)[v.id]
    if limitConfig == nil or limitConfig.fight_display ~= 0 and (limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time)) then
      (table.insert)(cardList, v)
    end
  end
  return cardList
end

-- DECOMPILER ERROR at PC118: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetPreEditFormationCards = function(...)
  -- function num : 0_26 , upvalues : _ENV, ipairs, tonumber
  local List = (CardData.GetObtainedCardList)()
  local cardList = {}
  local limitConfig = nil
  for _,v in ipairs(List) do
    limitConfig = ((TableData.gTable).BaseCardLimitData)[v.id]
    if limitConfig == nil or limitConfig.formation_display ~= 0 and (limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time)) then
      (table.insert)(cardList, v)
    end
  end
  return cardList
end

-- DECOMPILER ERROR at PC121: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetObtainedRankingList = function(num, ...)
  -- function num : 0_27 , upvalues : self, t_insert, _ENV
  if not num then
    num = 18
  end
  local cardList = self.cardList
  local list = {}
  for i = 1, num do
    if cardList[i] then
      t_insert(list, (Util.Copy)(cardList[i]))
    end
  end
  return list
end

-- DECOMPILER ERROR at PC124: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetObtainedRankAllList = function(...)
  -- function num : 0_28 , upvalues : self
  local cardList = self.cardList
  return cardList
end

-- DECOMPILER ERROR at PC127: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetNotObtainedCardList = function(...)
  -- function num : 0_29 , upvalues : self, ipairs, _ENV, tonumber
  local List = self.notObtainCardList
  local cardList = {}
  local limitConfig = nil
  for _,v in ipairs(List) do
    limitConfig = ((TableData.gTable).BaseCardLimitData)[v.id]
    if limitConfig == nil or limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time) then
      (table.insert)(cardList, v)
    end
  end
  return cardList
end

-- DECOMPILER ERROR at PC130: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetCanMergeCardList = function(...)
  -- function num : 0_30 , upvalues : self, ipairs, _ENV, tonumber
  local List = self.canMergeCardList
  local cardList = {}
  local limitConfig = nil
  for _,v in ipairs(List) do
    limitConfig = ((TableData.gTable).BaseCardLimitData)[v.id]
    if limitConfig == nil or limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time) then
      (table.insert)(cardList, v)
    end
  end
  return cardList
end

-- DECOMPILER ERROR at PC133: Confused about usage of register: R7 in 'UnsetPending'

CardData.IsObtained = function(cardId, ...)
  -- function num : 0_31 , upvalues : self, ipairs
  local obtainCardList = (self.GetObtainedCardList)()
  for _,v in ipairs(obtainCardList) do
    if v.id == cardId then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC136: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetAddAttrList = function(add_attr, ...)
  -- function num : 0_32 , upvalues : split, ipairs, tonumber
  local attrList = {}
  if add_attr then
    local addAttrTable = split(add_attr, ",")
    for _,v in ipairs(addAttrTable) do
      local addAttr = split(v, ":")
      if addAttr and #addAttr > 1 then
        local addType, attrId, addValue = nil, nil, nil
        if #addAttr == 3 then
          addType = tonumber(addAttr[1])
          attrId = tonumber(addAttr[2])
          addValue = tonumber(addAttr[3])
        else
          if #addAttr == 2 then
            attrId = tonumber(addAttr[1])
            addValue = tonumber(addAttr[2])
          end
        end
        local oneAddAttr = {type = addType, id = attrId, value = addValue}
        attrList[attrId] = oneAddAttr
      end
    end
  end
  do
    return attrList
  end
end

-- DECOMPILER ERROR at PC139: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetCardLevelUpConfig = function(type, level, ...)
  -- function num : 0_33 , upvalues : _ENV, pairs
  local levelUpConfig = (TableData.gTable).BaseCardLevelUpData
  for _,v in pairs(levelUpConfig) do
    if v.type == type and v.level == level then
      return v
    end
  end
  return {}
end

-- DECOMPILER ERROR at PC142: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetCardStarUpConfig = function(id, star, ...)
  -- function num : 0_34 , upvalues : _ENV
  do
    if id and star then
      local starUpConfig = (TableData.gTable).BaseCardStarUpData
      return starUpConfig[id * 100 + star]
    end
    return {}
  end
end

-- DECOMPILER ERROR at PC145: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetCardQualityUpConfig = function(id, quality, ...)
  -- function num : 0_35 , upvalues : _ENV
  do
    if id and quality then
      local qualityUpConfig = (TableData.gTable).BaseCardQualityUpData
      return qualityUpConfig[id * 100 + quality]
    end
    return {}
  end
end

-- DECOMPILER ERROR at PC148: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetFashionConfig = function(cardInfo, notUseFashionID, ...)
  -- function num : 0_36 , upvalues : self, _ENV, tonumber, split
  local id = cardInfo.id
  local quality = cardInfo.quality
  local cardConfig, isMonster = (self.GetBaseConfig)(id)
  if not notUseFashionID then
    local fashionId = cardInfo.fashionId
    if isMonster then
      return ((TableData.gTable).BaseFashionData)[cardConfig.unlock_fashion_id]
    else
      if fashionId and fashionId ~= 0 then
        if id then
          local cardData = ((TableData.gTable).BaseCardData)[id]
          local fashionId_default = tonumber((split(cardData.fashion_ids, ":"))[1])
          local fashionCfg = ((TableData.gTable).BaseFashionData)[fashionId]
          do
            do
              do
                if fashionCfg and fashionCfg.close_time then
                  local serverTime = (LuaTime.GetTimeStamp)()
                  if fashionCfg.close_time <= serverTime then
                    fashionCfg = ((TableData.gTable).BaseFashionData)[fashionId_default]
                  end
                end
                do return fashionCfg end
                do return ((TableData.gTable).BaseFashionData)[fashionId] end
                if id and quality then
                  if cardConfig == nil then
                    return 
                  end
                  if isMonster then
                    return ((TableData.gTable).BaseFashionData)[cardConfig.unlock_fashion_id]
                  end
                  local qualityUpConfig = (TableData.gTable).BaseCardQualityUpData
                  for i = id * 100 + quality, id * 100, -1 do
                    local curConfig = qualityUpConfig[i]
                    if curConfig then
                      local unlock_fashion_id = curConfig.unlock_fashion_id
                      if unlock_fashion_id and unlock_fashion_id ~= 0 then
                        return ((TableData.gTable).BaseFashionData)[unlock_fashion_id]
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC151: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetAttrRemarkById = function(id, ...)
  -- function num : 0_37 , upvalues : _ENV
  if id then
    local tableData = (TableData.gTable).BaseAttributeData
    local config = tableData[id]
    if not config or not config.remark then
      do return "未找到属性：" .. id end
    end
  end
end

-- DECOMPILER ERROR at PC154: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetAttrIdByName = function(name, ...)
  -- function num : 0_38 , upvalues : _ENV, pairs
  if name then
    local tableData = (TableData.gTable).BaseAttributeData
    for _,v in pairs(tableData) do
      if v.name == name then
        return v.id
      end
    end
  end
end

-- DECOMPILER ERROR at PC157: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveCurClickCardID = function(id, ...)
  -- function num : 0_39 , upvalues : self
  self.curClickedID = id
end

-- DECOMPILER ERROR at PC160: Confused about usage of register: R7 in 'UnsetPending'

CardData.ReturnCardID = function(...)
  -- function num : 0_40 , upvalues : self
  return self.curClickedID or 0
end

-- DECOMPILER ERROR at PC163: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveCurClickCardIndex = function(index, ...)
  -- function num : 0_41 , upvalues : self
  self.curClickedIndex = index
end

-- DECOMPILER ERROR at PC166: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetCardIndex = function(...)
  -- function num : 0_42 , upvalues : self
  return self.curClickedIndex or 1
end

-- DECOMPILER ERROR at PC169: Confused about usage of register: R7 in 'UnsetPending'

CardData.SetCardDataLevel = function(cID, level, ...)
  -- function num : 0_43 , upvalues : ipairs, self
  for _,v in ipairs(self.cardList) do
    if v.id == cID then
      v.level = level
      ;
      (self.ResetCardData)(v)
      break
    end
  end
end

-- DECOMPILER ERROR at PC172: Confused about usage of register: R7 in 'UnsetPending'

CardData.SetCardDataExp = function(cID, exp, ...)
  -- function num : 0_44 , upvalues : ipairs, self
  for _,v in ipairs(self.cardList) do
    if v.id == cID then
      v.exp = exp
      break
    end
  end
end

-- DECOMPILER ERROR at PC175: Confused about usage of register: R7 in 'UnsetPending'

CardData.SetCardDataFc = function(cID, fc, ...)
  -- function num : 0_45 , upvalues : ipairs, self
  for _,v in ipairs(self.cardList) do
    if v.id == cID then
      v.fc = fc
      break
    end
  end
end

-- DECOMPILER ERROR at PC178: Confused about usage of register: R7 in 'UnsetPending'

CardData.SetCardDataQuality = function(cID, quality, ...)
  -- function num : 0_46 , upvalues : ipairs, self
  for _,v in ipairs(self.cardList) do
    if v.id == cID then
      v.quality = quality
      ;
      (self.ResetCardData)(v)
      break
    end
  end
end

-- DECOMPILER ERROR at PC181: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveHowManySkillGetFromQ = function(skillTable, ...)
  -- function num : 0_47 , upvalues : self, _ENV
  self.qualitySkillList = {}
  self.qualitySkillList = skillTable
  print("技能个数:", #self.qualitySkillList)
end

-- DECOMPILER ERROR at PC184: Confused about usage of register: R7 in 'UnsetPending'

CardData.SubHowManySkillGetFromQ = function(...)
  -- function num : 0_48 , upvalues : _ENV, self
  (table.remove)(self.qualitySkillList, 1)
end

-- DECOMPILER ERROR at PC187: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetHowManySkillGetFromQ = function(...)
  -- function num : 0_49 , upvalues : self
  return self.qualitySkillList
end

-- DECOMPILER ERROR at PC190: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveHowManyFashionGetFromQ = function(fashionTable, ...)
  -- function num : 0_50 , upvalues : self, _ENV
  self.qualityFashionList = {}
  self.qualityFashionList = fashionTable
  print("立绘个数:", #self.qualityFashionList)
end

-- DECOMPILER ERROR at PC193: Confused about usage of register: R7 in 'UnsetPending'

CardData.SubHowManyFashionGetFromQ = function(...)
  -- function num : 0_51 , upvalues : _ENV, self
  (table.remove)(self.qualityFashionList, 1)
end

-- DECOMPILER ERROR at PC196: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetHowManyFashionGetFromQ = function(...)
  -- function num : 0_52 , upvalues : self
  return self.qualityFashionList
end

-- DECOMPILER ERROR at PC199: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveUpSkills = function(cID, skills, ...)
  -- function num : 0_53 , upvalues : ipairs, self, pairs, t_insert
  for _,v in ipairs(self.cardList) do
    if v.id == cID then
      for n,m in pairs(skills) do
        local isEx = false
        for k,l in pairs(v.skillInfo) do
          if l.id == m.id then
            l.value = m.value
            isEx = true
          end
        end
        if isEx == false then
          local tmp = {id = m.id, value = m.value}
          t_insert(v.skillInfo, tmp)
        end
      end
      ;
      (self.ResetCardData)(v)
      break
    end
  end
end

-- DECOMPILER ERROR at PC202: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetSkillLevel = function(cID, skillID, ...)
  -- function num : 0_54 , upvalues : ipairs, self, pairs
  for _,v in ipairs(self.cardList) do
    if v.id == cID then
      for k,l in pairs(v.skillInfo) do
        if not l.value then
          do
            do return l.id ~= skillID or 0 end
            -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC205: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveFashionID = function(cardID, fashionID, ...)
  -- function num : 0_55 , upvalues : ipairs, self
  for _,v in ipairs(self.cardList) do
    if v.id == cardID then
      v.fashionId = fashionID
      break
    end
  end
end

-- DECOMPILER ERROR at PC208: Confused about usage of register: R7 in 'UnsetPending'

CardData.GetFashionID = function(cardID, ...)
  -- function num : 0_56 , upvalues : ipairs, self
  local fashionID = 0
  for _,v in ipairs(self.cardList) do
    if v.id == cardID then
      v.fashionId = fashionID
      break
    end
  end
  do
    return fashionID
  end
end

-- DECOMPILER ERROR at PC211: Confused about usage of register: R7 in 'UnsetPending'

CardData.UpdateCardQualityrInfo = function(id, quality, ...)
  -- function num : 0_57 , upvalues : self, _ENV
  local cardData = (self.GetCardData)(id)
  local oldData = (Util.Copy)(cardData)
  if cardData then
    cardData.quality = quality
  end
  ;
  (self.ResetCardData)(cardData)
  return oldData
end

-- DECOMPILER ERROR at PC214: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveCardIntimacyLevel = function(cardID, intimacyLevel, ...)
  -- function num : 0_58 , upvalues : ipairs, self, _ENV
  for _,v in ipairs(self.cardList) do
    if v.id == cardID then
      v.intimacyLv = intimacyLevel
      break
    end
  end
  do
    ;
    (ActorData.SaveIntimacyData)(cardID, intimacyLevel)
    ;
    (self.UpdateAllCardAttr)()
  end
end

-- DECOMPILER ERROR at PC217: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveCardStarLeve = function(...)
  -- function num : 0_59 , upvalues : _ENV, self
  (ActorData.SaveCardStarTeamAttrTable)()
  ;
  (self.UpdateAllCardAttr)()
end

-- DECOMPILER ERROR at PC220: Confused about usage of register: R7 in 'UnsetPending'

CardData.SaveFetter = function(...)
  -- function num : 0_60 , upvalues : _ENV, self
  (ActorData.SaveFetterAttrTable)()
  ;
  (self.UpdateAllCardAttr)()
end

-- DECOMPILER ERROR at PC223: Confused about usage of register: R7 in 'UnsetPending'

CardData.UpdateCardStageID = function(cardID, StageID, ...)
  -- function num : 0_61 , upvalues : ipairs, self
  for _,v in ipairs(self.cardList) do
    if v.id == cardID and v.lastStageId < StageID then
      v.lastStageId = StageID
      break
    end
  end
end

-- DECOMPILER ERROR at PC225: Confused about usage of register: R7 in 'UnsetPending'

CardData.CurrentCardInfo = nil
-- DECOMPILER ERROR at PC230: Confused about usage of register: R7 in 'UnsetPending'

CardData.CurrentUpgradeStarCost = {pieces = 0, currency = 0}
-- DECOMPILER ERROR at PC233: Confused about usage of register: R7 in 'UnsetPending'

CardData.UpdateCardStarInfo = function(id, star, ...)
  -- function num : 0_62 , upvalues : self, _ENV
  local cardData = (self.GetCardData)(id)
  local oldData = (Util.Copy)(cardData)
  if cardData and star ~= cardData.star then
    cardData.star = star
    ;
    (self.SaveCardStarLeve)()
  end
  return oldData
end

-- DECOMPILER ERROR at PC236: Confused about usage of register: R7 in 'UnsetPending'

CardData.UpdateCardInfo = function(cID, data, ...)
  -- function num : 0_63 , upvalues : ipairs, self, pairs
  for _,v in ipairs(self.cardList) do
    if v.id == cID then
      local preFc = v.fc
      local newFc = data.fc
      for subk,subv in pairs(data) do
        v[subk] = subv
      end
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.fcChangeList)[cID] = {preFc = preFc, newFc = newFc}
      break
    end
  end
end

local SR_WILD_CARD = 21120001
local WILD_CARD = 21120000
self.WildCardId = 0
self.SRWildCard = nil
self.WildCard = nil
self.CurrentExchangePieces = 0
self.CurrentCardPiecesNeed = 0
self.CardPiecesToUpgrade = 0
self.CurrentPieceID = 0
self.CurrentCardPieceInfo = nil
self.WildCardAmount = 0
-- DECOMPILER ERROR at PC250: Confused about usage of register: R9 in 'UnsetPending'

CardData.SetWildCardId = function(cardId, ...)
  -- function num : 0_64 , upvalues : self, _ENV, SR_WILD_CARD, WILD_CARD, tonumber
  if self.SRWildCard == nil then
    self.SRWildCard = ((TableData.gTable).BasePropData)[SR_WILD_CARD]
    self.WildCard = ((TableData.gTable).BasePropData)[WILD_CARD]
  end
  local config = ((TableData.gTable).BaseCardData)[cardId]
  if tonumber((self.SRWildCard).effect_value) < config.intelligence then
    self.WildCardId = (self.WildCard).id
  else
    if (ActorData.GetGoodsCount)((self.SRWildCard).id, PropType.ITEM) > 0 or (ActorData.GetGoodsCount)((self.WildCard).id, PropType.ITEM) == 0 then
      self.WildCardId = (self.SRWildCard).id
    else
      self.WildCardId = (self.WildCard).id
    end
  end
end

-- DECOMPILER ERROR at PC253: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetNextStarCardData = function(cardData, ...)
  -- function num : 0_65 , upvalues : _ENV, self
  local newOne = {}
  cardData.star = cardData.star + 1
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  CardData.testStarTeamAttr = (ActorData.GetCardStarTeamAttrTable)()
  ;
  (self.InitCardAttr)(newOne, cardData)
  cardData.star = cardData.star - 1
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  CardData.testStarTeamAttr = nil
  return newOne
end

-- DECOMPILER ERROR at PC256: Confused about usage of register: R9 in 'UnsetPending'

CardData.CheckExchangeAmount = function(...)
  -- function num : 0_66 , upvalues : _ENV, self
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  CardData.CardPiecesToUpgrade = CardData.CurrentCardPiecesNeed - (CardData.CurrentCardPieceInfo).haveNum
  if self.CardPiecesToUpgrade <= 0 then
    self.CardPiecesToUpgrade = 0
  end
end

-- DECOMPILER ERROR at PC259: Confused about usage of register: R9 in 'UnsetPending'

CardData.SetToMaxExchange = function(...)
  -- function num : 0_67 , upvalues : _ENV, self, WILD_CARD
  local wildCardCount = (ActorData.GetGoodsCount)(self.WildCardId, PropType.ITEM)
  if self.CardPiecesToUpgrade < wildCardCount then
    if self.CardPiecesToUpgrade == self.CurrentExchangePieces then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000082))
      return 
    end
    ;
    (self.ChangeExchangePieces)(self.CardPiecesToUpgrade - self.CurrentExchangePieces)
  else
    if wildCardCount == 0 then
      if self.WildCardId == WILD_CARD then
        (MessageMgr.SendCenterTips)((PUtil.get)(60000080))
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(60000528))
      end
      return 
    else
      if wildCardCount == self.CurrentExchangePieces then
        (MessageMgr.SendCenterTips)((PUtil.get)(60000083))
        return 
      end
    end
    ;
    (self.ChangeExchangePieces)(wildCardCount - self.CurrentExchangePieces)
  end
end

-- DECOMPILER ERROR at PC262: Confused about usage of register: R9 in 'UnsetPending'

CardData.ChangeExchangePieces = function(change, ...)
  -- function num : 0_68 , upvalues : self, _ENV
  if self.CurrentExchangePieces == 0 and change < 0 then
    return 
  end
  local origin = self.CurrentExchangePieces
  self.CurrentExchangePieces = self.CurrentExchangePieces + change
  if self.CardPiecesToUpgrade < self.CurrentExchangePieces then
    if self.CardPiecesToUpgrade <= origin then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000082))
    end
    self.CurrentExchangePieces = self.CardPiecesToUpgrade
  end
  local wildCardCount = (ActorData.GetGoodsCount)(self.WildCardId, PropType.ITEM)
  if wildCardCount < self.CurrentExchangePieces then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000083))
    self.CurrentExchangePieces = wildCardCount
  end
  UIMgr:SendWindowMessage((WinResConfig.StarDebrisChangeGrpWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_PIECE_EXCHANGE_COUNT)
end

-- DECOMPILER ERROR at PC265: Confused about usage of register: R9 in 'UnsetPending'

CardData.ResetCardData = function(cardData, ...)
  -- function num : 0_69 , upvalues : self
  local newOne = {}
  cardData.hp = nil
  ;
  (self.InitCardAttr)(newOne, cardData)
  ;
  (self.UpdateCardInfo)(cardData.id, newOne)
end

-- DECOMPILER ERROR at PC268: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetMaxStarCards = function(...)
  -- function num : 0_70 , upvalues : self, _ENV, t_insert
  local maxStarCards = {}
  local count = #self.cardList
  for i = 1, count do
    if ((self.cardList)[i]).star == Const.MaxRoleStar then
      t_insert(maxStarCards, (self.cardList)[i])
    end
  end
  return maxStarCards
end

-- DECOMPILER ERROR at PC271: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetBaseSkillAttrData = function(sType, level, ...)
  -- function num : 0_71 , upvalues : pairs, _ENV
  local data = nil
  for k,v in pairs((TableData.gTable).BaseSkillAttrData) do
    if v.type == sType and v.level == level then
      data = v
    end
  end
  return data
end

-- DECOMPILER ERROR at PC274: Confused about usage of register: R9 in 'UnsetPending'

CardData.CheckUpSixHeroRedPoint = function(...)
  -- function num : 0_72 , upvalues : self
  local homeRedDot = false
  local allHeroList = (self.GetObtainedRankAllList)()
  for i = 1, 6 do
    if allHeroList[i] then
      local cardId = (allHeroList[i]).id
      if not (self.CheckAllHeroLevelUpRedPoint)(cardId) and not (self.CheckAllHeroStageUpRedPoint)(cardId) and not (self.CheckAllHeroStarUpRedPoint)(cardId) then
        local tmpRedDot = (self.CheckAllHeroSkillUpRedPoint)(cardId)
      end
      if tmpRedDot then
        homeRedDot = true
        break
      end
    end
  end
  do
    homeRedDot = homeRedDot or #(self.GetCanMergeCardList)() > 0
    do return homeRedDot end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC277: Confused about usage of register: R9 in 'UnsetPending'

CardData.CheckIsSixHeroId = function(id, ...)
  -- function num : 0_73 , upvalues : self
  local isSix = false
  local allHeroList = (self.GetObtainedRankAllList)()
  for i = 1, 6 do
    local cardId = (allHeroList[i]).id
    if id == cardId then
      isSix = true
      break
    end
  end
  do
    return isSix
  end
end

-- DECOMPILER ERROR at PC280: Confused about usage of register: R9 in 'UnsetPending'

CardData.CheckUpAllHeroRedPoint = function(...)
  -- function num : 0_74 , upvalues : self
  self.redPointInfo = {}
end

-- DECOMPILER ERROR at PC283: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetTrueMaxLevel = function(a, b, ...)
  -- function num : 0_75
  local tmp = a
  if b < a then
    tmp = b
  end
  return tmp
end

-- DECOMPILER ERROR at PC286: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetRoleMaxLevel = function(cardId, ...)
  -- function num : 0_76 , upvalues : _ENV
  local limitConfig = ((TableData.gTable).BaseCardLimitData)[cardId]
  if limitConfig and limitConfig.max_level then
    return limitConfig.max_level
  else
    return (((TableData.gTable).BaseFixedData)[Const.MAX_CARDLEVEL]).int_value
  end
end

-- DECOMPILER ERROR at PC289: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetRoleMaxStage = function(cardId, ...)
  -- function num : 0_77 , upvalues : _ENV
  local limitConfig = ((TableData.gTable).BaseCardLimitData)[cardId]
  if limitConfig and limitConfig.max_quality_level then
    return limitConfig.max_quality_level
  else
    return (((TableData.gTable).BaseFixedData)[Const.MAX_CARDSTAGE]).int_value
  end
end

-- DECOMPILER ERROR at PC292: Confused about usage of register: R9 in 'UnsetPending'

CardData.CheckAllHeroLevelUpRedPoint = function(cardId, ...)
  -- function num : 0_78 , upvalues : _ENV, self, pairs
  if (FunctionControlMgr.GetFunctionState)(ControlID.Card_Strength, false) ~= true then
    return false
  end
  local cardData = (self.GetCardData)(cardId)
  local MAX_LEVEL = (CardData.GetRoleMaxLevel)(cardId)
  local tmpMax = (CardData.GetTrueMaxLevel)(MAX_LEVEL, (ActorData.GetLevel)())
  if tmpMax <= cardData.level then
    return false
  end
  local expPool = 0
  for i = 1, 4 do
    local itemID = 21110000 + i
    local count = ((ActorData.GetPropsIDAndNum)(itemID)).count
    if count > 0 then
      expPool = expPool + (((TableData.gTable).BasePropData)[itemID]).effect_value * count
    end
  end
  if expPool <= 0 then
    return false
  end
  local isHaveLvlUpMat = false
  local curExp = cardData.exp
  local needExp = 0
  local tableConfig = (TableData.gTable).BaseCardLevelUpData
  local grow_type = cardData.grow_type
  local level = cardData.level
  for n,m in pairs(tableConfig) do
    if m.type == grow_type and m.level == level then
      needExp = m.next_exp
      break
    end
  end
  do
    if needExp <= curExp + (expPool) then
      isHaveLvlUpMat = true
    else
      isHaveLvlUpMat = false
    end
    return isHaveLvlUpMat
  end
end

-- DECOMPILER ERROR at PC295: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetCurCardIsHaveLevelUpRedDot = function(cardId, ...)
  -- function num : 0_79 , upvalues : ipairs, self
  for i,v in ipairs((self.redPointInfo).levelUpInfo) do
    if v.cardId == cardId then
      return v.lvlUpRedDot
    end
  end
end

-- DECOMPILER ERROR at PC298: Confused about usage of register: R9 in 'UnsetPending'

CardData.CheckAllHeroStageUpRedPoint = function(cardId, ...)
  -- function num : 0_80 , upvalues : _ENV, self, split, ipairs, tonumber
  if (FunctionControlMgr.GetFunctionState)(ControlID.Card_Break, false) ~= true then
    return false
  end
  local cardData = (self.GetCardData)(cardId)
  local canStageUp = true
  local upStageData = (CardMgr.GetBaseCardQualityData)(cardData.quality + 1, cardData.id)
  if upStageData then
    local needItemString = split(upStageData.need_goods, ",")
    for j,k in ipairs(needItemString) do
      local splitData = split(k, ":")
      local itemType = tonumber(splitData[1])
      local itemID = tonumber(splitData[2])
      local needNum = tonumber(splitData[3])
      if itemType == 1 then
        local tmpEnough = nil
        local ownNum = (ActorData.GetPropsByID)(itemID)
        tmpEnough = needNum <= ownNum
        if canStageUp then
          do
            canStageUp = tmpEnough
            if itemType == 2 then
              local tmpEnough = nil
              local selfGold = (ActorData.GetAssetCount)(AssetType.GOLD)
              tmpEnough = needNum <= selfGold
              if canStageUp then
                canStageUp = tmpEnough
              end
            end
            local cardLvl = cardData.level
            do
              local needLvl = upStageData.card_lv_limit
              canStageUp = not canStageUp or needLvl <= cardLvl
              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  elseif canStageUp ~= false then
    canStageUp = false
  end
  do return canStageUp end
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC301: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetCurCardIsHaveStageUpRedDot = function(cardId, ...)
  -- function num : 0_81 , upvalues : ipairs, self
  for i,v in ipairs((self.redPointInfo).stageUpInfo) do
    if v.cardId == cardId then
      return v.stageUpRedDot
    end
  end
end

-- DECOMPILER ERROR at PC304: Confused about usage of register: R9 in 'UnsetPending'

CardData.CheckAllHeroStarUpRedPoint = function(cardId, ...)
  -- function num : 0_82 , upvalues : _ENV, self, split, ipairs, tonumber
  if (FunctionControlMgr.GetFunctionState)(ControlID.Card_Wake, false) ~= true then
    return false
  end
  local cardData = (self.GetCardData)(cardId)
  local seal_type = (self.GetCardSealType)(cardId)
  local config = ((TableData.gTable).BaseCardStarUpData)[cardData.id * 100 + cardData.star]
  local canStarUp = true
  if config and config.next_cost ~= "0" then
    local needItemString = split(config.next_cost, ",")
    for j,k in ipairs(needItemString) do
      local splitData = split(k, ":")
      local itemType = tonumber(splitData[1])
      local itemID = tonumber(splitData[2])
      local needNum = tonumber(splitData[3])
      if itemType == 1 then
        local tmpEnough = nil
        local ownNum = ((ActorData.GetCardPieceInfo)(cardData.id)).haveNum
        tmpEnough = needNum <= ownNum
        if canStarUp then
          do
            canStarUp = tmpEnough
            if itemType == 2 then
              local tmpEnough = nil
              local selfGold = (ActorData.GetAssetCount)(AssetType.GOLD)
              tmpEnough = needNum <= selfGold
              if canStarUp then
                canStarUp = tmpEnough
              end
            end
            -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  elseif canStarUp ~= false then
    if (FunctionControlMgr.GetFunctionState)(ControlID.Card_Seal, false) and seal_type and seal_type > 0 then
      local SealLv = (CardData.GetCardSealLv)(cardId)
      if SealLv < 0 then
        return true
      else
        local config = (CardData.GetSealConfig)(seal_type, SealLv)
        if config.next_id ~= 0 then
          local consume = config.next_cost
          if (Util.CheckCostResources)(consume, nil, nil, true) then
            local nextConfig = (CardData.GetSealConfig)(seal_type, SealLv + 1)
            local needSkill = nextConfig.need_skill_id
            if needSkill > 0 then
              local SealLevelUp = ((TableData.gTable).BaseCardSealSkillUpData)[needSkill]
              local Lv = (CardData.GetSealSkillLv)(cardId, SealLevelUp.type) or -1
              if SealLevelUp.level <= Lv then
                return true
              end
            else
              return true
            end
          end
        end
      end
      local baseData = ((TableData.gTable).BaseCardData)[cardId]
      local sealList = split(baseData.seal_list, ":")
      for _,v in ipairs(sealList) do
        local skillType = tonumber(v)
        local skillLv = (CardData.GetSealSkillLv)(cardId, skillType)
        if skillLv then
          local skillConfig = (CardData.GetSealSkillConfig)(skillType, skillLv)
          if skillConfig.next_id ~= 0 then
            local const = skillConfig.next_cost
            if (Util.CheckCostResources)(const, nil, nil, true) then
              local nextConfig = (CardData.GetSealSkillConfig)(skillType, skillConfig.level + 1)
              local isSatisfy = (CardData.SealSkillCanLevelUp)(cardId, nextConfig)
              if isSatisfy then
                return true
              end
            end
          end
        end
      end
      canStarUp = false
    else
      canStarUp = false
    end
  end
  do return canStarUp end
  -- DECOMPILER ERROR: 14 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC307: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetCurCardIsHaveStarUpRedDot = function(cardId, ...)
  -- function num : 0_83 , upvalues : ipairs, self
  for i,v in ipairs((self.redPointInfo).starUpInfo) do
    if v.cardId == cardId then
      return v.starUpRedDot
    end
  end
end

-- DECOMPILER ERROR at PC310: Confused about usage of register: R9 in 'UnsetPending'

CardData.CheckAllHeroSkillUpRedPoint = function(cardId, ...)
  -- function num : 0_84 , upvalues : _ENV, self, pairs, ipairs, tonumber, split
  if (FunctionControlMgr.GetFunctionState)(ControlID.Card_Talent, false) ~= true then
    return false
  end
  local cardData = (self.GetCardData)(cardId)
  local canSkillUp = false
  if not cardData.skillInfo then
    local skillsData = {}
  end
  local skills = {}
  local isHave = {isHave1 = false, isHave2 = false, isHave3 = false, isHave4 = false, isHave5 = false, isHave6 = false, isHave7 = false, isHave8 = false, isHave9 = false}
  for n,k in pairs(skillsData) do
    if k.id == cardData.unique_skill_id then
      isHave.isHave1 = true
      skills[1] = {id = cardData.unique_skill_id, value = k.value}
    end
    if k.id == cardData.special_skill_id then
      isHave.isHave2 = true
      skills[2] = {id = cardData.special_skill_id, value = k.value}
    end
    for j = 1, 7 do
      if k.id == cardData["passiveSkillId" .. j] then
        isHave["isHave" .. tostring(2 + j)] = true
        skills[2 + j] = {id = cardData["passiveSkillId" .. j], value = k.value}
      end
    end
  end
  if isHave.isHave1 == false then
    skills[1] = {id = cardData.unique_skill_id, value = 0}
  end
  if isHave.isHave2 == false then
    skills[2] = {id = cardData.special_skill_id, value = 0}
  end
  for j = 1, 7 do
    if isHave["isHave" .. tostring(2 + j)] == false then
      skills[2 + j] = {id = cardData["passiveSkillId" .. j], value = 0}
    end
  end
  local tableConfig = (TableData.gTable).BaseSkillLevelUpData
  local GetBaseSkillData = TableData.GetBaseSkillData
  for j,k in ipairs(skills) do
    if canSkillUp ~= true then
      local skillData = GetBaseSkillData(k.id)
      local curQuality = cardData.quality
      local curStar = cardData.star
      local isStarLock = skillData.need_star <= curStar
      local cardLvl = cardData.level
      if isStarLock == true and k.value < cardLvl then
        for n,m in pairs(tableConfig) do
          if m.type == ((self.GetCardData)(cardData.id)).skill_grow_type and m.level == k.value + 1 and skillData.no_level_up == nil then
            local haveGoldNum = (ActorData.GetAssetCount)(AssetType.GOLD)
            if j == 1 then
              local cost = tonumber((split(m.unique_skill_cost, ":"))[3])
              if cost <= haveGoldNum then
                canSkillUp = true
                break
              end
            elseif j == 2 then
              local cost = tonumber((split(m.special_skill_cost, ":"))[3])
              if cost <= haveGoldNum then
                canSkillUp = true
                break
              end
            elseif j == 3 then
              local cost = tonumber((split(m.passive_skill_cost1, ":"))[3])
              if cost <= haveGoldNum then
                canSkillUp = true
                break
              end
            elseif j == 4 then
              local cost = tonumber((split(m.passive_skill_cost2, ":"))[3])
              if cost <= haveGoldNum then
                canSkillUp = true
                break
              end
            elseif j == 5 then
              local cost = tonumber((split(m.passive_skill_cost3, ":"))[3])
              if cost <= haveGoldNum then
                canSkillUp = true
                break
              end
            elseif j == 6 then
              local cost = tonumber((split(m.passive_skill_cost4, ":"))[3])
              if cost <= haveGoldNum then
                canSkillUp = true
                break
              end
            elseif j == 7 then
              local cost = tonumber((split(m.passive_skill_cost5, ":"))[3])
              if cost <= haveGoldNum then
                canSkillUp = true
                break
              end
            elseif j == 8 then
              local cost = tonumber((split(m.passive_skill_cost6, ":"))[3])
              if cost <= haveGoldNum then
                canSkillUp = true
                break
              end
            elseif j == 9 then
              local cost = tonumber((split(m.passive_skill_cost7, ":"))[3])
              if cost <= haveGoldNum then
                canSkillUp = true
                break
              end
            end
          end
        end
      end
      -- DECOMPILER ERROR at PC301: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC301: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  do return canSkillUp end
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC313: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetCurCardIsHaveSkillUpRedDot = function(cardId, ...)
  -- function num : 0_85 , upvalues : ipairs, self
  for i,v in ipairs((self.redPointInfo).skillUpInfo) do
    if v.cardId == cardId then
      return v.skillUpRedDot
    end
  end
end

-- DECOMPILER ERROR at PC316: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetFormationLucky = function(formation, ...)
  -- function num : 0_86 , upvalues : pairs, self
  local lucky = 0
  local cardData = nil
  for k,v in pairs(formation) do
    cardData = (self.GetCardData)(v.id)
    if cardData ~= nil then
      lucky = lucky + cardData.luck
    end
  end
  return lucky
end

-- DECOMPILER ERROR at PC319: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetFormationfc = function(formation, ...)
  -- function num : 0_87 , upvalues : pairs, self
  local fc = 0
  local cardData = nil
  for k,v in pairs(formation) do
    cardData = (self.GetCardData)(v.id)
    if cardData ~= nil then
      fc = fc + cardData.fc
    end
  end
  return fc
end

-- DECOMPILER ERROR at PC322: Confused about usage of register: R9 in 'UnsetPending'

CardData.SetSealLevel = function(cardID, lv, ...)
  -- function num : 0_88 , upvalues : ipairs, self, _ENV
  for _,v in ipairs(self.cardList) do
    if v.id == cardID then
      v.sealLv = lv
      ;
      (CardData.ResetCardData)(v)
      UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_REFRESH_FC)
    end
  end
end

-- DECOMPILER ERROR at PC325: Confused about usage of register: R9 in 'UnsetPending'

CardData.SetSealSkillLevel = function(cardID, skillType, lv, ...)
  -- function num : 0_89 , upvalues : ipairs, self, _ENV
  for _,v in ipairs(self.cardList) do
    if v.id == cardID then
      local isFind = false
      for _,v2 in ipairs(v.sealSkillInfo) do
        if v2.id == skillType then
          v2.value = lv
          isFind = true
        end
      end
      if not isFind then
        (table.insert)(v.sealSkillInfo, {id = skillType, value = lv})
      end
      ;
      (CardData.ResetCardData)(v)
      break
    end
  end
end

-- DECOMPILER ERROR at PC328: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetCardSealLv = function(cardID, ...)
  -- function num : 0_90 , upvalues : _ENV
  return ((CardData.GetCardData)(cardID)).sealLv or -1
end

-- DECOMPILER ERROR at PC331: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetCardSealType = function(cardID, ...)
  -- function num : 0_91 , upvalues : _ENV
  local cardData = ((TableData.gTable).BaseCardData)[cardID]
  return cardData.seal_grow_type, cardData.seal_list
end

-- DECOMPILER ERROR at PC334: Confused about usage of register: R9 in 'UnsetPending'

CardData.GetSealSkillLv = function(cardID, skillType, ...)
  -- function num : 0_92 , upvalues : _ENV, ipairs, tonumber
  local cardData = (CardData.GetCardData)(cardID)
  local sealSkillInfo = cardData.sealSkillInfo
  for _,v in ipairs(sealSkillInfo) do
    if v.id == tonumber(skillType) then
      return v.value
    end
  end
  local config = (CardData.GetSealSkillConfig)(skillType, 0)
  if (CardData.SealSkillCanLevelUp)(cardID, config) then
    return 0
  end
end

local SealSkillUpConfig = nil
-- DECOMPILER ERROR at PC338: Confused about usage of register: R10 in 'UnsetPending'

CardData.GetSealSkillConfig = function(type, level, ...)
  -- function num : 0_93 , upvalues : tonumber, _ENV, SealSkillUpConfig, pairs
  type = tonumber(type)
  level = tonumber(level)
  local SealSkillUp = (TableData.gTable).BaseCardSealSkillUpData
  if SealSkillUpConfig == nil then
    SealSkillUpConfig = {}
    for _,v in pairs(SealSkillUp) do
      if SealSkillUpConfig[v.type] == nil then
        SealSkillUpConfig[v.type] = {}
      end
      ;
      (table.insert)(SealSkillUpConfig[v.type], v)
    end
  end
  do
    for _,v in pairs(SealSkillUpConfig[type]) do
      if v.type == type and v.level == level then
        return v
      end
    end
  end
end

local SealLevelUpConfig = nil
-- DECOMPILER ERROR at PC342: Confused about usage of register: R11 in 'UnsetPending'

CardData.GetSealConfig = function(type, level, ...)
  -- function num : 0_94 , upvalues : tonumber, _ENV, SealLevelUpConfig, pairs
  type = tonumber(type)
  local SealLevelUp = (TableData.gTable).BaseCardSealLevelUpData
  if SealLevelUpConfig == nil then
    SealLevelUpConfig = {}
    for _,v in pairs(SealLevelUp) do
      if SealLevelUpConfig[v.type] == nil then
        SealLevelUpConfig[v.type] = {}
      end
      ;
      (table.insert)(SealLevelUpConfig[v.type], v)
    end
  end
  do
    for _,v in pairs(SealLevelUpConfig[type]) do
      if v.type == type and v.level == level then
        return v
      end
    end
  end
end

-- DECOMPILER ERROR at PC345: Confused about usage of register: R11 in 'UnsetPending'

CardData.GetCardSealAttr = function(cardID, level, ...)
  -- function num : 0_95 , upvalues : _ENV
  local baseData = ((TableData.gTable).BaseCardData)[cardID]
  local config = (CardData.GetSealConfig)(baseData.seal_grow_type, level)
  if config == nil then
    return 0
  end
  return config.add_attr
end

-- DECOMPILER ERROR at PC348: Confused about usage of register: R11 in 'UnsetPending'

CardData.GetCardSealLevelUpAttr = function(cardID, level, ...)
  -- function num : 0_96 , upvalues : _ENV, ipairs, tonumber
  local attrList = {}
  if level == nil or level <= 0 then
    return attrList
  end
  local add_attr = (CardData.GetCardSealAttr)(cardID, level)
  if add_attr == 0 then
    return attrList
  end
  local attTable = (Util.ParseConfigStr)(add_attr)
  for _,v in ipairs(attTable) do
    local addType, attrId, addValue = nil, nil, nil
    if #v == 3 then
      addType = tonumber(v[1])
      attrId = tonumber(v[2])
      addValue = tonumber(v[3])
    else
      if #v == 2 then
        attrId = tonumber(v[1])
        addValue = tonumber(v[2])
      end
    end
    local oneAddAttr = {type = addType, id = attrId, value = addValue}
    attrList[attrId] = oneAddAttr
  end
  return attrList
end

-- DECOMPILER ERROR at PC351: Confused about usage of register: R11 in 'UnsetPending'

CardData.GetSealSkillUpAttr = function(skillTable, ...)
  -- function num : 0_97 , upvalues : ipairs, _ENV, tonumber
  local attrList = {}
  if skillTable == nil or #skillTable <= 0 then
    return attrList
  end
  for _,v in ipairs(skillTable) do
    local skillConfig = (CardData.GetSealSkillConfig)(v.id, v.value)
    if skillConfig then
      local add_attr = skillConfig.add_attr
      if add_attr and add_attr ~= "0" then
        local attTable = (Util.ParseConfigStr)(add_attr)
        for _,v in ipairs(attTable) do
          local addType, attrId, addValue = nil, nil, nil
          if #v == 3 then
            addType = tonumber(v[1])
            attrId = tonumber(v[2])
            addValue = tonumber(v[3])
          else
            if #v == 2 then
              attrId = tonumber(v[1])
              addValue = tonumber(v[2])
            end
          end
          local oneAddAttr = {type = addType, id = attrId, value = addValue}
          attrList[attrId] = oneAddAttr
        end
      end
    end
  end
  return attrList
end

-- DECOMPILER ERROR at PC354: Confused about usage of register: R11 in 'UnsetPending'

CardData.GetMaxSealLv = function(cardID, ...)
  -- function num : 0_98 , upvalues : _ENV, SealLevelUpConfig, pairs, ipairs
  local cardData = ((TableData.gTable).BaseCardData)[cardID]
  local type = cardData.seal_grow_type
  local SealLevelUp = (TableData.gTable).BaseCardSealLevelUpData
  if SealLevelUpConfig == nil then
    SealLevelUpConfig = {}
    for _,v in pairs(SealLevelUp) do
      if SealLevelUpConfig[v.type] == nil then
        SealLevelUpConfig[v.type] = {}
      end
      ;
      (table.insert)(SealLevelUpConfig[v.type], v)
    end
  end
  do
    for _,v in ipairs(SealLevelUpConfig[type]) do
      if v.next_id == 0 then
        return v.level
      end
    end
  end
end

-- DECOMPILER ERROR at PC357: Confused about usage of register: R11 in 'UnsetPending'

CardData.SealSkillCanLevelUp = function(cardID, config, ...)
  -- function num : 0_99 , upvalues : _ENV
  local needSealLv = config.need_seal_level
  local needSkillID = config.need_skill_id
  local sealLV = (CardData.GetCardSealLv)(cardID)
  local skillSat = false
  if needSkillID == nil or needSkillID == 0 then
    skillSat = true
  else
    local SealLevelUp = ((TableData.gTable).BaseCardSealSkillUpData)[needSkillID]
    local lv = (CardData.GetSealSkillLv)(cardID, SealLevelUp.type) or -1
    skillSat = SealLevelUp.level <= lv
  end
  do return not skillSat or needSealLv <= sealLV end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC360: Confused about usage of register: R11 in 'UnsetPending'

CardData.JudgeSealSkillModify = function(sealSkillTable, skillID, ...)
  -- function num : 0_100 , upvalues : tonumber, ipairs, _ENV, split
  skillID = tonumber(skillID)
  if sealSkillTable == nil or #sealSkillTable <= 0 then
    return skillID, false
  end
  for _,v in ipairs(sealSkillTable) do
    local config = (CardData.GetSealSkillConfig)(v.id, v.value)
    if config and config.change_skill then
      local change = split(config.change_skill, ":")
      if tonumber(change[1]) == skillID then
        return tonumber(change[2]), true
      end
    end
  end
  return skillID, false
end


