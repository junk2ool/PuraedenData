-- params : ...
-- function num : 0 , upvalues : _ENV
NewActivityDungeonService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResRiskDataInit, NewActivityDungeonService.RecvRiskDataInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResRiskData, NewActivityDungeonService.RecvRiskData)
  ;
  (Net.AddListener)((Proto.MsgName).ResBeginRisk, NewActivityDungeonService.RecvBeginRisk)
  ;
  (Net.AddListener)((Proto.MsgName).ResEndRisk, NewActivityDungeonService.RecvEndRisk)
  ;
  (Net.AddListener)((Proto.MsgName).ResAssistFightInit, NewActivityDungeonService.RecvAssistFightInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResChallengeAssistFight, NewActivityDungeonService.RecvChallengeAssistFight)
  ;
  (Net.AddListener)((Proto.MsgName).ResNeedNoticeBossHP, NewActivityDungeonService.RecvNeedNoticeBossHP)
  ;
  (Net.AddListener)((Proto.MsgName).ResAssistFightData, NewActivityDungeonService.RecvAssistFightData)
  ;
  (Net.AddListener)((Proto.MsgName).ResEmbattle, NewActivityDungeonService.RecvCardGroups)
  ;
  (Net.AddListener)((Proto.MsgName).ResChallengeReward, NewActivityDungeonService.RecvChallengeReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResAssistGuildMember, NewActivityDungeonService.RecvAssistGuildMember)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleAssistFight, NewActivityDungeonService.RecvSettleAssistFight)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqRiskDataInit = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqRiskDataInit, m, (Proto.MsgName).ResRiskDataInit)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvRiskDataInit = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (NewActivityDungeonMgr.InitAdventureData)(msg)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqRiskData = function(id, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqRiskData, m, (Proto.MsgName).ResRiskData)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvRiskData = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (NewActivityDungeonMgr.RefreshRiskData)(msg)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqBeginRisk = function(id, duration, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.id = id
  m.riskTime = duration
  ;
  (Net.Send)((Proto.MsgName).ReqBeginRisk, m, (Proto.MsgName).ResBeginRisk)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvBeginRisk = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  (NewActivityDungeonMgr.RefreshRiskData)(msg)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqEndRisk = function(id, ...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqEndRisk, m, (Proto.MsgName).ResEndRisk)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvEndRisk = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  (NewActivityDungeonMgr.RecvEndRisk)(msg)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqAssistFightInit = function(...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqAssistFightInit, m, (Proto.MsgName).ResAssistFightInit)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvAssistFightInit = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  (NewActivityDungeonMgr.RecvAssistData)(msg)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqChallengeAssistFight = function(formation, ...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  m.cardInfo = formation
  ;
  (Net.Send)((Proto.MsgName).ReqChallengeAssistFight, m, (Proto.MsgName).ResChallengeAssistFight)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvChallengeAssistFight = function(msg, ...)
  -- function num : 0_12
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqCardGroups = function(formation, ...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  m.type = (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ASSIST_BOSS
  m.cardInfo = (Util.CovertLoaclFormationToRemote)(formation)
  ;
  (Net.Send)((Proto.MsgName).ReqEmbattle, m, (Proto.MsgName).ResEmbattle)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvCardGroups = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if msg.type == (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ASSIST_BOSS then
    (NewActivityDungeonData.AssistData).cardInfo = msg.cardInfo
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqSettleAssistFight = function(msg, ...)
  -- function num : 0_15 , upvalues : _ENV
  local m = {}
  m.battleCompleteData = msg
  ;
  (Net.Send)((Proto.MsgName).ReqSettleAssistFight, m, (Proto.MsgName).ResSettleAssistFight)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvSettleAssistFight = function(msg, ...)
  -- function num : 0_16 , upvalues : _ENV
  (NewActivityDungeonMgr.RecvSettleAssistFight)(msg)
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqNeedNoticeBossHP = function(notify, ...)
  -- function num : 0_17 , upvalues : _ENV
  local m = {}
  m.notify = notify
  ;
  (Net.Send)((Proto.MsgName).ReqNeedNoticeBossHP, m, (Proto.MsgName).ResNeedNoticeBossHP)
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvNeedNoticeBossHP = function(msg, ...)
  -- function num : 0_18
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqChallengeReward = function(id, ...)
  -- function num : 0_19 , upvalues : _ENV
  local m = {}
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqChallengeReward, m, (Proto.MsgName).ResChallengeReward)
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvChallengeReward = function(msg, ...)
  -- function num : 0_20 , upvalues : _ENV
  (NewActivityDungeonMgr.RecvReward)(msg)
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.ReqAssistGuildMember = function(id, ...)
  -- function num : 0_21 , upvalues : _ENV
  local m = {}
  m.playerIndex = id
  ;
  (Net.Send)((Proto.MsgName).ReqAssistGuildMember, m, (Proto.MsgName).ResAssistGuildMember)
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R0 in 'UnsetPending'

NewActivityDungeonService.RecvAssistGuildMember = function(msg, ...)
  -- function num : 0_22 , upvalues : _ENV
  (NewActivityDungeonMgr.RecvAssistGuildMemebr)(msg)
end

;
(NewActivityDungeonService.Init)()

