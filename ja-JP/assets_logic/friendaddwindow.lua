-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_FriendAddByName")
require("CommonResource_AssetStripByName")
local FriendAddWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local currentType = 0
local listData = {}
local mUis = {}
FriendAddWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, currentType, uis, FriendAddWindow, mUis
  bridgeObj:SetView((WinResConfig.FriendAddWindow).package, (WinResConfig.FriendAddWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  currentType = argTable[1]
  uis = GetFriends_FriendAddUis(contentPane)
  ;
  (FriendAddWindow.InitAssetStrip)()
  mUis = uis.FriendList
  ;
  (FriendAddWindow.SetInvariable)()
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (mUis.FriendTipsList).itemRenderer = FriendAddWindow.FriendsListRenderer
  ;
  (mUis.FriendTipsList):SetBeginAnim(false, "up", 0.05, 0.05, true)
  ;
  (mUis.FriendTipsList):SetVirtual()
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (mUis.c1Ctr).selectedIndex = currentType - 1
  ;
  (FriendAddWindow.RefreshContent)(true)
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((mUis.Search).InputNameTxt).promptText = (PUtil.get)(20000591)
end

FriendAddWindow.FriendsListRenderer = function(index, obj, ...)
  -- function num : 0_1 , upvalues : listData, currentType, _ENV
  local mData = listData[index + 1]
  obj = obj:GetChild("PlayerInfo")
  local btn1 = obj:GetChild("A_Btn")
  local btn2 = obj:GetChild("B_Btn")
  if currentType == (FriendsMgr.FriendAddType).ApplyFor then
    ChangeUIController(obj, "c1", 0)
    btn2.text = (PUtil.get)(20000583)
    ;
    (btn2.onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, mData
    (FriendsService.ReqChangeRelation)((ProtoEnum.FriendOperationType).CANCAL_INVITE, mData.playerIndex)
  end
)
  else
    if currentType == (FriendsMgr.FriendAddType).InviteMe then
      ChangeUIController(obj, "c1", 1)
      btn2.text = (PUtil.get)(20000585)
      btn1.text = (PUtil.get)(20000584)
      ;
      (btn2.onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV, mData
    (FriendsService.ReqChangeRelation)((ProtoEnum.FriendOperationType).REFUSE_INVITE, mData.playerIndex)
  end
)
      ;
      (btn1.onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : _ENV, mData
    (FriendsService.ReqChangeRelation)((ProtoEnum.FriendOperationType).AGREE_INVITE, mData.playerIndex)
  end
)
    else
      if currentType == (FriendsMgr.FriendAddType).Search then
        if (FriendsData.IsAlreadyApply)(mData.playerIndex) then
          ChangeUIController(obj, "c1", 0)
          btn2.text = (PUtil.get)(20000583)
          ;
          (btn2.onClick):Set(function(...)
    -- function num : 0_1_3 , upvalues : _ENV, mData
    (FriendsService.ReqChangeRelation)((ProtoEnum.FriendOperationType).CANCAL_INVITE, mData.playerIndex)
  end
)
        else
          if (FriendsData.IsSelfFriend)(mData.playerIndex) then
            ChangeUIController(obj, "c1", 0)
            btn2.text = (PUtil.get)(20000572)
            ;
            (btn2.onClick):Set(function(...)
    -- function num : 0_1_4 , upvalues : _ENV, mData
    OpenWindow((WinResConfig.FriendChatWindow).name, UILayer.HUD, mData.playerIndex)
  end
)
          else
            ChangeUIController(obj, "c1", 2)
            btn1.text = (PUtil.get)(20000582)
            ;
            (btn1.onClick):Set(function(...)
    -- function num : 0_1_5 , upvalues : _ENV, mData
    (FriendsService.ReqChangeRelation)((ProtoEnum.FriendOperationType).ADD_FRIEND, mData.playerIndex)
  end
)
          end
        end
      end
    end
  end
  local head = obj:GetChild("AddHead")
  local headLoader = head:GetChild("HeadLoader")
  local fashionConfig = ((TableData.gTable).BaseFashionData)[mData.fashionShow]
  headLoader.url = (Util.GetItemUrl)(fashionConfig.head_icon_banner)
  if mData.online then
    ChangeUIController(head:GetChild("OnLine"), "c1", 0)
  else
    ChangeUIController(head:GetChild("OnLine"), "c1", 1)
  end
  ;
  (obj:GetChild("PlayerNameTxt")).text = mData.nickName
  ;
  (obj:GetChild("LevelTxt")).text = "Lv." .. mData.level
  local Guild = obj:GetChild("Guild")
  ChangeUIController(Guild, "c1", 0)
  ;
  (Guild:GetChild("NameTxt")).text = (PUtil.get)(20000571)
  local guildName = mData.guildName
  if (Util.StringIsNullOrEmpty)(guildName) then
    guildName = (PUtil.get)(20000621)
  end
  ;
  (Guild:GetChild("WordTxt")).text = guildName
  local Battle = obj:GetChild("Battle")
  ChangeUIController(Battle, "c1", 1)
  ;
  (Battle:GetChild("NameTxt")).text = (PUtil.get)(60000235)
  ;
  (Battle:GetChild("WordTxt")).text = mData.fc
end

FriendAddWindow.SetInvariable = function(...)
  -- function num : 0_2 , upvalues : mUis, _ENV, currentType, FriendAddWindow
  ((mUis.Add_A_Btn):GetChild("NameTxt")).text = (PUtil.get)(20000579)
  ;
  ((mUis.Add_B_Btn):GetChild("NameTxt")).text = (PUtil.get)(20000580)
  ;
  ((mUis.Add_C_Btn):GetChild("NameTxt")).text = (PUtil.get)(20000581)
  ;
  ((mUis.Add_A_Btn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : currentType, _ENV, FriendAddWindow
    currentType = (FriendsMgr.FriendAddType).ApplyFor
    ;
    (FriendAddWindow.RefreshContent)()
  end
)
  ;
  ((mUis.Add_B_Btn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : currentType, _ENV, FriendAddWindow
    currentType = (FriendsMgr.FriendAddType).InviteMe
    ;
    (FriendAddWindow.RefreshContent)()
  end
)
  ;
  ((mUis.Add_C_Btn).onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : currentType, _ENV, FriendAddWindow
    currentType = (FriendsMgr.FriendAddType).Search
    ;
    (FriendAddWindow.RefreshContent)(true)
  end
)
  ;
  (((mUis.Search).QueryBtn).onClick):Set(function(...)
    -- function num : 0_2_3 , upvalues : mUis, _ENV
    local content = ((mUis.Search).InputNameTxt).text
    if (Util.StringIsNullOrEmpty)(content) then
      (MessageMgr.SendCenterTipsByWordID)(20000589)
    else
      ;
      (FriendsService.ReqSearch)(content)
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((mUis.Search).InputNameTxt).text = ""
    end
  end
)
end

FriendAddWindow.RefreshContent = function(initData, ...)
  -- function num : 0_3 , upvalues : currentType, _ENV, listData, mUis
  if currentType == (FriendsMgr.FriendAddType).ApplyFor then
    listData = (Util.clone)(FriendsData.MyInviteList)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (mUis.NothingTxt).text = (PUtil.get)(20000587)
  else
    if currentType == (FriendsMgr.FriendAddType).InviteMe then
      listData = (Util.clone)(FriendsData.FriendsInviteList)
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (mUis.NothingTxt).text = (PUtil.get)(20000586)
    else
      if initData then
        listData = {}
      end
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (mUis.NothingTxt).text = (PUtil.get)(20000588)
    end
  end
  ;
  (table.sort)(listData, function(a, b, ...)
    -- function num : 0_3_0
    do return b.fc < a.fc end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

  if #listData <= 0 then
    (mUis.c2Ctr).selectedIndex = 1
    ;
    (Util.SetNotFoundEffect)(mUis.CardQLoader)
  else
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (mUis.c2Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (mUis.FriendTipsList).numItems = #listData
  ;
  (mUis.FriendTipsList):RefreshVirtualList()
  local max = (FriendsMgr.GetMaxFriendNum)()
  local num = #FriendsData.FriendsList
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R3 in 'UnsetPending'

  if num <= 0 then
    (mUis.NumberTxt).text = (PUtil.get)(20000570, num, max)
  else
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (mUis.NumberTxt).text = (PUtil.get)(20000569, num, max)
  end
end

FriendAddWindow.SetSearch = function(...)
  -- function num : 0_4
end

FriendAddWindow.OnShown = function(...)
  -- function num : 0_5
end

FriendAddWindow.OnHide = function(...)
  -- function num : 0_6
end

FriendAddWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, argTable, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.FriendAddWindow).name)
  ;
  (FriendsMgr.SetFriendAddRedDot)(false)
end

FriendAddWindow.InitAssetStrip = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.FriendAddWindow).name
  m.Tip = (PUtil.get)(20000578)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

FriendAddWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9 , upvalues : _ENV, listData, mUis, FriendAddWindow
  if msgId == (WindowMsgEnum.Friends).E_MSG_REFRESH_ADD_LIST then
    listData = para
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    if #listData <= 0 then
      (mUis.c2Ctr).selectedIndex = 1
      ;
      (Util.SetNotFoundEffect)(mUis.CardQLoader)
    else
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (mUis.c2Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (mUis.FriendTipsList).numItems = #listData
    end
  else
    if msgId == (WindowMsgEnum.Friends).E_MSG_REFRESH_ONLY_ADD_LIST then
      (FriendAddWindow.RefreshContent)()
    end
  end
end

return FriendAddWindow

