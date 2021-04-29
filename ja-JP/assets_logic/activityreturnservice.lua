-- params : ...
-- function num : 0 , upvalues : _ENV
ActivityReturnService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

ActivityReturnService.Init = function(...)
  -- function num : 0_0
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

ActivityReturnService.ReqGetReward = function(actId, rewId, ...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  m.actId = actId
  m.rewId = rewId
  ;
  (Net.Send)((Proto.MsgName).ReqGetReward, m, (Proto.MsgName).ResGetReward)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

ActivityReturnService.RecvGetReward = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (ActivityReturnMgr.RecvGetReward)(msg)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

ActivityReturnService.ReqPointReward = function(actId, rewId, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.actId = actId
  m.rewId = rewId
  ;
  (Net.Send)((Proto.MsgName).ReqPointReward, m, (Proto.MsgName).ResPointReward)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

ActivityReturnService.RecvPointReward = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (ActivityReturnMgr.RecvPointReward)(msg)
end

;
(ActivityReturnService.Init)()

