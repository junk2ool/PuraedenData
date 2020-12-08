-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_FriendsByName")
local FriendsListWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local listData = {}
local guildID = -1
local isClose = false
FriendsListWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, isClose, uis, guildID, FriendsListWindow
  bridgeObj:SetView((WinResConfig.FriendsListWindow).package, (WinResConfig.FriendsListWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  isClose = false
  uis = GetFriends_FriendsUis(contentPane)
  guildID = (ActorData.GetGuildID)()
  ;
  (FriendsListWindow.InitAssetStrip)()
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.FriendTipsList).itemRenderer = FriendsListWindow.ListRenderer
  ;
  (uis.FriendTipsList):SetVirtual()
  ;
  (FriendsListWindow.SetInvariable)()
  ;
  (FriendsListWindow.RefreshList)()
  ;
  (FriendsListWindow.Binding)()
  ;
  (FriendsListWindow.PlayListAni)()
end

FriendsListWindow.PlayListAni = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, isClose
  local InfoList = uis.FriendTipsList
  local child = {}
  do
    for i = 0, InfoList.numChildren - 1 do
      local obj = InfoList:GetChildAt(i)
      obj.visible = false
      ;
      (table.insert)(child, obj)
    end
  end
  local mLength = #child
  if mLength > 0 then
    local num = 0
    ;
    ((SimpleTimer.new)(0.05, mLength, function(...)
    -- function num : 0_1_0 , upvalues : num, child, isClose, _ENV
    num = num + 1
    local obj = child[num]
    if isClose then
      return 
    end
    PlayUITrans(obj, "up")
    obj.visible = true
  end
)):start()
  end
end

FriendsListWindow.Binding = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local winName = (WinResConfig.FriendsListWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.Friend_Chat, uis.MessageBtn)
  BindingUI(winName, RedDotComID.Friend_Add, uis.FriendBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

FriendsListWindow.ListRenderer = function(index, obj, ...)
  -- function num : 0_3 , upvalues : listData, _ENV, guildID
  local data = listData[index + 1]
  if data == nil then
    return 
  end
  obj = obj:GetChild("FriendTips")
  local head = obj:GetChild("FriendHead")
  if data.online then
    ChangeUIController(obj:GetChild("OnLine"), "c1", 0)
    ChangeUIController(head, "c1", 0)
  else
    ChangeUIController(obj:GetChild("OnLine"), "c1", 1)
    ChangeUIController(head, "c1", 0)
  end
  if guildID and data.guildId and guildID > 0 and guildID == data.guildId then
    ChangeUIController(obj, "c2", 1)
  else
    ChangeUIController(obj, "c2", 0)
  end
  ;
  (obj:GetChild("NameTxt")).text = data.nickName
  ;
  (obj:GetChild("LevelTxt")).text = (PUtil.get)(53) .. data.level
  ;
  (Util.SetTitleShow)(obj:GetChild("TitlePic"), data.titleId)
  local fashionConfig = ((TableData.gTable).BaseFashionData)[data.fashionShow]
  ;
  (head:GetChild("HeadLoader")).url = (Util.GetItemUrl)(fashionConfig.head_icon_banner)
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, data
    (FriendsService.ReqFriendInfo)(data.playerIndex)
  end
)
end

FriendsListWindow.SetInvariable = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.FriendBtn).text = (PUtil.get)(20000568)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.MessageBtn).text = (PUtil.get)(20000567)
  ;
  ((uis.MessageBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV
    local friendNum = #FriendsData.FriendsList
    if friendNum > 0 then
      OpenWindow((WinResConfig.FriendChatWindow).name, UILayer.HUD)
    else
      ;
      (MessageMgr.SendCenterTipsByWordID)(20000592)
    end
  end
)
  ;
  ((uis.FriendBtn).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    OpenWindow((WinResConfig.FriendAddWindow).name, UILayer.HUD, (FriendsMgr.FriendAddType).InviteMe)
  end
)
end

FriendsListWindow.RefreshList = function(...)
  -- function num : 0_5 , upvalues : listData, _ENV, uis
  listData = (Util.clone)(FriendsData.FriendsList)
  ;
  (table.sort)(listData, function(a, b, ...)
    -- function num : 0_5_0 , upvalues : _ENV
    do return (FriendsMgr.ListSort)(b) < (FriendsMgr.ListSort)(a) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local max = (FriendsMgr.GetMaxFriendNum)()
  local num = #listData
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  if num <= 0 then
    (uis.NumberTxt).text = (PUtil.get)(20000570, num, max)
    ChangeUIController(uis.root, "c1", 1)
    ;
    (Util.SetNotFoundEffect)(uis.CardQLoader)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.NothingTxt).text = (PUtil.get)(20000601)
  else
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.NumberTxt).text = (PUtil.get)(20000569, num, max)
    ChangeUIController(uis.root, "c1", 0)
  end
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.FriendTipsList).numItems = num
end

FriendsListWindow.OnShown = function(...)
  -- function num : 0_6
end

FriendsListWindow.OnHide = function(...)
  -- function num : 0_7
end

FriendsListWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : isClose, uis, contentPane, argTable, _ENV
  isClose = true
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.FriendsListWindow).name)
end

FriendsListWindow.InitAssetStrip = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.FriendsListWindow).name
  m.Tip = (PUtil.get)(20000566)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

FriendsListWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_10 , upvalues : _ENV, FriendsListWindow
  if msgId == (WindowMsgEnum.Friends).E_MSG_REFRESH_MAIN_LIST then
    (FriendsListWindow.RefreshList)()
  end
end

return FriendsListWindow

