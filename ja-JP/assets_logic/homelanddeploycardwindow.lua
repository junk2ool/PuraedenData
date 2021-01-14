-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_LiveWindowByName")
local HomelandDeployCardWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _allCards = {}
local _cardIndex = {}
local _roomDeployItem, _initRoleCount = nil, nil
HomelandDeployCardWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HomelandDeployCardWindow
  bridgeObj:SetView((WinResConfig.HomelandDeployCardWindow).package, (WinResConfig.HomelandDeployCardWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argTable.Slots = argTable[1]
  uis = GetFamily_LiveWindowUis(contentPane)
  ;
  (HomelandDeployCardWindow.InitVariable)()
  ;
  (HomelandDeployCardWindow.InitText)()
  ;
  (HomelandDeployCardWindow.InitList)()
  ;
  (HomelandDeployCardWindow.InitButtonEvent)()
  ;
  (HomelandDeployCardWindow.BindingUI)()
  ;
  (HomelandDeployCardWindow.InitFunctionControl)()
end

HomelandDeployCardWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _initRoleCount, _ENV
  _initRoleCount = #(HomelandData.RoomData).Role
end

HomelandDeployCardWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.Live).TitleTxt).text = (PUtil.get)(60000608)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Live).TipsTxt).text = (PUtil.get)(60000548)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Live).SureBtn).text = (PUtil.get)(60000004)
end

HomelandDeployCardWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : uis, HomelandDeployCardWindow
  ((uis.Live).CardHeadList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Live).CardHeadList).itemRenderer = HomelandDeployCardWindow.RefreshAllCardItem
end

HomelandDeployCardWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, HomelandDeployCardWindow
  (((uis.Live).SureBtn).onClick):Set(HomelandDeployCardWindow.ClickCloseBtn)
  ;
  (((uis.Live).CloseBtn).onClick):Set(HomelandDeployCardWindow.ClickCloseBtn)
end

HomelandDeployCardWindow.BindingUI = function(...)
  -- function num : 0_5
end

HomelandDeployCardWindow.InitFunctionControl = function(...)
  -- function num : 0_6
end

HomelandDeployCardWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : HomelandDeployCardWindow
  (HomelandDeployCardWindow.Init)()
end

HomelandDeployCardWindow.Init = function(...)
  -- function num : 0_8 , upvalues : HomelandDeployCardWindow, _allCards, _ENV, uis
  (HomelandDeployCardWindow.RefreshLeftPanel)()
  _allCards = (CardData.GetObtainedCardList)()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Live).CardHeadList).numItems = #_allCards
end

HomelandDeployCardWindow.RefreshLeftPanel = function(...)
  -- function num : 0_9 , upvalues : uis, _roomDeployItem, _ENV, HomelandDeployCardWindow
  ((uis.Live).LivePlaceList):RemoveChildrenToPool()
  _roomDeployItem = ((uis.Live).LivePlaceList):AddItemFromPool()
  ;
  (_roomDeployItem:GetChild("TitleTxt")).text = (PUtil.get)(60000547)
  ;
  (HomelandDeployCardWindow.RefreshDeployCard)()
end

HomelandDeployCardWindow.RefreshDeployCard = function(...)
  -- function num : 0_10 , upvalues : _roomDeployItem, _ENV
  local list = _roomDeployItem:GetChild("CardHeadList")
  list:RemoveChildrenToPool()
  local item = nil
  local index = 0
  for k,v in pairs((HomelandData.RoomData).Role) do
    index = index + 1
    local cardId = v.cardId
    do
      item = list:AddItemFromPool()
      ;
      (item:GetController("c1")).selectedIndex = 0
      ;
      (Util.SetHeadFrame)(item:GetChild("HeadFrame"), (CardData.GetCardData)(cardId))
      ;
      (item.onClick):Set(function(...)
    -- function num : 0_10_0 , upvalues : _ENV, cardId
    (HomelandMgr.UnDeployCard)(cardId)
  end
)
    end
  end
  local maxRole = (((HomelandData.RoomByLevel)[(HomelandData.RoomData).Type])[(HomelandData.RoomData).Level]).RoleAmount
  ;
  (_roomDeployItem:GetChild("NumberTxt")).text = "[color=" .. Const.GreenColor .. "]" .. index .. "[/color]/" .. maxRole
  for i = index + 1, maxRole do
    item = list:AddItemFromPool()
    ;
    (item:GetController("c1")).selectedIndex = 1
  end
  list.numItems = maxRole
end

HomelandDeployCardWindow.RefreshAllCardItem = function(index, item, ...)
  -- function num : 0_11 , upvalues : _allCards, _ENV, argTable, _initRoleCount
  index = index + 1
  local data = _allCards[index]
  ;
  (Util.SetHeadFrame)(item, data)
  if (HomelandData.UsedCard)[data.id] then
    (item:GetController("c3")).selectedIndex = 7
    ;
    (item.onClick):Clear()
  else
    ;
    (item:GetController("c3")).selectedIndex = 0
    local clicked = false
    do
      (item.onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : clicked, _ENV, data, argTable, _initRoleCount
    if clicked then
      return 
    end
    clicked = true
    ;
    (HomelandMgr.DeployCard)(data.id, (((HomelandData.RoomByLevel)[(HomelandData.RoomData).Type])[(HomelandData.RoomData).Level]).RoleAmount, argTable.Slots + _initRoleCount - #(HomelandData.RoomData).Role)
  end
)
    end
  end
end

HomelandDeployCardWindow.OnHide = function(...)
  -- function num : 0_12
end

HomelandDeployCardWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

HomelandDeployCardWindow.ClickCloseBtn = function(...)
  -- function num : 0_14 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.HomelandDeployCardWindow).name)
end

HomelandDeployCardWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15 , upvalues : _ENV, HomelandDeployCardWindow, uis
  if msgId == (WindowMsgEnum.Family).E_MSG_REFRESH_ROOM_ROLES then
    (HomelandDeployCardWindow.RefreshDeployCard)()
    ;
    ((uis.Live).CardHeadList):RefreshVirtualList()
  end
end

return HomelandDeployCardWindow

