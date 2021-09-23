-- params : ...
-- function num : 0 , upvalues : _ENV
GuildBossData = {}
GuildBossSkillType = {Green = 1, Red = 2, Yellow = 3, Blue = 4}
-- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.TalentInit = false
-- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.CycleType = 1
-- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.ActiveSkillInfo = {}
-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.TotalInvestPoint = 0
-- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.currentRankPage = 0
-- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.SkillLevelData = {}
-- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.SkillStartId = {}
-- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.Info = {}
-- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.InitGuildSkillData = function(...)
  -- function num : 0_0 , upvalues : _ENV
  if (_G.next)(GuildBossData.SkillLevelData) ~= nil then
    return 
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  GuildBossData.SkillLevelData = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  GuildBossData.SkillStartId = {}
  local talent = {}
  for k,v in pairs((TableData.gTable).BaseGuildWarTalentData) do
    talent[k] = {Season = v.cycle_type, Type = v.type}
  end
  local nextIds, count, id = nil, nil, nil
  for k,v in pairs((TableData.gTable).BaseGuildWarTalentData) do
    if (Util.CheckNullString)(v.next) == false then
      nextIds = split(v.next, ":")
      count = #nextIds
      for i = 1, count do
        id = tonumber(nextIds[i])
        if id ~= nil then
          talent[id] = nil
        end
      end
    end
  end
  local config = nil
  for k,v in pairs(talent) do
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R10 in 'UnsetPending'

    if (GuildBossData.SkillStartId)[v.Season] == nil then
      (GuildBossData.SkillStartId)[v.Season] = {}
    end
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((GuildBossData.SkillStartId)[v.Season])[v.Type] = k
    config = ((TableData.gTable).BaseGuildWarTalentData)[k]
    nextIds = split(config.next, ":")
    count = #nextIds
    for i = 1, count do
      id = tonumber(nextIds[i])
      if id ~= nil then
        config = ((TableData.gTable).BaseGuildWarTalentData)[id]
        -- DECOMPILER ERROR at PC119: Confused about usage of register: R14 in 'UnsetPending'

        if config and config.type ~= v.Type then
          ((GuildBossData.SkillStartId)[v.Season])[config.type] = id
        end
      end
    end
  end
  for k,v in pairs((TableData.gTable).BaseGuildWarTalentUpData) do
    -- DECOMPILER ERROR at PC139: Confused about usage of register: R10 in 'UnsetPending'

    if (GuildBossData.SkillLevelData)[v.type] == nil then
      (GuildBossData.SkillLevelData)[v.type] = {}
    end
    -- DECOMPILER ERROR at PC145: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((GuildBossData.SkillLevelData)[v.type])[v.level] = k
  end
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.GetUnlockCondition = function(skillId, ...)
  -- function num : 0_1 , upvalues : _ENV
  local config = ((TableData.gTable).BaseGuildWarTalentData)[skillId]
  if config == nil then
    return 
  end
  local condition = ""
  if config.unlock_level > 1 then
    if config.unlock_level <= (GuildData.BaseInfo).level then
      condition = "[color=" .. Const.GreenColor .. "]" .. (PUtil.get)(60000513, config.unlock_level) .. "[/color]"
    else
      condition = (PUtil.get)(60000513, config.unlock_level)
    end
  end
  if (Util.CheckNullString)(config.need_talents) == false then
    local needTalents = split(config.need_talents, ",")
    local count = #needTalents
    local talentInfo, conditionConfig, needLevel = nil, nil, nil
    for i = 1, count do
      condition = condition .. "\n"
      talentInfo = split(needTalents[i], ":")
      conditionConfig = ((TableData.gTable).BaseGuildWarTalentData)[tonumber(talentInfo[1])]
      needLevel = tonumber(talentInfo[2])
      if (GuildBossData.ActiveSkillInfo)[conditionConfig.id] or needLevel <= conditionConfig == nil or needLevel == nil or 0 then
        condition = condition .. "[color=" .. Const.GreenColor .. "]" .. (PUtil.get)(60000514, conditionConfig.name, needLevel, (GuildBossData.ActiveSkillInfo)[conditionConfig.id], needLevel) .. "[/color]"
      else
        condition = condition .. (PUtil.get)(60000514, conditionConfig.name, needLevel, (GuildBossData.ActiveSkillInfo)[conditionConfig.id] or 0, needLevel)
      end
    end
  end
  do
    return condition
  end
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.CheckUnlockAvailable = function(id, ...)
  -- function num : 0_2 , upvalues : _ENV
  local config = ((TableData.gTable).BaseGuildWarTalentData)[id]
  if config == nil then
    return false
  end
  local condition = true
  if config.unlock_level > (GuildData.BaseInfo).level then
    condition = config.unlock_level <= 0
    if condition and (Util.CheckNullString)(config.need_talents) == false then
      local needTalents = split(config.need_talents, ",")
      local count = #needTalents
      local talentInfo, conditionConfig, needLevel = nil, nil, nil
      for i = 1, count do
        talentInfo = split(needTalents[i], ":")
        conditionConfig = ((TableData.gTable).BaseGuildWarTalentData)[tonumber(talentInfo[1])]
        needLevel = tonumber(talentInfo[2])
        condition = not (GuildBossData.ActiveSkillInfo)[conditionConfig.id] and needLevel <= conditionConfig == nil or needLevel == nil or 0
      end
    end
    do return condition end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.CheckSkillAvailable = function(...)
  -- function num : 0_3 , upvalues : _ENV
  local table = (TableData.gTable).BaseGuildWarTalentData
  local result = false
  for k,v in pairs(table) do
    if v.cycle_type == GuildBossData.CycleType then
      if (GuildBossData.ActiveSkillInfo)[k] == nil then
        local unlock = (GuildBossData.CheckUnlockAvailable)(k)
        if unlock then
          local nextConfigId = ((GuildBossData.SkillLevelData)[v.grow_type])[1]
          local nextConfig = ((TableData.gTable).BaseGuildWarTalentUpData)[nextConfigId]
          if nextConfig then
            if not result then
              do
                result = (Util.CheckCostResources)(nextConfig.cost, nil, nil, true)
                local nextConfigId = ((GuildBossData.SkillLevelData)[v.grow_type])[(GuildBossData.ActiveSkillInfo)[k] + 1]
                do
                  local nextConfig = ((TableData.gTable).BaseGuildWarTalentUpData)[nextConfigId]
                  if nextConfig and not result then
                    result = (Util.CheckCostResources)(nextConfig.cost, nil, nil, true)
                  end
                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  if not result then
    return result
  end
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.ResetGuildSkillInfo = function(...)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  GuildBossData.ActiveSkillInfo = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  GuildBossData.TotalInvestPoint = 0
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R0 in 'UnsetPending'

GuildBossData.ResetData = function(...)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  GuildBossData.TalentInit = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  GuildBossData.currentRankPage = 0
  ;
  (GuildBossData.ResetGuildSkillInfo)()
end


