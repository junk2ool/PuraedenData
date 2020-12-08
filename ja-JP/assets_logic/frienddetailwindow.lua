-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_FriendDetailsWindowByName")
local FriendDetailWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local data = {}
FriendDetailWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, data, FriendDetailWindow
  bridgeObj:SetView((WinResConfig.FriendDetailWindow).package, (WinResConfig.FriendDetailWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetFriends_FriendDetailsWindowUis(contentPane)
  uis = uis.FriendDetails
  data = argTable[1]
  ;
  (FriendDetailWindow.SetInvariable)()
  ;
  (FriendDetailWindow.SetTopInfo)()
  ;
  (FriendDetailWindow.SetCardShow)()
end

FriendDetailWindow.SetTopInfo = function(...)
  -- function num : 0_1 , upvalues : data, _ENV, uis
  local time = data.logoutTime
  if time and time > 0 then
    local leftTime = (LuaTime.GetLeftTimeStr)(time)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.DetailsName).PlayerNameTxt).text = (PUtil.get)(20000576, data.nickName, leftTime)
  else
    do
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.DetailsName).PlayerNameTxt).text = data.nickName .. (PUtil.get)(20000600)
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.DetailsName).LevelTxt).text = "Lv." .. data.level
      local guildName = data.guildName
      if (Util.StringIsNullOrEmpty)(guildName) then
        guildName = (PUtil.get)(20000621)
      end
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((uis.DetailsName).Guild).WordTxt).text = guildName
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((uis.DetailsName).Battle).WordTxt).text = data.fc
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((uis.DetailsName).PlayerID).WordTxt).text = data.playerIndex
    end
  end
end

FriendDetailWindow.SetInvariable = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, data
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.DeleteBtn).text = (PUtil.get)(20000573)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleBtn).text = (PUtil.get)(20000574)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ChartBtn).text = (PUtil.get)(20000572)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000575)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.DetailsName).CopyBtn).text = (PUtil.get)(112)
  ;
  (((uis.DetailsName).CopyBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV, data
    ((CS.UniClipboard).SetText)(tostring(data.playerIndex))
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(128))
  end
)
  ;
  ((uis.DeleteBtn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : _ENV, data
    if (FriendsData.IsSelfFriend)(data.playerIndex) then
      (MessageMgr.OpenConfirmWindow)((PUtil.get)(20000577, data.nickName), function(...)
      -- function num : 0_2_1_0 , upvalues : _ENV, data
      (FriendsService.ReqChangeRelation)((ProtoEnum.FriendOperationType).DEL_FRIEND, data.playerIndex)
    end
)
    else
      ;
      (MessageMgr.SendCenterTipsByWordID)(20000620)
      UIMgr:CloseWindow((WinResConfig.FriendDetailWindow).name)
    end
  end
)
  ;
  ((uis.BattleBtn).onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : _ENV, data
    if (FriendsData.IsSelfFriend)(data.playerIndex) then
      (FriendsService.ReqFriendPK)(data.playerIndex, data.serverId)
    else
      ;
      (MessageMgr.SendCenterTipsByWordID)(20000620)
      UIMgr:CloseWindow((WinResConfig.FriendDetailWindow).name)
    end
  end
)
  ;
  ((uis.ChartBtn).onClick):Set(function(...)
    -- function num : 0_2_3 , upvalues : _ENV, data
    if (FriendsData.IsSelfFriend)(data.playerIndex) then
      OpenWindow((WinResConfig.FriendChatWindow).name, UILayer.HUD, data.playerIndex)
    else
      ;
      (MessageMgr.SendCenterTipsByWordID)(20000620)
      UIMgr:CloseWindow((WinResConfig.FriendDetailWindow).name)
    end
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_2_4 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.FriendDetailWindow).name)
  end
)
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.DetailsName).Guild).NameTxt).text = (PUtil.get)(20000571)
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.DetailsName).Guild).c1Ctr).selectedIndex = 0
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.DetailsName).Battle).NameTxt).text = (PUtil.get)(60000235)
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.DetailsName).Battle).c1Ctr).selectedIndex = 1
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.DetailsName).PlayerID).NameTxt).text = (PUtil.get)(111)
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.DetailsName).PlayerID).c1Ctr).selectedIndex = 2
end

FriendDetailWindow.SetCardShow = function(...)
  -- function num : 0_3 , upvalues : data, _ENV, uis
  local cardList = data.cardIdList
  for i = 1, 6 do
    local cardId = cardList[i]
    if cardId and cardId > 0 then
      local cardData = ((TableData.gTable).BaseCardData)[cardId]
      local fashionID = tonumber((split(cardData.fashion_ids, ":"))[1])
      local loader = ((uis.root):GetChild("DetailsCard_" .. i)):GetChild("CardLoader")
      ;
      (Util.CreateMiniModel)(loader, fashionID)
    end
  end
end

FriendDetailWindow.OnShown = function(...)
  -- function num : 0_4
end

FriendDetailWindow.OnHide = function(...)
  -- function num : 0_5
end

FriendDetailWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

FriendDetailWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7
end

return FriendDetailWindow

