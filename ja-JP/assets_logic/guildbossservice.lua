-- params : ...
-- function num : 0 , upvalues : _ENV
GuildBossService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

GuildBossService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResGuildWarInfo, GuildBossService.OnResGuildBattleInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResSupportInfo, GuildBossService.OnResSupportInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResSupportSet, GuildBossService.OnResSupportSet)
  ;
  (Net.AddListener)((Proto.MsgName).ResSupportHarvest, GuildBossService.OnResSupportHarvest)
  ;
  (Net.AddListener)((Proto.MsgName).ResWarReward, GuildBossService.OnResSeasonReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResGetWarReward, GuildBossService.OnResGetSeasonReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildTalent, GuildBossService.RecvGuildTalent)
  ;
  (Net.AddListener)((Proto.MsgName).ResUpTalent, GuildBossService.RecvUpTalent)
  ;
  (Net.AddListener)((Proto.MsgName).ResTalentReset, GuildBossService.RecvTalentReset)
  ;
  (Net.AddListener)((Proto.MsgName).ResWarAdvisory, GuildBossService.OnResWarAdvisory)
  ;
  (Net.AddListener)((Proto.MsgName).ResGSeasonRank, GuildBossService.OnResGSeasonRank)
  ;
  (Net.AddListener)((Proto.MsgName).ResMSeasonRank, GuildBossService.OnResMSeasonRank)
  ;
  (Net.AddListener)((Proto.MsgName).ResInGuildStage, GuildBossService.OnResInGuildStage)
  ;
  (Net.AddListener)((Proto.MsgName).ResInGuildWar, GuildBossService.OnResInGuildWar)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleGuildWar, GuildBossService.OnResSettleGuildWar)
  ;
  (Net.AddListener)((Proto.MsgName).ResHurtReport, GuildBossService.OnResHurtReport)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildWarInfo, GuildBossService.OnResGuildBattleRecord)
end

local update = false
-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqGuildBattleInfo = function(onlyUpdate, ...)
  -- function num : 0_1 , upvalues : _ENV, update
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildWarInfo, m, (Proto.MsgName).ResGuildWarInfo)
  update = onlyUpdate
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResGuildBattleInfo = function(msg, ...)
  -- function num : 0_2 , upvalues : update, _ENV
  local lastRound = 0
  if update then
    lastRound = (GuildBossMgr.GetCurrentRound)(true)
  end
  ;
  (GuildBossMgr.GuildBattleAllPass)(msg.passAll)
  ;
  (GuildBossMgr.GuildInfo)(msg.guildInfo)
  ;
  (GuildBossMgr.GuildBossInfo)(msg.baseInfo)
  ;
  (GuildBossMgr.GuildBossCurStage)(msg.stageInfo)
  ;
  (GuildBossMgr.GuildRemCount)(msg.remCount)
  ;
  (GuildBossMgr.GuildActivity)(msg.activity)
  ;
  (GuildBossMgr.GuildBattleRecord)(msg.battleRecord)
  ;
  (GuildBossMgr.GuildeInBattleInfo)(msg.inBattleInfo)
  if update or not msg.request then
    update = false
    local curRound = (GuildBossMgr.GetCurrentRound)(true)
    local changeRound = lastRound > 0 and lastRound < curRound
    UIMgr:SendWindowMessage((WinResConfig.GuildBossMainWindow).name, (WindowMsgEnum.GuildBoss).E_MSG_GUILD_MAIN_BOSS, changeRound)
    return 
  end
  if msg.promptInfo then
    if (msg.promptInfo).prompt == (ProtoEnum.GUILD_WAR_PROMPT).NEW_SEASON then
      UIMgr:SetOnShownComplete((WinResConfig.GuildBossMainWindow).name, function(...)
    -- function num : 0_2_0 , upvalues : _ENV, msg
    OpenWindow((WinResConfig.GuildBossSeasonStartWindow).name, UILayer.HUD, (msg.promptInfo).params)
  end
)
    elseif (msg.promptInfo).prompt == (ProtoEnum.GUILD_WAR_PROMPT).SETTLE_SEASON then
      UIMgr:SetOnShownComplete((WinResConfig.GuildBossMainWindow).name, function(...)
    -- function num : 0_2_1 , upvalues : _ENV, msg
    OpenWindow((WinResConfig.GuildBossSeasonEndWindow).name, UILayer.HUD, (msg.promptInfo).params)
  end
)
    end
  end
  if (msg.baseInfo).status ~= (ProtoEnum.GUILD_WAR_STATUS).SETTLE then
    (GuildBossMgr.InitTalentData)()
  end
  OpenWindow((WinResConfig.GuildBossMainWindow).name, UILayer.HUD)
  if msg.remCount <= 0 then
    (RedDotMgr.EliminateRedDot)((WinResConfig.GuildBossMainWindow).name, RedDotComID.GuildBoss_Rem)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqSupportInfo = function(...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqSupportInfo, m, (Proto.MsgName).ResSupportInfo)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResSupportInfo = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (GuildBossMgr.GuildSupportCard)(msg.supportCards)
  ;
  (GuildBossMgr.GuildSupportTimes)(msg.supportTimes)
  ;
  (GuildBossMgr.GuildSupportGetNum)(msg.curCanRw)
  ;
  (GuildBossMgr.GuildSupportAlreadyNum)(msg.todayRw)
  OpenWindow((WinResConfig.GuildBossSupportWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqSupportSet = function(cardID, type, pos, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.cardID = cardID
  m.type = type
  m.pos = pos
  ;
  (Net.Send)((Proto.MsgName).ReqSupportSet, m, (Proto.MsgName).ResSupportSet)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResSupportSet = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  if msg.type == (ProtoEnum.GUILD_WAR_SUPPORT).JOIN then
    (GuildBossMgr.GuildSupportSetValue)(msg.pos + 1, msg.cardID)
  else
    if msg.type == (ProtoEnum.GUILD_WAR_SUPPORT).QUIT then
      (GuildBossMgr.GuildSupportSetValue)(msg.pos + 1, 0)
    end
  end
  UIMgr:SendWindowMessage((WinResConfig.GuildBossSupportWindow).name, 2)
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqSupportHarvest = function(...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqSupportHarvest, m, (Proto.MsgName).ResSupportHarvest)
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResSupportHarvest = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  (GuildBossMgr.GuildSupportGetNum)(msg.curCanRw)
  ;
  (GuildBossMgr.GuildSupportAlreadyNum)(msg.todayRw)
  UIMgr:SendWindowMessage((WinResConfig.GuildBossSupportWindow).name, 1)
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.GuildBossMainWindow).name, RedDotComID.GuildBoss_Rup)
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqSeasonReward = function(...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqWarReward, m, (Proto.MsgName).ResWarReward)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResSeasonReward = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  (GuildBossMgr.RewardListData)(msg.rewardInfo)
  OpenWindow((WinResConfig.GuildBossRewardWindow).name, UILayer.HUD1)
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqGetSeasonReward = function(id, ...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  m.rewardId = id
  ;
  (Net.Send)((Proto.MsgName).ReqGetWarReward, m, (Proto.MsgName).ResGetWarReward)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResGetSeasonReward = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  (GuildBossMgr.SetListData)(msg.rewardId, (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS)
  UIMgr:SendWindowMessage((WinResConfig.GuildBossRewardWindow).name, 1)
  if not (GuildBossMgr.CheckIsCanGetReward)() then
    (RedDotMgr.EliminateRedDot)((WinResConfig.GuildBossMainWindow).name, RedDotComID.GuildBoss_Rwd)
  end
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqGuildTalent = function(...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildTalent, m, (Proto.MsgName).ResGuildTalent)
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.RecvGuildTalent = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  (GuildBossMgr.AfterRecvTalentData)(msg)
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqTalentReset = function(...)
  -- function num : 0_15 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqTalentReset, m, (Proto.MsgName).ResTalentReset)
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.RecvTalentReset = function(msg, ...)
  -- function num : 0_16 , upvalues : _ENV
  if msg.success then
    (GuildBossMgr.ResetTalent)()
  end
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqUpTalent = function(id, ...)
  -- function num : 0_17 , upvalues : _ENV
  local m = {}
  m.talentId = id
  ;
  (Net.Send)((Proto.MsgName).ReqUpTalent, m, (Proto.MsgName).ResUpTalent)
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.RecvUpTalent = function(msg, ...)
  -- function num : 0_18 , upvalues : _ENV
  (GuildBossMgr.AfterUpgradeTalent)(msg)
  if not (GuildBossData.CheckSkillAvailable)() then
    (RedDotMgr.EliminateRedDot)((WinResConfig.GuildBossMainWindow).name, RedDotComID.GuildBoss_Talent)
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqGuildBossAdvisory = function(...)
  -- function num : 0_19 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqWarAdvisory, m, (Proto.MsgName).ResWarAdvisory)
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResWarAdvisory = function(msg, ...)
  -- function num : 0_20 , upvalues : _ENV
  (GuildBossMgr.BossInfoData)(msg.stageInfo)
  OpenWindow((WinResConfig.GuildBossInformationWindow).name, UILayer.HUD1)
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqHurtReport = function(stageID, round, ...)
  -- function num : 0_21 , upvalues : _ENV
  local m = {}
  m.stageId = stageID
  m.round = round
  ;
  (Net.Send)((Proto.MsgName).ReqHurtReport, m, (Proto.MsgName).ResHurtReport)
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResHurtReport = function(msg, ...)
  -- function num : 0_22 , upvalues : _ENV
  (GuildBossMgr.BossHurtReport)(msg)
  OpenWindow((WinResConfig.GuildBossHurtReportWindow).name, UILayer.HUD1)
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqGSeasonRank = function(last, page, ...)
  -- function num : 0_23 , upvalues : _ENV
  local m = {}
  m.lastSeason = last
  m.page = page
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if page == 1 then
    GuildBossData.currentRankPage = 0
  end
  ;
  (Net.Send)((Proto.MsgName).ReqGSeasonRank, m, (Proto.MsgName).ResGSeasonRank)
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResGSeasonRank = function(msg, ...)
  -- function num : 0_24 , upvalues : _ENV
  (GuildBossMgr.IsLastSeasonData)(msg.lastSeason)
  ;
  (GuildBossMgr.GuildRankIndex)(msg.myRank)
  ;
  (GuildBossMgr.GuildRankScore)(msg.integral)
  ;
  (GuildBossMgr.IsPersonList)(false)
  local pageSize = msg.pageSize
  if pageSize == nil or pageSize <= 0 then
    pageSize = 50
  end
  ;
  (GuildBossMgr.ProcessGuildRankData)(msg.page, msg.gsRank, pageSize)
  if msg.page <= 1 then
    if UIMgr:IsWindowOpen((WinResConfig.GuildBossRankWindow).name) then
      UIMgr:SendWindowMessage((WinResConfig.GuildBossRankWindow).name, (WindowMsgEnum.GuildBoss).E_MSG_GUILD_RANK_REFRESH)
    else
      OpenWindow((WinResConfig.GuildBossRankWindow).name, UILayer.HUD1)
    end
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqMSeasonRank = function(last, ...)
  -- function num : 0_25 , upvalues : _ENV
  local m = {}
  m.lastSeason = last
  ;
  (Net.Send)((Proto.MsgName).ReqMSeasonRank, m, (Proto.MsgName).ResMSeasonRank)
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResMSeasonRank = function(msg, ...)
  -- function num : 0_26 , upvalues : _ENV
  (GuildBossMgr.IsPersonList)(true)
  ;
  (GuildBossMgr.IsLastSeasonData)(msg.lastSeason)
  ;
  (GuildBossMgr.ProcessPersonRankData)(msg.msRank)
  if UIMgr:IsWindowOpen((WinResConfig.GuildBossRankWindow).name) then
    UIMgr:SendWindowMessage((WinResConfig.GuildBossRankWindow).name, (WindowMsgEnum.GuildBoss).E_MSG_GUILD_RANK_REFRESH)
  else
    OpenWindow((WinResConfig.GuildBossRankWindow).name, UILayer.HUD1)
  end
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.ReqInGuildStage = function(stageID, simulation, ...)
  -- function num : 0_27 , upvalues : _ENV
  local m = {}
  m.stageId = stageID
  m.sim = simulation
  ;
  (Net.Send)((Proto.MsgName).ReqInGuildStage, m, (Proto.MsgName).ResInGuildStage)
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R1 in 'UnsetPending'

GuildBossService.OnResInGuildStage = function(msg, ...)
  -- function num : 0_28 , upvalues : _ENV
  if #msg.aliveBoss > 0 then
    UIMgr:CloseWindow((WinResConfig.GuildBossDetailWindow).name, true, true)
    ;
    (GuildBossMgr.EnterFormation)(msg)
  else
    ;
    (GuildBossService.ReqGuildBattleInfo)(true)
  end
end

local isSim = false
-- DECOMPILER ERROR at PC93: Confused about usage of register: R2 in 'UnsetPending'

GuildBossService.ReqInGuildWar = function(stageID, cardGroup, simulation, ...)
  -- function num : 0_29 , upvalues : isSim, _ENV
  local m = {}
  m.stageId = stageID
  m.sim = simulation
  m.cardGroup = cardGroup
  isSim = simulation
  ;
  (Net.Send)((Proto.MsgName).ReqInGuildWar, m, (Proto.MsgName).InitBattleData)
end

-- DECOMPILER ERROR at PC96: Confused about usage of register: R2 in 'UnsetPending'

GuildBossService.OnResInGuildWar = function(msg, ...)
  -- function num : 0_30
end

-- DECOMPILER ERROR at PC99: Confused about usage of register: R2 in 'UnsetPending'

GuildBossService.ReqSettleGuildWar = function(battleCompleteData, ...)
  -- function num : 0_31 , upvalues : isSim, _ENV
  local m = {}
  m.battleCompleteData = battleCompleteData
  m.sim = isSim
  ;
  (Net.Send)((Proto.MsgName).ReqSettleGuildWar, m, (Proto.MsgName).ResSettleGuildWar)
end

-- DECOMPILER ERROR at PC102: Confused about usage of register: R2 in 'UnsetPending'

GuildBossService.OnResSettleGuildWar = function(msg, ...)
  -- function num : 0_32 , upvalues : _ENV
  local BattleData = {}
  BattleData.BattleType = (ProtoEnum.E_BATTLE_TYPE).GUILD_WAR
  BattleData.BasicGoods = (Util.GoodsObjectToItemDataModel)(msg.stageRw)
  local maxHp = (GuildBossMgr.GetStageBossMaxHP)(msg.stageId)
  BattleData.GuildWarData = {}
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (BattleData.GuildWarData).challengeType = msg.type
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (BattleData.GuildWarData).DamagePer = msg.hurt / maxHp
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (BattleData.GuildWarData).RemainHP = msg.bossHp / maxHp
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (BattleData.GuildWarData).Score = msg.integral
  local btn = {}
  btn.btnTxt = (PUtil.get)(185)
  btn.fun = function(...)
    -- function num : 0_32_0 , upvalues : _ENV
    (GuildBossService.ReqGuildBattleInfo)(true)
    ld("Battle", function(...)
      -- function num : 0_32_0_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
  end

  BattleData.btn2 = btn
  loge("工会战boss总血量：" .. maxHp)
  loge("工会战boss伤害：" .. msg.hurt)
  ;
  (CommonWinMgr.OpenBattleSettleConvergeWindow)(BattleData)
end

-- DECOMPILER ERROR at PC105: Confused about usage of register: R2 in 'UnsetPending'

GuildBossService.ReqGuildBattleRecord = function(...)
  -- function num : 0_33 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildWarInfo, m, (Proto.MsgName).ResGuildWarInfo)
end

-- DECOMPILER ERROR at PC108: Confused about usage of register: R2 in 'UnsetPending'

GuildBossService.OnResGuildBattleRecord = function(msg, ...)
  -- function num : 0_34 , upvalues : _ENV
  (GuildBossMgr.GuildBattleRecord)(msg.battleRecord)
  ;
  (GuildBossMgr.GuildeInBattleInfo)(msg.inBattleInfo)
  UIMgr:SendWindowMessage((WinResConfig.GuildBossMainWindow).name, (WindowMsgEnum.GuildBoss).E_MSG_GUILD_RECORD)
end

;
(GuildBossService.Init)()

