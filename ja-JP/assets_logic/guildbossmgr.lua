-- params : ...
-- function num : 0 , upvalues : _ENV
GuildBossMgr = {}
local self = GuildBossMgr
-- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildBossInfo = function(data, ...)
  -- function num : 0_0 , upvalues : self
  if data == nil then
    return self.BossInfo
  else
    self.BossInfo = data
  end
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildInfo = function(data, ...)
  -- function num : 0_1 , upvalues : self
  if data == nil then
    return self.GuildInfoData
  else
    self.GuildInfoData = data
  end
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildBossCurStage = function(data, ...)
  -- function num : 0_2 , upvalues : self, _ENV
  if data == nil then
    do
      if self.BossCurStage == nil then
        local maxStageID = (GuildBossMgr.GetCurrentMaxStageID)()
        self.BossCurStage = {id = maxStageID}
      end
      do return self.BossCurStage end
      self.BossCurStage = data
    end
  end
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildDetailStageID = function(data, ...)
  -- function num : 0_3 , upvalues : self
  if data == nil then
    return self.DetailStageID
  else
    self.DetailStageID = data
  end
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GetMaxRank = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local FixedData = ((TableData.gTable).BaseFixedData)[Const.GuildBossMaxRank]
  return FixedData.int_value
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildBossHP = function(...)
  -- function num : 0_5 , upvalues : _ENV
  local stageInfo = (GuildBossMgr.GuildBossCurStage)()
  local maxHp = (GuildBossMgr.GetStageBossMaxHP)(stageInfo.id)
  return (math.ceil)(stageInfo.bossHp / maxHp * 100)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildRemCount = function(data, ...)
  -- function num : 0_6 , upvalues : self
  if data == nil then
    return self.RemCount
  else
    self.RemCount = data
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildActivity = function(data, ...)
  -- function num : 0_7 , upvalues : self
  if data == nil then
    return self.Activity
  else
    self.Activity = data
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildBattleRecord = function(data, ...)
  -- function num : 0_8 , upvalues : self
  if data == nil then
    return self.BattleRecord
  else
    self.BattleRecord = data
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildeInBattleInfo = function(data, ...)
  -- function num : 0_9 , upvalues : self
  if data == nil then
    return self.InBattleInfo
  else
    self.InBattleInfo = data
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildBattleAllPass = function(data, ...)
  -- function num : 0_10 , upvalues : self
  if data == nil then
    return self.AllPass
  else
    self.AllPass = data
  end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GetCurrentMaxStageID = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local StageData = (TableData.gTable).BaseGuildWarStageData
  local cycle = (GuildBossMgr.GetCurrentSeasonCycle)()
  for _,v in pairs(StageData) do
    if v.cycle_type == cycle and v.next == 0 then
      return v.id
    end
  end
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GetCurrentRound = function(realRound, ...)
  -- function num : 0_12 , upvalues : _ENV
  if realRound then
    return ((GuildBossMgr.GuildBossCurStage)()).round
  else
    local id = 0
    if (GuildBossMgr.GuildBattleAllPass)() then
      id = (GuildBossMgr.GetCurrentMaxStageID)()
    else
      id = ((GuildBossMgr.GuildBossCurStage)()).id
    end
    local StageData = ((TableData.gTable).BaseGuildWarStageData)[id]
    return StageData.round
  end
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GetCurrentSeasonCycle = function(...)
  -- function num : 0_13 , upvalues : _ENV
  local FixedData = ((TableData.gTable).BaseFixedData)[Const.GuildBossCycleMax]
  local maxCycle = FixedData.int_value
  local seasonID = ((GuildBossMgr.GuildBossInfo)()).seasonId
  local cycle = seasonID % maxCycle
  if cycle == 0 then
    cycle = maxCycle
  end
  return cycle
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GetStageBossMaxHP = function(stageID, ...)
  -- function num : 0_14 , upvalues : _ENV
  local maxHp = 0
  local stageData = ((TableData.gTable).BaseGuildWarStageData)[stageID]
  if stageData == nil then
    return 
  end
  local monsterList = split(stageData.monster_group_list, ":")
  for _,v in pairs(monsterList) do
    local groupID = tonumber(v)
    local stageData = ((TableData.gTable).BaseMonsterGroupData)[groupID]
    local monsterList = split(stageData.monster_list, ":")
    for _,v2 in ipairs(monsterList) do
      local monsterID = tonumber(v2)
      if monsterID > 0 then
        local MonsterData = (TableData.GetBaseMonsterData)(monsterID)
        maxHp = maxHp + MonsterData.max_hp
      end
    end
  end
  return maxHp
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.InitTalentData = function(...)
  -- function num : 0_15 , upvalues : _ENV
  if not GuildBossData.TalentInit then
    (GuildBossService.ReqGuildTalent)()
  end
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.OpenTalentUI = function(...)
  -- function num : 0_16 , upvalues : _ENV
  (GuildBossData.InitGuildSkillData)()
  if not GuildBossData.TalentInit then
    (GuildBossService.ReqGuildTalent)()
  else
    OpenWindow((WinResConfig.GuildBossSkillWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.AfterRecvTalentData = function(data, ...)
  -- function num : 0_17 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  GuildBossData.TalentInit = true
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  GuildBossData.CycleType = nil
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  GuildBossData.TotalInvestPoint = data.invTalent
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  GuildBossData.ActiveSkillInfo = {}
  local count = #data.talentInfo
  local config = nil
  for i = 1, count do
    if GuildBossData.CycleType == nil then
      config = ((TableData.gTable).BaseGuildWarTalentData)[((data.talentInfo)[i]).id]
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

      if config ~= nil then
        GuildBossData.CycleType = config.cycle_type
      end
    end
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R7 in 'UnsetPending'

    if ((data.talentInfo)[i]).level > 0 then
      (GuildBossData.ActiveSkillInfo)[((data.talentInfo)[i]).id] = ((data.talentInfo)[i]).level
    end
  end
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.ResetTalent = function(...)
  -- function num : 0_18 , upvalues : _ENV
  (GuildBossData.ResetGuildSkillInfo)()
  UIMgr:SendWindowMessage((WinResConfig.GuildBossSkillWindow).name, (WindowMsgEnum.GuildBoss).E_MSG_REFRESH_TALENT)
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.TryUpgradeTalent = function(id, cost, ...)
  -- function num : 0_19 , upvalues : _ENV
  loge("cost:" .. cost)
  if not (Util.CheckCostResources)(cost) then
    return 
  end
  ;
  (GuildBossService.ReqUpTalent)(id)
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.AfterUpgradeTalent = function(data, ...)
  -- function num : 0_20 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  GuildBossData.TotalInvestPoint = data.invTalent
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (GuildBossData.ActiveSkillInfo)[(data.talentInfo).id] = (data.talentInfo).level
  UIMgr:SendWindowMessage((WinResConfig.GuildBossSkillWindow).name, (WindowMsgEnum.GuildBoss).E_MSG_REFRESH_SINGLE_TALENT, (data.talentInfo).id)
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildSupportCard = function(data, ...)
  -- function num : 0_21 , upvalues : self, _ENV
  if data == nil then
    return self.SupportCard
  else
    self.SupportCard = {}
    for _,v in ipairs(data) do
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

      (self.SupportCard)[v.value + 1] = v.id
    end
  end
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildSupportSetValue = function(pos, value, ...)
  -- function num : 0_22 , upvalues : self
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.SupportCard)[pos] = value
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildSupportTimes = function(data, ...)
  -- function num : 0_23 , upvalues : self
  if data == nil then
    return self.SupportTimes
  else
    self.SupportTimes = data
  end
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildSupportGetNum = function(data, ...)
  -- function num : 0_24 , upvalues : self
  if data == nil then
    return self.SupportGetNum
  else
    self.SupportGetNum = data
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildSupportAlreadyNum = function(data, ...)
  -- function num : 0_25 , upvalues : self
  if data == nil then
    return self.SupportAlreadyNum
  else
    self.SupportAlreadyNum = data
  end
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.CardIsInSupport = function(cardID, ...)
  -- function num : 0_26 , upvalues : _ENV, self
  for _,v in ipairs(self.SupportCard) do
    if v == cardID then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.RewardListData = function(data, ...)
  -- function num : 0_27 , upvalues : self
  if data == nil then
    return self.RewardList
  else
    self.RewardList = data
  end
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.SetListData = function(id, status, ...)
  -- function num : 0_28 , upvalues : _ENV
  local mData = (GuildBossMgr.RewardListData)()
  for _,v in ipairs(mData) do
    if v.id == id then
      v.status = status
      return 
    end
  end
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GetRewardState = function(id, ...)
  -- function num : 0_29 , upvalues : _ENV, self
  for _,v in ipairs(self.RewardList) do
    if v.id == id then
      return v.status
    end
  end
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.CheckIsCanGetReward = function(...)
  -- function num : 0_30 , upvalues : _ENV
  local mData = (GuildBossMgr.RewardListData)()
  for _,v in ipairs(mData) do
    if v.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.BossInfoData = function(data, ...)
  -- function num : 0_31 , upvalues : self
  if data == nil then
    return self.BossInfoList
  else
    self.BossInfoList = data
  end
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GetBossInfo = function(stageID, ...)
  -- function num : 0_32 , upvalues : _ENV
  local bossList = (GuildBossMgr.BossInfoData)()
  for _,v in ipairs(bossList) do
    if v.id == stageID then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.BossHurtReport = function(data, ...)
  -- function num : 0_33 , upvalues : self
  if data == nil then
    return self.HurtReport
  else
    self.HurtReport = data
  end
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.IsLastSeasonData = function(isLast, ...)
  -- function num : 0_34 , upvalues : self
  if isLast == nil then
    return self.RankIsLast
  else
    self.RankIsLast = isLast
  end
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildRankIndex = function(rank, ...)
  -- function num : 0_35 , upvalues : self
  if rank == nil then
    return self.RankIndex
  else
    self.RankIndex = rank
  end
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GuildRankScore = function(score, ...)
  -- function num : 0_36 , upvalues : self
  if score == nil then
    return self.RankScore
  else
    self.RankScore = score
  end
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.IsPersonList = function(isPerson, ...)
  -- function num : 0_37 , upvalues : self
  if isPerson == nil then
    return self.PersonInList
  else
    self.PersonInList = isPerson
  end
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.ProcessGuildRankData = function(page, data, pageSize, ...)
  -- function num : 0_38 , upvalues : self, _ENV
  if page == 1 then
    self.GuildRankData = {}
  end
  local count = #data
  local start = (page - 1) * pageSize
  for i = 1, count do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R9 in 'UnsetPending'

    (self.GuildRankData)[start + i] = data[i]
  end
  ;
  (table.sort)(self.GuildRankData, function(a, b, ...)
    -- function num : 0_38_0
    do return a.rank < b.rank end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local nextPage = GuildBossData.currentRankPage + 1
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

  if count == pageSize and page == nextPage then
    GuildBossData.currentRankPage = nextPage
  end
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GetGuildRankDataList = function(...)
  -- function num : 0_39 , upvalues : self
  return self.GuildRankData
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.ProcessPersonRankData = function(data, ...)
  -- function num : 0_40 , upvalues : self, _ENV
  self.PersonRankData = {}
  for _,v in ipairs(data) do
    (table.insert)(self.PersonRankData, v)
  end
  ;
  (table.sort)(self.PersonRankData, function(a, b, ...)
    -- function num : 0_40_0
    do return b.integral < a.integral end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GetPersonRankDataList = function(...)
  -- function num : 0_41 , upvalues : self
  return self.PersonRankData
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.GetPersonRank = function(...)
  -- function num : 0_42 , upvalues : _ENV
  local objIndex = (ActorData.GetPlayerIndex)()
  local data = (GuildBossMgr.GetPersonRankDataList)()
  for i,v in ipairs(data) do
    if v.objectindex == objIndex then
      return i, v.integral
    end
  end
  return -1
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.EnterFormation = function(msg, ...)
  -- function num : 0_43 , upvalues : _ENV
  local enemyList = {}
  local stageData = ((TableData.gTable).BaseGuildWarStageData)[msg.stageId]
  local groupList = split(stageData.monster_group_list, ":")
  local Battle = ((TableData.gTable).BaseMonsterGroupData)[tonumber(groupList[#groupList])]
  local monsters = split(Battle.monster_list, ":")
  for i = 1, 6 do
    if tonumber(monsters[i]) == 0 then
      enemyList[i] = nil
    else
      for _,v in ipairs(msg.aliveBoss) do
        if monsters[i] == tostring(v) then
          enemyList[i] = monsters[i]
        end
      end
    end
  end
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(20000021)
  btnData.fun = function(forData, supportId, supportPlayerIndex, ...)
    -- function num : 0_43_0 , upvalues : _ENV, msg
    local serverID = 0
    if supportId and supportId > 0 then
      for _,v in ipairs(msg.supportCard) do
        if v.playerIndex == supportPlayerIndex and v.id == supportId then
          serverID = v.serverId
        end
      end
    end
    do
      local cardList = {}
      for i,v in pairs(forData) do
        if v > 0 then
          local m = {}
          m.id = v
          m.value = i
          if supportId > 0 and supportId == v then
            m.playerIndex = supportPlayerIndex
            m.serverId = serverID
          else
            m.playerIndex = (ActorData.GetPlayerIndex)()
          end
          ;
          (table.insert)(cardList, m)
        end
      end
      ;
      (GuildBossService.ReqInGuildWar)(msg.stageId, cardList, msg.sim)
    end
  end

  local formationData = {}
  formationData.enemyList = enemyList
  formationData.myselfList = (Util.CovertRemoteFormationToLocal)(msg.cardGroup, true)
  formationData.BtnData = btnData
  formationData.formationType = FormationType.GuildBattle
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).GUILD_WAR
  formationData.stageId = msg.stageId
  formationData.GuildBossExternal = {}
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (formationData.GuildBossExternal).isSimulation = msg.sim
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (formationData.GuildBossExternal).SupportCardList = msg.supportCard
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (formationData.GuildBossExternal).cantUseCard = msg.canNotUse
  formationData.closeFun = function(forData, supportId, supportPlayerIndex, ...)
    -- function num : 0_43_1 , upvalues : _ENV
    (GuildBossMgr.SaveCardList)(forData, supportId, supportPlayerIndex)
  end

  formationData.backFun = function(forData, supportId, supportPlayerIndex, ...)
    -- function num : 0_43_2 , upvalues : _ENV
    (GuildBossMgr.SaveCardList)(forData, supportId, supportPlayerIndex)
  end

  ;
  (MessageMgr.OpenFormationWindow)(formationData)
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.SaveCardList = function(forData, supportId, supportPlayerIndex, ...)
  -- function num : 0_44 , upvalues : _ENV
  local serverId = 0
  if supportId and supportId > 0 then
    for _,v in ipairs((GuildBossData.Info).supportCard) do
      if v.playerIndex == supportPlayerIndex and v.id == supportId then
        serverId = v.serverId
      end
    end
  end
  do
    local cardList = {}
    for i,v in pairs(forData) do
      if v > 0 then
        local m = {}
        m.id = v
        m.value = i
        if supportId == nil then
          supportId = 0
        end
        if supportId > 0 and supportId == v then
          m.playerIndex = supportPlayerIndex
          m.serverId = serverId
        else
          m.playerIndex = (ActorData.GetPlayerIndex)()
        end
        ;
        (table.insert)(cardList, m)
      end
    end
    ;
    (GuildBossMgr.ReqSaveCardGroup)(cardList)
  end
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R1 in 'UnsetPending'

GuildBossMgr.ReqSaveCardGroup = function(cardList, ...)
  -- function num : 0_45 , upvalues : _ENV
  (GuildBossService.ReqSaveCardGroup)(cardList)
end


