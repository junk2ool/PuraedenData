-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_FriendChatByName")
local GTween = FairyGUI.GTween
local EmojiParser = CS.EmojiParser
local FriendChatWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local friendList = {}
local friendHeadIcon = {}
local currentPlayerIndex = 0
local ExpressionUis, emojiGprHeight = nil, nil
local EmojiLisData = {}
local emojiIsOpen = false
local _chatList = nil
local chatDataList = {}
local _timers = {}
local ChatMaxWidth = 650
local isJump = false
FriendChatWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, FriendChatWindow, currentPlayerIndex, isJump, friendList
  bridgeObj:SetView((WinResConfig.FriendChatWindow).package, (WinResConfig.FriendChatWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  ld("Guild")
  uis = GetFriends_FriendChatUis(contentPane)
  ;
  (FriendChatWindow.InitAssetStrip)()
  ;
  (FriendChatWindow.InitList)()
  ;
  (FriendChatWindow.InitEOMJICom)()
  ;
  (FriendChatWindow.InitVariable)()
  ;
  (FriendChatWindow.RefreshFriendList)(true)
  if argTable[1] then
    currentPlayerIndex = argTable[1]
    isJump = true
  else
    currentPlayerIndex = (friendList[1]).playerIndex
    isJump = false
  end
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.ChatHeadList).ChatHeadList).selectedIndex = (FriendChatWindow.GetFriendIndex)() - 1
  ;
  ((uis.ChatHeadList).ChatHeadList):ScrollToView((FriendChatWindow.GetFriendIndex)() - 1, false)
  ;
  (FriendChatWindow.RefreshChatList)()
  ;
  (FriendsMgr.RemoveUnreadMsg)(nil, true)
end

FriendChatWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.ChatFrame).InputTxt).promptText = (PUtil.get)(60000460)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ChatFrame).SureBtn).text = (PUtil.get)(20000179)
end

FriendChatWindow.GetFriendIndex = function(...)
  -- function num : 0_2 , upvalues : _ENV, friendList, currentPlayerIndex
  for i,v in ipairs(friendList) do
    if v.playerIndex == currentPlayerIndex then
      return i
    end
  end
end

FriendChatWindow.GetChatItemUrl = function(index, ...)
  -- function num : 0_3 , upvalues : chatDataList, _ENV
  local data = chatDataList[index + 1]
  if data.pId == (ActorData.GetPlayerIndex)() then
    return (Util.GetResUrl)("Friends:OneSelfChat")
  else
    return (Util.GetResUrl)("Friends:OtherChat")
  end
end

FriendChatWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV, FriendChatWindow, _chatList
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.ChatHeadList).ChatHeadList).defaultItem = (Util.GetResUrl)("Friends:ChatHeadBtn")
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ChatHeadList).ChatHeadList).itemRenderer = FriendChatWindow.FriendsListRenderer
  ;
  ((uis.ChatHeadList).ChatHeadList):SetVirtual()
  _chatList = (uis.ChatFrame).ChatList
  _chatList.defaultItem = (Util.GetResUrl)("Friends:OneSelfChat")
  _chatList:SetVirtual()
  _chatList.itemRenderer = FriendChatWindow.RefreshChatItem
  _chatList.itemProvider = FriendChatWindow.GetChatItemUrl
end

FriendChatWindow.RefreshChatItem = function(index, item, ...)
  -- function num : 0_5 , upvalues : chatDataList, _ENV, _timers, friendHeadIcon, EmojiParser, ChatMaxWidth
  local data = chatDataList[index + 1]
  ;
  (item:GetChild("PlayerNameTxt")).text = data.pName
  local mTime = data.time - 1000
  ;
  (item:GetChild("TimeTxt")).text = (PUtil.get)(60000234, (LuaTime.GetLeftTimeStr)(mTime * 0.001))
  do
    if (LuaTime.GetTimeStamp)() - mTime < 3600 then
      local timer = (SimpleTimer.new)(60, -1, function(...)
    -- function num : 0_5_0 , upvalues : _ENV, mTime, item
    if (LuaTime.GetTimeStamp)() - mTime >= 3600 then
      timer:stop()
    end
    ;
    (item:GetChild("TimeTxt")).text = (PUtil.get)(60000234, (LuaTime.GetLeftTimeStr)(mTime * 0.001))
  end
)
      timer:start()
      ;
      (table.insert)(_timers, timer)
    end
    local headFrame = item:GetChild("HeadFrameLoader")
    local fashionFrame = (headFrame:GetChild("HeadFrameLoader"))
    local fashionFrameValue, headGrp, wordGrp = nil, nil, nil
    if data.pId == (ActorData.GetPlayerIndex)() then
      headGrp = item:GetChild("OneSelfGrp")
      wordGrp = item:GetChild("OneSelfChatWordGrp")
      fashionFrameValue = (ActorData.GetFashionFrame)()
    else
      headGrp = item:GetChild("OtherPlayerGrp")
      wordGrp = item:GetChild("OtherChatWordGrp")
      if not friendHeadIcon[data.pId] then
        fashionFrameValue = data.fashionFrame
      end
    end
    if fashionFrameValue == nil or fashionFrameValue == 0 then
      fashionFrame.url = nil
    else
      local frameConfig = ((TableData.gTable).BasePlayerHeadFrameData)[fashionFrameValue]
      if frameConfig then
        fashionFrame.url = (Util.GetResUrl)(frameConfig.icon_path)
      end
    end
    do
      local content = wordGrp:GetChild("WordTxt")
      local mLoader = headGrp:GetChild("ActorHeadLoader")
      mLoader.url = (Util.GetHeadIconByFashionId)(data.fashionHead, HeadIconType.ROUND)
      mLoader.alpha = 1
      mLoader:InvalidateBatchingState()
      content.text = (EmojiParser.inst):Parse(data.content)
      content.width = ChatMaxWidth
      content.width = (math.min)(ChatMaxWidth, content.textWidth)
    end
  end
end

FriendChatWindow.RefreshChatList = function(...)
  -- function num : 0_6 , upvalues : FriendChatWindow, chatDataList, _ENV, currentPlayerIndex, _chatList, uis
  (FriendChatWindow.ClearChatTimers)()
  chatDataList = (FriendsData.ChatRecord)[currentPlayerIndex]
  if chatDataList then
    local count = #chatDataList
    _chatList.numItems = count
    ;
    (_chatList.scrollPane):ScrollBottom()
    ;
    (FriendsMgr.RemoveUnreadMsg)(currentPlayerIndex)
    local mIndex = (FriendChatWindow.GetFriendIndex)() - 1
    mIndex = ((uis.ChatHeadList).ChatHeadList):ItemIndexToChildIndex(mIndex)
    local numChildren = ((uis.ChatHeadList).ChatHeadList).numChildren
    if mIndex < numChildren then
      ((((uis.ChatHeadList).ChatHeadList):GetChildAt(mIndex)):GetChild("MessageTips")).visible = false
    end
  else
    do
      _chatList.numItems = 0
    end
  end
end

FriendChatWindow.ClearChatTimers = function(...)
  -- function num : 0_7 , upvalues : _timers
  local count = #_timers
  for i = 1, count do
    (_timers[i]):stop()
  end
  _timers = {}
end

FriendChatWindow.FriendsListRenderer = function(index, obj, ...)
  -- function num : 0_8 , upvalues : friendList, _ENV, friendHeadIcon, currentPlayerIndex, FriendChatWindow, uis
  local data = friendList[index + 1]
  if not data then
    return 
  end
  local fashionConfig = ((TableData.gTable).BasePlayerHeadIconData)[data.fashionHead]
  ;
  (obj:GetChild("ActorHeadLoader")).url = (Util.GetItemUrl)(fashionConfig.icon_path)
  ;
  (obj:GetChild("NameTxt")).text = data.nickName
  local headFrame = obj:GetChild("HeadFrameLoader")
  local fashionFrame = headFrame:GetChild("HeadFrameLoader")
  if data.fashionFrame == nil or data.fashionFrame == 0 then
    fashionFrame.url = nil
  else
    local frameConfig = ((TableData.gTable).BasePlayerHeadFrameData)[data.fashionFrame]
    if frameConfig then
      fashionFrame.url = (Util.GetResUrl)(frameConfig.icon_path)
    end
  end
  do
    friendHeadIcon[data.playerIndex] = data.fashionFrame
    if data.online then
      ChangeUIController(obj:GetChild("OnLine"), "c1", 0)
    else
      ChangeUIController(obj:GetChild("OnLine"), "c1", 1)
    end
    ;
    (obj:GetChild("MessageTips")).visible = (FriendsMgr.GetHaveNewMsg)(data.playerIndex)
    ;
    (obj.onClick):Set(function(...)
    -- function num : 0_8_0 , upvalues : currentPlayerIndex, data, FriendChatWindow, uis, index
    if currentPlayerIndex ~= data.playerIndex then
      currentPlayerIndex = data.playerIndex
      ;
      (FriendChatWindow.RefreshChatList)()
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.ChatHeadList).ChatHeadList).selectedIndex = index
    end
  end
)
  end
end

FriendChatWindow.RefreshFriendList = function(sort, ...)
  -- function num : 0_9 , upvalues : friendList, _ENV, isJump, currentPlayerIndex, friendHeadIcon, uis
  friendList = (Util.clone)(FriendsData.FriendsList)
  ;
  (table.sort)(friendList, function(a, b, ...)
    -- function num : 0_9_0 , upvalues : isJump, sort, currentPlayerIndex, _ENV
    local aJump = 0
    local bJump = 0
    if isJump and sort then
      if a.playerIndex == currentPlayerIndex then
        aJump = 10000000000000
      end
      if b.playerIndex == currentPlayerIndex then
        bJump = 10000000000000
      end
    end
    local aWeight = 0
    if (FriendsMgr.GetHaveNewMsg)(a.playerIndex) then
      aWeight = 1000000000000
    end
    local bWeight = 0
    if (FriendsMgr.GetHaveNewMsg)(b.playerIndex) then
      bWeight = 1000000000000
    end
    do return bWeight + (FriendsMgr.ListSort)(b) + bJump < aWeight + (FriendsMgr.ListSort)(a) + aJump end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  friendHeadIcon = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.ChatHeadList).ChatHeadList).numItems = #friendList
end

FriendChatWindow.OnShown = function(...)
  -- function num : 0_10
end

FriendChatWindow.OnHide = function(...)
  -- function num : 0_11
end

FriendChatWindow.InitEOMJICom = function(...)
  -- function num : 0_12 , upvalues : _ENV, ExpressionUis, uis, FriendChatWindow, emojiGprHeight, currentPlayerIndex
  UIMgr:LoadPackage("Emoji")
  ;
  (GuildData.InitEmojiList)()
  ExpressionUis = (uis.ChatFrame).EmojiChoice
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (ExpressionUis.TypeList).itemRenderer = FriendChatWindow.ExpressionGroupRender
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (ExpressionUis.EmojiList).itemRenderer = FriendChatWindow.ExpressionEmojiRender
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (ExpressionUis.TypeList).numItems = #GuildData.ExpressionGroup
  emojiGprHeight = (((uis.ChatFrame).EmojiChoice).root).height
  ;
  (((uis.ChatFrame).EmojiBtn).onClick):Set(FriendChatWindow.ClickEmojiBtn)
  ;
  (((uis.ChatFrame).SureBtn).onClick):Set(function(...)
    -- function num : 0_12_0 , upvalues : uis, _ENV, currentPlayerIndex
    local content = ((uis.ChatFrame).InputTxt).text
    if not (Util.StringIsNullOrEmpty)(content) then
      local content = ((CS.DirtyWordChecker).Singleton):Replace(content)
      ;
      (ChatService.ReqSetPrivateChat)(content, currentPlayerIndex)
    else
      do
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000227))
        -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

        ;
        ((uis.ChatFrame).InputTxt).text = ""
      end
    end
  end
)
end

FriendChatWindow.ExpressionGroupRender = function(index, obj, ...)
  -- function num : 0_13 , upvalues : _ENV, FriendChatWindow
  local data = (GuildData.ExpressionGroup)[index + 1]
  ;
  (obj:GetChild("WordTxt")).text = data.name
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : FriendChatWindow, data
    (FriendChatWindow.OnClickGroupBtn)(data.id)
  end
)
end

FriendChatWindow.OnClickGroupBtn = function(id, ...)
  -- function num : 0_14 , upvalues : ExpressionUis, FriendChatWindow, EmojiLisData, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  (ExpressionUis.TypeList).selectedIndex = (FriendChatWindow.GetGroupIndex)(id) - 1
  EmojiLisData = (GuildData.ExpressionList)[id]
  if EmojiLisData and #EmojiLisData > 0 then
    if id ~= GuildData.OFTEN_TYPE_KEY then
      (table.sort)(EmojiLisData, function(a, b, ...)
    -- function num : 0_14_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (ExpressionUis.EmojiList).numItems = #EmojiLisData
  else
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (ExpressionUis.EmojiList).numItems = 0
  end
end

FriendChatWindow.GetGroupIndex = function(id, ...)
  -- function num : 0_15 , upvalues : _ENV
  for i,v in ipairs(GuildData.ExpressionGroup) do
    if v.id == id then
      return i
    end
  end
end

FriendChatWindow.ExpressionEmojiRender = function(index, obj, ...)
  -- function num : 0_16 , upvalues : EmojiLisData, _ENV, currentPlayerIndex, FriendChatWindow
  local data = EmojiLisData[index + 1]
  ;
  (obj:GetChild("EmojiLoader")).url = (Util.GetItemUrl)("Emoji:" .. data.name)
  ;
  ((obj:GetChild("EmojiLoader")).onClick):Set(function(context, ...)
    -- function num : 0_16_0 , upvalues : _ENV, currentPlayerIndex, data, FriendChatWindow
    local item = context.sender
    local name = "[:custom_" .. ((UIPackage.GetItemByURL)(item.icon)).name .. "]"
    ;
    (ChatService.ReqSetPrivateChat)(name, currentPlayerIndex)
    ;
    (GuildData.AddEmojiToOftenList)(data.id)
    ;
    (FriendChatWindow.ClickEmojiBtn)()
    ;
    (GRoot.inst):ClearCustomPopups()
  end
)
end

FriendChatWindow.ClickEmojiBtn = function(...)
  -- function num : 0_17 , upvalues : emojiIsOpen, uis, emojiGprHeight, _ENV, ExpressionUis, FriendChatWindow, GTween
  emojiIsOpen = not emojiIsOpen
  local startPos = (((uis.ChatFrame).root):GetChild("Chat")).y
  local endPos = nil
  if emojiIsOpen then
    endPos = startPos - emojiGprHeight
    ;
    (GRoot.inst):AddCustomPopups(ExpressionUis.root, function(...)
    -- function num : 0_17_0 , upvalues : _ENV, uis, FriendChatWindow
    if (GRoot.inst).touchTarget ~= (uis.ChatFrame).EmojiBtn then
      (FriendChatWindow.ClickEmojiBtn)()
    end
  end
)
    local often = ((GuildData.ExpressionGroup)[1]).id
    local EmojiLisData = (GuildData.ExpressionList)[often]
    if #EmojiLisData > 0 then
      (FriendChatWindow.OnClickGroupBtn)(often)
    else
      ;
      (FriendChatWindow.OnClickGroupBtn)(((GuildData.ExpressionGroup)[2]).id)
    end
  else
    do
      endPos = startPos + emojiGprHeight
      local gt = (GTween.To)(startPos, endPos, 0.3)
      gt:OnUpdate(function(...)
    -- function num : 0_17_1 , upvalues : uis, gt
    if uis then
      (((uis.ChatFrame).root):GetChild("Chat")).y = (gt.value).x
    end
  end
)
    end
  end
end

FriendChatWindow.InitAssetStrip = function(...)
  -- function num : 0_18 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.FriendChatWindow).name
  m.Tip = (PUtil.get)(20000590)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

FriendChatWindow.OnClose = function(...)
  -- function num : 0_19 , upvalues : uis, contentPane, argTable, FriendChatWindow, friendList, currentPlayerIndex, ExpressionUis, emojiGprHeight, EmojiLisData, emojiIsOpen, _chatList, chatDataList, _timers, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (FriendChatWindow.ClearChatTimers)()
  friendList = {}
  currentPlayerIndex = 0
  ExpressionUis = nil
  emojiGprHeight = 0
  EmojiLisData = {}
  emojiIsOpen = false
  _chatList = nil
  chatDataList = {}
  _timers = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.FriendChatWindow).name)
end

FriendChatWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_20 , upvalues : _ENV, FriendChatWindow, uis, currentPlayerIndex, friendList, _chatList
  if msgId == (WindowMsgEnum.Friends).E_MSG_REFRESH_CHAT_LIST then
    (FriendChatWindow.RefreshChatList)()
  else
    if msgId == (WindowMsgEnum.Friends).E_MSG_UNREAD_CHAT_LIST then
      ((uis.ChatHeadList).ChatHeadList):RefreshVirtualList()
    else
      if msgId == (WindowMsgEnum.Friends).E_MSG_FRIEND_UPDATE_CHAT then
        (FriendChatWindow.RefreshFriendList)(false)
        local isFriend = (FriendsData.IsSelfFriend)(currentPlayerIndex)
        -- DECOMPILER ERROR at PC37: Unhandled construct in 'MakeBoolean' P1

        if not isFriend and friendList[1] ~= nil then
          currentPlayerIndex = (friendList[1]).playerIndex
          -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((uis.ChatHeadList).ChatHeadList).selectedIndex = (FriendChatWindow.GetFriendIndex)() - 1
          ;
          (FriendChatWindow.RefreshChatList)()
        else
          _chatList.numItems = 0
        end
      end
    end
  end
end

return FriendChatWindow

