-- params : ...
-- function num : 0 , upvalues : _ENV
TowerTopStageService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResOldSetsTower, TowerTopStageService.RecTowerExpandChooseEquip)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageService.ReqTowerExpandData = function(isOpen, ...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  m.type = 2
  ;
  (Net.Send)((Proto.MsgName).ReqTowerInit, m, (Proto.MsgName).ResTowerInit)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageService.ReqTowerExpandChooseEquip = function(towerId, ...)
  -- function num : 0_2 , upvalues : _ENV
  local m = {}
  m.towerId = towerId
  ;
  (Net.Send)((Proto.MsgName).ReqOldSetsTower, m, (Proto.MsgName).ResOldSetsTower)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageService.RecTowerExpandChooseEquip = function(msg, ...)
  -- function num : 0_3 , upvalues : _ENV
  (table.insert)(TowerTopStageData.TowerExpandList, msg.tower)
  ;
  (TowerTopStageMgr.RefreshReceiveMsg)()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  TowerTopStageData.CurrentLayer = (msg.tower).towerId
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

TowerTopStageService.ReqTowerCardGroups = function(formation, ...)
  -- function num : 0_4 , upvalues : _ENV
  local m = {}
  m.type = (ProtoEnum.E_EMBATTLE_TYPE).EMBATTLE_TOWER_EXPAND
  m.cardInfo = (Util.CovertLoaclFormationToRemote)(formation)
  ;
  (Net.Send)((Proto.MsgName).ReqEmbattle, m, (Proto.MsgName).ResEmbattle)
end

;
(TowerTopStageService.Init)()

