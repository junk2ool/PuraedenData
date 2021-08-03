-- params : ...
-- function num : 0 , upvalues : _ENV
EquiptMgr = {}
local _detailPanelPool = {}
-- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.OpenEquipmentWindow = function(type, arg, ...)
  -- function num : 0_0 , upvalues : _ENV
  if (FunctionControlMgr.GetFunctionState)(ControlID.Home_EquipBtn, true) then
    if not EquiptData.PresetInitialized then
      (EquiptService.ReqEquipScheme)()
    end
    OpenWindow((WinResConfig.EquipmentWindow).name, UILayer.HUD, type, arg)
  end
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ReInitializePreset = function(...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ReInitialize = true
  ;
  (EquiptService.ReqEquipScheme)()
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.InitEquipmentsInBag = function(equipments, ...)
  -- function num : 0_2 , upvalues : _ENV
  (EquiptData.ClearEquipData)()
  ;
  (EquiptData.StoreEquipments)(equipments)
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AcquireEquipments = function(equipments, ...)
  -- function num : 0_3 , upvalues : _ENV
  if #equipments == 0 then
    return 
  end
  ;
  (EquiptData.AcquireEquipments)(equipments)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.LoseEquipments = function(equipmentIds, ...)
  -- function num : 0_4 , upvalues : _ENV
  if #equipmentIds == 0 then
    return 
  end
  ;
  (EquiptData.LoseEquipments)(equipmentIds)
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Change)
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Decompose)
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Identify)
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Preset)
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_TO_DECOMPOSE)
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AfterEquipChange = function(msg, ...)
  -- function num : 0_5 , upvalues : _ENV
  local roleInfo, count, equipInfo, oldEquip = nil, nil, nil, nil
  if msg.cardId == (EquiptData.CurrentRoleData).id then
    roleInfo = EquiptData.CurrentRoleData
  else
    if msg.cardId ~= 0 then
      roleInfo = (CardData.GetCardData)(msg.cardId)
    else
      roleInfo = (CardData.GetCardData)(msg.sourceCardId)
    end
  end
  local isPutOn = false
  local equipmentType = nil
  if (Util.StringIsNullOrEmpty)(msg.replaceEquipIndex) then
    if msg.sourceCardId == 0 then
      equipmentType = (EquiptMgr.PutOnEquipment)(roleInfo, msg.sourceEquipIndex)
      isPutOn = true
      if (EquiptData.EquipBelongTo)[msg.sourceEquipIndex] ~= nil then
        (EquiptData.RemoveFromPreset)(msg.sourceEquipIndex, (EquiptData.EquipBelongTo)[msg.sourceEquipIndex])
      end
      if roleInfo.equipScheme ~= 0 and roleInfo.equipScheme ~= nil then
        (EquiptData.AddToPreset)(msg.sourceEquipIndex, roleInfo.equipScheme)
      end
    else
      ;
      (EquiptMgr.PutOffEquipment)(roleInfo, msg.sourceEquipIndex)
      if roleInfo.equipScheme ~= 0 and roleInfo.equipScheme ~= nil and (EquiptData.RemoveFromPreset)(msg.sourceEquipIndex, roleInfo.equipScheme) then
        roleInfo.equipScheme = 0
      end
    end
  else
    if msg.sourceCardId == 0 then
      (EquiptMgr.PutOffEquipment)(roleInfo, msg.replaceEquipIndex)
      equipmentType = (EquiptMgr.PutOnEquipment)(roleInfo, msg.sourceEquipIndex)
      if (EquiptData.EquipBelongTo)[msg.sourceEquipIndex] ~= nil then
        (EquiptData.RemoveFromPreset)(msg.sourceEquipIndex, (EquiptData.EquipBelongTo)[msg.sourceEquipIndex])
      end
      if roleInfo.equipScheme ~= 0 and roleInfo.equipScheme ~= nil then
        (EquiptData.RemoveFromPreset)(msg.replaceEquipIndex, roleInfo.equipScheme, true)
        ;
        (EquiptData.AddToPreset)(msg.sourceEquipIndex, roleInfo.equipScheme)
      end
      isPutOn = true
    end
  end
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Change)
  ;
  (EquiptData.UpdateCardSuitInfo)(roleInfo.id)
  ;
  (CardData.ResetCardData)(roleInfo)
  if (CommonWinMgr.OpenCommonFcUp)(roleInfo.id) == false and isPutOn then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000390))
  end
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT, equipmentType)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.PutOnEquipment = function(roleData, equipId, equip, ...)
  -- function num : 0_6 , upvalues : _ENV
  (LuaSound.PlaySound)(LuaSound.EQUIP_ON, SoundBank.OTHER)
  ;
  (EquiptData.HandelAvailablePartsData)(equipId, nil, false, equip)
  ;
  (EquiptData.HandleEquiptObjectIndexData)(EquiptData.AvailableEquipmentsInBag, equipId, false)
  ;
  (EquiptData.HandleEquiptObjectIndexData)(EquiptData.EquipmentsToDecompose, equipId, false)
  local equipInfo = nil
  if equip then
    equipInfo = equip
  else
    equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[equipId]]
  end
  local config = ((TableData.gTable).BaseEquipData)[equipInfo.id]
  ;
  (EquiptData.HandelAvailablePartsData)(equipId, equipInfo.id, false)
  ;
  (EquiptData.HandleEquiptData)(EquiptData.Equipments, equipInfo, false)
  if equipInfo ~= nil then
    (table.insert)(roleData.equipInfo, equipInfo)
    return config.type
  else
    loge("equipment:" .. msg.sourceEquipIndex .. " not found")
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.PutOffEquipment = function(roleData, equipId, ...)
  -- function num : 0_7 , upvalues : _ENV
  local count = #roleData.equipInfo
  local oldEquip, index = nil, nil
  for i = 1, count do
    oldEquip = (roleData.equipInfo)[i]
    if oldEquip.objectIndex == equipId then
      oldEquip.SortedAttr = (EquiptData.GetSortedAttrs)(oldEquip)
      ;
      (table.sort)(oldEquip.randomBuff, function(x, y, ...)
    -- function num : 0_7_0
    do return x < y end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      ;
      (EquiptData.HandelAvailablePartsData)(equipId, oldEquip.id, true)
      ;
      (EquiptData.HandleEquiptObjectIndexData)(EquiptData.AvailableEquipmentsInBag, equipId, true)
      ;
      (EquiptData.HandleEquiptObjectIndexData)(EquiptData.EquipmentsToDecompose, equipId, true)
      ;
      (EquiptData.HandleEquiptData)(EquiptData.Equipments, oldEquip, true)
      ;
      (table.remove)(roleData.equipInfo, i)
      break
    end
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.CheckIdentifyEquipmentsFull = function(...)
  -- function num : 0_8 , upvalues : _ENV
  if (((TableData.gTable).BaseFixedData)[EquiptData.MAX_IDENTIFY_AMOUNT]).int_value <= #EquiptData.ReadyToIdentify then
    return true
  else
    return false
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.HandleEquipmentToIdentify = function(equipInfo, add, notRefresh, ...)
  -- function num : 0_9 , upvalues : _ENV
  local costInfo = split((((TableData.gTable).BaseEquipData)[equipInfo.id]).identify_cost, ",")
  local costCount = #costInfo
  local cost, id, value = nil, nil, nil
  ;
  (EquiptData.HandleEquiptData)(EquiptData.ReadyToIdentify, equipInfo, add)
  if add then
    for i = 1, costCount do
      cost = split(costInfo[i], ":")
      id = tonumber(cost[2])
      value = tonumber(cost[3])
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R12 in 'UnsetPending'

      if (EquiptData.IdentifyCost)[id] == nil then
        (EquiptData.IdentifyCost)[id] = {Value = 0, Type = tonumber(cost[1])}
      end
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((EquiptData.IdentifyCost)[id]).Value = ((EquiptData.IdentifyCost)[id]).Value + value
    end
  else
    do
      for i = 1, costCount do
        cost = split(costInfo[i], ":")
        id = tonumber(cost[2])
        value = tonumber(cost[3])
        -- DECOMPILER ERROR at PC92: Confused about usage of register: R12 in 'UnsetPending'

        if (EquiptData.IdentifyCost)[id] ~= nil then
          ((EquiptData.IdentifyCost)[id]).Value = ((EquiptData.IdentifyCost)[id]).Value - value
        end
      end
      do
        if not notRefresh then
          UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_TO_IDENTIFY)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ChangeFilterSortType = function(setType, ...)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  if ((EquiptData.Filters)[setType]).SortType == EquiptSortType.Increase then
    ((EquiptData.Filters)[setType]).SortType = EquiptSortType.Decrease
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((EquiptData.Filters)[setType]).SortType = EquiptSortType.Increase
  end
  ;
  (EquiptData.SortEquipmentSet)(setType)
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG)
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AfterFilterChanged = function(setType, ...)
  -- function num : 0_11 , upvalues : _ENV
  (EquiptData.FilteringEquiptSet)(setType)
  if setType == EquiptSetType.Decompose then
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_DISABLE_ALL_DECOMPOSE)
  end
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.FilterChangeEquipments = function(data, ...)
  -- function num : 0_12 , upvalues : _ENV
  (EquiptData.ResetFilters)(EquiptSetType.Change)
  for k,v in pairs(data) do
    for subK,subV in pairs(v) do
      if subV then
        (EquiptData.ChangeFilter)(EquiptSetType.Change, k, subK, true)
      end
    end
  end
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Change)
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG)
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ResetChangeFilter = function(...)
  -- function num : 0_13 , upvalues : _ENV
  (EquiptData.ResetFilters)(EquiptSetType.Change)
  ;
  (EquiptMgr.AfterFilterChanged)(EquiptSetType.Change)
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ResetDecomposeFilter = function(...)
  -- function num : 0_14 , upvalues : _ENV
  (EquiptData.ResetFilters)(EquiptSetType.Decompose)
  ;
  (EquiptMgr.AfterFilterChanged)(EquiptSetType.Decompose)
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ResetIdentifyFilter = function(...)
  -- function num : 0_15 , upvalues : _ENV
  (EquiptData.ResetFilters)(EquiptSetType.Identify)
  ;
  (EquiptMgr.AfterFilterChanged)(EquiptSetType.Identify)
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ResetFilter = function(setType, ...)
  -- function num : 0_16 , upvalues : _ENV
  (EquiptData.ResetFilters)(setType)
  ;
  (EquiptMgr.AfterFilterChanged)(setType)
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ChangeFilter = function(setType, filterType, arg1, arg2, ...)
  -- function num : 0_17 , upvalues : _ENV
  (EquiptData.ChangeFilter)(setType, filterType, arg1, arg2)
  ;
  (EquiptMgr.AfterFilterChanged)(setType)
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ChangePresetEditFilter = function(filterType, ...)
  -- function num : 0_18 , upvalues : _ENV
  (EquiptData.ChangePresetEditFilter)(filterType)
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG)
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetAllEquipToDecomposeOrNot = function(decompose, ...)
  -- function num : 0_19 , upvalues : _ENV
  if decompose then
    local equipments = ((EquiptData.Filters)[EquiptSetType.Decompose]).Result
    local count = #equipments
    local config, equipInfo = nil, nil
    for i = 1, count do
      equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[equipments[i]]]
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R9 in 'UnsetPending'

      if equipInfo.lock == false then
        (EquiptData.ReadyToDecompose)[equipInfo.objectIndex] = true
        config = ((TableData.gTable).BaseEquipData)[equipInfo.id]
        -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

        if Const.AdvenceEquipStar <= config.star then
          (EquiptData.AdvanceEquiptToDecompose)[equipInfo.objectIndex] = true
        end
      end
    end
  else
    do
      ;
      (EquiptData.ResetDecomposeData)()
    end
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetUnidentifiedEquipToDecompose = function(unidentified, ...)
  -- function num : 0_20 , upvalues : _ENV
  local equipments = ((EquiptData.Filters)[EquiptSetType.Decompose]).Result
  local count = #equipments
  local config, equipInfo = nil, nil
  for i = 1, count do
    equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[equipments[i]]]
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R9 in 'UnsetPending'

    if equipInfo.lock == false and not equipInfo.identify then
      if unidentified then
        (EquiptData.ReadyToDecompose)[equipInfo.objectIndex] = true
        config = ((TableData.gTable).BaseEquipData)[equipInfo.id]
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R9 in 'UnsetPending'

        if Const.AdvenceEquipStar <= config.star then
          (EquiptData.AdvanceEquiptToDecompose)[equipInfo.objectIndex] = true
        end
      else
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (EquiptData.ReadyToDecompose)[equipInfo.objectIndex] = nil
        config = ((TableData.gTable).BaseEquipData)[equipInfo.id]
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R9 in 'UnsetPending'

        if Const.AdvenceEquipStar <= config.star then
          (EquiptData.AdvanceEquiptToDecompose)[equipInfo.objectIndex] = nil
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetIdentifiedEquipToDecompose = function(identified, ...)
  -- function num : 0_21 , upvalues : _ENV
  local equipments = ((EquiptData.Filters)[EquiptSetType.Decompose]).Result
  local count = #equipments
  local config, equipInfo = nil, nil
  for i = 1, count do
    equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[equipments[i]]]
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R9 in 'UnsetPending'

    if equipInfo.lock == false and equipInfo.identify then
      if identified then
        (EquiptData.ReadyToDecompose)[equipInfo.objectIndex] = true
        config = ((TableData.gTable).BaseEquipData)[equipInfo.id]
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R9 in 'UnsetPending'

        if Const.AdvenceEquipStar <= config.star then
          (EquiptData.AdvanceEquiptToDecompose)[equipInfo.objectIndex] = true
        end
      else
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (EquiptData.ReadyToDecompose)[equipInfo.objectIndex] = nil
        config = ((TableData.gTable).BaseEquipData)[equipInfo.id]
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R9 in 'UnsetPending'

        if Const.AdvenceEquipStar <= config.star then
          (EquiptData.AdvanceEquiptToDecompose)[equipInfo.objectIndex] = nil
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ChangeEquipDecomposeStatue = function(equipID, configID, add, ...)
  -- function num : 0_22 , upvalues : _ENV
  local config = ((TableData.gTable).BaseEquipData)[configID]
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if add then
    (EquiptData.ReadyToDecompose)[equipID] = true
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

    if Const.AdvenceEquipStar <= config.star then
      (EquiptData.AdvanceEquiptToDecompose)[equipID] = true
    end
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (EquiptData.ReadyToDecompose)[equipID] = nil
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

    if Const.AdvenceEquipStar <= config.star then
      (EquiptData.AdvanceEquiptToDecompose)[equipID] = nil
    end
  end
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.TryDecomposeEquips = function(...)
  -- function num : 0_23 , upvalues : _ENV
  local equips = {}
  local presetId, equipInfo, config, presetData = nil, nil, nil, nil
  local str = ""
  for k,v in pairs(EquiptData.ReadyToDecompose) do
    (table.insert)(equips, k)
    if (EquiptData.EquipBelongTo)[k] ~= nil then
      presetId = (EquiptData.EquipBelongTo)[k]
      equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[k]]
      config = ((TableData.gTable).BaseEquipData)[equipInfo.id]
      presetData = (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[presetId]]
      str = str .. (PUtil.get)(60000580, presetData.schemeName, config.name)
    end
  end
  if #equips == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000070))
    return 
  end
  local decompose = function(...)
    -- function num : 0_23_0 , upvalues : _ENV, equips
    if (_G.next)(EquiptData.AdvanceEquiptToDecompose) ~= nil then
      (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000078), function(...)
      -- function num : 0_23_0_0 , upvalues : _ENV, equips
      (EquiptMgr.PreAutoDeletePreset)(equips, 60000587, function(...)
        -- function num : 0_23_0_0_0 , upvalues : _ENV, equips
        (EquiptService.ReqDestroyEquip)(equips)
      end
)
    end
, nil, (PUtil.get)(60000079))
    else
      ;
      (EquiptMgr.PreAutoDeletePreset)(equips, 60000587, function(...)
      -- function num : 0_23_0_1 , upvalues : _ENV, equips
      (EquiptService.ReqDestroyEquip)(equips)
    end
)
    end
  end

  if (Util.StringIsNullOrEmpty)(str) then
    decompose()
  else
    str = str .. (PUtil.get)(60000582)
    ;
    (MessageMgr.OpenConfirmWindow)(str, function(...)
    -- function num : 0_23_1 , upvalues : decompose
    decompose()
  end
)
  end
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetAllEquipToIdentifyOrNot = function(identify, ...)
  -- function num : 0_24 , upvalues : _ENV
  if identify then
    local equipments = ((EquiptData.Filters)[EquiptSetType.Identify]).Result
    local count = #equipments
    local config, equipInfo = nil, nil
    for i = 1, count do
      equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[equipments[i]]]
      if (EquiptData.ReadyToIdentify)[equipments[i]] == nil then
        (EquiptMgr.HandleEquipmentToIdentify)(equipInfo, true, true)
      end
    end
    do
      if not (EquiptMgr.CheckIdentifyEquipmentsFull)() then
        do
          UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_TO_IDENTIFY)
          ;
          (EquiptMgr.ResetIdentifyData)()
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.TryIdentifyEquips = function(...)
  -- function num : 0_25 , upvalues : _ENV
  if EquiptData.Identifying then
    return 
  end
  local count = #EquiptData.ReadyToIdentify
  if count == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000324))
    return 
  end
  local costStr = ""
  for k,v in pairs(EquiptData.IdentifyCost) do
    costStr = costStr .. v.Type .. ":" .. k .. ":" .. v.Value .. ","
  end
  costStr = (string.sub)(costStr, 1, -2)
  if not (Util.CheckCostResources)(costStr) then
    return 
  end
  local equipments = {}
  for i = 1, count do
    (table.insert)(equipments, ((EquiptData.ReadyToIdentify)[i]).objectIndex)
  end
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R3 in 'UnsetPending'

  EquiptData.Identifying = true
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_25_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    EquiptData.Identifying = false
  end
)
  ;
  (EquiptService.ReqIdentifyEquip)(equipments)
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.RecvIdentifyEquips = function(equipmentList, ...)
  -- function num : 0_26 , upvalues : _ENV
  (LuaSound.PlaySound)(LuaSound.EQUIP_IDENTIFY, SoundBank.OTHER)
  ;
  (EquiptMgr.ResetIdentifyData)()
  local data = nil
  local count = #equipmentList
  for i = 1, count do
    data = equipmentList[i]
    data.SortedAttr = (EquiptData.GetSortedAttrs)(data)
    ;
    (table.sort)(data.randomBuff, function(x, y, ...)
    -- function num : 0_26_0
    do return x < y end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (EquiptData.NewEquipments)[data.objectIndex] = true
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (EquiptData.Equipments)[(EquiptData.Equipments)[data.objectIndex]] = data
    ;
    (EquiptData.HandelAvailablePartsData)(data.objectIndex, data.id, true)
    ;
    (EquiptData.HandleEquiptObjectIndexData)(EquiptData.AvailableEquipmentsInBag, data.objectIndex, true)
    ;
    (EquiptData.HandleEquiptObjectIndexData)(EquiptData.UnidentifiedEquipments, data.objectIndex, false)
  end
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Identify)
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_PLAY_IDENTIFY_EFFECT, function(...)
    -- function num : 0_26_1 , upvalues : _ENV
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG)
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_ALL_CHOOSE_BTN)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

    EquiptData.Identifying = false
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(60000337))
  end
)
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ResetIdentifyData = function(...)
  -- function num : 0_27 , upvalues : _ENV
  (EquiptData.ResetIdentifyCost)()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ReadyToIdentify = {}
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.GetDetailPanel = function(...)
  -- function num : 0_28 , upvalues : _detailPanelPool, _ENV
  local panelGrp = nil
  if #_detailPanelPool == 0 then
    local panel = (UIPackage.CreateObject)("Equipt", "EquiptPop")
    panelGrp = GetEquipt_EquiptPopUis(panel)
    panelGrp.PopImage = (panelGrp.root):GetChild("n33")
  else
    do
      panelGrp = (table.remove)(_detailPanelPool, #_detailPanelPool)
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (panelGrp.root).visible = true
      return panelGrp
    end
  end
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.RecyclePanel = function(panel, ...)
  -- function num : 0_29 , upvalues : _ENV, _detailPanelPool
  if panel == nil then
    return 
  end
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (panel.root).visible = false
  ;
  (table.insert)(_detailPanelPool, panel)
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetEquipDetailPanel = function(panel, equipInfo, equipConfig, type, cardID, srcEquipInfo, isPreset, ...)
  -- function num : 0_30 , upvalues : _ENV
  if equipInfo == nil then
    return 
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

  if EquiptData.EquipPanelBottomBlankSize == 0 then
    EquiptData.EquipPanelBottomBlankSize = (panel.root).height - (panel.ReplaceBtn).y - (panel.ReplaceBtn).height * 0.5
  end
  if equipConfig == nil then
    equipConfig = ((TableData.gTable).BaseEquipData)[equipInfo.id]
  end
  ;
  (EquiptMgr.SetDetailBasicInfo)(panel, equipInfo, equipConfig, cardID, isPreset)
  local bottomGComponent, percent = (EquiptMgr.SetDetailStatue)(equipInfo, panel, type)
  ;
  (EquiptMgr.SetAttrs)(panel, equipInfo, srcEquipInfo, cardID)
  ;
  (EquiptMgr.CheckPopListSize)(panel, bottomGComponent, percent)
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.CheckPopListSize = function(panel, bottomGComponent, percent, ...)
  -- function num : 0_31 , upvalues : _ENV
  local size = bottomGComponent.y + bottomGComponent.height * percent + EquiptData.EquipPanelBottomBlankSize
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  if EquiptData.MAX_EQUIP_PANEL_SIZE < size then
    (panel.PopList).height = (panel.PopList).height - (size - EquiptData.MAX_EQUIP_PANEL_SIZE)
  end
  if EquiptData.MAX_EQUIP_PANEL_SIZE < size then
    size = EquiptData.MAX_EQUIP_PANEL_SIZE
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (panel.PopImage).height = size
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetPanelSize = function(panel, bottomGComponent, ...)
  -- function num : 0_32 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  (panel.PopImage).height = bottomGComponent.y + bottomGComponent.height + EquiptData.EquipPanelBottomBlankSize
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetDetailBasicInfo = function(panel, equipInfo, equipConfig, cardID, isPreset, ...)
  -- function num : 0_33 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

  (panel.NameTxt).text = equipConfig.name
  ;
  (Util.SetEquipFrame)((panel.EquiptIcon).root, equipInfo)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  if equipConfig.card_id > 1 then
    (panel.ExclusiveTxt).text = (((TableData.gTable).BaseCardData)[equipConfig.card_id]).name .. (PUtil.get)(60000061)
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (panel.ExclusiveTxt).text = ""
  end
  -- DECOMPILER ERROR at PC40: Unhandled construct in 'MakeBoolean' P1

  if isPreset and (EquiptData.EquipBelongTo)[equipInfo.objectIndex] ~= nil then
    local presetId = (EquiptData.EquipBelongTo)[equipInfo.objectIndex]
    if (EquiptData.PresetBelongTo)[presetId] == nil then
      cardID = 0
    end
  else
    do
      cardID = 0
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (panel.LockBtn).selected = equipInfo.lock
      ;
      ((panel.LockBtn).onClick):Set(function(...)
    -- function num : 0_33_0 , upvalues : _ENV, equipInfo, cardID, panel
    (EquiptService.ReqLockEquip)(equipInfo.objectIndex, cardID, (panel.LockBtn).selected)
  end
)
    end
  end
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetDetailStatue = function(equipInfo, panel, type, ...)
  -- function num : 0_34 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  if equipInfo.identify == false or type == EquiptDetailPanelType.NoButton then
    (panel.ReplaceBtn).visible = false
    return panel.PopList, 1
  else
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (panel.ReplaceBtn).visible = true
    return panel.ReplaceBtn, 0.5
  end
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetAttrs = function(panel, equipInfo, srcEquipInfo, cardId, ...)
  -- function num : 0_35 , upvalues : _ENV
  (panel.PopList):RemoveChildrenToPool()
  local height = ((panel.PopList).margin).top
  if equipInfo.identify then
    height = height + (EquiptMgr.SetDetailAttrs)(panel.PopList, equipInfo, srcEquipInfo)
    height = height + (EquiptMgr.SetSuitBuffAttrs)(panel.PopList, equipInfo, cardId)
    height = height + (EquiptMgr.SetBuffAttrs)(panel.PopList, equipInfo)
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (panel.PopList).height = height
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetDetailAttrs = function(list, equipInfo, srcEquipInfo, ...)
  -- function num : 0_36 , upvalues : _ENV
  local attrInfo = {}
  local height = 0
  if srcEquipInfo ~= nil then
    local equipAttr = (EquiptMgr.GetEquipmentAttrs)(equipInfo)
    local srcEquipAttr = (EquiptMgr.GetEquipmentAttrs)(srcEquipInfo)
    for k,v in pairs(equipAttr) do
      if srcEquipAttr[k] == nil then
        attrInfo[k] = EquiptAttrStatusType.New
      else
        if srcEquipAttr[k] < v then
          attrInfo[k] = EquiptAttrStatusType.Promote
        else
          if v < srcEquipAttr[k] then
            attrInfo[k] = EquiptAttrStatusType.Demote
          end
        end
      end
    end
  end
  do
    local datas = {}
    local item, config, itemSize, attrs, attrId = nil, nil, nil, nil, nil
    if equipInfo.mainAttrId ~= 0 then
      height = (EquiptMgr.AddSeperater)(list, 60000445) + list.lineGap
      height = height + (EquiptMgr.AddSingleAttr)(list, equipInfo.mainAttrId, attrInfo)
    end
    local count = #equipInfo.randomAttrId
    for i = 1, count do
      (table.insert)(datas, (equipInfo.randomAttrId)[i])
    end
    ;
    (table.sort)(datas, EquiptData.SortEquiptAttr)
    local count = #datas
    for i = 1, count do
      height = height + list.lineGap
      if i == 1 then
        height = height + (EquiptMgr.AddSeperater)(list, 60000446) + list.lineGap
      end
      height = height + (EquiptMgr.AddSingleAttr)(list, datas[i], attrInfo)
    end
    return height
  end
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AddSeperater = function(list, content, resources, ...)
  -- function num : 0_37 , upvalues : _ENV
  if not resources then
    resources = EquiptData.LINE_A_RESOURCE
  end
  local seperater = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, resources))
  ;
  (seperater:GetChild("NameTxt")).text = (PUtil.get)(content)
  return seperater.height
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.GetEquipmentAttrs = function(equipInfo, ...)
  -- function num : 0_38 , upvalues : _ENV
  local result = {}
  local config, attrs = nil, nil
  if equipInfo.mainAttrId ~= 0 then
    config = ((TableData.gTable).BaseEquipAttributeData)[equipInfo.mainAttrId]
    attrs = split(config.value, ":")
    result[tonumber(attrs[2])] = tonumber(attrs[3])
  end
  local count = #equipInfo.randomAttrId
  for i = 1, count do
    config = ((TableData.gTable).BaseEquipAttributeData)[(equipInfo.randomAttrId)[i]]
    attrs = split(config.value, ":")
    if result[tonumber(attrs[2])] == nil then
      result[tonumber(attrs[2])] = tonumber(attrs[3])
    else
      result[tonumber(attrs[2])] = result[tonumber(attrs[2])] + tonumber(attrs[3])
    end
  end
  return result
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AddSingleAttr = function(list, equipAttrId, attrInfo, ...)
  -- function num : 0_39 , upvalues : _ENV
  local item, config, attrs, attrId = nil, nil, nil, nil
  config = ((TableData.gTable).BaseEquipAttributeData)[equipAttrId]
  attrs = split(config.value, ":")
  attrId = tonumber(attrs[2])
  local item = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.LIST_A_RESOURCE))
  ;
  (item:GetController("c1")).selectedIndex = EquiptData.MAX_ATTR_QUALITY_AMOUNT - config.level
  if status == nil then
    (item:GetController("c2")).selectedIndex = EquiptAttrStatusType.Normal
  else
    ;
    (item:GetController("c2")).selectedIndex = attrInfo[attrId]
  end
  local attrConfig = ((TableData.gTable).BaseAttributeData)[attrId]
  if attrConfig.type ~= 0 then
    (item:GetChild("NameTxt")).text = "[color=" .. EquiptAttrColor[attrConfig.type] .. "]" .. attrConfig.display_name .. "[/color]"
    ;
    (item:GetChild("NumberTxt")).text = "[color=" .. EquiptAttrColor[attrConfig.type] .. "]" .. attrs[3] .. "[/color]"
  else
    ;
    (item:GetChild("NameTxt")).text = attrConfig.display_name
    ;
    (item:GetChild("NumberTxt")).text = attrs[3]
  end
  return item.height
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetBuffAttrs = function(list, equipInfo, ...)
  -- function num : 0_40 , upvalues : _ENV
  local count = #equipInfo.randomBuff
  local item, config = nil, nil
  local height = 0
  for i = 1, count do
    height = height + list.lineGap
    if i == 1 then
      height = height + (EquiptMgr.AddSeperater)(list, 60000447) + list.lineGap
    end
    height = height + (EquiptMgr.AddSingleBuff)(list, (equipInfo.randomBuff)[i])
  end
  return height
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AddSingleBuff = function(list, id, ...)
  -- function num : 0_41 , upvalues : _ENV
  local item = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.LIST_B_RESOURCE))
  local config = ((TableData.gTable).BaseBuffPreBattleData)[id]
  ;
  (item:GetChild("WordTxt")).text = config.remark
  return item.height
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetSuitBuffAttrs = function(list, equipInfo, ...)
  -- function num : 0_42 , upvalues : _ENV
  local height = 0
  local suitId = (((TableData.gTable).BaseEquipData)[equipInfo.id]).setsId
  if suitId == nil or suitId == 0 then
    return height
  end
  local suitConfig = ((TableData.gTable).BaseEquipSetsData)[suitId]
  height = height + (EquiptMgr.AddSeperater)(list, suitConfig.name) + list.lineGap
  local suits = split(suitConfig.effect, ",")
  local count = #suits
  local buffs = {}
  local suitType = nil
  for i = 1, count do
    local buffId = tonumber((split(suits[i], ":"))[2])
    local buffType = tonumber((split(suits[i], ":"))[1])
    if buffType == 1 then
      buffs[i] = buffId
    else
      buffs[i] = 0
    end
  end
  local lowerId = (EquiptMgr.JudgeHaveLowerBuff)(buffs, nil)
  local constructEquipSet = (EquiptData.CurrentRoleData).equipSet
  for k,v in ipairs(lowerId) do
    (table.insert)(constructEquipSet, v)
  end
  for i = 1, count do
    suitType = tonumber((split(suits[i], ":"))[1])
    if suitType ~= 0 then
      height = height + (EquiptMgr.AddSuitBuff)(list, buffs[i], constructEquipSet)
    end
  end
  return height
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.JudgeHaveLowerBuff = function(buffs, cardEquipSet, ...)
  -- function num : 0_43 , upvalues : _ENV
  local buffList = nil
  if cardEquipSet ~= nil then
    buffList = cardEquipSet
  else
    buffList = (EquiptData.CurrentRoleData).equipSet
  end
  local index = 0
  local lowerId = {}
  for k,v in ipairs(buffList) do
    for a,b in ipairs(buffs) do
      if v ~= 0 and v == b then
        index = a
        break
      end
    end
  end
  for k,v in ipairs(buffs) do
    if v ~= 0 and k < index then
      local have = false
      for a,b in ipairs(buffList) do
        if b == v then
          have = true
        end
      end
      if have == false then
        (table.insert)(lowerId, v)
      end
    end
  end
  return lowerId
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AddSuitBuff = function(list, buffId, constructEquipSet, ...)
  -- function num : 0_44 , upvalues : _ENV
  local item = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.LIST_B_RESOURCE))
  local buffPreConfig = ((TableData.gTable).BaseBuffPreBattleData)[buffId]
  local setsId = buffPreConfig.setsId
  local suitConfig = ((TableData.gTable).BaseEquipSetsData)[setsId]
  if constructEquipSet ~= nil then
    local count = #constructEquipSet
    ;
    (item:GetChild("WordTxt")).text = "[color=" .. Const.BlueGrayColor .. "]" .. buffPreConfig.remark .. "[/color]"
    for i = 1, count do
      if buffId == constructEquipSet[i] then
        (item:GetChild("WordTxt")).text = "[color=" .. Const.GreenColor .. "]" .. buffPreConfig.remark .. "[/color]"
      end
    end
  else
    do
      ;
      (item:GetChild("WordTxt")).text = "[color=" .. Const.BlueGrayColor .. "]" .. buffPreConfig.remark .. "[/color]"
      return item.height
    end
  end
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.TryUpgradeEquipment = function(equipInfo, cardId, expCost, coinCost, ...)
  -- function num : 0_45 , upvalues : _ENV
  if (Util.CheckAssetByType)(coinCost, AssetType.GOLD) == false then
    return 
  end
  if (Util.CheckAssetByType)(expCost, AssetType.EQUIP_EXP) == false then
    return 
  end
  ;
  (EquiptService.ReqLevelUpEquip)(equipInfo.objectIndex, cardId, 1)
end

-- DECOMPILER ERROR at PC143: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.TryFullyUpgradeEquipment = function(equipInfo, equipConfig, cardId, ...)
  -- function num : 0_46 , upvalues : _ENV
  local maxLevel = ((EquiptData.UpgradeConfig)[equipConfig.grow_type]).MaxLevel
  local coinCost = 0
  local expCost = 0
  local cost = nil
  for i = equipInfo.level, maxLevel do
    cost = ((EquiptData.UpgradeConfig)[equipConfig.grow_type])[i]
    coinCost = coinCost + cost.next_gold
    expCost = expCost + cost.next_exp
  end
  if (Util.CheckAssetByType)(coinCost, AssetType.GOLD) == false then
    return 
  end
  if (Util.CheckAssetByType)(expCost, AssetType.EQUIP_EXP) == false then
    return 
  end
  local times = maxLevel - equipInfo.level
  ;
  (EquiptService.ReqLevelUpEquip)(equipInfo.objectIndex, cardId, times)
end

-- DECOMPILER ERROR at PC146: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.CheckShowEquipBagConfirm = function(acquireType, callback, ...)
  -- function num : 0_47 , upvalues : _ENV
  local args = {...}
  local rewards = {}
  local rewardsInfo, eachReward, count, config = nil, nil, nil, nil
  local haveEquips = false
  if args[1] ~= nil and args[1] == true then
    haveEquips = true
  else
    for k,v in pairs(args) do
      if type(v) == "table" then
        for subk,subv in pairs(v) do
          subv.RewardType = 1
          ;
          (table.insert)(rewards, subv)
        end
      else
        do
          rewardsInfo = split(v, ",")
          count = #rewardsInfo
          for i = 1, count do
            eachReward = split(rewardsInfo[i], ":")
            -- DECOMPILER ERROR at PC70: Unhandled construct in 'MakeBoolean' P1

            if #eachReward == 3 and tonumber(eachReward[1]) == PropType.EQUIP then
              (table.insert)(rewards, {RewardType = 1, Id = tonumber(eachReward[2])})
            end
            -- DECOMPILER ERROR at PC91: Unhandled construct in 'MakeBoolean' P1

            if #eachReward == 2 and tonumber(eachReward[1]) == PropType.EQUIP then
              (table.insert)(rewards, {RewardType = 1, Id = tonumber(eachReward[2])})
            end
            if #eachReward == 1 then
              (table.insert)(rewards, {RewardType = 2, GroupId = tonumber(eachReward[1])})
            end
          end
          do
            -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    count = #rewards
    for i = 1, count do
      -- DECOMPILER ERROR at PC126: Unhandled construct in 'MakeBoolean' P1

      if (rewards[i]).RewardType == 1 and ((TableData.gTable).BaseEquipData)[(rewards[i]).Id] ~= nil then
        haveEquips = true
        break
      end
      if (rewards[i]).RewardType == 2 then
        config = ((TableData.gTable).BaseDropGroupData)[(rewards[i]).GroupId]
        if config ~= nil and config.equips ~= "0" then
          haveEquips = true
          break
        end
      end
    end
  end
  do
    if haveEquips or haveEquips then
      if EquiptData.MaxBagSlots <= #EquiptData.Equipments then
        if acquireType == EquiptAcquireType.Shop then
          (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000345), function(...)
    -- function num : 0_47_0 , upvalues : _ENV
    (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Decompose)
  end
)
        else
          if acquireType == EquiptAcquireType.Gift then
            (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000346), function(...)
    -- function num : 0_47_1 , upvalues : _ENV
    (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Decompose)
  end
)
          else
            if acquireType == EquiptAcquireType.Lottory then
              (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000347), function(...)
    -- function num : 0_47_2 , upvalues : _ENV
    (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Decompose)
  end
)
            else
              ;
              (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000077), function(...)
    -- function num : 0_47_3 , upvalues : _ENV
    (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Decompose)
  end
, callback, (PUtil.get)(60000003), (PUtil.get)(60000072), (PUtil.get)(60000008))
            end
          end
        end
        return true
      else
        if callback ~= nil then
          callback()
        end
        return false
      end
    else
      if callback ~= nil then
        callback()
      end
      return false
    end
  end
end

-- DECOMPILER ERROR at PC149: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.PreAutoDeletePreset = function(equipts, wordsId, cb, dstPresetId, ...)
  -- function num : 0_48 , upvalues : _ENV
  local equiptments = nil
  if equipts.equipIndex ~= nil then
    equiptments = equipts.equipIndex
  else
    equiptments = equipts
  end
  local count = #equiptments
  local equiptId, presetId, presetData = nil, nil, nil
  for i = 1, count do
    equiptId = equiptments[i]
    if (EquiptData.EquipBelongTo)[equiptId] ~= nil then
      presetId = (EquiptData.EquipBelongTo)[equiptId]
      if (not dstPresetId or presetId ~= dstPresetId) and (EquiptData.EquipPresetsIndex)[presetId] ~= nil then
        presetData = (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[presetId]]
        if #presetData.equipIndex == 1 then
          (MessageMgr.OpenConfirmWindow)((PUtil.get)(wordsId, presetData.schemeName), function(...)
    -- function num : 0_48_0 , upvalues : cb
    cb()
  end
)
          return 
        end
      end
    end
  end
  cb()
end

-- DECOMPILER ERROR at PC152: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.TryChangeEquipment = function(id, cardInfo, equipType, ...)
  -- function num : 0_49 , upvalues : _ENV
  (EquiptMgr.PreAutoDeletePreset)({id}, 60000589, function(...)
    -- function num : 0_49_0 , upvalues : _ENV, id, cardInfo
    (EquiptService.ReqPutOnEquip)(id, 0, cardInfo.id)
  end
, cardInfo.equipScheme)
end

-- DECOMPILER ERROR at PC155: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.InitEquiptMainRedDot = function(...)
  -- function num : 0_50 , upvalues : _ENV
  local data, show = (EquiptData.GetRedDotList)()
  if show then
    (RedDotMgr.ProcessRedDot)(RedDotComID.Equipt_Role_List, data, true)
  else
    ;
    (RedDotMgr.ProcessRedDot)(RedDotComID.Equipt_Role_List, data, false)
  end
end

-- DECOMPILER ERROR at PC158: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.RecvEquipPreset = function(msg, ...)
  -- function num : 0_51 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  if EquiptData.ReInitialize then
    EquiptData.ReInitialize = false
    ;
    (EquiptData.InitEquipPresetData)(msg.equipScheme)
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_PRESET_AFTER_OPREATE)
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

    EquiptData.PresetInitialized = true
    ;
    (EquiptData.InitEquipPresetData)(msg.equipScheme)
  end
end

-- DECOMPILER ERROR at PC161: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ChangeFilterSortTypeForPreset = function(...)
  -- function num : 0_52 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if (EquiptData.PresetEditEquipments).SortType == EquiptSortType.Increase then
    (EquiptData.PresetEditEquipments).SortType = EquiptSortType.Decrease
  else
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (EquiptData.PresetEditEquipments).SortType = EquiptSortType.Increase
  end
  ;
  (EquiptData.SortPresetEquipments)()
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG)
end

-- DECOMPILER ERROR at PC164: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.UsePreset = function(presetId, ...)
  -- function num : 0_53 , upvalues : _ENV
  if (EquiptData.PresetBelongTo)[presetId] ~= nil and (EquiptData.PresetBelongTo)[presetId] ~= (EquiptData.CurrentRoleData).id then
    local other = (CardData.GetCardData)((EquiptData.PresetBelongTo)[presetId])
    ;
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000590, other.name), function(...)
    -- function num : 0_53_0 , upvalues : _ENV, presetId
    (EquiptService.ReqUseEquipScheme)(presetId, (EquiptData.CurrentRoleData).id)
  end
)
  else
    do
      ;
      (EquiptService.ReqUseEquipScheme)(presetId, (EquiptData.CurrentRoleData).id)
    end
  end
end

-- DECOMPILER ERROR at PC167: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.RecvUsePreset = function(msg, ...)
  -- function num : 0_54 , upvalues : _ENV
  if not msg.success then
    loge("ReqUseEquipScheme failed")
    return 
  end
  local roleInfo = (CardData.GetCardData)(msg.cardId)
  local presetData = (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[msg.id]]
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  if roleInfo.equipScheme ~= 0 and roleInfo.equipScheme ~= nil then
    (EquiptData.PresetBelongTo)[roleInfo.equipScheme] = nil
  end
  if (EquiptData.PresetBelongTo)[msg.id] ~= nil then
    local originRole = (CardData.GetCardData)((EquiptData.PresetBelongTo)[msg.id])
    local count = #presetData.equipIndex
    for i = 1, count do
      (EquiptMgr.PutOffEquipment)(originRole, (presetData.equipIndex)[i])
    end
    originRole.equipScheme = 0
    ;
    (EquiptData.UpdateCardSuitInfo)(originRole.id)
    ;
    (CardData.ResetCardData)(originRole)
    ;
    (EquiptMgr.RefrshBuffByEquipInfo)(originRole)
  end
  do
    local count = #roleInfo.equipInfo
    local equipInfo = (Util.Copy)(roleInfo.equipInfo)
    for i = 1, count do
      (EquiptMgr.PutOffEquipment)(roleInfo, (equipInfo[i]).objectIndex)
    end
    count = #presetData.equipIndex
    for i = 1, count do
      (EquiptMgr.PutOnEquipment)(roleInfo, (presetData.equipIndex)[i])
    end
    -- DECOMPILER ERROR at PC101: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (EquiptData.PresetBelongTo)[msg.id] = msg.cardId
    -- DECOMPILER ERROR at PC115: Confused about usage of register: R5 in 'UnsetPending'

    if roleInfo.equipScheme ~= 0 and roleInfo.equipScheme ~= nil then
      ((EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[roleInfo.equipScheme]]).cardId = 0
    end
    presetData.cardId = msg.cardId
    roleInfo.equipScheme = msg.id
    ;
    (EquiptMgr.RefrshBuffByEquipInfo)(roleInfo)
    ;
    (EquiptData.UpdateCardSuitInfo)(roleInfo.id)
    ;
    (CardData.ResetCardData)(roleInfo)
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_PRESET)
  end
end

-- DECOMPILER ERROR at PC170: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.DeletePreset = function(presetId, ...)
  -- function num : 0_55 , upvalues : _ENV
  (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000576, ((EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[presetId]]).schemeName), function(...)
    -- function num : 0_55_0 , upvalues : _ENV, presetId
    (EquiptService.ReqRemoveEquipScheme)(presetId)
  end
)
end

-- DECOMPILER ERROR at PC173: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.RecvDeletePreset = function(msg, ...)
  -- function num : 0_56 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  EquiptData.EditPreset = {}
  if msg.success then
    local presetData = (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[msg.id]]
    local count = #presetData.equipIndex
    for i = 1, count do
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

      (EquiptData.EquipBelongTo)[(presetData.equipIndex)[i]] = nil
    end
    do
      do
        if (EquiptData.PresetBelongTo)[msg.id] ~= nil then
          local cardData = (CardData.GetCardData)((EquiptData.PresetBelongTo)[msg.id])
          cardData.equipScheme = 0
          -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

          ;
          (EquiptData.PresetBelongTo)[msg.id] = nil
        end
        ;
        (EquiptData.UpdateEquipPreset)(msg, false)
        UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_PRESET_AFTER_OPREATE, true)
        loge("ReqRemoveEquipScheme failed")
      end
    end
  end
end

-- DECOMPILER ERROR at PC176: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ChangeEquiptInPresetEdit = function(remove, equiptInfo, oldEquipInfo, ...)
  -- function num : 0_57 , upvalues : _ENV
  if remove then
    local count = #(EquiptData.EditPreset).equipIndex
    for i = 1, count do
      if ((EquiptData.EditPreset).equipIndex)[i] == equiptInfo.objectIndex then
        (table.remove)((EquiptData.EditPreset).equipIndex, i)
        break
      end
    end
    do
      do
        ;
        (EquiptData.HandlePresetResult)(true, equiptInfo)
        if oldEquipInfo then
          local count = #(EquiptData.EditPreset).equipIndex
          for i = 1, count do
            if ((EquiptData.EditPreset).equipIndex)[i] == oldEquipInfo.objectIndex then
              (table.remove)((EquiptData.EditPreset).equipIndex, i)
              break
            end
          end
          do
            do
              ;
              (EquiptData.HandlePresetResult)(true, oldEquipInfo)
              -- DECOMPILER ERROR at PC72: Confused about usage of register: R3 in 'UnsetPending'

              if (EquiptData.EditPreset).equipIndex == nil then
                (EquiptData.EditPreset).equipIndex = {}
              end
              ;
              (table.insert)((EquiptData.EditPreset).equipIndex, equiptInfo.objectIndex)
              ;
              (EquiptData.HandlePresetResult)(false, equiptInfo)
              ;
              (EquiptData.ChangePresetEditFilter)()
              UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EDIT_PRESET)
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC179: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.UpdateEquipPreset = function(presetData, name, ...)
  -- function num : 0_58 , upvalues : _ENV
  local new = (Util.StringIsNullOrEmpty)(presetData.schemeName)
  if presetData.equipIndex == nil or #presetData.equipIndex == 0 then
    if new then
      (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000579), function(...)
    -- function num : 0_58_0 , upvalues : _ENV
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_CANCEL_EDIT_PRESET)
  end
)
    else
      ;
      (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000578), function(...)
    -- function num : 0_58_1 , upvalues : _ENV, presetData
    (EquiptService.ReqRemoveEquipScheme)(presetData.id)
  end
)
    end
  else
    local count = #presetData.equipIndex
    do
      local str = ""
      local originBelongTo, equipInfo, config, originPreset = nil, nil, nil, nil
      for i = 1, count do
        originBelongTo = (EquiptData.EquipBelongTo)[(presetData.equipIndex)[i]]
        if originBelongTo ~= nil and originBelongTo ~= presetData.id then
          equipInfo = ((EquiptData.PresetEditEquipments).EquipDetail)[(presetData.equipIndex)[i]]
          config = ((TableData.gTable).BaseEquipData)[equipInfo.id]
          originPreset = (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[originBelongTo]]
          str = str .. (PUtil.get)(60000580, originPreset.schemeName, config.name)
        end
      end
      local update = function(...)
    -- function num : 0_58_2 , upvalues : presetData, name, _ENV
    local nameChanged = presetData.schemeName ~= name
    presetData.schemeName = name
    local new = presetData.New
    presetData.New = nil
    if new then
      (EquiptService.ReqAddEquipScheme)(presetData, 0)
    else
      local oldEquipts = {}
      local oldPresetData = (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[presetData.id]]
      local oldEquiptCount = #oldPresetData.equipIndex
      local count = #presetData.equipIndex
      local same = true
      if count ~= oldEquiptCount then
        same = false
      else
        for i = 1, oldEquiptCount do
          oldEquipts[(oldPresetData.equipIndex)[i]] = true
        end
        for i = 1, count do
          oldEquipts[(presetData.equipIndex)[i]] = nil
        end
        if (_G.next)(oldEquipts) ~= nil then
          same = false
        end
      end
      if not same and nameChanged then
        (EquiptService.ReqAddEquipScheme)(presetData, 3)
      elseif nameChanged then
        (EquiptService.ReqAddEquipScheme)(presetData, 1)
      elseif not same then
        (EquiptService.ReqAddEquipScheme)(presetData, 2)
      else
        UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_CANCEL_EDIT_PRESET)
      end
    end
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
  end

      local prompt = function(...)
    -- function num : 0_58_3 , upvalues : presetData, _ENV, update
    if presetData.New and presetData.cardId ~= 0 then
      local oldEquipts = {}
      local card = (CardData.GetCardData)(presetData.cardId)
      local editEquiptCount = #card.equipInfo
      local count = #presetData.equipIndex
      local same = true
      if count ~= editEquiptCount then
        same = false
      else
        for i = 1, count do
          oldEquipts[((card.equipInfo)[i]).objectIndex] = true
        end
        for i = 1, editEquiptCount do
          oldEquipts[(presetData.equipIndex)[i]] = nil
        end
        if (_G.next)(oldEquipts) ~= nil then
          same = false
        end
      end
      if not same then
        (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000591, card.name), function(...)
      -- function num : 0_58_3_0 , upvalues : update
      update()
    end
)
      else
        update()
      end
    else
      do
        update()
      end
    end
  end

      local prompt2 = function(...)
    -- function num : 0_58_4 , upvalues : presetData, _ENV, prompt
    local count = #presetData.equipIndex
    local roles = {}
    local roleId = nil
    for i = 1, count do
      roleId = (EquiptData.NPEquipBelongToCard)[(presetData.equipIndex)[i]]
      if roleId and roleId ~= presetData.cardId then
        if roles[roleId] == nil then
          roles[roleId] = {}
        end
        ;
        (table.insert)(roles[roleId], (presetData.equipIndex)[i])
      end
    end
    if (_G.next)(roles) == nil then
      prompt()
    else
      local finalStr = ""
      local roleStr = ""
      local card, equip, count, config, equipStr = nil, nil, nil, nil, nil
      for k,v in pairs(roles) do
        equipStr = ""
        count = #v
        for i = 1, count do
          equip = ((EquiptData.PresetEditEquipments).EquipDetail)[v[i]]
          config = ((TableData.gTable).BaseEquipData)[equip.id]
          if i == 1 then
            equipStr = (PUtil.get)(60000594, config.name)
          else
            equipStr = equipStr .. "、" .. (PUtil.get)(60000594, config.name)
          end
        end
        card = (CardData.GetCardData)(k)
        roleStr = roleStr .. (PUtil.get)(60000593, card.name, equipStr)
      end
      finalStr = (PUtil.get)(60000592, roleStr)
      ;
      (MessageMgr.OpenConfirmWindow)(finalStr, function(...)
      -- function num : 0_58_4_0 , upvalues : prompt
      prompt()
    end
)
    end
  end

      if (Util.StringIsNullOrEmpty)(str) then
        prompt2()
      else
        str = str .. (PUtil.get)(60000581)
        ;
        (MessageMgr.OpenConfirmWindow)(str, function(...)
    -- function num : 0_58_5 , upvalues : _ENV, presetData, prompt2
    (EquiptMgr.PreAutoDeletePreset)(presetData, 60000588, function(...)
      -- function num : 0_58_5_0 , upvalues : prompt2
      prompt2()
    end
, presetData.id)
  end
)
      end
    end
  end
end

-- DECOMPILER ERROR at PC182: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.RecvUpdateEquipPreset = function(msg, ...)
  -- function num : 0_59 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  EquiptData.EditPreset = {}
  local presetData = msg.equipScheme
  local count = #presetData.equipIndex
  local equiptId, originBelongTo, roleInfo = nil, nil, nil
  local changedRoles = {}
  for i = 1, count do
    equiptId = (presetData.equipIndex)[i]
    originBelongTo = (EquiptData.EquipBelongTo)[equiptId]
    if originBelongTo ~= nil and originBelongTo ~= presetData.id then
      if (EquiptData.PresetBelongTo)[originBelongTo] ~= nil then
        roleInfo = (CardData.GetCardData)((EquiptData.PresetBelongTo)[originBelongTo])
        ;
        (EquiptMgr.PutOffEquipment)(roleInfo, equiptId)
        changedRoles[roleInfo] = true
      end
      ;
      (EquiptData.RemoveFromPreset)(equiptId, originBelongTo)
    else
      if (EquiptData.NPEquipBelongToCard)[equiptId] and (EquiptData.NPEquipBelongToCard)[equiptId] ~= presetData.cardId then
        roleInfo = (CardData.GetCardData)((EquiptData.NPEquipBelongToCard)[equiptId])
        ;
        (EquiptMgr.PutOffEquipment)(roleInfo, equiptId)
        changedRoles[roleInfo] = true
      end
    end
  end
  for k,v in pairs(changedRoles) do
    (EquiptData.UpdateCardSuitInfo)(k.id)
    ;
    (CardData.ResetCardData)(k)
  end
  if (EquiptData.EquipPresetsIndex)[presetData.id] ~= nil then
    local oldPresetData = (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[presetData.id]]
    local count = #oldPresetData.equipIndex
    local roleInfo, equipInfo = nil, nil
    local updateEquip = (EquiptData.PresetBelongTo)[presetData.id] ~= nil
    if updateEquip then
      roleInfo = (CardData.GetCardData)((EquiptData.PresetBelongTo)[presetData.id])
    end
    for i = 1, count do
      -- DECOMPILER ERROR at PC127: Confused about usage of register: R16 in 'UnsetPending'

      (EquiptData.EquipBelongTo)[(oldPresetData.equipIndex)[i]] = nil
      if updateEquip then
        (EquiptMgr.PutOffEquipment)(roleInfo, (oldPresetData.equipIndex)[i])
      end
    end
    count = #presetData.equipIndex
    for i = 1, count do
      -- DECOMPILER ERROR at PC148: Confused about usage of register: R16 in 'UnsetPending'

      (EquiptData.EquipBelongTo)[(presetData.equipIndex)[i]] = presetData.id
      if updateEquip then
        equipInfo = ((EquiptData.PresetEditEquipments).EquipDetail)[(presetData.equipIndex)[i]]
        ;
        (EquiptMgr.PutOnEquipment)(roleInfo, (presetData.equipIndex)[i], equipInfo)
      end
    end
    -- DECOMPILER ERROR at PC171: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[presetData.id]] = presetData
    if updateEquip then
      (EquiptData.UpdateCardSuitInfo)(roleInfo.id)
      ;
      (CardData.ResetCardData)(roleInfo)
    end
  else
    local count = #presetData.equipIndex
    for i = 1, count do
      -- DECOMPILER ERROR at PC194: Confused about usage of register: R12 in 'UnsetPending'

      (EquiptData.EquipBelongTo)[(presetData.equipIndex)[i]] = presetData.id
    end
    -- DECOMPILER ERROR at PC203: Confused about usage of register: R8 in 'UnsetPending'

    if presetData.cardId ~= 0 then
      (EquiptData.PresetBelongTo)[presetData.id] = presetData.cardId
      local roleInfo = (CardData.GetCardData)(presetData.cardId)
      roleInfo.equipScheme = presetData.id
      count = #roleInfo.equipInfo
      local equips = (Util.Copy)(roleInfo.equipInfo)
      for i = 1, count do
        (EquiptMgr.PutOffEquipment)(roleInfo, (equips[i]).objectIndex)
      end
      count = #presetData.equipIndex
      local equipInfo = nil
      for i = 1, count do
        equipInfo = ((EquiptData.PresetEditEquipments).EquipDetail)[(presetData.equipIndex)[i]]
        ;
        (EquiptMgr.PutOnEquipment)(roleInfo, (presetData.equipIndex)[i], equipInfo)
      end
      ;
      (EquiptData.UpdateCardSuitInfo)(roleInfo.id)
      ;
      (CardData.ResetCardData)(roleInfo)
    end
    ;
    (EquiptData.UpdateEquipPreset)(presetData, true)
  end
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_PRESET_AFTER_OPREATE)
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC185: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.CheckEditPresetChanged = function(name, ...)
  -- function num : 0_60 , upvalues : _ENV
  if (EquiptData.EditPreset).New then
    if (EquiptData.EditPreset).equipIndex == nil or #(EquiptData.EditPreset).equipIndex == 0 then
      return EquiptPresetEditStatus.EmptyNew
    else
      return EquiptPresetEditStatus.New
    end
  else
    local oldPresetData = (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[(EquiptData.EditPreset).id]]
    if oldPresetData == nil then
      return EquiptPresetEditStatus.Same
    end
    if name ~= oldPresetData.schemeName then
      return EquiptPresetEditStatus.Modified
    else
      local oldEquipts = {}
      local editEquiptCount = #(EquiptData.EditPreset).equipIndex
      local count = #oldPresetData.equipIndex
      if count ~= editEquiptCount then
        return EquiptPresetEditStatus.Modified
      else
        for i = 1, count do
          oldEquipts[(oldPresetData.equipIndex)[i]] = true
        end
        for i = 1, editEquiptCount do
          oldEquipts[((EquiptData.EditPreset).equipIndex)[i]] = nil
        end
        if (_G.next)(oldEquipts) ~= nil then
          return EquiptPresetEditStatus.Modified
        else
          return EquiptPresetEditStatus.Same
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC188: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.GetSuitBuff = function(equiptInfo, ...)
  -- function num : 0_61 , upvalues : _ENV
  local suitBuff = {}
  for k,v in pairs(equiptInfo) do
    local id = (((TableData.gTable).BaseEquipData)[v.id]).setsId
    if id ~= nil and id ~= 0 then
      if suitBuff[id] ~= nil then
        suitBuff[id] = suitBuff[id] + 1
      else
        suitBuff[id] = 1
      end
    end
  end
  return suitBuff
end

-- DECOMPILER ERROR at PC191: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.GetSuitPreBuffId = function(suitId, num, ...)
  -- function num : 0_62 , upvalues : _ENV
  local config = ((TableData.gTable).BaseEquipSetsData)[suitId]
  local buffs = split(config.effect, ",")
  local preBuffId = (split(buffs[num], ":"))[2]
  return tonumber(preBuffId)
end

-- DECOMPILER ERROR at PC194: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.GetSuitBuffByEquiptInfo = function(equipInfo, ...)
  -- function num : 0_63 , upvalues : _ENV
  if equipInfo == nil then
    return 
  end
  local equiptCpunt = #equipInfo
  local preBuff = {}
  local suitList = {}
  local showList = {}
  local typeList = {}
  local buffList = {}
  suitList = (EquiptMgr.GetSuitBuff)(equipInfo)
  for k,v in pairs(suitList) do
    local suitId = k
    local count = v
    local config = ((TableData.gTable).BaseEquipSetsData)[suitId]
    local suits = split(config.effect, ",")
    local suitsCount = #suits
    local lowId = 0
    for i = 1, suitsCount do
      local buffType = tonumber((split(suits[i], ":"))[1])
      local buffId = tonumber((split(suits[i], ":"))[2])
      if i == v then
        buffList[1] = buffId
        lowId = buffId
      end
      if buffType == 1 then
        preBuff[i] = buffId
      else
        preBuff[i] = 0
      end
    end
    local lowerIds = (EquiptMgr.FindLowerSuiBuff)(preBuff, buffList)
    ;
    (table.insert)(showList, lowerIds)
    typeList = {}
    preBuff = {}
    buffList = {}
  end
  return showList
end

-- DECOMPILER ERROR at PC197: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.FindLowerSuiBuff = function(preBuff, buffList, ...)
  -- function num : 0_64 , upvalues : _ENV
  local lowerId = (EquiptMgr.JudgeHaveLowerBuff)(preBuff, buffList)
  local lowerIdCount = #lowerId
  for k,v in ipairs(lowerId) do
    (table.insert)(buffList, v)
  end
  if lowerIdCount ~= 0 then
    (table.sort)(buffList, function(a, b, ...)
    -- function num : 0_64_0 , upvalues : _ENV
    local aC = ((TableData.gTable).BaseBuffPreBattleData)[a]
    local bC = ((TableData.gTable).BaseBuffPreBattleData)[b]
    if b >= a then
      do return bC.sortId >= aC.sortId end
      do return a < b end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  end
  return buffList
end

-- DECOMPILER ERROR at PC200: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.RefrshBuffByEquipInfo = function(roleData, ...)
  -- function num : 0_65 , upvalues : _ENV
  local equipInfo = roleData.equipInfo
  local equipSetBuff = {}
  local suitBuff = {}
  suitBuff = (EquiptMgr.GetSuitBuff)(equipInfo)
  for k,v in pairs(suitBuff) do
    local equipConfig = ((TableData.gTable).BaseEquipSetsData)[k]
    local suits = split(equipConfig.effect, ",")
    local count = #suits
    local preBuffId = 0
    for i = v, 1, -1 do
      local buffId = tonumber((split(suits[i], ":"))[2])
      local buffType = tonumber((split(suits[i], ":"))[1])
      if buffType ~= 0 then
        preBuffId = buffId
        break
      end
    end
    do
      do
        if preBuffId ~= 0 then
          (table.insert)(equipSetBuff, preBuffId)
        end
        -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  roleData.equipSet = equipSetBuff
end


