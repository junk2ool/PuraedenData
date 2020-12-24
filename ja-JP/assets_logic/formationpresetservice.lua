-- params : ...
-- function num : 0 , upvalues : _ENV
FormationPresetService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetService.init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResDeckScheme, FormationPresetService.RecvDeckScheme)
  ;
  (Net.AddListener)((Proto.MsgName).ResAddOrUpdateDeckScheme, FormationPresetService.RecvAddOrUpdateDeckScheme)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetService.ReqDeckScheme = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqDeckScheme, m, (Proto.MsgName).ResDeckScheme)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetService.RecvDeckScheme = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (FormationPresetMgr.RecvInitData)(msg)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetService.ReqAddOrUpdateDeckScheme = function(type, id, name, formation, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.type = type
  m.id = id
  m.name = name
  m.deckSchemes = formation
  ;
  (Net.Send)((Proto.MsgName).ReqAddOrUpdateDeckScheme, m, (Proto.MsgName).ResAddOrUpdateDeckScheme)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetService.RecvAddOrUpdateDeckScheme = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (FormationPresetMgr.RecvPresetData)(msg)
end

;
(FormationPresetService.init)()

