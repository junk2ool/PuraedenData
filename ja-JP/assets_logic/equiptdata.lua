-- params : ...
-- function num : 0 , upvalues : _ENV
EquiptData = {}
EquiptDetailPanelType = {NoButton = 1, Change = 2, Disarm = 3, Equip = 4}
EquiptOpenType = {Normal = 1, Identify = 2, SpecifyEquipment = 3, Decompose = 4, ChangeRoldEquipts = 5}
EquiptAcquireType = {Default = 0, Tower = 1, Dungeon = 2, Shop = 3, Gift = 4, Lottory = 5}
EquiptAttrStatusType = {Normal = 0, New = 1, Demote = 2, Promote = 3}
EquiptPresetEditStatus = {Same = 0, New = 1, Modified = 2, EmptyNew = 3}
if Const then
  EquiptAttrColor = {Const.RedEquipmentColor, Const.BlueEquipmentColor, Const.GreenEquipmentColor, Const.YellowEquipmentColor, Const.LightBlueEquipmentColor, Const.LightGrayEquipmentColor}
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.MAX_EQUIP_PANEL_SIZE = 610
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.DEFAULT_MAX_BAG_SLOTS = 72000005
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EQUIPMENT_INTELLIGENCE_LIMIT = 72000011
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EQUIPMENT_BUFF_TYPE_NAME = 72000012
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.MAX_IDENTIFY_AMOUNT = 72000015
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.MAX_PRESET_AMOUNT = 72010071
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.MAX_PRESET_NAME_LENGTH = 72010072
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.LINE_A_RESOURCE = "EquiptPopLine_A"
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.LIST_A_RESOURCE = "EquiptPopAttribute_A"
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.LIST_B_RESOURCE = "EquiptPopAttribute_B"
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EQUIPMENT_TYPE_FILTER_RESOURCE = "EquiptTips"
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EQUIPMENT_INTELLIGENCE_FILTER_RESOURCE = "EquiptStage"
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EQUIPMENT_PARTS_FILTER_RESOURCE = "EquiptPosition"
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EQUIPMENT_FILTER_RESOURCE = "EquiptAttribute"
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EQUIPMENT_ATTRIBUTE_RESOURCE = "AttributeTipsLIst"
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EQUIPMENT_BUFF_DETAIL_RESOURCE = "EquiptDetailedBuff"
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EQUIPMENT_DETAIL_LINE_A_RESOURCE = "EquiptDetailedLine_A"
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PRESET_LINE_A = "Edit_A"
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PRESET_INFO_A = "Info_A"
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PRESET_INFO_B = "Info_B"
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PRESET_ATTR_A = "Edit_C"
  -- DECOMPILER ERROR at PC96: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PRESET_ATTR_B = "Info_D"
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PRESET_BUFF_A = "Edit_B"
  -- DECOMPILER ERROR at PC107: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.MaxBagSlots = (((TableData.gTable).BaseFixedData)[EquiptData.DEFAULT_MAX_BAG_SLOTS]).int_value
  -- DECOMPILER ERROR at PC109: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EQUIPMENT_TYPE_COUNT = 4
  -- DECOMPILER ERROR at PC111: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.MAX_ATTR_QUALITY_AMOUNT = 8
  -- DECOMPILER ERROR at PC113: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.MAX_ATTRIBUTE_AMOUNT = 8
  -- DECOMPILER ERROR at PC115: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipPanelBottomBlankSize = 0
  -- DECOMPILER ERROR at PC117: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.CurrentRoleData = nil
  -- DECOMPILER ERROR at PC120: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.AvailableParts = {}
  -- DECOMPILER ERROR at PC123: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.Equipments = {}
  -- DECOMPILER ERROR at PC126: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipmentsToDecompose = {}
  -- DECOMPILER ERROR at PC129: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.AvailableEquipmentsInBag = {}
  -- DECOMPILER ERROR at PC132: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.UnidentifiedEquipments = {}
  -- DECOMPILER ERROR at PC134: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.Identifying = false
  -- DECOMPILER ERROR at PC137: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PresetEditEquipments = {}
  EquiptSortType = {Increase = 1, Decrease = 2}
  EquiptType = {Normal = 0, Activity = 2, Privilege = 1}
  EquiptPartsType = {Weapon = 1, Chest = 2, Ring = 3, Necklace = 4, All = 5}
  EquiptEnhanceType = {Fixed = 1, Percent = 2}
  EquiptSetType = {Change = 1, Decompose = 2, Identify = 3, Preset = 4}
  EquiptFilterType = {Type = 1, SinglePart = 2, MultiplyParts = 3, Intelligence = 4, Attributes = 5, Buff = 6, AttributeAmount = 7, Privilege = 8}
  -- DECOMPILER ERROR at PC237: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipmentSetContainFilter = {
[EquiptSetType.Change] = {[1] = EquiptFilterType.Type, [2] = EquiptFilterType.SinglePart, [3] = EquiptFilterType.Intelligence, [4] = EquiptFilterType.Attributes, [5] = EquiptFilterType.Buff, [6] = EquiptFilterType.AttributeAmount, [7] = EquiptFilterType.Privilege}
, 
[EquiptSetType.Decompose] = {[1] = EquiptFilterType.Type, [2] = EquiptFilterType.MultiplyParts, [3] = EquiptFilterType.Intelligence, [4] = EquiptFilterType.Attributes, [5] = EquiptFilterType.Buff, [6] = EquiptFilterType.AttributeAmount}
, 
[EquiptSetType.Identify] = {[1] = EquiptFilterType.SinglePart}
, 
[EquiptSetType.Preset] = {[1] = EquiptFilterType.SinglePart}
}
  -- DECOMPILER ERROR at PC240: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.Filters = {}
  -- DECOMPILER ERROR at PC243: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ReadyToDecompose = {}
  -- DECOMPILER ERROR at PC246: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.AdvanceEquiptToDecompose = {}
  -- DECOMPILER ERROR at PC249: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ReadyToIdentify = {}
  -- DECOMPILER ERROR at PC252: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.IdentifyCost = {}
  -- DECOMPILER ERROR at PC255: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.UpgradeConfig = {}
  -- DECOMPILER ERROR at PC258: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.SuitInfo = {}
  -- DECOMPILER ERROR at PC261: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ChosedMainType = {}
  -- DECOMPILER ERROR at PC264: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.CurrentMainAttr = {}
  -- DECOMPILER ERROR at PC267: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GroupSuitInfo = {}
  -- DECOMPILER ERROR at PC269: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.MaxIntelligence = 0
  -- DECOMPILER ERROR at PC272: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.Attributes = {}
  -- DECOMPILER ERROR at PC275: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.Buffs = {}
  -- DECOMPILER ERROR at PC278: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.NewEquipments = {}
  -- DECOMPILER ERROR at PC280: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PresetInitialized = false
  -- DECOMPILER ERROR at PC282: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ReInitialize = false
  -- DECOMPILER ERROR at PC285: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipBelongTo = {}
  -- DECOMPILER ERROR at PC288: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PresetBelongTo = {}
  -- DECOMPILER ERROR at PC291: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.NPEquipBelongToCard = {}
  -- DECOMPILER ERROR at PC294: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipPresetsIndex = {}
  -- DECOMPILER ERROR at PC297: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipPresets = {}
  -- DECOMPILER ERROR at PC300: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EditPreset = {}
  -- DECOMPILER ERROR at PC303: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitConfig = function(...)
  -- function num : 0_0 , upvalues : _ENV
  if (_G.next)(EquiptData.GroupSuitInfo) ~= nil or IsBattleServer == true then
    return 
  end
  ;
  (EquiptData.InitLevelUpConfig)()
  ;
  (EquiptData.InitPartMayContainAttrConfig)()
  ;
  (EquiptData.InitGroupSuitInfo)()
end

  -- DECOMPILER ERROR at PC306: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitLevelUpConfig = function(...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.UpgradeConfig = {}
  for k,v in pairs((TableData.gTable).BaseEquipLevelUpData) do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

    if (EquiptData.UpgradeConfig)[v.type] == nil then
      (EquiptData.UpgradeConfig)[v.type] = {MaxLevel = 0}
    end
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((EquiptData.UpgradeConfig)[v.type])[v.level] = v
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

    if ((EquiptData.UpgradeConfig)[v.type]).MaxLevel < v.level then
      ((EquiptData.UpgradeConfig)[v.type]).MaxLevel = v.level
    end
  end
end

  -- DECOMPILER ERROR at PC309: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetPartName = function(part, ...)
  -- function num : 0_2 , upvalues : _ENV
  return (PUtil.get)(60000047 + part)
end

  -- DECOMPILER ERROR at PC312: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitPartMayContainAttrConfig = function(...)
  -- function num : 0_3 , upvalues : _ENV
  local mainAttr = {}
  local attrTable = {}
  for k,v in pairs((TableData.gTable).BaseEquipData) do
    if mainAttr[v.type] == nil then
      mainAttr[v.type] = {}
      attrTable[v.type] = {}
    end
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (mainAttr[v.type])[tonumber((split(v.main_attribute, ":"))[1])] = true
  end
  local config, attrs, count, subConfig, attr = nil, nil, nil, nil, nil
  for k,v in pairs(mainAttr) do
    for subK,subV in pairs(v) do
      config = ((TableData.gTable).BaseEquipAttributePoolData)[subK]
      if config ~= nil then
        attrs = split(config.attribute_info, ",")
      else
        attrs = {}
      end
      count = #attrs
      for i = 1, count do
        attr = tonumber((split(attrs[i], ":"))[1])
        subConfig = ((TableData.gTable).BaseEquipAttributeData)[attr]
        -- DECOMPILER ERROR at PC78: Confused about usage of register: R21 in 'UnsetPending'

        ;
        (attrTable[k])[tonumber((split(subConfig.value, ":"))[2])] = true
      end
    end
  end
end

  -- DECOMPILER ERROR at PC315: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitGroupSuitInfo = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local count, equipts = nil, nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  EquiptData.GroupSuitInfo = {}
  for k,v in pairs((TableData.gTable).BaseEquipSuitData) do
    equipts = split(v.equip_id, ":")
    count = #equipts
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

    if (EquiptData.GroupSuitInfo)[v.group_id] == nil then
      (EquiptData.GroupSuitInfo)[v.group_id] = {
Equipts = {}
, 
SuitId = {}
, 
EquiptsDic = {}
, 
SuitIdDic = {}
}
    end
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (((EquiptData.GroupSuitInfo)[v.group_id]).SuitIdDic)[k] = true
    for i = 1, count do
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R11 in 'UnsetPending'

      (((EquiptData.GroupSuitInfo)[v.group_id]).EquiptsDic)[tonumber(equipts[i])] = true
    end
  end
  for k,v in pairs(EquiptData.GroupSuitInfo) do
    for subK,subV in pairs(v.EquiptsDic) do
      (table.insert)(v.Equipts, subK)
    end
    for subK,subV in pairs(v.SuitIdDic) do
      (table.insert)(v.SuitId, subK)
    end
    v.EquiptsDic = {}
    v.SuitIdDic = {}
  end
end

  -- DECOMPILER ERROR at PC318: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitMaxIntelligence = function(...)
  -- function num : 0_5 , upvalues : _ENV
  if EquiptData.MaxIntelligence ~= 0 then
    return 
  end
  local values = split((((TableData.gTable).BaseFixedData)[EquiptData.EQUIPMENT_INTELLIGENCE_LIMIT]).array_value, ":")
  local count = #values
  for i = 1, count do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

    EquiptData.MaxIntelligence = (math.max)(EquiptData.MaxIntelligence, tonumber(values[i]))
  end
end

  -- DECOMPILER ERROR at PC321: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitEquiptAttributes = function(...)
  -- function num : 0_6 , upvalues : _ENV
  if (_G.next)(EquiptData.Attributes) ~= nil then
    return 
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.Attributes = {}
  for k,v in pairs((TableData.gTable).BaseAttributeData) do
    if v.equip_show == 1 then
      (table.insert)(EquiptData.Attributes, k)
    end
  end
  ;
  (table.sort)(EquiptData.Attributes, function(x, y, ...)
    -- function num : 0_6_0
    do return x < y end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

  -- DECOMPILER ERROR at PC324: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitEquiptBuff = function(...)
  -- function num : 0_7 , upvalues : _ENV
  if (_G.next)(EquiptData.Buffs) ~= nil then
    return 
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.Buffs = {}
  local buffs = split((((TableData.gTable).BaseFixedData)[EquiptData.EQUIPMENT_BUFF_TYPE_NAME]).array_value, ":")
  local count = #buffs
  for i = 1, count do
    (table.insert)(EquiptData.Buffs, tonumber(buffs[i]))
  end
end

  -- DECOMPILER ERROR at PC327: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetWearEquipInfo = function(cardId, EquipId, ...)
  -- function num : 0_8 , upvalues : _ENV
  local cardInfo = (CardData.GetCardData)(cardId)
  local count = #cardInfo.equipInfo
  for i = 1, count do
    if ((cardInfo.equipInfo)[i]).id == EquipId then
      return (cardInfo.equipInfo)[i]
    end
  end
  return nil
end

  -- DECOMPILER ERROR at PC330: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ClearEquipData = function(...)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.AvailableParts = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.Equipments = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipmentsToDecompose = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.AvailableEquipmentsInBag = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.UnidentifiedEquipments = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.NewEquipments = {}
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PresetInitialized = false
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ReInitialize = false
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipBelongTo = {}
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.PresetBelongTo = {}
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.NPEquipBelongToCard = {}
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipPresetsIndex = {}
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipPresets = {}
  ;
  (EquiptData.ResetData)()
end

  -- DECOMPILER ERROR at PC333: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetCardSuitCount = function(cardId, ...)
  -- function num : 0_10 , upvalues : _ENV
  if cardId == nil then
    return 0
  end
  return #((EquiptData.GetCardSuitInfo)(cardId)).GroupId
end

  -- DECOMPILER ERROR at PC336: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetCardSuitStatue = function(cardId, suitId, ...)
  -- function num : 0_11 , upvalues : _ENV
  if cardId == nil or suitId == nil then
    return false
  end
  do return (((EquiptData.GetCardSuitInfo)(cardId)).Statue)[suitId] == true end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

  -- DECOMPILER ERROR at PC339: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetSuitInfobyEquipts = function(equipts, ...)
  -- function num : 0_12 , upvalues : _ENV
  if equipts == nil then
    return {}
  end
  local count = #equipts
  local activedSuit = {}
  local suit = {}
  local config, suitInfo, subCount, suitID = nil, nil, nil, nil
  for i = 1, count do
    config = ((TableData.gTable).BaseEquipData)[(equipts[i]).id]
    if config.suit_id ~= "0" then
      suitInfo = split(config.suit_id, ":")
      subCount = #suitInfo
      for j = 1, subCount do
        suitID = tonumber(suitInfo[j])
        if suit[suitID] == nil then
          suit[suitID] = 0
        end
        suit[suitID] = suit[suitID] + 1
      end
    end
  end
  for k,v in pairs(suit) do
    config = ((TableData.gTable).BaseEquipSuitData)[k]
    if config.equip_num <= v then
      (table.insert)(activedSuit, k)
    end
  end
  return activedSuit
end

  -- DECOMPILER ERROR at PC342: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetCardSuitInfo = function(cardId, ...)
  -- function num : 0_13 , upvalues : _ENV
  if cardId == nil or cardId == 0 then
    return {
Statue = {}
, 
GroupId = {}
}
  end
  if (EquiptData.SuitInfo)[cardId] == nil then
    (EquiptData.UpdateCardSuitInfo)(cardId)
  end
  return (EquiptData.SuitInfo)[cardId]
end

  -- DECOMPILER ERROR at PC345: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.UpdateCardSuitInfo = function(cardId, ...)
  -- function num : 0_14 , upvalues : _ENV
  local cardInfo = (CardData.GetCardData)(cardId)
  if cardInfo == nil then
    return 
  end
  local count = #cardInfo.equipInfo
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (EquiptData.SuitInfo)[cardId] = {
Statue = {}
, 
GroupId = {}
, 
GroupDic = {}
}
  local suit = {}
  local config, suitInfo, subCount, suitID = nil, nil, nil, nil
  for i = 1, count do
    config = ((TableData.gTable).BaseEquipData)[((cardInfo.equipInfo)[i]).id]
    if config.suit_id ~= "0" then
      suitInfo = split(config.suit_id, ":")
      subCount = #suitInfo
      for j = 1, subCount do
        suitID = tonumber(suitInfo[j])
        if suit[suitID] == nil then
          suit[suitID] = 0
        end
        suit[suitID] = suit[suitID] + 1
      end
    end
  end
  for k,v in pairs(suit) do
    config = ((TableData.gTable).BaseEquipSuitData)[k]
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (((EquiptData.SuitInfo)[cardId]).Statue)[k] = config.equip_num <= v
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (((EquiptData.SuitInfo)[cardId]).GroupDic)[config.group_id] = k
  end
  for k,v in pairs(((EquiptData.SuitInfo)[cardId]).GroupDic) do
    (table.insert)(((EquiptData.SuitInfo)[cardId]).GroupId, {GroupId = k, Id = v})
  end
  ;
  (table.sort)(((EquiptData.SuitInfo)[cardId]).GroupId, function(x, y, ...)
    -- function num : 0_14_0 , upvalues : _ENV
    local xConfig = ((TableData.gTable).BaseEquipSuitData)[x.Id]
    local yConfig = ((TableData.gTable).BaseEquipSuitData)[y.Id]
    do return xConfig.sort < yConfig.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC114: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((EquiptData.SuitInfo)[cardId]).GroupDic = nil
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

  -- DECOMPILER ERROR at PC348: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.CheckAvailableParts = function(parts, id, ...)
  -- function num : 0_15 , upvalues : _ENV
  if (EquiptData.AvailableParts)[parts] ~= nil then
    if ((EquiptData.AvailableParts)[parts]).Other > 0 or (((EquiptData.AvailableParts)[parts]).Privilege)[id] ~= nil then
      return true
    else
      return false
    end
  else
    return false
  end
end

  -- DECOMPILER ERROR at PC351: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.HandelAvailablePartsData = function(equipmentId, equiptConfigId, add, equip, ...)
  -- function num : 0_16 , upvalues : _ENV
  if equiptConfigId == nil then
    if equip then
      equiptConfigId = equip.id
    else
      equiptConfigId = ((EquiptData.Equipments)[(EquiptData.Equipments)[equipmentId]]).id
    end
  end
  local config = ((TableData.gTable).BaseEquipData)[equiptConfigId]
  local equiptType = config.type
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

  if add then
    if (EquiptData.AvailableParts)[equiptType] == nil then
      (EquiptData.AvailableParts)[equiptType] = {
Privilege = {}
, Other = 0}
    end
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

    if ((EquiptData.AvailableParts)[equiptType])[equipmentId] == nil then
      ((EquiptData.AvailableParts)[equiptType])[equipmentId] = true
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

      if config.show_type == EquiptType.Privilege then
        if (((EquiptData.AvailableParts)[equiptType]).Privilege)[config.card_id] == nil then
          (((EquiptData.AvailableParts)[equiptType]).Privilege)[config.card_id] = {}
        end
        -- DECOMPILER ERROR at PC68: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((((EquiptData.AvailableParts)[equiptType]).Privilege)[config.card_id])[equipmentId] = true
      else
        -- DECOMPILER ERROR at PC78: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((EquiptData.AvailableParts)[equiptType]).Other = ((EquiptData.AvailableParts)[equiptType]).Other + 1
      end
    end
  else
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R6 in 'UnsetPending'

    if (EquiptData.AvailableParts)[equiptType] ~= nil and ((EquiptData.AvailableParts)[equiptType])[equipmentId] then
      ((EquiptData.AvailableParts)[equiptType])[equipmentId] = nil
      -- DECOMPILER ERROR at PC106: Confused about usage of register: R6 in 'UnsetPending'

      if config.show_type == EquiptType.Privilege then
        ((((EquiptData.AvailableParts)[equiptType]).Privilege)[config.card_id])[equipmentId] = nil
        -- DECOMPILER ERROR at PC123: Confused about usage of register: R6 in 'UnsetPending'

        if (_G.next)((((EquiptData.AvailableParts)[equiptType]).Privilege)[config.card_id]) == nil then
          (((EquiptData.AvailableParts)[equiptType]).Privilege)[config.card_id] = nil
        end
      else
        -- DECOMPILER ERROR at PC133: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((EquiptData.AvailableParts)[equiptType]).Other = ((EquiptData.AvailableParts)[equiptType]).Other - 1
      end
    end
  end
end

  -- DECOMPILER ERROR at PC354: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.StoreEquipments = function(equipments, ...)
  -- function num : 0_17 , upvalues : _ENV
  log("store:" .. #equipments)
  local count = #equipments
  local config = nil
  for i = 1, count do
    config = ((TableData.gTable).BaseEquipData)[(equipments[i]).id]
    if config ~= nil and config.show_type == EquiptType.Normal then
      (EquiptData.HandleEquiptData)(EquiptData.Equipments, equipments[i], true)
      ;
      (EquiptData.HandleEquiptObjectIndexData)(EquiptData.EquipmentsToDecompose, (equipments[i]).objectIndex, true)
      if (equipments[i]).identify then
        (EquiptData.HandelAvailablePartsData)((equipments[i]).objectIndex, (equipments[i]).id, true)
        ;
        (EquiptData.HandleEquiptObjectIndexData)(EquiptData.AvailableEquipmentsInBag, (equipments[i]).objectIndex, true)
        -- DECOMPILER ERROR at PC64: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (equipments[i]).SortedAttr = (EquiptData.GetSortedAttrs)(equipments[i])
        ;
        (table.sort)((equipments[i]).randomBuff, function(x, y, ...)
    -- function num : 0_17_0
    do return x < y end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      else
        ;
        (EquiptData.HandleEquiptObjectIndexData)(EquiptData.UnidentifiedEquipments, (equipments[i]).objectIndex, true)
      end
    end
  end
  loge("..")
end

  -- DECOMPILER ERROR at PC357: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.HandleEquiptData = function(dataSet, data, add, ...)
  -- function num : 0_18 , upvalues : _ENV
  if add then
    if dataSet[data.objectIndex] == nil then
      (table.insert)(dataSet, data)
      dataSet[data.objectIndex] = #dataSet
      return true
    else
      return false
    end
  else
    local index = dataSet[data.objectIndex]
    if index ~= nil then
      (table.remove)(dataSet, index)
      dataSet[data.objectIndex] = nil
      local count = #dataSet
      for i = index, count do
        dataSet[(dataSet[i]).objectIndex] = i
      end
      return true
    else
      do
        local count = #dataSet
        for i = 1, count do
          if (dataSet[i]).objectIndex == data.objectIndex then
            (table.remove)(dataSet, i)
            return true
          end
        end
        do return false end
      end
    end
  end
end

  -- DECOMPILER ERROR at PC360: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.HandleEquiptObjectIndexData = function(dataSet, objectIndex, add, ...)
  -- function num : 0_19 , upvalues : _ENV
  if add then
    if dataSet[objectIndex] == nil then
      (table.insert)(dataSet, objectIndex)
      dataSet[objectIndex] = #dataSet
      return true
    else
      return false
    end
  else
    local index = dataSet[objectIndex]
    if index ~= nil then
      (table.remove)(dataSet, index)
      dataSet[objectIndex] = nil
      local count = #dataSet
      for i = index, count do
        dataSet[dataSet[i]] = i
      end
      return true
    else
      do
        local count = #dataSet
        for i = 1, count do
          if dataSet[i] == objectIndex then
            (table.remove)(dataSet, i)
            return true
          end
        end
        do return false end
      end
    end
  end
end

  -- DECOMPILER ERROR at PC363: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ResetData = function(...)
  -- function num : 0_20 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ReadyToDecompose = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.AdvanceEquiptToDecompose = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ReadyToIdentify = {}
  ;
  (EquiptData.ResetIdentifyCost)()
end

  -- DECOMPILER ERROR at PC366: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ResetIdentifyCost = function(...)
  -- function num : 0_21 , upvalues : _ENV
  for k,v in pairs(EquiptData.IdentifyCost) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

    ((EquiptData.IdentifyCost)[k]).Value = 0
  end
end

  -- DECOMPILER ERROR at PC369: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitFilter = function(...)
  -- function num : 0_22 , upvalues : _ENV
  (EquiptData.InitSingleFilter)(EquiptSetType.Change, EquiptData.AvailableEquipmentsInBag)
  ;
  (EquiptData.InitSingleFilter)(EquiptSetType.Decompose, EquiptData.EquipmentsToDecompose)
  ;
  (EquiptData.InitSingleFilter)(EquiptSetType.Identify, EquiptData.UnidentifiedEquipments)
  ;
  (EquiptData.InitSingleFilter)(EquiptSetType.Preset, EquiptData.AvailableEquipmentsInBag)
end

  -- DECOMPILER ERROR at PC372: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitSingleFilter = function(setType, data, ...)
  -- function num : 0_23 , upvalues : _ENV
  local filter = {}
  local count = #(EquiptData.EquipmentSetContainFilter)[setType]
  filter.FilterType = {}
  local filterType = nil
  for i = 1, count do
    filterType = ((EquiptData.EquipmentSetContainFilter)[setType])[i]
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R9 in 'UnsetPending'

    if filterType == EquiptFilterType.SinglePart then
      (filter.FilterType)[filterType] = 0
    else
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (filter.FilterType)[filterType] = {}
    end
  end
  filter.SortType = EquiptSortType.Decrease
  filter.Result = {}
  filter.SrcData = data
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (EquiptData.Filters)[setType] = filter
end

  -- DECOMPILER ERROR at PC375: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.FilteringEquiptSet = function(setType, ...)
  -- function num : 0_24 , upvalues : _ENV
  (EquiptData.FilteringEquips)(setType)
  ;
  (EquiptData.SortEquipmentSet)(setType)
end

  -- DECOMPILER ERROR at PC378: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ResetFilters = function(setType, ...)
  -- function num : 0_25 , upvalues : _ENV
  for k,v in pairs(((EquiptData.Filters)[setType]).FilterType) do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

    -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

    if k == EquiptFilterType.SinglePart and setType ~= EquiptSetType.Change then
      (((EquiptData.Filters)[setType]).FilterType)[k] = 0
    end
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((EquiptData.Filters)[setType]).FilterType)[k] = {}
  end
end

  -- DECOMPILER ERROR at PC381: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.FilteringEquips = function(setType, currentRole, ...)
  -- function num : 0_26 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((EquiptData.Filters)[setType]).Result = {}
  local count = #((EquiptData.Filters)[setType]).SrcData
  local pass, equipInfo, equipConfig, attrConfig = nil, nil, nil, nil
  local result = ((EquiptData.Filters)[setType]).Result
  if currentRole == nil then
    currentRole = (EquiptData.CurrentRoleData).id
  end
  for i = 1, count do
    equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[(((EquiptData.Filters)[setType]).SrcData)[i]]]
    equipConfig = ((TableData.gTable).BaseEquipData)[equipInfo.id]
    pass = true
    for k,v in pairs(((EquiptData.Filters)[setType]).FilterType) do
      if pass ~= false then
        do
          -- DECOMPILER ERROR at PC62: Unhandled construct in 'MakeBoolean' P1

          if k == EquiptFilterType.Privilege and equipConfig.show_type == EquiptType.Privilege and equipConfig.card_id ~= currentRole then
            pass = false
          end
          -- DECOMPILER ERROR at PC78: Unhandled construct in 'MakeBoolean' P1

          if k == EquiptFilterType.Type and (_G.next)(v) ~= nil and v[equipConfig.show_type] == nil then
            pass = false
          end
          -- DECOMPILER ERROR at PC93: Unhandled construct in 'MakeBoolean' P1

          if k == EquiptFilterType.SinglePart and v ~= 0 and v ~= EquiptPartsType.All and v ~= equipConfig.type then
            pass = false
          end
          -- DECOMPILER ERROR at PC109: Unhandled construct in 'MakeBoolean' P1

          if k == EquiptFilterType.MultiplyParts and (_G.next)(v) ~= nil and v[equipConfig.type] == nil then
            pass = false
          end
          -- DECOMPILER ERROR at PC125: Unhandled construct in 'MakeBoolean' P1

          if k == EquiptFilterType.Intelligence and (_G.next)(v) ~= nil and v[equipConfig.star] == nil then
            pass = false
          end
          if k == EquiptFilterType.Attributes then
            pass = (EquiptData.CheckAttributes)(equipInfo, v)
          else
            if k == EquiptFilterType.Buff then
              pass = (EquiptData.CheckBuffs)(equipInfo, v)
            else
              if k == EquiptFilterType.AttributeAmount and (_G.next)(v) ~= nil and (equipInfo.identify == false or v[1 + #equipInfo.randomAttrId + #equipInfo.randomBuff] == nil) then
                pass = false
              end
            end
          end
          -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    if pass then
      (table.insert)(result, equipInfo.objectIndex)
    else
      -- DECOMPILER ERROR at PC195: Confused about usage of register: R12 in 'UnsetPending'

      if setType == EquiptSetType.Decompose and (EquiptData.ReadyToDecompose)[equipInfo.objectIndex] then
        (EquiptData.ReadyToDecompose)[equipInfo.objectIndex] = nil
        -- DECOMPILER ERROR at PC205: Confused about usage of register: R12 in 'UnsetPending'

        if (EquiptData.AdvanceEquiptToDecompose)[equipInfo.objectIndex] then
          (EquiptData.AdvanceEquiptToDecompose)[equipInfo.objectIndex] = nil
        end
      end
    end
  end
end

  -- DECOMPILER ERROR at PC384: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitPresetEditEquipments = function(presetData, ...)
  -- function num : 0_27 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  EquiptData.PresetEditEquipments = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (EquiptData.PresetEditEquipments).SrcData = (Util.Copy)(EquiptData.AvailableEquipmentsInBag)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (EquiptData.PresetEditEquipments).SortType = EquiptSortType.Decrease
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (EquiptData.PresetEditEquipments).Result = {}
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (EquiptData.PresetEditEquipments).EquipDetail = {}
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (EquiptData.PresetEditEquipments).CurrentType = EquiptPartsType.All
  local count = #(EquiptData.PresetEditEquipments).SrcData
  local subCount, cardInfo, equipInfo = nil, nil, nil
  for i = 1, count do
    equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[((EquiptData.PresetEditEquipments).SrcData)[i]]]
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((EquiptData.PresetEditEquipments).EquipDetail)[equipInfo.objectIndex] = equipInfo
  end
  local cards = (EquiptData.GetCards)()
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

  EquiptData.NPEquipBelongToCard = {}
  count = #cards
  for i = 1, count do
    cardInfo = cards[i]
    subCount = #cardInfo.equipInfo
    for j = 1, subCount do
      equipInfo = (cardInfo.equipInfo)[j]
      equipInfo.SortedAttr = (EquiptData.GetSortedAttrs)(equipInfo)
      ;
      (table.insert)((EquiptData.PresetEditEquipments).SrcData, equipInfo.objectIndex)
      -- DECOMPILER ERROR at PC90: Confused about usage of register: R14 in 'UnsetPending'

      ;
      ((EquiptData.PresetEditEquipments).EquipDetail)[equipInfo.objectIndex] = equipInfo
      -- DECOMPILER ERROR at PC95: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (EquiptData.NPEquipBelongToCard)[equipInfo.objectIndex] = cardInfo.id
    end
  end
end

  -- DECOMPILER ERROR at PC387: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ChangePresetEditFilter = function(type, ...)
  -- function num : 0_28 , upvalues : _ENV
  (EquiptData.FilteringPresetEditEquipments)(type)
  ;
  (EquiptData.SortPresetEquipments)()
end

  -- DECOMPILER ERROR at PC390: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.SortPresetEquipments = function(...)
  -- function num : 0_29 , upvalues : _ENV
  if (EquiptData.PresetEditEquipments).SortType == EquiptSortType.Increase then
    (table.sort)((EquiptData.PresetEditEquipments).Result, function(x, y, ...)
    -- function num : 0_29_0 , upvalues : _ENV
    local equipInfoX = ((EquiptData.PresetEditEquipments).EquipDetail)[x]
    local equipInfoY = ((EquiptData.PresetEditEquipments).EquipDetail)[y]
    return (EquiptData.EquipmentIncreaseSort)(equipInfoX, equipInfoY)
  end
)
  else
    ;
    (table.sort)((EquiptData.PresetEditEquipments).Result, function(x, y, ...)
    -- function num : 0_29_1 , upvalues : _ENV
    local equipInfoX = ((EquiptData.PresetEditEquipments).EquipDetail)[x]
    local equipInfoY = ((EquiptData.PresetEditEquipments).EquipDetail)[y]
    return (EquiptData.EquipmentDecreaseSort)(equipInfoX, equipInfoY)
  end
)
  end
end

  -- DECOMPILER ERROR at PC393: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.HandlePresetResult = function(add, equiptInfo, ...)
  -- function num : 0_30 , upvalues : _ENV
  local config = ((TableData.gTable).BaseEquipData)[equiptInfo.id]
  if (EquiptData.PresetEditEquipments).CurrentType ~= EquiptPartsType.All and (EquiptData.PresetEditEquipments).CurrentType ~= config.type then
    return 
  end
  if add then
    (table.insert)((EquiptData.PresetEditEquipments).Result, equiptInfo.objectIndex)
    ;
    (EquiptData.SortPresetEquipments)()
  else
    local count = #(EquiptData.PresetEditEquipments).Result
    for i = 1, count do
      if ((EquiptData.PresetEditEquipments).Result)[i] == equiptInfo.objectIndex then
        (table.remove)((EquiptData.PresetEditEquipments).Result, i)
        break
      end
    end
  end
end

  -- DECOMPILER ERROR at PC396: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.FilteringPresetEditEquipments = function(type, ...)
  -- function num : 0_31 , upvalues : _ENV
  if type == nil then
    type = (EquiptData.PresetEditEquipments).CurrentType
  else
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (EquiptData.PresetEditEquipments).CurrentType = type
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (EquiptData.PresetEditEquipments).Result = {}
  local count = nil
  local equipInPreset = {}
  if (EquiptData.EditPreset).equipIndex ~= nil then
    count = #(EquiptData.EditPreset).equipIndex
    for i = 1, count do
      equipInPreset[((EquiptData.EditPreset).equipIndex)[i]] = true
    end
  end
  do
    local count = #(EquiptData.PresetEditEquipments).SrcData
    local equipInfo, equipConfig = nil, nil
    for i = 1, count do
      equipInfo = ((EquiptData.PresetEditEquipments).EquipDetail)[((EquiptData.PresetEditEquipments).SrcData)[i]]
      equipConfig = ((TableData.gTable).BaseEquipData)[equipInfo.id]
      if not equipInPreset[equipInfo.objectIndex] and (type == EquiptPartsType.All or type == equipConfig.type) then
        (table.insert)((EquiptData.PresetEditEquipments).Result, equipInfo.objectIndex)
      end
    end
  end
end

  -- DECOMPILER ERROR at PC399: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.CheckAttributes = function(equipInfo, filter, ...)
  -- function num : 0_32 , upvalues : _ENV
  if (_G.next)(filter) == nil then
    return true
  else
    if equipInfo.identify == false then
      return false
    end
    local allAttr = {}
    local attrConfig, attr, count = nil, nil, nil
    if equipInfo.mainAttrId ~= 0 then
      attrConfig = ((TableData.gTable).BaseEquipAttributeData)[equipInfo.mainAttrId]
      attr = split(attrConfig.value, ":")
      allAttr[tonumber(attr[2])] = true
    end
    count = #equipInfo.randomAttrId
    for i = 1, count do
      attrConfig = ((TableData.gTable).BaseEquipAttributeData)[(equipInfo.randomAttrId)[i]]
      attr = split(attrConfig.value, ":")
      allAttr[tonumber(attr[2])] = true
    end
    for k,v in pairs(filter) do
      if allAttr[k] == nil then
        return false
      end
    end
    return true
  end
end

  -- DECOMPILER ERROR at PC402: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.CheckBuffs = function(equipInfo, filter, ...)
  -- function num : 0_33 , upvalues : _ENV
  if (_G.next)(filter) == nil then
    return true
  else
    if equipInfo.identify == false then
      return false
    end
    local allAttr = {}
    local count = #equipInfo.randomBuff
    local config = nil
    for i = 1, count do
      config = ((TableData.gTable).BaseBuffPreBattleData)[(equipInfo.randomBuff)[i]]
      allAttr[config.show_type] = true
    end
    for k,v in pairs(filter) do
      if allAttr[k] == nil then
        return false
      end
    end
  end
  do
    return true
  end
end

  -- DECOMPILER ERROR at PC405: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.SortEquipmentSet = function(setType, ...)
  -- function num : 0_34 , upvalues : _ENV
  if ((EquiptData.Filters)[setType]).SortType == EquiptSortType.Increase then
    (table.sort)(((EquiptData.Filters)[setType]).Result, function(x, y, ...)
    -- function num : 0_34_0 , upvalues : _ENV
    local equipInfoX = (EquiptData.Equipments)[(EquiptData.Equipments)[x]]
    local equipInfoY = (EquiptData.Equipments)[(EquiptData.Equipments)[y]]
    return (EquiptData.EquipmentIncreaseSort)(equipInfoX, equipInfoY)
  end
)
  else
    ;
    (table.sort)(((EquiptData.Filters)[setType]).Result, function(x, y, ...)
    -- function num : 0_34_1 , upvalues : _ENV
    local equipInfoX = (EquiptData.Equipments)[(EquiptData.Equipments)[x]]
    local equipInfoY = (EquiptData.Equipments)[(EquiptData.Equipments)[y]]
    return (EquiptData.EquipmentDecreaseSort)(equipInfoX, equipInfoY)
  end
)
  end
end

  -- DECOMPILER ERROR at PC408: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipmentIncreaseSort = function(equipInfoX, equipInfoY, ...)
  -- function num : 0_35 , upvalues : _ENV
  local configX = ((TableData.gTable).BaseEquipData)[equipInfoX.id]
  local configY = ((TableData.gTable).BaseEquipData)[equipInfoY.id]
  if equipInfoX.identify == equipInfoY.identify then
    if equipInfoX.identify then
      if (EquiptData.NewEquipments)[equipInfoX.objectIndex] == (EquiptData.NewEquipments)[equipInfoY.objectIndex] then
        if configX.sort == configY.sort then
          if configX.type == configY.type then
            local count = ((math.max)(#equipInfoX.SortedAttr, #equipInfoY.SortedAttr))
            local attrX, attrY = nil, nil
            for i = 1, count do
              attrX = (equipInfoX.SortedAttr)[i]
              attrY = (equipInfoY.SortedAttr)[i]
              if attrX ~= attrY then
                if attrX == nil then
                  return false
                else
                  if attrY == nil then
                    return true
                  else
                    return attrX < attrY
                  end
                end
              end
            end
            local count = ((math.max)(#equipInfoX.randomBuff, #equipInfoY.randomBuff))
            local buffX, buffY = nil, nil
            for i = 1, count do
              buffX = (equipInfoX.randomBuff)[i]
              buffY = (equipInfoY.randomBuff)[i]
              if buffX ~= buffY then
                if buffX == nil then
                  return false
                elseif buffY == nil then
                  return true
                else
                  return buffX < buffY
                end
              end
            end
            if equipInfoX.objectIndex == equipInfoY.objectIndex then
              return false
            else
              return equipInfoX.objectIndex < equipInfoY.objectIndex
            end
          else
            return configY.type < configX.type
          end
        else
          return configY.sort < configX.sort
        end
      elseif (EquiptData.NewEquipments)[equipInfoX.objectIndex] then
        do return not (EquiptData.NewEquipments)[equipInfoY.objectIndex] end
        if configX.sort == configY.sort then
          if configX.type == configY.type then
            if equipInfoX.objectIndex == equipInfoY.objectIndex then
              return false
            else
              return equipInfoX.objectIndex < equipInfoY.objectIndex
            end
          else
            return configY.type < configX.type
          end
        else
          return configY.sort < configX.sort
        end
        if equipInfoX.identify then
          do return not equipInfoY.identify end
          -- DECOMPILER ERROR: 24 unprocessed JMP targets
        end
      end
    end
  end
end

  -- DECOMPILER ERROR at PC411: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.EquipmentDecreaseSort = function(equipInfoX, equipInfoY, ...)
  -- function num : 0_36 , upvalues : _ENV
  local configX = ((TableData.gTable).BaseEquipData)[equipInfoX.id]
  local configY = ((TableData.gTable).BaseEquipData)[equipInfoY.id]
  if equipInfoX.identify == equipInfoY.identify then
    if equipInfoX.identify then
      if (EquiptData.NewEquipments)[equipInfoX.objectIndex] == (EquiptData.NewEquipments)[equipInfoY.objectIndex] then
        if configX.sort == configY.sort then
          if configX.type == configY.type then
            local count = ((math.max)(#equipInfoX.SortedAttr, #equipInfoY.SortedAttr))
            local attrX, attrY = nil, nil
            for i = 1, count do
              attrX = (equipInfoX.SortedAttr)[i]
              attrY = (equipInfoY.SortedAttr)[i]
              if attrX ~= attrY then
                if attrX == nil then
                  return true
                else
                  if attrY == nil then
                    return false
                  else
                    return attrY < attrX
                  end
                end
              end
            end
            local count = ((math.max)(#equipInfoX.randomBuff, #equipInfoY.randomBuff))
            local buffX, buffY = nil, nil
            for i = 1, count do
              buffX = (equipInfoX.randomBuff)[i]
              buffY = (equipInfoY.randomBuff)[i]
              if buffX ~= buffY then
                if buffX == nil then
                  return true
                elseif buffY == nil then
                  return false
                else
                  return buffY < buffX
                end
              end
            end
            if equipInfoX.objectIndex == equipInfoY.objectIndex then
              return false
            else
              return equipInfoY.objectIndex < equipInfoX.objectIndex
            end
          else
            return configX.type < configY.type
          end
        else
          return configX.sort < configY.sort
        end
      elseif (EquiptData.NewEquipments)[equipInfoX.objectIndex] then
        do return not (EquiptData.NewEquipments)[equipInfoY.objectIndex] end
        if configX.sort == configY.sort then
          if configX.type == configY.type then
            if equipInfoX.objectIndex == equipInfoY.objectIndex then
              return false
            else
              return equipInfoY.objectIndex < equipInfoX.objectIndex
            end
          else
            return configX.type < configY.type
          end
        else
          return configX.sort < configY.sort
        end
        do return (not equipInfoX.identify and equipInfoY.identify) end
        -- DECOMPILER ERROR: 25 unprocessed JMP targets
      end
    end
  end
end

  -- DECOMPILER ERROR at PC414: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetEquipmentTypeWeight = function(equipmentType, ...)
  -- function num : 0_37 , upvalues : _ENV
  if equipmentType == EquiptType.Normal then
    return 2
  else
    if equipmentType == EquiptType.Activity then
      return 1
    else
      return 3
    end
  end
end

  -- DECOMPILER ERROR at PC417: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetSortedAttrs = function(equipInfo, ...)
  -- function num : 0_38 , upvalues : _ENV
  local attrs = (Util.Copy)(equipInfo.randomAttrId)
  if equipInfo.mainAttrId ~= 0 then
    (table.insert)(attrs, equipInfo.mainAttrId)
  end
  local count = #attrs
  local attrConfig, attr = nil, nil
  for i = 1, count do
    attrConfig = ((TableData.gTable).BaseEquipAttributeData)[attrs[i]]
    attr = split(attrConfig.value, ":")
    attrs[i] = tonumber(attr[2])
  end
  ;
  (table.sort)(attrs, function(x, y, ...)
    -- function num : 0_38_0
    do return x < y end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return attrs
end

  -- DECOMPILER ERROR at PC420: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ChangeFilter = function(setType, filterType, arg1, arg2, ...)
  -- function num : 0_39 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if filterType == EquiptFilterType.SinglePart then
    (((EquiptData.Filters)[setType]).FilterType)[filterType] = arg1
  else
    ;
    (EquiptData.SetTableFilter)((((EquiptData.Filters)[setType]).FilterType)[filterType], arg1, arg2)
  end
end

  -- DECOMPILER ERROR at PC423: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.SetTableFilter = function(filter, type, add, ...)
  -- function num : 0_40
  if add then
    filter[type] = true
  else
    filter[type] = nil
  end
end

  -- DECOMPILER ERROR at PC426: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetEquipmentsFCById = function(equipIds, equipInfo, ...)
  -- function num : 0_41 , upvalues : _ENV
  if equipInfo == nil then
    equipInfo = {}
    if equipIds then
      for k,v in pairs(equipIds) do
        (table.insert)(equipInfo, (EquiptData.Equipments)[(EquiptData.Equipments)[v]])
      end
    end
  end
  do
    return (EquiptData.GetEquipmentsFC)(equipInfo)
  end
end

  -- DECOMPILER ERROR at PC429: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetEquipmentsPresetEditFC = function(equipIds, ...)
  -- function num : 0_42 , upvalues : _ENV
  local equipInfo = {}
  if equipIds then
    for k,v in pairs(equipIds) do
      (table.insert)(equipInfo, ((EquiptData.PresetEditEquipments).EquipDetail)[v])
    end
  end
  do
    return (EquiptData.GetEquipmentsFC)(equipInfo)
  end
end

  -- DECOMPILER ERROR at PC432: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetEquipmentsFC = function(equipInfo, ...)
  -- function num : 0_43 , upvalues : _ENV
  ((CardData.GetEquipAddAttrList)(equipInfo))
  local equipAddAttrs = nil
  local config = nil
  local fc = 0
  for k,v in pairs(equipAddAttrs) do
    config = ((TableData.gTable).BaseAttributeData)[k]
    fc = fc + v.value * config.fc_base / 10000
  end
  return (math.ceil)(fc)
end

  -- DECOMPILER ERROR at PC435: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.AcquireEquipments = function(equipments, ...)
  -- function num : 0_44 , upvalues : _ENV
  (EquiptData.StoreEquipments)(equipments)
end

  -- DECOMPILER ERROR at PC438: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.LoseEquipments = function(equipmentIds, ...)
  -- function num : 0_45 , upvalues : _ENV
  local count = #equipmentIds
  local equipmentId, presetId, presetData, subCount = nil, nil, nil, nil
  local needRemove = {}
  for i = 1, count do
    equipmentId = equipmentIds[i]
    presetId = (EquiptData.EquipBelongTo)[equipmentId]
    if presetId ~= nil then
      (EquiptData.RemoveFromPreset)(equipmentId, presetId)
    end
    if (EquiptData.ReadyToIdentify)[equipmentId] ~= nil then
      (EquiptMgr.HandleEquipmentToIdentify)((EquiptData.Equipments)[(EquiptData.Equipments)[equipmentId]], false, true)
    end
    ;
    (EquiptData.HandelAvailablePartsData)(equipmentId, nil, false)
    ;
    (EquiptData.HandleEquiptData)(EquiptData.Equipments, (EquiptData.Equipments)[(EquiptData.Equipments)[equipmentId]], false)
    ;
    (EquiptData.HandleEquiptObjectIndexData)(EquiptData.EquipmentsToDecompose, equipmentId, false)
    if (EquiptData.HandleEquiptObjectIndexData)(EquiptData.AvailableEquipmentsInBag, equipmentId, false) == false then
      (EquiptData.HandleEquiptObjectIndexData)(EquiptData.UnidentifiedEquipments, equipmentId, false)
    end
  end
end

  -- DECOMPILER ERROR at PC441: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.AddToPreset = function(equipmentId, presetId, ...)
  -- function num : 0_46 , upvalues : _ENV
  if presetId == nil or (EquiptData.EquipPresetsIndex)[presetId] == nil then
    return 
  end
  local presetData = (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[presetId]]
  ;
  (table.insert)(presetData.equipIndex, equipmentId)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (EquiptData.EquipBelongTo)[equipmentId] = presetId
end

  -- DECOMPILER ERROR at PC444: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.RemoveFromPreset = function(equipmentId, presetId, notRemove, ...)
  -- function num : 0_47 , upvalues : _ENV
  if presetId == nil or (EquiptData.EquipPresetsIndex)[presetId] == nil then
    return 
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (EquiptData.EquipBelongTo)[equipmentId] = nil
  local presetData = (EquiptData.EquipPresets)[(EquiptData.EquipPresetsIndex)[presetId]]
  local count = #presetData.equipIndex
  for i = 1, count do
    if (presetData.equipIndex)[i] == equipmentId then
      (table.remove)(presetData.equipIndex, i)
      break
    end
  end
  do
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

    if #presetData.equipIndex == 0 and not notRemove then
      (EquiptData.PresetBelongTo)[presetId] = nil
      ;
      (EquiptData.UpdateEquipPreset)(presetData, false)
      return true
    end
  end
end

  -- DECOMPILER ERROR at PC447: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.SortEquiptAttr = function(x, y, ...)
  -- function num : 0_48 , upvalues : _ENV
  local attrsX = split((((TableData.gTable).BaseEquipAttributeData)[x]).value, ":")
  local attrsY = split((((TableData.gTable).BaseEquipAttributeData)[y]).value, ":")
  if tonumber(attrsY[3]) >= tonumber(attrsX[3]) then
    do return tonumber(attrsX[2]) ~= tonumber(attrsY[2]) end
    do return tonumber(attrsX[2]) < tonumber(attrsY[2]) end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

  -- DECOMPILER ERROR at PC450: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetColorByStar = function(star, ...)
  -- function num : 0_49 , upvalues : _ENV
  if star <= 2 then
    return star
  else
    if star >= 7 then
      return 5
    else
      return (math.ceil)(star * 0.5) + 1
    end
  end
end

  -- DECOMPILER ERROR at PC453: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ResetDecomposeData = function(...)
  -- function num : 0_50 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ReadyToDecompose = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.AdvanceEquiptToDecompose = {}
end

  -- DECOMPILER ERROR at PC456: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetEquipIndex = function(equipmentId, ...)
  -- function num : 0_51 , upvalues : _ENV
  local count = #((EquiptData.Filters)[EquiptSetType.Change]).Result
  for i = 1, count do
    if ((((EquiptData.Filters)[EquiptSetType.Change]).Result)[i]).objectIndex == equipmentId then
      return i
    end
  end
  return -1
end

  -- DECOMPILER ERROR at PC459: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ClearFilterInfo = function(...)
  -- function num : 0_52 , upvalues : _ENV
  (EquiptData.ResetFilters)(EquiptSetType.Change)
  ;
  (EquiptData.ResetFilters)(EquiptSetType.Decompose)
  ;
  (EquiptData.ResetFilters)(EquiptSetType.Identify)
end

  -- DECOMPILER ERROR at PC462: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetRedDotList = function(...)
  -- function num : 0_53 , upvalues : _ENV
  local list = (EquiptData.GetCards)()
  local count = (math.min)(#list, Const.MAX_SHOW_RED_DOT_ROLE_INDEX)
  local result = {}
  local found, eachResult = nil, nil
  found = false
  for i = 1, count do
    eachResult = (EquiptData.CheckSingleRedDot)(list[i])
    ;
    (table.insert)(result, eachResult)
    if not found then
      found = eachResult
    end
  end
  return result, found
end

  -- DECOMPILER ERROR at PC465: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.CheckSingleRedDot = function(oneCardData, ...)
  -- function num : 0_54 , upvalues : _ENV
  local equipmentCount = #oneCardData.equipInfo
  if equipmentCount < EquiptData.EQUIPMENT_TYPE_COUNT then
    local equiptType = {}
    for i = 1, equipmentCount do
      equiptType[(((TableData.gTable).BaseEquipData)[((oneCardData.equipInfo)[i]).id]).type] = true
    end
    local found = false
    for i = 1, EquiptData.EQUIPMENT_TYPE_COUNT do
      if equiptType[i] == nil and (EquiptData.CheckAvailableParts)(i, oneCardData.id) then
        return true
      end
    end
    return false
  else
    do
      do return false end
    end
  end
end

  -- DECOMPILER ERROR at PC468: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.InitEquipPresetData = function(list, ...)
  -- function num : 0_55 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  EquiptData.EquipPresetsIndex = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  EquiptData.EquipBelongTo = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  EquiptData.PresetBelongTo = {}
  ;
  (table.sort)(list, function(x, y, ...)
    -- function num : 0_55_0
    if x.id == y.id then
      return false
    else
      return x.id < y.id
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  EquiptData.EquipPresets = list
  local count = #list
  local subCount, data = nil, nil
  for i = 1, count do
    data = list[i]
    subCount = #data.equipIndex
    for j = 1, subCount do
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R12 in 'UnsetPending'

      (EquiptData.EquipBelongTo)[(data.equipIndex)[j]] = data.id
    end
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (EquiptData.EquipPresetsIndex)[data.id] = i
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'

    if data.cardId ~= 0 then
      (EquiptData.PresetBelongTo)[data.id] = data.cardId
    end
  end
end

  -- DECOMPILER ERROR at PC471: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.UpdateEquipPreset = function(data, add, ...)
  -- function num : 0_56 , upvalues : _ENV
  if add then
    (table.insert)(EquiptData.EquipPresets, data)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (EquiptData.EquipPresetsIndex)[data.id] = #EquiptData.EquipPresets
  else
    local index = (EquiptData.EquipPresetsIndex)[data.id]
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (EquiptData.EquipPresetsIndex)[data.id] = nil
    ;
    (table.remove)(EquiptData.EquipPresets, index)
    local count = #EquiptData.EquipPresets
    for i = index, count do
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R8 in 'UnsetPending'

      (EquiptData.EquipPresetsIndex)[((EquiptData.EquipPresets)[i]).id] = i
    end
  end
end

  -- DECOMPILER ERROR at PC474: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetEquipmentAttrById = function(equipIds, equipInfo, ...)
  -- function num : 0_57 , upvalues : _ENV
  if not equipInfo then
    equipInfo = {}
  end
  if equipIds then
    for k,v in pairs(equipIds) do
      (table.insert)(equipInfo, (EquiptData.Equipments)[(EquiptData.Equipments)[v]])
    end
  end
  do
    return (EquiptData.GetEquipmentAttr)(equipInfo)
  end
end

  -- DECOMPILER ERROR at PC477: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetEquipmentPresetEditAttr = function(equipIds, ...)
  -- function num : 0_58 , upvalues : _ENV
  local equipInfo = {}
  if equipIds then
    for k,v in pairs(equipIds) do
      (table.insert)(equipInfo, ((EquiptData.PresetEditEquipments).EquipDetail)[v])
    end
  end
  do
    return (EquiptData.GetEquipmentAttr)(equipInfo)
  end
end

  -- DECOMPILER ERROR at PC480: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetEquipmentAttr = function(equipInfos, ...)
  -- function num : 0_59 , upvalues : _ENV
  local attrs = (CardData.GetEquipAddAttrList)(equipInfos)
  local data = {}
  for k,v in pairs(attrs) do
    (table.insert)(data, v)
  end
  ;
  (table.sort)(data, function(x, y, ...)
    -- function num : 0_59_0
    if y.value >= x.value then
      do return x.id ~= y.id end
      do return x.id < y.id end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  return data
end

  -- DECOMPILER ERROR at PC483: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.GetCards = function(...)
  -- function num : 0_60 , upvalues : _ENV
  local List = (CardData.GetObtainedCardList)()
  local cardList = {}
  local limitConfig = nil
  for _,v in ipairs(List) do
    limitConfig = ((TableData.gTable).BaseCardLimitData)[v.id]
    if limitConfig == nil or limitConfig.equip_display ~= 0 and (limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time)) then
      (table.insert)(cardList, v)
    end
  end
  return cardList
end

  ;
  (EquiptData.InitConfig)()
end

