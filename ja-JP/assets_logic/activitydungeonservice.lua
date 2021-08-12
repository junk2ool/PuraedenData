-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityDungeonService = {}
ActivityDungeonService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV, ActivityDungeonService
  (Net.AddListener)((Proto.MsgName).ResRiskDataInit, ActivityDungeonService.RecvRiskDataInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResRiskData, ActivityDungeonService.RecvRiskData)
  ;
  (Net.AddListener)((Proto.MsgName).ResBeginRisk, ActivityDungeonService.RecvBeginRisk)
  ;
  (Net.AddListener)((Proto.MsgName).ResEndRisk, ActivityDungeonService.RecvEndRisk)
  ;
  (Net.AddListener)((Proto.MsgName).ResAssistFightInit, ActivityDungeonService.RecvAssistFightInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResChallengeAssistFight, ActivityDungeonService.RecvChallengeAssistFight)
  ;
  (Net.AddListener)((Proto.MsgName).ResNeedNoticeBossHP, ActivityDungeonService.RecvNeedNoticeBossHP)
  ;
  (Net.AddListener)((Proto.MsgName).ResAssistFightData, ActivityDungeonService.RecvAssistFightData)
  ;
  (Net.AddListener)((Proto.MsgName).ResEmbattle, ActivityDungeonService.RecvCardGroups)
  ;
  (Net.AddListener)((Proto.MsgName).ResChallengeReward, ActivityDungeonService.RecvChallengeReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResAssistGuildMember, ActivityDungeonService.RecvAssistGuildMember)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleAssistFight, ActivityDungeonService.RecvSettleAssistFight)
end

ActivityDungeonService.ReqRiskDataInit = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqRiskDataInit, m, (Proto.MsgName).ResRiskDataInit)
end

ActivityDungeonService.RecvRiskDataInit = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (ActivityDungeonMgr.InitRiskDataList)(msg)
end

ActivityDungeonService.ReqRiskData = function(id, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqRiskData, m, (Proto.MsgName).ResRiskData)
end

ActivityDungeonService.RecvRiskData = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (ActivityDungeonMgr.RefreshRiskData)(msg)
end

ActivityDungeonService.ReqBeginRisk = function(id, duration, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.id = id
  m.riskTime = duration
  ;
  (Net.Send)((Proto.MsgName).ReqBeginRisk, m, (Proto.MsgName).ResBeginRisk)
end

ActivityDungeonService.RecvBeginRisk = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  (ActivityDungeonMgr.RefreshRiskData)(msg)
end

ActivityDungeonService.ReqEndRisk = function(id, ...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqEndRisk, m, (Proto.MsgName).ResEndRisk)
end

ActivityDungeonService.RecvEndRisk = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  (ActivityDungeonMgr.RecvEndRisk)(msg)
end

ActivityDungeonService.ReqAssistFightInit = function(...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqAssistFightInit, m, (Proto.MsgName).ResAssistFightInit)
end

ActivityDungeonService.RecvAssistFightInit = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  (ActivityDungeonMgr.RecvAssistData)(msg)
end

ActivityDungeonService.ReqChallengeAssistFight = function(formation, ...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  m.cardInfo = formation
  ;
  (Net.Send)((Proto.MsgName).ReqChallengeAssistFight, m, (Proto.MsgName).ResChallengeAssistFight)
end

ActivityDungeonService.RecvChallengeAssistFight = function(msg, ...)
  -- function num : 0_12
end

ActivityDungeonService.ReqCardGroups = function(formation, ...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  m.type = (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ASSIST_BOSS
  m.cardInfo = (Util.CovertLoaclFormationToRemote)(formation)
  ;
  (Net.Send)((Proto.MsgName).ReqEmbattle, m, (Proto.MsgName).ResEmbattle)
end

ActivityDungeonService.RecvCardGroups = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  if msg.type == (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_ASSIST_BOSS then
    local assistData = (ActivityRiskData.GetAssistData)()
    assistData.cardInfo = msg.cardInfo
  end
end

ActivityDungeonService.ReqSettleAssistFight = function(msg, ...)
  -- function num : 0_15 , upvalues : _ENV
  local m = {}
  m.battleCompleteData = msg
  ;
  (Net.Send)((Proto.MsgName).ReqSettleAssistFight, m, (Proto.MsgName).ResSettleAssistFight)
end

ActivityDungeonService.RecvSettleAssistFight = function(msg, ...)
  -- function num : 0_16 , upvalues : _ENV
  (ActivityDungeonMgr.RecvSettleAssistFight)(msg)
end

ActivityDungeonService.ReqNeedNoticeBossHP = function(notify, ...)
  -- function num : 0_17 , upvalues : _ENV
  local m = {}
  m.notify = notify
  ;
  (Net.Send)((Proto.MsgName).ReqNeedNoticeBossHP, m, (Proto.MsgName).ResNeedNoticeBossHP)
end

ActivityDungeonService.RecvNeedNoticeBossHP = function(msg, ...)
  -- function num : 0_18
end

ActivityDungeonService.ReqChallengeReward = function(id, ...)
  -- function num : 0_19 , upvalues : _ENV
  local m = {}
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqChallengeReward, m, (Proto.MsgName).ResChallengeReward)
end

ActivityDungeonService.RecvChallengeReward = function(msg, ...)
  -- function num : 0_20 , upvalues : _ENV
  (ActivityDungeonMgr.RecvReward)(msg)
end

ActivityDungeonService.ReqAssistGuildMember = function(id, ...)
  -- function num : 0_21 , upvalues : _ENV
  local m = {}
  m.playerIndex = id
  ;
  (Net.Send)((Proto.MsgName).ReqAssistGuildMember, m, (Proto.MsgName).ResAssistGuildMember)
end

ActivityDungeonService.RecvAssistGuildMember = function(msg, ...)
  -- function num : 0_22 , upvalues : _ENV
  (ActivityDungeonMgr.RecvAssistGuildMember)(msg)
end

;
(ActivityDungeonService.Init)()
return ActivityDungeonService

