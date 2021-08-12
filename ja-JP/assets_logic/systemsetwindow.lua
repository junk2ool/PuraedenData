-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_SystemSetWindowByName")
require("ActorInfo_BattleSetByName")
require("ActorInfo_MassageSetByName")
require("ActorInfo_SoundSetByName")
require("ActorInfo_UISetByName")
require("ActorInfo_PushSetByName")
local SystemSetWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local pushSetData = {}
local _battleGrp, _uiSetGrp, _messageSetGrp, _soundSetGrp, isPause, _pushSetGrp, _isShowPushSet = nil, nil, nil, nil, nil, nil, nil
SystemSetWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, isPause, uis, SystemSetWindow
  bridgeObj:SetView((WinResConfig.SystemSetWindow).package, (WinResConfig.SystemSetWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argTable.Type = argTable[1]
  argTable.Replay = argTable[2]
  isPause = false
  if argTable.Type ~= SystemSetType.NonBattle then
    if Time.timeScale == 0 then
      isPause = true
    else
      ;
      (BattleMgr.PauseBattle)()
    end
  end
  uis = GetActorInfo_SystemSetWindowUis(contentPane)
  ;
  (SystemSetWindow.InitVariable)()
  ;
  (SystemSetWindow.InitText)()
  ;
  (SystemSetWindow.InitButtonEvent)()
end

SystemSetWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _isShowPushSet, _ENV, _battleGrp, uis, _uiSetGrp, _pushSetGrp, _messageSetGrp, _soundSetGrp
  _isShowPushSet = SuperSDKUtil.IsUseSDKPush
  if _isShowPushSet == true then
    _battleGrp = GetActorInfo_BattleSetUis(((uis.SystemSetGrp).SetList):GetChildAt(0))
    _uiSetGrp = GetActorInfo_UISetUis(((uis.SystemSetGrp).SetList):GetChildAt(1))
    _pushSetGrp = GetActorInfo_PushSetUis(((uis.SystemSetGrp).SetList):GetChildAt(2))
    _messageSetGrp = GetActorInfo_MassageSetUis(((uis.SystemSetGrp).SetList):GetChildAt(3))
    _soundSetGrp = GetActorInfo_SoundSetUis(((uis.SystemSetGrp).SetList):GetChildAt(4))
  else
    ;
    ((uis.SystemSetGrp).SetList):RemoveChildrenToPool()
    ;
    ((uis.SystemSetGrp).SetList):AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "BattleSet"))
    ;
    ((uis.SystemSetGrp).SetList):AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "UISet"))
    ;
    ((uis.SystemSetGrp).SetList):AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "MassageSet"))
    ;
    ((uis.SystemSetGrp).SetList):AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "SoundSet"))
    _battleGrp = GetActorInfo_BattleSetUis(((uis.SystemSetGrp).SetList):GetChildAt(0))
    _uiSetGrp = GetActorInfo_UISetUis(((uis.SystemSetGrp).SetList):GetChildAt(1))
    _messageSetGrp = GetActorInfo_MassageSetUis(((uis.SystemSetGrp).SetList):GetChildAt(2))
    _soundSetGrp = GetActorInfo_SoundSetUis(((uis.SystemSetGrp).SetList):GetChildAt(3))
  end
end

SystemSetWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, argTable, _battleGrp, SystemSetWindow, _uiSetGrp, _messageSetGrp, _soundSetGrp, _isShowPushSet, _pushSetGrp, pushSetData
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.SystemSetGrp).TitleTxt).text = (PUtil.get)(114)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  if argTable.Type == SystemSetType.Battle or argTable.Replay then
    ((uis.SystemSetGrp).SureBtn).text = (PUtil.get)(40001001)
  else
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.SystemSetGrp).SureBtn).text = (PUtil.get)(60000004)
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.SystemSetGrp).BattleOutBtn).text = (PUtil.get)(40001000)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_battleGrp.NameTxt).text = (PUtil.get)(60000348)
  ;
  (SystemSetWindow.InitSingleGrpText)(_battleGrp, 1, 60000349, 60000360, 60000361)
  ;
  (SystemSetWindow.InitSingleGrpText)(_battleGrp, 2, 60000350, 60000360, 60000361)
  ;
  (SystemSetWindow.InitSingleGrpText)(_battleGrp, 3, 60000382, 60000360, 60000361)
  ;
  (SystemSetWindow.InitSingleGrpText)(_battleGrp, 4, 60000383, 60000360, 60000361)
  ;
  (SystemSetWindow.InitSingleGrpText)(_battleGrp, 5, 60000384, 60000360, 60000361)
  ;
  (SystemSetWindow.InitSingleGrpText)(_battleGrp, 6, 40002021, 60000360, 60000361)
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_uiSetGrp.NameTxt).text = (PUtil.get)(60000353)
  -- DECOMPILER ERROR at PC96: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_uiSetGrp.ExplainTxt).text = (PUtil.get)(60000506)
  ;
  (SystemSetWindow.InitSingleGrpText)(_uiSetGrp, 1, 60000354, 60000351, 60000352)
  ;
  (SystemSetWindow.InitSingleGrpText)(_uiSetGrp, 2, 60000355, 60000351, 60000352)
  ;
  (SystemSetWindow.InitSingleGrpText)(_uiSetGrp, 3, 40002020, 60000351, 60000352)
  -- DECOMPILER ERROR at PC123: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_messageSetGrp.NameTxt).text = (PUtil.get)(20000604)
  ;
  (SystemSetWindow.InitSingleGrpText)(_messageSetGrp, 1, 60000385, 60000360, 60000361)
  ;
  (SystemSetWindow.InitSingleGrpText)(_messageSetGrp, 2, 60000481, 60000360, 60000361)
  -- DECOMPILER ERROR at PC143: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_soundSetGrp.NameTxt).text = (PUtil.get)(60000356)
  -- DECOMPILER ERROR at PC150: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_soundSetGrp.SoundControl_01_Grp).NameTxt).text = (PUtil.get)(60000357)
  -- DECOMPILER ERROR at PC157: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_soundSetGrp.SoundControl_02_Grp).NameTxt).text = (PUtil.get)(60000358)
  -- DECOMPILER ERROR at PC164: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_soundSetGrp.SoundControl_03_Grp).NameTxt).text = (PUtil.get)(60000359)
  -- DECOMPILER ERROR at PC173: Confused about usage of register: R0 in 'UnsetPending'

  if _isShowPushSet == true then
    (_pushSetGrp.NameTxt).text = (PUtil.get)(20000658)
    -- DECOMPILER ERROR at PC179: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (_pushSetGrp.ExplainTxt).text = (PUtil.get)(20000659)
    local pushData = (TableData.gTable).BaseMessagePushData
    local pushList = {}
    for key,value in pairs(pushData) do
      if pushList[value.push_type] == nil then
        pushList[value.push_type] = value
        ;
        (table.insert)(pushSetData, value)
      end
    end
    ;
    (table.sort)(pushSetData, function(a, b, ...)
    -- function num : 0_2_0
    do return a.push_type < b.push_type end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (SystemSetWindow.InitPushSetList)()
    -- DECOMPILER ERROR at PC211: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (_pushSetGrp.PushTipsList).numItems = #pushSetData
  end
end

SystemSetWindow.PushListRenderer = function(index, obj, ...)
  -- function num : 0_3 , upvalues : pushSetData, SystemSetWindow
  local data = pushSetData[index + 1]
  ;
  (SystemSetWindow.SetPushSet)(obj, data)
end

SystemSetWindow.InitPushSetList = function(...)
  -- function num : 0_4 , upvalues : _pushSetGrp, SystemSetWindow
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  (_pushSetGrp.PushTipsList).itemRenderer = SystemSetWindow.PushListRenderer
end

SystemSetWindow.SetPushSet = function(obj, data, ...)
  -- function num : 0_5 , upvalues : _ENV, SystemSetWindow
  if data == nil then
    obj.visible = false
    return 
  end
  obj.visible = true
  ;
  (obj:GetChild("Content_01_Txt")).text = (PUtil.get)(data.option_name)
  ;
  (((obj:GetChild("Content_01_Grp")):GetChild("Switch_A_Btn")):GetChild("WordTxt")).text = (PUtil.get)(60000360)
  ;
  (((obj:GetChild("Content_01_Grp")):GetChild("Switch_B_Btn")):GetChild("WordTxt")).text = (PUtil.get)(60000361)
  ;
  (((obj:GetChild("Content_01_Grp")):GetChild("Switch_A_Btn")).onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : SystemSetWindow, data, obj
    (SystemSetWindow.ClickPushBtn)(data, obj)
  end
)
  ;
  (((obj:GetChild("Content_01_Grp")):GetChild("Switch_B_Btn")).onClick):Set(function(...)
    -- function num : 0_5_1 , upvalues : SystemSetWindow, data, obj
    (SystemSetWindow.ClickPushBtn)(data, obj)
  end
)
  for k,v in ipairs(ActorData.pushSetInfo) do
    if v ~= true then
      do
        local isOpen = k ~= data.push_type
        ;
        ((obj:GetChild("Content_01_Grp")):GetController("c1")).selectedIndex = isOpen and 0 or 1
        -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

SystemSetWindow.InitSingleGrpText = function(grp, index, title, option1, option2, ...)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  (grp["Content_0" .. tostring(index) .. "_Txt"]).text = (PUtil.get)(title)
  ;
  (((grp["Content_0" .. tostring(index) .. "_Grp"]).Switch_A_Btn):GetChild("WordTxt")).text = (PUtil.get)(option1)
  ;
  (((grp["Content_0" .. tostring(index) .. "_Grp"]).Switch_B_Btn):GetChild("WordTxt")).text = (PUtil.get)(option2)
end

SystemSetWindow.InitButtonEvent = function(...)
  -- function num : 0_7 , upvalues : _battleGrp, SystemSetWindow, _uiSetGrp, _messageSetGrp, _soundSetGrp, uis
  (((_battleGrp.Content_01_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickActionBarBtn)
  ;
  (((_battleGrp.Content_01_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickActionBarBtn)
  ;
  (((_battleGrp.Content_02_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickTopInfoBtn)
  ;
  (((_battleGrp.Content_02_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickTopInfoBtn)
  ;
  (((_battleGrp.Content_03_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickAttackInfoBtn)
  ;
  (((_battleGrp.Content_03_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickAttackInfoBtn)
  ;
  (((_battleGrp.Content_04_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickHpBtn)
  ;
  (((_battleGrp.Content_04_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickHpBtn)
  ;
  (((_battleGrp.Content_05_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickHpBarBtn)
  ;
  (((_battleGrp.Content_05_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickHpBarBtn)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_battleGrp.Content_06_Txt).visible = true
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_battleGrp.Content_06_Grp).root).visible = true
  ;
  (((_battleGrp.Content_06_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickRageBarBtn)
  ;
  (((_battleGrp.Content_06_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickRageBarBtn)
  ;
  (((_uiSetGrp.Content_01_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickBattleFrameBtn)
  ;
  (((_uiSetGrp.Content_01_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickBattleFrameBtn)
  ;
  (((_uiSetGrp.Content_02_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickFrameBtn)
  ;
  (((_uiSetGrp.Content_02_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickFrameBtn)
  ;
  (((_uiSetGrp.Content_03_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickQualityBtn)
  ;
  (((_uiSetGrp.Content_03_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickQualityBtn)
  ;
  (((_messageSetGrp.Content_01_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickScrollInfoBtn)
  ;
  (((_messageSetGrp.Content_01_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickScrollInfoBtn)
  ;
  (((_messageSetGrp.Content_02_Grp).Switch_A_Btn).onClick):Add(SystemSetWindow.ClickConsumTipBtn)
  ;
  (((_messageSetGrp.Content_02_Grp).Switch_B_Btn).onClick):Add(SystemSetWindow.ClickConsumTipBtn)
  ;
  (((_soundSetGrp.SoundControl_01_Grp).SoundBtn).onClick):Add(SystemSetWindow.ClickSoundMuteBtn)
  ;
  (((_soundSetGrp.SoundControl_01_Grp).SoundSlider).onChanged):Add(SystemSetWindow.SoundVolumeChanged)
  ;
  (((_soundSetGrp.SoundControl_02_Grp).SoundBtn).onClick):Add(SystemSetWindow.ClickMusicMuteBtn)
  ;
  (((_soundSetGrp.SoundControl_02_Grp).SoundSlider).onChanged):Add(SystemSetWindow.MusicVolumeChanged)
  ;
  (((_soundSetGrp.SoundControl_03_Grp).SoundBtn).onClick):Add(SystemSetWindow.ClickCVMuteBtn)
  ;
  (((_soundSetGrp.SoundControl_03_Grp).SoundSlider).onChanged):Add(SystemSetWindow.CVVolumeChanged)
  ;
  (((uis.SystemSetGrp).SureBtn).onClick):Set(SystemSetWindow.ClickCloseBtn)
  ;
  (((uis.SystemSetGrp).BattleOutBtn).onClick):Set(SystemSetWindow.ClickBattleOutBtn)
  ;
  (((uis.SystemSetGrp).CloseBtn).onClick):Set(SystemSetWindow.ClickCloseBtn)
end

SystemSetWindow.InitEvent = function(...)
  -- function num : 0_8
end

SystemSetWindow.RemoveEvent = function(...)
  -- function num : 0_9
end

SystemSetWindow.OnShown = function(...)
  -- function num : 0_10 , upvalues : SystemSetWindow
  (SystemSetWindow.InitEvent)()
  ;
  (SystemSetWindow.Init)()
end

SystemSetWindow.OnHide = function(...)
  -- function num : 0_11
end

SystemSetWindow.Init = function(...)
  -- function num : 0_12 , upvalues : argTable, _ENV, uis, _battleGrp, SystemSetWindow, _uiSetGrp, _messageSetGrp, _soundSetGrp
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  if argTable.Type == SystemSetType.Battle or argTable.Replay then
    ((uis.SystemSetGrp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.SystemSetGrp).c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  if tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_SPEED, "0")) == 0 then
    ((_battleGrp.Content_01_Grp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((_battleGrp.Content_01_Grp).c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

  if tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_RAGE_BAR, "0")) == 0 then
    ((_battleGrp.Content_06_Grp).c1Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((_battleGrp.Content_06_Grp).c1Ctr).selectedIndex = 1
  end
  ;
  (SystemSetWindow.UpdateBattleSelection)(true)
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_uiSetGrp.Content_01_Grp).c1Ctr).selectedIndex = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_FRAME, Game.defaultBattleFrame))
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R0 in 'UnsetPending'

  if tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.SCROLL_INFO, "0")) == 0 then
    ((_messageSetGrp.Content_01_Grp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((_messageSetGrp.Content_01_Grp).c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC91: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_messageSetGrp.Content_02_Grp).c1Ctr).selectedIndex = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.IGNORE_DIAMOND_CONSUM_TIPS, "0"))
  -- DECOMPILER ERROR at PC104: Confused about usage of register: R0 in 'UnsetPending'

  if tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.SETTING_FRAME, "0")) == 0 then
    ((_uiSetGrp.Content_02_Grp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC108: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((_uiSetGrp.Content_02_Grp).c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC121: Confused about usage of register: R0 in 'UnsetPending'

  if tonumber((PlayerPrefs.GetString)(PlayerPrefsKeyName.SETTING_QUALITY, "1")) == 0 then
    ((_uiSetGrp.Content_03_Grp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC125: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((_uiSetGrp.Content_03_Grp).c1Ctr).selectedIndex = 0
  end
  ;
  (SystemSetWindow.InitSoundSet)(_soundSetGrp.SoundControl_01_Grp, PlayerPrefsKeyName.SOUND_MUTE, PlayerPrefsKeyName.SOUND_VOLUME)
  ;
  (SystemSetWindow.InitSoundSet)(_soundSetGrp.SoundControl_02_Grp, PlayerPrefsKeyName.MUSIC_MUTE, PlayerPrefsKeyName.MUSIC_VOLUME)
  ;
  (SystemSetWindow.InitSoundSet)(_soundSetGrp.SoundControl_03_Grp, PlayerPrefsKeyName.CV_MUTE, PlayerPrefsKeyName.CV_VOLUME)
end

SystemSetWindow.InitSoundSet = function(grp, muteKey, volumeKey, ...)
  -- function num : 0_13 , upvalues : _ENV, SystemSetWindow
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  (grp.SoundSlider).value = (Util.GetFloatPlayerSetting)(volumeKey, 1) * 100
  local on = (Util.GetPlayerSetting)(muteKey, "0") == "0"
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (grp.SoundBtn).selected = on
  ;
  (SystemSetWindow.InitSoundSlider)(grp, on)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SystemSetWindow.InitSoundSlider = function(grp, on, ...)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (grp.SoundSlider).touchable = on
  local Color = (CS.UnityEngine).Color
  if on then
    ((grp.SoundSlider):GetChild("bar")).color = Color.white
    ;
    (((grp.SoundSlider):GetChild("grip")):GetChild("n4")).color = Color.white
  else
    ;
    ((grp.SoundSlider):GetChild("bar")).color = Color.gray
    ;
    (((grp.SoundSlider):GetChild("grip")):GetChild("n4")).color = Color.gray
  end
end

SystemSetWindow.OnClose = function(...)
  -- function num : 0_15 , upvalues : argTable, _ENV, isPause, _pushSetGrp, SystemSetWindow, uis, contentPane, pushSetData
  if argTable.Type ~= SystemSetType.NonBattle and isPause ~= true then
    (BattleMgr.ContinueBattle)()
  end
  _pushSetGrp = nil
  ;
  (SystemSetWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
  pushSetData = {}
end

SystemSetWindow.ChangeValue = function(keyName, ...)
  -- function num : 0_16 , upvalues : _ENV
  local curValue = tonumber((Util.GetPlayerSetting)(keyName, "0"))
  if curValue == 1 then
    curValue = 0
  else
    curValue = 1
  end
  ;
  (Util.SetPlayerSetting)(keyName, curValue)
  return curValue
end

SystemSetWindow.ClickBattleOutBtn = function(...)
  -- function num : 0_17 , upvalues : _ENV
  if BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).GUILD_WAR then
    (GuildBossService.ReqGuildBattleInfo)(true)
  end
  ;
  (BattleService.SendOutBattle)()
  UIMgr:CloseWindow((WinResConfig.SystemSetWindow).name)
  ;
  (BattleMgr.CloseBattle)()
end

SystemSetWindow.ClickCloseBtn = function(...)
  -- function num : 0_18 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.SystemSetWindow).name)
end

SystemSetWindow.ClickPushBtn = function(data, obj, ...)
  -- function num : 0_19 , upvalues : _ENV
  local state = ((obj:GetChild("Content_01_Grp")):GetController("c1")).selectedIndex
  local receive = state == 0
  ;
  (ActorData.SetPushData)(data, receive)
  ;
  (MessageMgr.SetPushTypeData)(data.push_type, true)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SystemSetWindow.ClickActionBarBtn = function(...)
  -- function num : 0_20 , upvalues : SystemSetWindow, _ENV, _battleGrp, argTable
  local value = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.BATTLE_SETTING_SPEED)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if value == 0 then
    ((_battleGrp.Content_01_Grp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((_battleGrp.Content_01_Grp).c1Ctr).selectedIndex = 0
  end
  if argTable.Type ~= SystemSetType.NonBattle then
    UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_SETTING_UI)
  end
end

SystemSetWindow.ClickTopInfoBtn = function(...)
  -- function num : 0_21 , upvalues : SystemSetWindow, _battleGrp, _ENV, argTable
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if (SystemSetWindow.ClickWithHideBattle)(_battleGrp.Content_02_Grp) ~= true then
    ((_battleGrp.Content_02_Grp).c1Ctr).selectedIndex = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.BATTLE_SETTING_TOP_INFO)
  end
  if argTable.Type ~= SystemSetType.NonBattle then
    UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_SETTING_UI)
  end
end

SystemSetWindow.ClickAttackInfoBtn = function(...)
  -- function num : 0_22 , upvalues : SystemSetWindow, _battleGrp, _ENV, argTable
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if (SystemSetWindow.ClickWithHideBattle)(_battleGrp.Content_03_Grp) ~= true then
    ((_battleGrp.Content_03_Grp).c1Ctr).selectedIndex = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.BATTLE_SETTING_ATTACK)
  end
  if argTable.Type ~= SystemSetType.NonBattle then
    UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_SETTING_UI)
  end
end

SystemSetWindow.ClickHpBtn = function(...)
  -- function num : 0_23 , upvalues : SystemSetWindow, _ENV, _battleGrp, argTable
  local value = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.BATTLE_SETTING_HP)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if value == 0 then
    ((_battleGrp.Content_04_Grp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((_battleGrp.Content_04_Grp).c1Ctr).selectedIndex = 0
  end
  if argTable.Type ~= SystemSetType.NonBattle then
    UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_SETTING_UI)
  end
end

SystemSetWindow.ClickHpBarBtn = function(...)
  -- function num : 0_24 , upvalues : _battleGrp, SystemSetWindow, _ENV, argTable
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((_battleGrp.Content_05_Grp).c1Ctr).selectedIndex = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.BATTLE_SETTING_HP_BAR)
  ;
  (SystemSetWindow.UpdateBattleSelection)()
  if argTable.Type ~= SystemSetType.NonBattle then
    UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_SETTING_UI)
  end
end

SystemSetWindow.ClickRageBarBtn = function(...)
  -- function num : 0_25 , upvalues : SystemSetWindow, _ENV, _battleGrp, argTable
  local value = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.BATTLE_SETTING_RAGE_BAR)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if value == 0 then
    ((_battleGrp.Content_06_Grp).c1Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((_battleGrp.Content_06_Grp).c1Ctr).selectedIndex = 1
  end
  if argTable.Type ~= SystemSetType.NonBattle then
    UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_SETTING_UI)
  end
end

SystemSetWindow.ClickBattleFrameBtn = function(...)
  -- function num : 0_26 , upvalues : SystemSetWindow, _ENV, _uiSetGrp, argTable
  local value = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.BATTLE_SETTING_FRAME)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((_uiSetGrp.Content_01_Grp).c1Ctr).selectedIndex = value
  if argTable.Type ~= SystemSetType.NonBattle then
    (BattleConfig.UpdateCurFrameRate)()
  end
end

SystemSetWindow.ClickWithHideBattle = function(clickItem, ...)
  -- function num : 0_27 , upvalues : _ENV, _battleGrp, SystemSetWindow
  local visible = (BattleConfig.IsHideBattleHeadInfo)() == false
  do
    if visible == false then
      local itemTable = {
{item = _battleGrp.Content_02_Grp, keyName = PlayerPrefsKeyName.BATTLE_SETTING_TOP_INFO}
, 
{item = _battleGrp.Content_03_Grp, keyName = PlayerPrefsKeyName.BATTLE_SETTING_ATTACK}
, 
{item = _battleGrp.Content_04_Grp, keyName = PlayerPrefsKeyName.BATTLE_SETTING_HP}
}
      for _,v in ipairs(itemTable) do
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

        if clickItem == v.item then
          ((v.item).c1Ctr).selectedIndex = 0
          ;
          (Util.SetPlayerSetting)(v.keyName, 0)
        else
          -- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'

          ((v.item).c1Ctr).selectedIndex = 1
          ;
          (Util.SetPlayerSetting)(v.keyName, 1)
        end
      end
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((_battleGrp.Content_05_Grp).c1Ctr).selectedIndex = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.BATTLE_SETTING_HP_BAR)
      return true
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

SystemSetWindow.UpdateBattleSelection = function(init, ...)
  -- function num : 0_28 , upvalues : _ENV, _battleGrp
  local visible = (BattleConfig.IsHideBattleHeadInfo)() == false
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  if visible == true then
    ((_battleGrp.Content_02_Grp).c1Ctr).selectedIndex = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_TOP_INFO, "0"))
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((_battleGrp.Content_03_Grp).c1Ctr).selectedIndex = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_ATTACK, "0"))
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

    if tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_HP, "0")) == 0 then
      ((_battleGrp.Content_04_Grp).c1Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

      ((_battleGrp.Content_04_Grp).c1Ctr).selectedIndex = 0
    end
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

    if init == true then
      ((_battleGrp.Content_05_Grp).c1Ctr).selectedIndex = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_HP_BAR, "0"))
    end
  else
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R2 in 'UnsetPending'

    ((_battleGrp.Content_02_Grp).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((_battleGrp.Content_03_Grp).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((_battleGrp.Content_04_Grp).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R2 in 'UnsetPending'

    if init == true then
      ((_battleGrp.Content_05_Grp).c1Ctr).selectedIndex = 1
    end
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

SystemSetWindow.ClickFrameBtn = function(...)
  -- function num : 0_29 , upvalues : SystemSetWindow, _ENV, _uiSetGrp
  local value = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.SETTING_FRAME)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if value == 0 then
    ((_uiSetGrp.Content_02_Grp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((_uiSetGrp.Content_02_Grp).c1Ctr).selectedIndex = 0
  end
  ;
  (Game.SetMainFramerate)()
end

SystemSetWindow.ClickQualityBtn = function(...)
  -- function num : 0_30 , upvalues : _ENV, _uiSetGrp
  local launch = (CS.Launch).Singleton
  local value = tonumber((PlayerPrefs.GetString)(PlayerPrefsKeyName.SETTING_QUALITY, "1"))
  if value == 1 then
    (PlayerPrefs.SetString)(PlayerPrefsKeyName.SETTING_QUALITY, "0")
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((_uiSetGrp.Content_03_Grp).c1Ctr).selectedIndex = 1
    launch:SetHResolution(Game.resolutionRatioMin)
  else
    ;
    (PlayerPrefs.SetString)(PlayerPrefsKeyName.SETTING_QUALITY, "1")
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((_uiSetGrp.Content_03_Grp).c1Ctr).selectedIndex = 0
    launch:SetHResolution(Game.resolutionRatioMax)
  end
end

SystemSetWindow.ClickScrollInfoBtn = function(...)
  -- function num : 0_31 , upvalues : SystemSetWindow, _ENV, _messageSetGrp
  local value = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.SCROLL_INFO)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if value == 0 then
    ((_messageSetGrp.Content_01_Grp).c1Ctr).selectedIndex = 1
    if UIMgr:IsWindowOpen((WinResConfig.NoticeWindow).name) then
      UIMgr:CloseWindow((WinResConfig.NoticeWindow).name)
    end
    ;
    (ActorService.ReqHorseSet)(false)
  else
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((_messageSetGrp.Content_01_Grp).c1Ctr).selectedIndex = 0
    ;
    (ActorService.ReqHorseSet)(true)
  end
end

SystemSetWindow.ClickConsumTipBtn = function(...)
  -- function num : 0_32 , upvalues : SystemSetWindow, _ENV, _messageSetGrp
  local value = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.IGNORE_DIAMOND_CONSUM_TIPS)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((_messageSetGrp.Content_02_Grp).c1Ctr).selectedIndex = value
end

SystemSetWindow.ClickSoundMuteBtn = function(...)
  -- function num : 0_33 , upvalues : SystemSetWindow, _ENV, _soundSetGrp
  local on = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.SOUND_MUTE) == 0
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((_soundSetGrp.SoundControl_01_Grp).SoundBtn).selected = on
  ;
  (LuaSound.UpdateSoundInfo)()
  ;
  (SystemSetWindow.InitSoundSlider)(_soundSetGrp.SoundControl_01_Grp, on)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SystemSetWindow.ClickMusicMuteBtn = function(...)
  -- function num : 0_34 , upvalues : SystemSetWindow, _ENV, _soundSetGrp, argTable
  local on = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.MUSIC_MUTE) == 0
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((_soundSetGrp.SoundControl_02_Grp).SoundBtn).selected = on
  if on then
    if argTable.Type == SystemSetType.NonBattle then
      (LuaSound.LoadAndPlayBGM)(1010001)
    else
      (LuaSound.LoadAndPlayBGM)(BattleData.soundId)
    end
  else
    (LuaSound.StopBGM)()
  end
  ;
  (SystemSetWindow.InitSoundSlider)(_soundSetGrp.SoundControl_02_Grp, on)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

SystemSetWindow.ClickCVMuteBtn = function(...)
  -- function num : 0_35 , upvalues : SystemSetWindow, _ENV, _soundSetGrp
  local on = (SystemSetWindow.ChangeValue)(PlayerPrefsKeyName.CV_MUTE) == 0
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((_soundSetGrp.SoundControl_03_Grp).SoundBtn).selected = on
  ;
  (SystemSetWindow.InitSoundSlider)(_soundSetGrp.SoundControl_03_Grp, on)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SystemSetWindow.SoundVolumeChanged = function(...)
  -- function num : 0_36 , upvalues : _soundSetGrp, _ENV
  local value = ((_soundSetGrp.SoundControl_01_Grp).SoundSlider).value / 100
  ;
  (Util.SetFloatPlayerSetting)(PlayerPrefsKeyName.SOUND_VOLUME, value)
  ;
  (LuaSound.UpdateSoundInfo)()
end

SystemSetWindow.MusicVolumeChanged = function(...)
  -- function num : 0_37 , upvalues : _soundSetGrp, _ENV
  local value = ((_soundSetGrp.SoundControl_02_Grp).SoundSlider).value / 100
  ;
  (LuaSound.ChangeBGMVolume)(value)
  ;
  (Util.SetFloatPlayerSetting)(PlayerPrefsKeyName.MUSIC_VOLUME, value)
end

SystemSetWindow.CVVolumeChanged = function(...)
  -- function num : 0_38 , upvalues : _soundSetGrp, _ENV
  local value = ((_soundSetGrp.SoundControl_03_Grp).SoundSlider).value / 100
  ;
  (Util.SetFloatPlayerSetting)(PlayerPrefsKeyName.CV_VOLUME, value)
end

SystemSetWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_39
end

return SystemSetWindow

