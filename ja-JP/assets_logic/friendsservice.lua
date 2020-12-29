-- params : ...
-- function num : 0 , upvalues : _ENV
FriendsService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResRelations, FriendsService.OnResRelations)
  ;
  (Net.AddListener)((Proto.MsgName).ResSearch, FriendsService.OnResSearch)
  ;
  (Net.AddListener)((Proto.MsgName).ResChangeMyRelation, FriendsService.OnResChangeMyRelation)
  ;
  (Net.AddListener)((Proto.MsgName).ResChangeFriendRelation, FriendsService.OnResChangeFriendRelation)
  ;
  (Net.AddListener)((Proto.MsgName).ResFriendInfo, FriendsService.OnResFriendInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResFriendState, FriendsService.OnResFriendState)
  ;
  (Net.AddListener)((Proto.MsgName).ResFriendPK, FriendsService.OnResFriendPK)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.ReqRelations = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqRelations, m, (Proto.MsgName).ResRelations)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.OnResRelations = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  FriendsData.FriendsList = msg.friendList
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  FriendsData.MyInviteList = msg.myInviteList
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  FriendsData.FriendsInviteList = msg.friendInviteList
  ;
  (FriendsData.InitChatRecord)()
  ;
  (ChatService.ReqGetChat)((ProtoEnum.CHAT_TYPE).PRIVATE_CHAT, (ProtoEnum.CHAT_SUB_TYPE).DEFAULT_SUB_CHAT)
  ;
  (FriendsMgr.SetFriendAddRedDot)(#msg.friendInviteList > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.ReqSearch = function(content, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.content = content
  ;
  (Net.Send)((Proto.MsgName).ReqSearch, m, (Proto.MsgName).ResSearch)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.OnResSearch = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  UIMgr:SendWindowMessage((WinResConfig.FriendAddWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_ADD_LIST, msg.searchList)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.ReqChangeRelation = function(type, playerIndex, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.playerIndex = playerIndex
  m.type = type
  ;
  (Net.Send)((Proto.MsgName).ReqChangeRelation, m, (Proto.MsgName).ResChangeMyRelation)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.OnResChangeMyRelation = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  if msg.code == (ProtoEnum.FriendOperationCode).EXCEED_MAX_FRIEND_COUNT then
    (MessageMgr.SendCenterTipsByWordID)(20000593)
  else
    if msg.code == (ProtoEnum.FriendOperationCode).EXCEED_TARGET_MAX_FRIEND_COUNT then
      (MessageMgr.SendCenterTipsByWordID)(20000594)
    else
      if msg.code == (ProtoEnum.FriendOperationCode).ALREADY_IS_FRIEND then
        (MessageMgr.SendCenterTipsByWordID)(20000595)
      else
        if msg.code == (ProtoEnum.FriendOperationCode).EXCEED_MAX_MY_INVITE_COUNT then
          (MessageMgr.SendCenterTipsByWordID)(20000596)
        else
          if msg.code == (ProtoEnum.FriendOperationCode).NEVER_BE_INVITED then
            (MessageMgr.SendCenterTipsByWordID)(20000597)
          else
            if msg.code == (ProtoEnum.FriendOperationCode).CAN_NOT_ADD_SELF then
              (MessageMgr.SendCenterTipsByWordID)(20000598)
            else
              if msg.code == (ProtoEnum.FriendOperationCode).CAN_NOT_FIND_PLAYER then
                (MessageMgr.SendCenterTipsByWordID)(20000599)
              else
                if msg.code == (ProtoEnum.FriendOperationCode).NOT_OPEN_FUNCTION then
                  (MessageMgr.SendCenterTipsByWordID)(20000602)
                else
                  if msg.code == (ProtoEnum.FriendOperationCode).FRIEND_NOT_OPEN_FUNCTION then
                    (MessageMgr.SendCenterTipsByWordID)(20000603)
                  else
                    if msg.type == (ProtoEnum.FriendOperationType).DEL_FRIEND then
                      loge("我删除了" .. (msg.info).nickName)
                      ;
                      (FriendsData.DeleteFriend)((msg.info).playerIndex)
                      UIMgr:CloseWindow((WinResConfig.FriendDetailWindow).name)
                      UIMgr:SendWindowMessage((WinResConfig.FriendsListWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_MAIN_LIST)
                    else
                      if msg.type == (ProtoEnum.FriendOperationType).ADD_FRIEND then
                        loge("我申请了" .. (msg.info).nickName)
                        ;
                        (FriendsData.ApplyFriend)(msg.info)
                        UIMgr:SendWindowMessage((WinResConfig.FriendAddWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_ONLY_ADD_LIST)
                      else
                        if msg.type == (ProtoEnum.FriendOperationType).CANCAL_INVITE then
                          loge("我取消申请了" .. (msg.info).nickName)
                          ;
                          (FriendsData.CancelApplyFriend)((msg.info).playerIndex)
                          UIMgr:SendWindowMessage((WinResConfig.FriendAddWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_ONLY_ADD_LIST)
                        else
                          if msg.type == (ProtoEnum.FriendOperationType).AGREE_INVITE then
                            loge("我同意了" .. (msg.info).nickName)
                            ;
                            (FriendsData.CancelInviteFriend)((msg.info).playerIndex)
                            ;
                            (FriendsData.CancelApplyFriend)((msg.info).playerIndex)
                            ;
                            (FriendsData.AddFriend)(msg.info)
                            UIMgr:SendWindowMessage((WinResConfig.FriendAddWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_ONLY_ADD_LIST)
                          else
                            if msg.type == (ProtoEnum.FriendOperationType).REFUSE_INVITE then
                              loge("我拒绝了" .. (msg.info).nickName)
                              ;
                              (FriendsData.CancelInviteFriend)((msg.info).playerIndex)
                              UIMgr:SendWindowMessage((WinResConfig.FriendAddWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_ONLY_ADD_LIST)
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_REFRESH_GULID_VISIT)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.OnResChangeFriendRelation = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV
  if msg.type == (ProtoEnum.FriendOperationType).DEL_FRIEND then
    loge((msg.info).nickName .. "删除了我")
    ;
    (FriendsData.DeleteFriend)((msg.info).playerIndex)
  else
    if msg.type == (ProtoEnum.FriendOperationType).ADD_FRIEND then
      loge((msg.info).nickName .. "申请了我")
      ;
      (FriendsData.AddInviteFriend)(msg.info)
      ;
      (FriendsMgr.SetFriendAddRedDot)(true)
    else
      if msg.type == (ProtoEnum.FriendOperationType).CANCAL_INVITE then
        loge((msg.info).nickName .. "取消申请了我")
        ;
        (FriendsData.CancelInviteFriend)((msg.info).playerIndex)
      else
        if msg.type == (ProtoEnum.FriendOperationType).AGREE_INVITE then
          loge((msg.info).nickName .. "同意了我")
          ;
          (FriendsData.AddFriend)(msg.info)
          ;
          (FriendsData.CancelApplyFriend)((msg.info).playerIndex)
          ;
          (FriendsData.CancelInviteFriend)((msg.info).playerIndex)
          UIMgr:SendWindowMessage((WinResConfig.FriendAddWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_ADD_LIST, {})
        else
          if msg.type == (ProtoEnum.FriendOperationType).REFUSE_INVITE then
            loge((msg.info).nickName .. "拒绝了我")
            ;
            (FriendsData.CancelApplyFriend)((msg.info).playerIndex)
            UIMgr:SendWindowMessage((WinResConfig.FriendAddWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_ADD_LIST, {})
          end
        end
      end
    end
  end
  UIMgr:SendWindowMessage((WinResConfig.FriendAddWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_ONLY_ADD_LIST)
  UIMgr:SendWindowMessage((WinResConfig.FriendsListWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_MAIN_LIST)
  UIMgr:SendWindowMessage((WinResConfig.FriendChatWindow).name, (WindowMsgEnum.Friends).E_MSG_FRIEND_UPDATE_CHAT)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.ReqFriendInfo = function(playerIndex, ...)
  -- function num : 0_8 , upvalues : _ENV
  local m = {}
  m.playerIndex = playerIndex
  ;
  (Net.Send)((Proto.MsgName).ReqFriendInfo, m, (Proto.MsgName).ResFriendInfo)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.OnResFriendInfo = function(msg, ...)
  -- function num : 0_9 , upvalues : _ENV
  (FriendsData.ModifyFriendData)(msg.detailInfo)
  UIMgr:SendWindowMessage((WinResConfig.FriendsListWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_MAIN_LIST)
  OpenWindow((WinResConfig.FriendDetailWindow).name, UILayer.HUD1, msg.detailInfo)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.OnResFriendState = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  (FriendsData.ChangeFriendState)(msg.playerIndex, msg.logoutTime)
  UIMgr:SendWindowMessage((WinResConfig.FriendsListWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_MAIN_LIST)
  UIMgr:SendWindowMessage((WinResConfig.FriendChatWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_CHAT_LIST)
  UIMgr:SendWindowMessage((WinResConfig.FriendAddWindow).name, (WindowMsgEnum.Friends).E_MSG_REFRESH_ONLY_ADD_LIST)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.ReqFriendPK = function(id, serverId, ...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  m.friendIndex = id
  m.serverId = serverId
  ;
  (Net.Send)((Proto.MsgName).ReqFriendPK, m, (Proto.MsgName).ResFriendPK)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.OnResFriendPK = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  (FriendsMgr.EnterSetFormation)(msg)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

FriendsService.ReqInFriendPK = function(cards, ...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  m.cardGroup = cards
  ;
  (Net.Send)((Proto.MsgName).ReqInFriendPK, m)
end

;
(FriendsService.Init)()

