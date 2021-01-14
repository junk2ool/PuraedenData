-- params : ...
-- function num : 0 , upvalues : _ENV
FormationPresetData = {}
FormationPresetChangeType = {Add = 1, Alter = 2, Delete = 3}
FormationPresetCardsStatus = {Normal = 1, PartialAvailable = 2, NotAvailable = 3, ExpeditionOutOfLimit = 4}
-- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetData.Initialized = false
-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetData.MAX_PRESET_AMOUNT = 72010081
-- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetData.MAX_PRESET_NAME_LENGTH = 72010082
-- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetData.ChosedPreset = nil
-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetData.EditPreset = nil
-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetData.PresetData = {}
-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetData.PresetFC = {}
-- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetData.OriginFormation = nil
-- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetData.ExternalData = nil
-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

FormationPresetData.Constant = {MaxPresetAmount = 20, MaxPresetNameLength = 7}
local self = FormationPresetData
-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetData.Init = function(...)
  -- function num : 0_0 , upvalues : self, _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  (self.Constant).MaxPresetAmount = (((TableData.gTable).BaseFixedData)[FormationPresetData.MAX_PRESET_AMOUNT]).int_value
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (self.Constant).MaxPresetNameLength = (((TableData.gTable).BaseFixedData)[FormationPresetData.MAX_PRESET_NAME_LENGTH]).int_value
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetData.GetPresetFC = function(data, ...)
  -- function num : 0_1 , upvalues : _ENV
  local fc = 0
  if data then
    local count = #data.deckSchemes
    local card = nil
    for i = 1, count do
      card = (CardData.GetCardData)(((data.deckSchemes)[i]).id)
      if card then
        fc = fc + card.fc
      else
        loge("card:" .. ((data.deckSchemes)[i]).id .. " not exists")
      end
    end
  end
  do
    return fc
  end
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetData.ClearData = function(...)
  -- function num : 0_2 , upvalues : self
  self.Initialized = false
  self.ChosedPresetId = 0
  self.PresetData = {}
  self.PresetFC = {}
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetData.CompareFormation = function(formation1, formation2, ...)
  -- function num : 0_3 , upvalues : _ENV
  if formation1 == nil or formation2 == nil then
    return false
  end
  if #formation1 ~= #formation2 then
    return false
  else
    local info1 = {}
    local count = #formation1
    for i = 1, count do
      info1[(formation1[i]).id] = (formation1[i]).value
    end
    count = #formation2
    for i = 1, count do
      if (formation2[i]).value == info1[(formation2[i]).id] then
        info1[(formation2[i]).id] = nil
      end
    end
    return (_G.next)(info1) == nil
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetData.RefreshPresetFC = function(...)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  FormationPresetData.PresetFC = {}
  local count = #FormationPresetData.PresetData
  local data, card, subCount, fc = nil, nil, nil, nil
  for i = 1, count do
    data = (FormationPresetData.PresetData)[i]
    subCount = #data.deckSchemes
    fc = 0
    for j = 1, subCount do
      card = (CardData.GetCardData)(((data.deckSchemes)[j]).id)
      if card then
        fc = fc + card.fc
      else
        loge("card:" .. ((data.deckSchemes)[i]).id .. " not exists")
      end
    end
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (FormationPresetData.PresetFC)[data.id] = fc
    ;
    (table.sort)(data.deckSchemes, FormationPresetData.FormationSort)
  end
  ;
  (table.sort)(FormationPresetData.PresetData, FormationPresetData.Sort)
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetData.Sort = function(x, y, ...)
  -- function num : 0_5 , upvalues : _ENV
  if FormationPresetData.ChosedPreset and x.id == (FormationPresetData.ChosedPreset).id then
    return true
  else
    if FormationPresetData.ChosedPreset and y.id == (FormationPresetData.ChosedPreset).id then
      return false
    else
      if (FormationPresetData.PresetFC)[x.id] == (FormationPresetData.PresetFC)[y.id] then
        if x.time == y.time then
          return false
        else
          return x.time < y.time
        end
      else
        return (FormationPresetData.PresetFC)[y.id] < (FormationPresetData.PresetFC)[x.id]
      end
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetData.FormationSort = function(x, y, ...)
  -- function num : 0_6
  if x.value == 0 or y.value == 0 then
    if x.value == 0 and y.value ~= 0 then
      return false
    else
      if x.value ~= 0 and y.value == 0 then
        return true
      else
        return false
      end
    end
  else
    return x.value < y.value
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

FormationPresetData.FindChosedPreset = function(formation, ...)
  -- function num : 0_7 , upvalues : _ENV
  local count = #FormationPresetData.PresetData
  local data, index = nil, nil
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  FormationPresetData.ChosedPreset = nil
  for i = 1, count do
    data = (FormationPresetData.PresetData)[i]
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R8 in 'UnsetPending'

    if (FormationPresetData.CompareFormation)(formation, data.deckSchemes) then
      FormationPresetData.ChosedPreset = (Util.Copy)(data)
      index = i
    end
  end
end


