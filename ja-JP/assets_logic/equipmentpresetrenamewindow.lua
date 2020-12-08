-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_ReNameWindowByName")
local EquipmentPresetRenameWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
EquipmentPresetRenameWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, EquipmentPresetRenameWindow
  bridgeObj:SetView((WinResConfig.EquipmentPresetRenameWindow).package, (WinResConfig.EquipmentPresetRenameWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argTable.Name = argTable[1]
  uis = GetEquipt_ReNameWindowUis(contentPane)
  ;
  (EquipmentPresetRenameWindow.InitVariable)()
  ;
  (EquipmentPresetRenameWindow.InitText)()
  ;
  (EquipmentPresetRenameWindow.InitButtonEvent)()
end

EquipmentPresetRenameWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.ReNameGrp).NameTxt).maxLength = (((TableData.gTable).BaseFixedData)[EquiptData.MAX_PRESET_NAME_LENGTH]).int_value
end

EquipmentPresetRenameWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.ReNameGrp).TitleTxt).text = (PUtil.get)(60000577)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ReNameGrp).WordTxt).text = (PUtil.get)(60000317, (((TableData.gTable).BaseFixedData)[EquiptData.MAX_PRESET_NAME_LENGTH]).int_value)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ReNameGrp).SureBtn).text = (PUtil.get)(60000004)
end

EquipmentPresetRenameWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, EquipmentPresetRenameWindow
  (((uis.ReNameGrp).CloseBtn).onClick):Set(EquipmentPresetRenameWindow.ClickCloseBtn)
  ;
  (((uis.ReNameGrp).SureBtn).onClick):Set(EquipmentPresetRenameWindow.ClickSaveBtn)
end

EquipmentPresetRenameWindow.OnShown = function(...)
  -- function num : 0_4 , upvalues : EquipmentPresetRenameWindow
  (EquipmentPresetRenameWindow.Init)()
end

EquipmentPresetRenameWindow.OnHide = function(...)
  -- function num : 0_5
end

EquipmentPresetRenameWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

EquipmentPresetRenameWindow.Init = function(...)
  -- function num : 0_7 , upvalues : uis, argTable
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.ReNameGrp).NameTxt).text = argTable.Name
end

EquipmentPresetRenameWindow.ClickCloseBtn = function(...)
  -- function num : 0_8 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.EquipmentPresetRenameWindow).name)
end

EquipmentPresetRenameWindow.ClickSaveBtn = function(...)
  -- function num : 0_9 , upvalues : uis, _ENV, EquipmentPresetRenameWindow
  local name = ((uis.ReNameGrp).NameTxt).text
  if (Util.NameCheck)(name, (PUtil.get)(60000377), Const.MIN_NAME_LENGTH, Const.MAX_NAME_LENGTH) == false then
    return 
  end
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_PRESET_NAME, name)
  ;
  (EquipmentPresetRenameWindow.ClickCloseBtn)()
end

EquipmentPresetRenameWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_10
end

return EquipmentPresetRenameWindow

