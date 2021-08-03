-- params : ...
-- function num : 0 , upvalues : _ENV
EquiptService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResPutOnEquip, EquiptService.RecvPutOnEquip)
  ;
  (Net.AddListener)((Proto.MsgName).ResDestroyEquip, EquiptService.RecvDestroyEquip)
  ;
  (Net.AddListener)((Proto.MsgName).ResLockEquip, EquiptService.RecvLockEquip)
  ;
  (Net.AddListener)((Proto.MsgName).ResLevelUpEquip, EquiptService.RecvLevelUpEquip)
  ;
  (Net.AddListener)((Proto.MsgName).ResIdentifyEquip, EquiptService.RecvIdentifyEquip)
  ;
  (Net.AddListener)((Proto.MsgName).ResEquipScheme, EquiptService.RecvEquipScheme)
  ;
  (Net.AddListener)((Proto.MsgName).ResRemoveEquipScheme, EquiptService.RecvRemoveEquipScheme)
  ;
  (Net.AddListener)((Proto.MsgName).ResAddEquipScheme, EquiptService.RecvAddEquipScheme)
  ;
  (Net.AddListener)((Proto.MsgName).ResUpdateEquipSchemeName, EquiptService.RecvUpdateEquipSchemeName)
  ;
  (Net.AddListener)((Proto.MsgName).ResUseEquipScheme, EquiptService.RecvUseEquipScheme)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.ReqPutOnEquip = function(equipid, sourceCardId, cardId, ...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  m.sourceEquipIndex = equipid
  m.sourceCardId = sourceCardId
  m.cardId = cardId
  ;
  (Net.Send)((Proto.MsgName).ReqPutOnEquip, m, (Proto.MsgName).ResPutOnEquip)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.RecvPutOnEquip = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (CardMgr.RefreshSuitBuffData)(msg)
  ;
  (EquiptMgr.AfterEquipChange)(msg)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.ReqDestroyEquip = function(equips, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.equipIndex = equips
  m.cardId = 0
  ;
  (Net.Send)((Proto.MsgName).ReqDestroyEquip, m, (Proto.MsgName).ResDestroyEquip)
  ;
  (EquiptData.ResetDecomposeData)()
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.RecvDestroyEquip = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (EquiptData.ResetDecomposeData)()
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.ReqLockEquip = function(equipID, cardID, isLock, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.equipIndex = equipID
  m.cardId = cardID
  m.lock = isLock
  ;
  (Net.Send)((Proto.MsgName).ReqLockEquip, m, (Proto.MsgName).ResLockEquip)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.RecvLockEquip = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if msg.cardId == 0 then
    ((EquiptData.Equipments)[(EquiptData.Equipments)[msg.equipIndex]]).lock = msg.lock
  else
    local count = #(EquiptData.CurrentRoleData).equipInfo
    local item = nil
    for i = 1, count do
      item = ((EquiptData.CurrentRoleData).equipInfo)[i]
      if item.objectIndex == msg.equipIndex then
        item.lock = msg.lock
        break
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

    if msg.lock and (EquiptData.ReadyToDecompose)[msg.equipIndex] ~= nil then
      (EquiptData.ReadyToDecompose)[msg.equipIndex] = nil
    end
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_LOCK_EQUIPMENT)
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.ReqLevelUpEquip = function(equipId, cardID, times, ...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  m.equipIndex = equipId
  m.cardId = cardID
  m.num = times
  ;
  (Net.Send)((Proto.MsgName).ReqLevelUpEquip, m, (Proto.MsgName).ResLevelUpEquip)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.RecvLevelUpEquip = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  local equipInfo, count, cardData = nil, nil, nil
  if msg.cardId == 0 then
    equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[msg.equipIndex]]
  else
    cardData = (CardData.GetCardData)(msg.cardId)
    local equipsInfo = cardData.equipInfo
    count = #equipsInfo
    for i = 1, count do
      if (equipsInfo[i]).objectIndex == msg.equipIndex then
        equipInfo = equipsInfo[i]
        break
      end
    end
  end
  do
    equipInfo.level = msg.level
    equipInfo.mainAttrId = msg.mainAttrId
    count = #msg.randomAttrId
    for i = 1, count do
      (table.insert)(equipInfo.randomAttrId, (msg.randomAttrId)[i])
    end
    if cardData ~= nil then
      (CardData.ResetCardData)(cardData)
      ;
      (CommonWinMgr.OpenCommonFcUp)(msg.cardId)
    end
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT, equipInfo)
    UIMgr:SendWindowMessage((WinResConfig.OperationEquiptWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT, equipInfo)
    UIMgr:SendWindowMessage((WinResConfig.EquiptLevelWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT)
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.ReqIdentifyEquip = function(data, ...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  m.equipIndex = data
  ;
  (Net.Send)((Proto.MsgName).ReqIdentifyEquip, m, (Proto.MsgName).ResIdentifyEquip)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.RecvIdentifyEquip = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  (EquiptMgr.RecvIdentifyEquips)(msg.equipInfo)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.ReqEquipScheme = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqEquipScheme, m, (Proto.MsgName).ResEquipScheme)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.RecvEquipScheme = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  (EquiptMgr.RecvEquipPreset)(msg)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.ReqRemoveEquipScheme = function(id, ...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqRemoveEquipScheme, m, (Proto.MsgName).ResRemoveEquipScheme)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.RecvRemoveEquipScheme = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  (EquiptMgr.RecvDeletePreset)(msg)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.ReqAddEquipScheme = function(data, type, ...)
  -- function num : 0_15 , upvalues : _ENV
  local m = {}
  m.equipScheme = data
  m.type = type
  ;
  (Net.Send)((Proto.MsgName).ReqAddEquipScheme, m, (Proto.MsgName).ResAddEquipScheme)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.RecvAddEquipScheme = function(msg, ...)
  -- function num : 0_16 , upvalues : _ENV
  (EquiptMgr.RecvUpdateEquipPreset)(msg)
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.ReqUpdateEquipSchemeName = function(id, name, ...)
  -- function num : 0_17 , upvalues : _ENV
  local m = {}
  m.id = id
  m.schemeName = name
  ;
  (Net.Send)((Proto.MsgName).ReqUpdateEquipSchemeName, m, (Proto.MsgName).ResUpdateEquipSchemeName)
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.RecvUpdateEquipSchemeName = function(msg, ...)
  -- function num : 0_18
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.ReqUseEquipScheme = function(id, cardId, type, ...)
  -- function num : 0_19 , upvalues : _ENV
  local m = {}
  m.id = id
  m.cardId = cardId
  m.useType = type
  ;
  (Net.Send)((Proto.MsgName).ReqUseEquipScheme, m, (Proto.MsgName).ResUseEquipScheme)
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

EquiptService.RecvUseEquipScheme = function(msg, ...)
  -- function num : 0_20 , upvalues : _ENV
  (EquiptMgr.RecvUsePreset)(msg)
end

;
(EquiptService.Init)()

