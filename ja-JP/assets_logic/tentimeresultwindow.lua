-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_TenTimeResultWindowByName")
local TenTimeResultWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
TenTimeResultWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, TenTimeResultWindow
  bridgeObj:SetView((WinResConfig.TenTimeResultWindow).package, (WinResConfig.TenTimeResultWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_TenTimeResultWindowUis(contentPane)
  ;
  (TenTimeResultWindow.InitVariable)()
  ;
  (TenTimeResultWindow.InitText)()
  ;
  (TenTimeResultWindow.InitList)()
  ;
  (TenTimeResultWindow.InitButtonEvent)()
end

TenTimeResultWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : uis, TenTimeResultWindow
  (((uis.TenTimeResultGrp).SureBtn).onClick):Add(TenTimeResultWindow.ClickCloseBtn)
  ;
  (((uis.TenTimeResultGrp).CloseBtn).onClick):Add(TenTimeResultWindow.ClickCloseBtn)
end

TenTimeResultWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.TenTimeResultGrp).SureBtn).text = (PUtil.get)(60000004)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TenTimeResultGrp).titlenameTxt).text = (PUtil.get)(60000530)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.TenTimeResultGrp).Tips_A_Grp).NameTxt).text = (PUtil.get)(60000531)
end

TenTimeResultWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : uis, TenTimeResultWindow
  (((uis.TenTimeResultGrp).Tips_B_Grp).TipsList):SetVirtual()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.TenTimeResultGrp).Tips_B_Grp).TipsList).itemRenderer = TenTimeResultWindow.RefreshEventItems
end

TenTimeResultWindow.InitButtonEvent = function(...)
  -- function num : 0_4
end

TenTimeResultWindow.InitEvent = function(...)
  -- function num : 0_5
end

TenTimeResultWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

TenTimeResultWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : TenTimeResultWindow
  (TenTimeResultWindow.InitEvent)()
  ;
  (TenTimeResultWindow.Init)()
end

TenTimeResultWindow.OnHide = function(...)
  -- function num : 0_8
end

TenTimeResultWindow.Init = function(...)
  -- function num : 0_9 , upvalues : argTable, uis, _ENV, TenTimeResultWindow
  local count = #argTable[1]
  local data = nil
  ;
  (((uis.TenTimeResultGrp).Tips_A_Grp).ItemList):RemoveChildrenToPool()
  for k,v in pairs(argTable[1]) do
    (Util.SetFrame)(v.id, v.value, ((uis.TenTimeResultGrp).Tips_A_Grp).ItemList)
  end
  ;
  (TenTimeResultWindow.RefreshUndoneEvent)()
end

TenTimeResultWindow.RefreshUndoneEvent = function(...)
  -- function num : 0_10 , upvalues : uis, argTable
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.TenTimeResultGrp).Tips_B_Grp).TipsList).numItems = #argTable[2]
end

TenTimeResultWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _ENV, TenTimeResultWindow, uis, contentPane, argTable
  UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_UNDONE_EVENT)
  ;
  (TenTimeResultWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

TenTimeResultWindow.ClickCloseBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.TenTimeResultWindow).name)
end

TenTimeResultWindow.RefreshEventItems = function(index, item, ...)
  -- function num : 0_13 , upvalues : argTable, _ENV
  local data = (argTable[2])[index + 1]
  local config = ((TableData.gTable).BaseAdventureEventData)[data.EventId]
  ;
  (item:GetController("c2")).selectedIndex = 1
  if config.type == AdventureEventType.Building then
    (item:GetController("c1")).selectedIndex = 5
  else
    ;
    (item:GetController("c1")).selectedIndex = (AdventureData.EVENT_ICON_INDEX)[config.event_icon]
  end
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : _ENV, config, data
    (AdventureMgr.TriggerEvent)(config.type, data.NodeId, tonumber(config.parameter), data.Uid)
  end
)
end

TenTimeResultWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14 , upvalues : _ENV, TenTimeResultWindow
  if msgId == (WindowMsgEnum.Adventure).E_MSG_REFRESH_UNDONE_EVENT then
    (TenTimeResultWindow.RefreshUndoneEvent)()
  end
end

return TenTimeResultWindow

