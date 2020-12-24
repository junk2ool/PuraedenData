-- params : ...
-- function num : 0 , upvalues : _ENV
require("Formation_TeamRenameWindowByName")
local FormationPresetNamingWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _lastContent = nil
FormationPresetNamingWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, FormationPresetNamingWindow
  bridgeObj:SetView((WinResConfig.FormationPresetNamingWindow).package, (WinResConfig.FormationPresetNamingWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetFormation_TeamRenameWindowUis(contentPane)
  ;
  (FormationPresetNamingWindow.InitText)()
  ;
  (FormationPresetNamingWindow.InitButtonEvent)()
end

FormationPresetNamingWindow.InitText = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.TeamRename).NameTxt).promptText = "[color=" .. Const.GrayColor .. "]" .. (PUtil.get)(60000457) .. "[/color]"
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TeamRename).TitleTxt).text = (PUtil.get)(60000604)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TeamRename).WordTxt).text = (PUtil.get)(60000317, (FormationPresetData.Constant).MaxPresetNameLength)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TeamRename).SureBtn).text = (PUtil.get)(60000004)
end

FormationPresetNamingWindow.InitButtonEvent = function(...)
  -- function num : 0_2 , upvalues : uis, FormationPresetNamingWindow
  (((uis.TeamRename).CloseBtn).onClick):Add(FormationPresetNamingWindow.ClickCloseBtn)
  ;
  (((uis.TeamRename).SureBtn).onClick):Add(FormationPresetNamingWindow.ClickConfirmBtn)
  ;
  (((uis.TeamRename).NameTxt).onChanged):Add(FormationPresetNamingWindow.OnChangedText)
end

FormationPresetNamingWindow.OnShown = function(...)
  -- function num : 0_3 , upvalues : uis, argTable
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.TeamRename).NameTxt).text = argTable[1]
end

FormationPresetNamingWindow.OnHide = function(...)
  -- function num : 0_4
end

FormationPresetNamingWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

FormationPresetNamingWindow.ClickCloseBtn = function(...)
  -- function num : 0_6 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.FormationPresetNamingWindow).name)
end

FormationPresetNamingWindow.ClickConfirmBtn = function(...)
  -- function num : 0_7 , upvalues : uis, _ENV, FormationPresetNamingWindow
  local name = ((uis.TeamRename).NameTxt).text
  if (Util.NameCheck)(name, (PUtil.get)(60000377), Const.MIN_NAME_LENGTH, (FormationPresetData.Constant).MaxPresetNameLength) == false then
    return 
  end
  name = (Util.StrUnicodeSub)(name, 1, (FormationPresetData.Constant).MaxPresetNameLength)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (FormationPresetData.EditPreset).name = name
  UIMgr:SendWindowMessage((WinResConfig.FormationWindow).name, (WindowMsgEnum.FormationPreset).E_MSG_REFRESH_PRESET_NAME, name)
  ;
  (FormationPresetNamingWindow.ClickCloseBtn)()
end

FormationPresetNamingWindow.OnChangedText = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis, _lastContent
  local left = (FormationPresetData.Constant).MaxPresetNameLength - (Util.StrUnicodeLength)(((uis.TeamRename).NameTxt).text)
  if left >= 0 then
    _lastContent = ((uis.TeamRename).NameTxt).text
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.TeamRename).NameTxt).text = _lastContent
  end
end

FormationPresetNamingWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9
end

return FormationPresetNamingWindow

