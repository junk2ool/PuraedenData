-- params : ...
-- function num : 0 , upvalues : _ENV
FriendsData = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.FriendsList = {}
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.MyInviteList = {}
-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.FriendsInviteList = {}
-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.ChatRecord = {}
-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.DeleteFriend = function(playerIndex, ...)
  -- function num : 0_0 , upvalues : _ENV
  for i,v in ipairs(FriendsData.FriendsList) do
    if v.playerIndex == playerIndex then
      (table.remove)(FriendsData.FriendsList, i)
      return 
    end
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.AddFriend = function(info, ...)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in ipairs(FriendsData.FriendsList) do
    if v.playerIndex == info.playerIndex then
      return 
    end
  end
  ;
  (table.insert)(FriendsData.FriendsList, info)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.ApplyFriend = function(info, ...)
  -- function num : 0_2 , upvalues : _ENV
  if not (FriendsData.IsAlreadyApply)(info.playerIndex) then
    (table.insert)(FriendsData.MyInviteList, info)
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.AddInviteFriend = function(info, ...)
  -- function num : 0_3 , upvalues : _ENV
  for _,v in ipairs(FriendsData.FriendsInviteList) do
    if v.playerIndex == info.playerIndex then
      return 
    end
  end
  ;
  (table.insert)(FriendsData.FriendsInviteList, info)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.CancelApplyFriend = function(playerIndex, ...)
  -- function num : 0_4 , upvalues : _ENV
  for i,v in ipairs(FriendsData.MyInviteList) do
    if v.playerIndex == playerIndex then
      (table.remove)(FriendsData.MyInviteList, i)
      return 
    end
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.CancelInviteFriend = function(playerIndex, ...)
  -- function num : 0_5 , upvalues : _ENV
  for i,v in ipairs(FriendsData.FriendsInviteList) do
    if v.playerIndex == playerIndex then
      (table.remove)(FriendsData.FriendsInviteList, i)
      return 
    end
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.IsAlreadyApply = function(playerIndex, ...)
  -- function num : 0_6 , upvalues : _ENV
  for _,v in ipairs(FriendsData.MyInviteList) do
    if v.playerIndex == playerIndex then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.ChangeFriendState = function(playerIndex, time, ...)
  -- function num : 0_7 , upvalues : _ENV
  for _,v in ipairs(FriendsData.FriendsList) do
    if time > 0 then
      do
        v.online = v.playerIndex ~= playerIndex
        -- DECOMPILER ERROR at PC13: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC13: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for _,v in ipairs(FriendsData.MyInviteList) do
    if time > 0 then
      do
        v.online = v.playerIndex ~= playerIndex
        -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for _,v in ipairs(FriendsData.FriendsInviteList) do
    if time > 0 then
      do
        v.online = v.playerIndex ~= playerIndex
        -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.AddChatRecord = function(chatData, isRes, ...)
  -- function num : 0_8 , upvalues : _ENV
  local playerIndex = nil
  if isRes then
    playerIndex = chatData.pId
  else
    playerIndex = chatData.tId
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  if (FriendsData.ChatRecord)[playerIndex] == nil then
    (FriendsData.ChatRecord)[playerIndex] = {}
  end
  if #(FriendsData.ChatRecord)[playerIndex] >= 100 then
    (table.remove)((FriendsData.ChatRecord)[playerIndex], 1)
  end
  ;
  (table.insert)((FriendsData.ChatRecord)[playerIndex], chatData)
  ;
  (FriendsMgr.AddToLocalSetting)(playerIndex)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.InitChatRecord = function(...)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  FriendsData.ChatRecord = {}
  for _,v in ipairs(FriendsData.FriendsList) do
    local playerIndex = v.playerIndex
    local str = (Util.GetPlayerSetting)(FriendsMgr.PRIVATE_CHAT_DATA .. playerIndex, "")
    if not (Util.StringIsNullOrEmpty)(str) then
      local data = (Json.decode)(str)
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (FriendsData.ChatRecord)[playerIndex] = data
    end
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.IsSelfFriend = function(playerIndex, ...)
  -- function num : 0_10 , upvalues : _ENV
  if playerIndex and tonumber(playerIndex) > 0 then
    for _,v in ipairs(FriendsData.FriendsList) do
      if v.playerIndex == tostring(playerIndex) then
        return true
      end
    end
  end
  do
    return false
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

FriendsData.ModifyFriendData = function(friendInfo, ...)
  -- function num : 0_11 , upvalues : _ENV
  for _,v in ipairs(FriendsData.FriendsList) do
    if v.playerIndex == friendInfo.playerIndex then
      v.guildName = friendInfo.guildName
      v.online = friendInfo.logoutTime <= 0
      v.guildId = friendInfo.guildId
      v.fc = friendInfo.fc
      v.nickName = friendInfo.nickName
      v.level = friendInfo.level
      v.titleId = friendInfo.titleId
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end


