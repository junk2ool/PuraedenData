-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_VisitPlayWindowByName")
local HomelandVisitRoomWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _currentData = {}
local _friendData, _guildData, _selfIndex, _notFoundEffect, _inAnim, _nothingGroup = nil, nil, nil, nil, nil, nil
HomelandVisitRoomWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HomelandVisitRoomWindow
  bridgeObj:SetView((WinResConfig.HomelandVisitRoomWindow).package, (WinResConfig.HomelandVisitRoomWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetFamily_VisitPlayWindowUis(contentPane)
  ;
  (HomelandVisitRoomWindow.InitVariable)()
  ;
  (HomelandVisitRoomWindow.InitText)()
  ;
  (HomelandVisitRoomWindow.InitList)()
  ;
  (HomelandVisitRoomWindow.InitButtonEvent)()
  ;
  (HomelandVisitRoomWindow.BindingUI)()
  ;
  (HomelandVisitRoomWindow.InitFunctionControl)()
end

HomelandVisitRoomWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _inAnim, uis, _nothingGroup, _ENV
  _inAnim = (uis.root):GetTransition("in")
  _nothingGroup = (((uis.VisitPlay).PlayerList).root):GetChild("NothingGrp")
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.VisitPlay).SureBtn).text = (PUtil.get)(60000004)
  ;
  ((((uis.VisitPlay).PlayerList).FriendsBtn):GetChild("NameTxt")).text = (PUtil.get)(20000566)
  ;
  ((((uis.VisitPlay).PlayerList).GuildBtn):GetChild("NameTxt")).text = (PUtil.get)(60000254)
end

HomelandVisitRoomWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.VisitPlay).TitleTxt).text = (PUtil.get)(60000607)
end

HomelandVisitRoomWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : uis, HomelandVisitRoomWindow
  (((uis.VisitPlay).PlayerList).PlayerList):SetVirtual()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.VisitPlay).PlayerList).PlayerList).itemRenderer = HomelandVisitRoomWindow.RefreshPlayerItem
end

HomelandVisitRoomWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, HomelandVisitRoomWindow
  (((uis.VisitPlay).SureBtn).onClick):Set(HomelandVisitRoomWindow.ClickCloseBtn)
  ;
  (((uis.VisitPlay).CloseBtn).onClick):Set(HomelandVisitRoomWindow.ClickCloseBtn)
  ;
  ((((uis.VisitPlay).PlayerList).FriendsBtn).onClick):Set(HomelandVisitRoomWindow.ClickFriendBtn)
end

HomelandVisitRoomWindow.BindingUI = function(...)
  -- function num : 0_5
end

HomelandVisitRoomWindow.InitFunctionControl = function(...)
  -- function num : 0_6
end

HomelandVisitRoomWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : HomelandVisitRoomWindow
  (HomelandVisitRoomWindow.Init)()
end

HomelandVisitRoomWindow.Init = function(...)
  -- function num : 0_8 , upvalues : _friendData, _ENV, _guildData, argTable, uis, HomelandVisitRoomWindow, _currentData
  _friendData = FriendsData.FriendsList
  if GuildData ~= nil then
    _guildData = GuildData.MemberList
  else
    _guildData = {}
  end
  if argTable[1] then
    ((((uis.VisitPlay).PlayerList).GuildBtn).onClick):Set(HomelandVisitRoomWindow.ClickGuildBtn)
  else
    ;
    ((((uis.VisitPlay).PlayerList).GuildBtn).onClick):Set(function(...)
    -- function num : 0_8_0 , upvalues : _ENV, _currentData, HomelandVisitRoomWindow
    (MessageMgr.SendCenterTips)((PUtil.get)(20000280))
    _currentData = {}
    ;
    (HomelandVisitRoomWindow.RefreshContent)(60000560)
  end
)
  end
  ;
  (HomelandVisitRoomWindow.ClickFriendBtn)()
end

HomelandVisitRoomWindow.RefreshPlayerItem = function(index, item, ...)
  -- function num : 0_9 , upvalues : _selfIndex, _currentData, _ENV, HomelandVisitRoomWindow
  index = index + 1
  local data = nil
  if _selfIndex and _selfIndex < index then
    index = index + 1
  end
  data = _currentData[index]
  if not data.playerIndex then
    local id = data.objectindex
  end
  if (ActorData.baseInfo).playerIndex == id then
    _selfIndex = index
    data = _currentData[index + 1]
  end
  if not data.name then
    (item:GetChild("PlayerNameTxt")).text = data.nickName
    local headCom = item:GetChild("PlayerHead")
    ;
    (headCom:GetChild("LevelTxt")).text = "Lv." .. data.level
    if not data.fashionHead then
      local head = data.fashionId
    end
    local fashionConfig = ((TableData.gTable).BasePlayerHeadIconData)[head]
    if fashionConfig then
      (headCom:GetChild("ActorHeadLoader")).url = (Util.GetResUrl)(fashionConfig.icon_path)
    end
    local fcCom = item:GetChild("BattleInfo")
    ;
    (fcCom:GetChild("NameTxt")).text = (PUtil.get)(60000235)
    ;
    (fcCom:GetChild("WordTxt")).text = data.fc
    local title = data.titleId
    if title == 0 then
      ((item:GetChild("TitlePic")):GetChild("PicLoader")).url = nil
    else
      ;
      ((item:GetChild("TitlePic")):GetChild("PicLoader")).url = (Util.GetItemUrl)((((TableData.gTable).BasePlayerTitleData)[title]).icon)
    end
    local btn = item:GetChild("VisitBtn")
    btn.text = (PUtil.get)(60000552)
    ;
    (btn.onClick):Set(function(...)
    -- function num : 0_9_0 , upvalues : HomelandVisitRoomWindow, _ENV, data
    (HomelandVisitRoomWindow.ClickCloseBtn)()
    ;
    (HomelandMgr.ReqRoomCallOn)(data.objectindex or data.playerIndex, data.serverId)
  end
)
  end
end

HomelandVisitRoomWindow.OnHide = function(...)
  -- function num : 0_10
end

HomelandVisitRoomWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _notFoundEffect, _ENV, uis, contentPane, argTable
  if _notFoundEffect ~= nil then
    (Util.RecycleUIModel)(((uis.VisitPlay).PlayerList).CardQLoader, true)
    _notFoundEffect = nil
  end
  uis = nil
  contentPane = nil
  argTable = {}
end

HomelandVisitRoomWindow.RefreshContent = function(words, ...)
  -- function num : 0_12 , upvalues : _currentData, uis, HomelandVisitRoomWindow, _selfIndex
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if #_currentData == 0 then
    (((uis.VisitPlay).PlayerList).c2Ctr).selectedIndex = 1
    ;
    (HomelandVisitRoomWindow.ShowNoOne)(words)
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.VisitPlay).PlayerList).c2Ctr).selectedIndex = 0
    _selfIndex = nil
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

    if (((uis.VisitPlay).PlayerList).c1Ctr).selectedIndex == 1 then
      (((uis.VisitPlay).PlayerList).PlayerList).numItems = #_currentData - 1
    else
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (((uis.VisitPlay).PlayerList).PlayerList).numItems = #_currentData
    end
  end
end

HomelandVisitRoomWindow.ShowNoOne = function(words, ...)
  -- function num : 0_13 , upvalues : uis, _ENV, _notFoundEffect, _inAnim, _nothingGroup
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  (((uis.VisitPlay).PlayerList).NothingTxt).text = (PUtil.get)(words)
  if _notFoundEffect == nil then
    _notFoundEffect = (Util.SetNotFoundEffect)(((uis.VisitPlay).PlayerList).CardQLoader)
    if _inAnim.playing then
      _nothingGroup.visible = false
      ;
      (SimpleTimer.setTimeout)(0.2, function(...)
    -- function num : 0_13_0 , upvalues : _nothingGroup
    _nothingGroup.visible = true
  end
)
    else
      _nothingGroup.visible = true
    end
  end
end

HomelandVisitRoomWindow.ClickFriendBtn = function(...)
  -- function num : 0_14 , upvalues : _currentData, _friendData, HomelandVisitRoomWindow
  _currentData = _friendData
  ;
  (HomelandVisitRoomWindow.RefreshContent)(60000559)
end

HomelandVisitRoomWindow.ClickGuildBtn = function(...)
  -- function num : 0_15 , upvalues : _currentData, _guildData, HomelandVisitRoomWindow
  _currentData = _guildData
  ;
  (HomelandVisitRoomWindow.RefreshContent)(60000560)
end

HomelandVisitRoomWindow.ClickCloseBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.HomelandVisitRoomWindow).name)
end

HomelandVisitRoomWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_17 , upvalues : _ENV, _guildData, uis, HomelandVisitRoomWindow
  if msgId == (WindowMsgEnum.Family).E_MSG_REFRESH_GULID_VISIT then
    _guildData = GuildData.MemberList
    if (((uis.VisitPlay).PlayerList).c1Ctr).selectedIndex == 1 then
      (HomelandVisitRoomWindow.ClickGuildBtn)()
    end
  else
    if msgId == (WindowMsgEnum.Family).E_MSG_REFRESH_HOUSE then
      (HomelandVisitRoomWindow.ClickCloseBtn)()
    end
  end
end

return HomelandVisitRoomWindow

