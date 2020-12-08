-- params : ...
-- function num : 0 , upvalues : _ENV
FriendsMgr = {}
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.FriendAddType = {ApplyFor = 1, InviteMe = 2, Search = 3}
-- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.PRIVATE_CHAT_DATA = "PRIVATE_CHAT_DATA"
-- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.PRIVATE_UNREAD_PLAYER_INDEX = "PRIVATE_UNREAD_PLAYER_INDEX"
-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.FRIEND_CHA_RED_DOT = "FRIEND_CHA_RED_DOT"
-- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.FRIEND_ADD_RED_DOT = "FRIEND_ADD_RED_DOT"
-- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.GetMaxFriendNum = function(...)
  -- function num : 0_0 , upvalues : _ENV
  local FixedData = ((TableData.gTable).BaseFixedData)[Const.MaxFriendsNum]
  return FixedData.int_value
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.ListSort = function(a, ...)
  -- function num : 0_1
  local sort = 0
  if a.online then
    sort = 100000000000
  end
  return sort + a.fc
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.AddToLocalSetting = function(playerIndex, ...)
  -- function num : 0_2 , upvalues : _ENV
  local data = (FriendsData.ChatRecord)[playerIndex]
  local jsonStr = (Json.encode)(data)
  ;
  (Util.SetPlayerSetting)(FriendsMgr.PRIVATE_CHAT_DATA .. playerIndex, jsonStr)
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.GetHaveNewMsg = function(playerIndex, ...)
  -- function num : 0_3 , upvalues : _ENV
  local str = (Util.GetPlayerSetting)(FriendsMgr.PRIVATE_UNREAD_PLAYER_INDEX, "")
  local lists = split(str, ":")
  for _,v in ipairs(lists) do
    if v == tostring(playerIndex) then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.RecordUnreadMsg = function(playerIndex, ...)
  -- function num : 0_4 , upvalues : _ENV
  local str = (Util.GetPlayerSetting)(FriendsMgr.PRIVATE_UNREAD_PLAYER_INDEX, "")
  local lists = split(str, ":")
  for _,v in ipairs(lists) do
    if v == tostring(playerIndex) then
      return 
    end
  end
  if (Util.StringIsNullOrEmpty)(str) then
    str = playerIndex
  else
    str = str .. ":" .. playerIndex
  end
  ;
  (Util.SetPlayerSetting)(FriendsMgr.PRIVATE_UNREAD_PLAYER_INDEX, str)
  UIMgr:SendWindowMessage((WinResConfig.FriendChatWindow).name, (WindowMsgEnum.Friends).E_MSG_UNREAD_CHAT_LIST)
  ;
  (FriendsMgr.SetFriendChatRedDot)(true)
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.RemoveUnreadMsg = function(playerIndex, RemoveAll, ...)
  -- function num : 0_5 , upvalues : _ENV
  local str = (Util.GetPlayerSetting)(FriendsMgr.PRIVATE_UNREAD_PLAYER_INDEX, "")
  local lists = split(str, ":")
  local builder = ""
  if not RemoveAll then
    for _,v in ipairs(lists) do
      if v ~= tostring(playerIndex) then
        if (Util.StringIsNullOrEmpty)(builder) then
          builder = v
        else
          builder = builder .. ":" .. v
        end
      end
    end
  end
  do
    ;
    (Util.SetPlayerSetting)(FriendsMgr.PRIVATE_UNREAD_PLAYER_INDEX, builder)
    if builder == nil or (Util.StringIsNullOrEmpty)(builder) then
      (FriendsMgr.SetFriendChatRedDot)(false)
      return 
    end
    local listNum = split(builder, ":")
    if #listNum <= 1 then
      (FriendsMgr.SetFriendChatRedDot)(false)
    end
  end
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.EnterSetFormation = function(data, ...)
  -- function num : 0_6 , upvalues : _ENV
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(20000021)
  btnData.fun = function(cards, ...)
    -- function num : 0_6_0 , upvalues : _ENV
    (FriendsService.ReqInFriendPK)((Util.CovertLoaclFormationToRemote)(cards))
  end

  local formationData = {}
  formationData.formationType = FormationType.Basic
  formationData.otherPlayerList = (Util.CovertRivalCardStateToLocal)(data.rivalCardGroup)
  formationData.myselfList = (Util.CovertRemoteFormationToLocal)(data.ownCardGroup)
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).GUILD_PK
  formationData.BtnData = btnData
  ;
  (MessageMgr.OpenFormationWindow)(formationData)
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.SetFriendAddRedDot = function(isAdd, ...)
  -- function num : 0_7 , upvalues : _ENV
  if isAdd then
    (Util.SetPlayerSetting)(FriendsMgr.FRIEND_ADD_RED_DOT, "1")
  else
    ;
    (Util.SetPlayerSetting)(FriendsMgr.FRIEND_ADD_RED_DOT, "0")
  end
  ;
  (RedDotMgr.ProcessRedDot)(RedDotComID.Friend_Add, nil, isAdd)
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.FriendsListWindow).name)
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.HomeWindow).name)
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R0 in 'UnsetPending'

FriendsMgr.SetFriendChatRedDot = function(isAdd, ...)
  -- function num : 0_8 , upvalues : _ENV
  local previous = (Util.GetPlayerSetting)(FriendsMgr.FRIEND_CHA_RED_DOT, "-1")
  local isChange = false
  -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

  if isAdd and previous ~= "1" then
    (Util.SetPlayerSetting)(FriendsMgr.FRIEND_CHA_RED_DOT, "1")
    isChange = true
  end
  if previous ~= "0" then
    (Util.SetPlayerSetting)(FriendsMgr.FRIEND_CHA_RED_DOT, "0")
    isChange = true
  end
  if not isChange then
    return 
  end
  ;
  (RedDotMgr.ProcessRedDot)(RedDotComID.Friend_Chat, nil, isAdd)
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.FriendsListWindow).name)
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.HomeWindow).name)
end


