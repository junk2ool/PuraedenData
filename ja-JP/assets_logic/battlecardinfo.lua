-- params : ...
-- function num : 0 , upvalues : _ENV
BattleCardInfo = {}
if Util then
  local clone = Util.Copy
end
local pairs = pairs
local ipairs = ipairs
local t_insert = table.insert
local math = math
local baseCardData = (TableData.gTable).BaseCardData
local baseAttributeData = (TableData.gTable).BaseAttributeData
-- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

BattleCardInfo.Initial = function(data, ...)
  -- function num : 0_0 , upvalues : _ENV, clone, pairs, baseAttributeData, baseCardData, t_insert, ipairs, math
  local battleCardInfo = {}
  battleCardInfo.Init = function(self, data, ...)
    -- function num : 0_0_0 , upvalues : _ENV, clone, pairs
    local BattleData = BattleData
    data = clone(data)
    for i,v in pairs(data.cardInfo) do
      data[i] = v
    end
    data.cardInfo = nil
    self:InitTestInfo(data)
    local isSelfCard, cardDetailInfo = nil, nil
    if data.posIndex > 100 then
      (CardData.InitCardAttr)(self, data, BattleData.battleType, {talentAllAttr = BattleData.talentAttrTeamB, intimacyAttrTable = BattleData.intimacyAttrTeamB, cardStarTeamAttrTable = BattleData.cardStarTeamAttrTeamB, fetterTeamAttrTable = BattleData.fetterTeamAttrTeamB})
    else
      isSelfCard = (BattleData.IsSelfCard)(data.uid)
      ;
      (CardData.InitCardAttr)(self, data, BattleData.battleType, {talentAllAttr = BattleData.talentAttrTeamA, intimacyAttrTable = BattleData.intimacyAttrTeamA, cardStarTeamAttrTable = BattleData.cardStarTeamAttrTeamA, fetterTeamAttrTable = BattleData.fetterTeamAttrTeamA}, isSelfCard, cardDetailInfo)
    end
    self:SetOriHp(self:GetHp())
    if self:GetMaxHp() < self:GetHp() and IsBattleServer == true then
      print_new("initial card error: hp > maxHp", self:GetPosIndex(), self:GetHp(), self:GetMaxHp())
    end
    if IsBattleServer == nil then
      print("卡片位置: ", self:GetPosIndex(), " 攻击: ", self:GetAtk(), " 防御: ", self:GetDef(), " 生命: ", self:GetHp())
    end
  end

  battleCardInfo.GetAttributeLog = function(self, ...)
    -- function num : 0_0_1 , upvalues : baseAttributeData, pairs
    local info = {}
    local baseAttributeData = baseAttributeData
    for _,v in pairs(baseAttributeData) do
      info[v.remark] = self[v.name]
    end
    return info
  end

  battleCardInfo.InitTestInfo = function(self, data, ...)
    -- function num : 0_0_2 , upvalues : _ENV, baseCardData, t_insert, ipairs
    if IsBattleTest ~= true then
      return 
    end
    local skillLevel = data.skillLevel
    if skillLevel then
      data.skillInfo = {}
      local cardId = data.id
      local config = baseCardData[cardId]
      if not config then
        config = (TableData.GetBaseMonsterData)(cardId)
      end
      if config then
        local specialSkillId = config.special_skill_id
        if not skillLevel[1] then
          t_insert(data.skillInfo, {id = specialSkillId, value = specialSkillId == 0 or 0})
          local uniqueSkillId = config.unique_skill_id
          if not skillLevel[2] then
            do
              t_insert(data.skillInfo, {id = uniqueSkillId, value = uniqueSkillId == 0 or 0})
              for i = 1, 10 do
                local passiveSkillId = config["passiveSkillId" .. i]
                if not skillLevel[i + 2] then
                  do
                    t_insert(data.skillInfo, {id = passiveSkillId, value = not passiveSkillId or passiveSkillId == 0 or 0})
                    -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
              local equipBuff = data.equipBuff
              if equipBuff then
                self.equipInfoTest = {
[1] = {
randomBuff = {}
}
}
                for _,buff in ipairs(equipBuff) do
                  t_insert(((self.equipInfoTest)[1]).randomBuff, buff)
                end
              end
            end
          end
        end
      end
    end
  end

  battleCardInfo.Destroy = function(self, ...)
    -- function num : 0_0_3
    self = {}
  end

  battleCardInfo.GetCardId = function(self, ...)
    -- function num : 0_0_4
    return self.id
  end

  battleCardInfo.GetCardUid = function(self, ...)
    -- function num : 0_0_5
    return self.uid
  end

  battleCardInfo.GetPosIndex = function(self, ...)
    -- function num : 0_0_6
    return self.posIndex
  end

  battleCardInfo.GetLevel = function(self, ...)
    -- function num : 0_0_7
    return self.level
  end

  battleCardInfo.GetFashionId = function(self, ...)
    -- function num : 0_0_8
    return self.fashionId
  end

  battleCardInfo.GetRoundDamage = function(self, ...)
    -- function num : 0_0_9
    return self.RoundDamage
  end

  battleCardInfo.SetRoundDamage = function(self, value, silent, ...)
    -- function num : 0_0_10 , upvalues : _ENV
    if IsBattleServer == nil then
      logw("SetRoundDamage:" .. value .. "  " .. value - self.RoundDamage .. " " .. self.id)
    end
    if value > 0 then
      self.TotalDamage = self.TotalDamage + value - self.RoundDamage
      if not silent then
        (BattleDataCount.UpdateBuffCount)(BattleAtk.curAtkInfo, BattleBuffDeductionRoundType.DAMAGE_REACH_MAXHP, self.posIndex)
      end
    end
    self.RoundDamage = value
  end

  battleCardInfo.GetTotalDamage = function(self, ...)
    -- function num : 0_0_11
    return self.TotalDamage
  end

  battleCardInfo.SetTotalDamage = function(self, damage, ...)
    -- function num : 0_0_12
    self.TotalDamage = damage
  end

  battleCardInfo.SetOriHp = function(self, hp, ...)
    -- function num : 0_0_13
    self.oriHp = hp
  end

  battleCardInfo.GetOriHp = function(self, ...)
    -- function num : 0_0_14
    return self.oriHp
  end

  battleCardInfo.GetHp = function(self, ...)
    -- function num : 0_0_15
    return self.hp
  end

  battleCardInfo.SetHp = function(self, hp, switchHp, silent, ...)
    -- function num : 0_0_16 , upvalues : _ENV, math
    if IsBattleServer == nil then
      print("改变血量 ： 位置：", self:GetPosIndex(), " 血量变化：", hp, " 实际变化：", (math.min)(hp, self:GetMaxHp()))
    end
    hp = (math.min)(hp, self:GetMaxHp())
    local previous = self.hp
    self.hp = hp
    if not switchHp then
      if previous < hp then
        (BattleDataCount.UpdateBuffCount)(BattleAtk.curAtkInfo, BattleBuffDeductionRoundType.AFTER_ENEMY_HEAL, self.posIndex)
      else
        if hp < previous then
          self:SetRoundDamage(self.RoundDamage + previous - hp, silent)
        end
      end
    end
  end

  battleCardInfo.GetStar = function(self, ...)
    -- function num : 0_0_17
    return self.star
  end

  battleCardInfo.GetQuality = function(self, ...)
    -- function num : 0_0_18
    return self.quality
  end

  battleCardInfo.GetMaxHp = function(self, ...)
    -- function num : 0_0_19
    return self.max_hp
  end

  battleCardInfo.GetAtk = function(self, ...)
    -- function num : 0_0_20
    return self.atk
  end

  battleCardInfo.GetDef = function(self, ...)
    -- function num : 0_0_21
    return self.def
  end

  battleCardInfo.GetCrt = function(self, ...)
    -- function num : 0_0_22
    return self.crt
  end

  battleCardInfo.GetRec = function(self, ...)
    -- function num : 0_0_23
    return self.rec
  end

  battleCardInfo.GetBlk = function(self, ...)
    -- function num : 0_0_24
    return self.blk
  end

  battleCardInfo.GetReb = function(self, ...)
    -- function num : 0_0_25
    return self.reb
  end

  battleCardInfo.GetHit = function(self, ...)
    -- function num : 0_0_26
    return self.hit
  end

  battleCardInfo.GetEva = function(self, ...)
    -- function num : 0_0_27
    return self.eva
  end

  battleCardInfo.GetArp = function(self, ...)
    -- function num : 0_0_28
    return self.arp
  end

  battleCardInfo.GetRea = function(self, ...)
    -- function num : 0_0_29
    return self.rea
  end

  battleCardInfo.GetCrtInt = function(self, ...)
    -- function num : 0_0_30
    return self.crt_int
  end

  battleCardInfo.GetRecInt = function(self, ...)
    -- function num : 0_0_31
    return self.rec_int
  end

  battleCardInfo.GetBlkInt = function(self, ...)
    -- function num : 0_0_32
    return self.blk_int
  end

  battleCardInfo.GetRebInt = function(self, ...)
    -- function num : 0_0_33
    return self.reb_int
  end

  battleCardInfo.GetAddInt = function(self, ...)
    -- function num : 0_0_34
    return self.add_int
  end

  battleCardInfo.GetExdInt = function(self, ...)
    -- function num : 0_0_35
    return self.exd_int
  end

  battleCardInfo.GetArpInt = function(self, ...)
    -- function num : 0_0_36
    return self.arp_int
  end

  battleCardInfo.GetReaInt = function(self, ...)
    -- function num : 0_0_37
    return self.rea_int
  end

  battleCardInfo.GetSpd = function(self, ...)
    -- function num : 0_0_38
    return self.spd
  end

  battleCardInfo.GetLuck = function(self, ...)
    -- function num : 0_0_39
    return self.luck
  end

  battleCardInfo.GetMaxDander = function(self, ...)
    -- function num : 0_0_40
    return self.max_dander
  end

  battleCardInfo.GetMaxDanderLimit = function(self, ...)
    -- function num : 0_0_41
    if not self.max_dander_limit then
      return self:GetMaxDander()
    end
  end

  battleCardInfo.GetDander = function(self, ...)
    -- function num : 0_0_42
    return self.dander
  end

  battleCardInfo.SetDander = function(self, dander, ...)
    -- function num : 0_0_43 , upvalues : math, _ENV
    dander = (math.min)(dander, self:GetMaxDanderLimit())
    dander = (math.max)(dander, 0)
    self.dander = dander
    if IsBattleServer == nil then
      print("怒气变化：位置：", self:GetPosIndex(), " 怒气值：", dander)
    end
  end

  battleCardInfo.GetExtraDander = function(self, ...)
    -- function num : 0_0_44
    return self.extraDander or 0
  end

  battleCardInfo.SetExtraDander = function(self, dander, ...)
    -- function num : 0_0_45
    self.extraDander = dander
  end

  battleCardInfo.ClearExtraDander = function(self, ...)
    -- function num : 0_0_46
    self.extraDander = 0
  end

  battleCardInfo.GetDanderRound = function(self, ...)
    -- function num : 0_0_47
    return self.dander_round
  end

  battleCardInfo.GetDanderAtk = function(self, ...)
    -- function num : 0_0_48
    return self.dander_atk
  end

  battleCardInfo.GetDanderHit = function(self, ...)
    -- function num : 0_0_49
    return self.dander_hit
  end

  battleCardInfo.GetDanderKill = function(self, ...)
    -- function num : 0_0_50
    return self.dander_kill
  end

  battleCardInfo.GetExtDamage = function(self, ...)
    -- function num : 0_0_51
    return self.ext_damage
  end

  battleCardInfo.GetExtDamageSub = function(self, ...)
    -- function num : 0_0_52
    return self.ext_damage_sub
  end

  battleCardInfo.GetTreatAdd = function(self, ...)
    -- function num : 0_0_53
    return self.treat_add
  end

  battleCardInfo.GetTreatSub = function(self, ...)
    -- function num : 0_0_54
    return self.treat_sub
  end

  battleCardInfo.GetBeTreatAdd = function(self, ...)
    -- function num : 0_0_55
    return self.be_treat_add
  end

  battleCardInfo.GetBeTreatSub = function(self, ...)
    -- function num : 0_0_56
    return self.be_treat_sub
  end

  battleCardInfo.GetAtkEvaProb = function(self, ...)
    -- function num : 0_0_57
    return self.atk_eva_prob
  end

  battleCardInfo.GetSkillEvaProb = function(self, ...)
    -- function num : 0_0_58
    return self.skill_eva_prob
  end

  battleCardInfo.GetCrtProp = function(self, ...)
    -- function num : 0_0_59
    return self.crt_prob or 0
  end

  battleCardInfo.GetBlkProp = function(self, ...)
    -- function num : 0_0_60
    return self.blk_prob or 0
  end

  battleCardInfo.GetSkillInfo = function(self, ...)
    -- function num : 0_0_61
    return self.skillInfo
  end

  battleCardInfo.GetSealSkillInfo = function(self, ...)
    -- function num : 0_0_62
    return self.sealSkillInfo
  end

  battleCardInfo.GetEquipInfo = function(self, ...)
    -- function num : 0_0_63 , upvalues : _ENV
    if IsBattleTest == true then
      return self.equipInfoTest
    else
      return self.equipInfo
    end
  end

  battleCardInfo.GetSuitBuff = function(self, ...)
    -- function num : 0_0_64
    return self.equipSet
  end

  battleCardInfo.AddAttrValue = function(self, attributeId, value, effectId, atkInfo, buff, ...)
    -- function num : 0_0_65 , upvalues : _ENV, baseAttributeData, math
    if (BattleBuff.IsAddIntoDamage)(effectId) == true then
      loge("伤害已加入总伤害")
      return nil
    end
    local SaveBattleProcess = BattleData.SaveBattleProcess
    local attrConfig = baseAttributeData[attributeId]
    local BattleCardAttributeID = BattleCardAttributeID
    if attrConfig then
      local curValue = self[attrConfig.name]
      if IsBattleServer == nil then
        print("属性变化：", (CardData.GetAttrRemarkById)(attributeId), " 位置：", self:GetPosIndex(), " 当前值：", curValue, " 增加量：", value)
      end
      if curValue then
        if attributeId == BattleCardAttributeID.HP then
          local card = ((BattleData.GetCardInfoByPos)(self:GetPosIndex()))
          local realDamage, absorbDamage, specialEffect = nil, nil, nil
          if effectId == BattleDisplayEffect.EXCHANGE_HP or effectId == BattleDisplayEffect.EXCHANGE_HP_SELF then
            self:SetHp(curValue + value, true)
            return value, 0, {isKeepAlive = false, isInvincible = false}
          end
          if value < 0 then
            local trueDmg = (BattleBuff.IsBuffContainEffectId)(buff, BattleDisplayEffect.TRUE_DAMAGE)
            realDamage = (BattleBuff.DealRealHpLoss)(card, -value, nil, nil, nil, effectId, trueDmg)
            value = -realDamage
            if IsBattleServer == nil then
              SaveBattleProcess("\tbuff伤害 位置：" .. self:GetPosIndex() .. " 变化值：" .. value)
            end
          else
            do
              if value > 0 then
                if (BattleBuff.IsForbiddenTreatment)(card) then
                  value = 0
                  if IsBattleServer == nil then
                    SaveBattleProcess("\tbuff加血（封疗） 位置：" .. self:GetPosIndex() .. " 变化值：" .. value)
                  end
                else
                  local defBeTreatAdd = card:GetBeTreatAdd()
                  local defBeTreatSub = card:GetBeTreatSub()
                  value = (math.ceil)(value * (1 + defBeTreatAdd / 10000 - defBeTreatSub / 1000))
                  if IsBattleServer == nil then
                    SaveBattleProcess("\tbuff加血 位置：" .. self:GetPosIndex() .. " 变化值：" .. value)
                  end
                end
              end
              do
                local dieLater = false
                if curValue + value <= 0 then
                  do
                    if (BattleBuff.ContainEffectId)(card, BattleDisplayEffect.LOCK_HP) then
                      local isTrigger = (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.NEAR_DEATH)
                      if isTrigger then
                        value = -curValue + 1
                      end
                    end
                    if card.waitingSkill or (BattleBuff.ContainDeductionRoundType)(card, BattleBuffDeductionRoundType.DIE_SKILL_DIE) then
                      if not card.waitingSkill then
                        local curAtkPos = buff:GetAtkPos()
                        local atkCard = (BattleData.GetCardInfoByPos)(curAtkPos)
                        ;
                        (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.DIE_SKILL_DIE, atkCard)
                        dieLater = true
                      end
                      do
                        do
                          value = -curValue + 1
                          ;
                          (BattleDataCount.ReviveCheck)(card, -(value), nil, buff)
                          self:SetHp(curValue + (value))
                          if curValue + (value) <= 0 or dieLater then
                            (BattleDataCount.UpdateEquipBuff)(atkInfo.atkPos, BattleBuffDeductionRoundType.DAMAGE_KILL, atkInfo)
                          end
                          do return value, absorbDamage, specialEffect end
                          if attributeId == BattleCardAttributeID.DANDER then
                            local t = curValue + (value)
                            -- DECOMPILER ERROR at PC224: Overwrote pending register: R12 in 'AssignReg'

                            local maxDander = self:GetMaxDander()
                            -- DECOMPILER ERROR at PC230: Overwrote pending register: R13 in 'AssignReg'

                            if maxDander < t then
                              if buff and (buff:GetBuffConfig()).sp_save then
                                self:SetExtraDander(t - maxDander + self:GetExtraDander())
                              end
                              t = maxDander
                            end
                            self:SetDander(t)
                            if IsBattleServer == nil then
                              SaveBattleProcess("\tbuff改变怒气 位置：" .. self:GetPosIndex() .. " 变化值：" .. value)
                            end
                          else
                            do
                              self[attrConfig.name] = curValue + (value)
                              do
                                if attributeId == BattleCardAttributeID.MAX_HP then
                                  local hpConfig = baseAttributeData[BattleCardAttributeID.HP]
                                  self[hpConfig.name] = self[hpConfig.name] + (value)
                                end
                                if IsBattleServer == nil then
                                  SaveBattleProcess("\tbuff属性变化 位置：" .. self:GetPosIndex() .. " 属性变化：" .. (CardData.GetAttrRemarkById)(attributeId) .. " 变化值：" .. value)
                                end
                                self[attrConfig.name] = value
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

  battleCardInfo:Init(data)
  return battleCardInfo
end


