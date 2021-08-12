-- params : ...
-- function num : 0 , upvalues : _ENV
HomelandMgr = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.OpenRoom = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (HomelandData.InitRoomConstantPart1)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if (_G.next)(HomelandData.AllRoomData) == nil then
    HomelandData.OpenUI = true
    ;
    (HomelandService.ReqRoomInfo)()
  else
    if ActorData.ReconnectedForHomeland then
      (HomelandData.RefreshFurnitureData)()
    end
    ;
    (HomelandMgr.InitDefaultData)()
    OpenWindow((WinResConfig.HomelandRoomWindow).name, UILayer.HUD)
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

  ActorData.ReconnectedForHomeland = false
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.InitRoomInfo = function(...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.OpenUI = false
  ;
  (HomelandService.ReqRoomInfo)()
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.ShowFurnitureDisappearTips = function(index, list, ...)
  -- function num : 0_2 , upvalues : _ENV
  if #list < index then
    return 
  end
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_2_0 , upvalues : _ENV, list, index
    if not UIMgr:IsWindowOpen((WinResConfig.HomelandRoomWindow).name) then
      return 
    end
    local config = ((TableData.gTable).BaseFamilyFurnitureData)[list[index]]
    if config then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000555, config.name))
    end
    ;
    (HomelandMgr.ShowFurnitureDisappearTips)(index + 1, list)
  end
)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.RecvRoomInfo = function(msg, ...)
  -- function num : 0_3 , upvalues : _ENV
  (HomelandData.InitData)(msg)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if HomelandData.OpenUI then
    HomelandData.OpenUI = false
    UIMgr:SetOnShownComplete((WinResConfig.HomelandRoomWindow).name, function(...)
    -- function num : 0_3_0 , upvalues : _ENV, msg
    loge("#msg.pastFurniture:" .. #msg.pastFurniture)
    ;
    (HomelandMgr.ShowFurnitureDisappearTips)(1, msg.pastFurniture)
  end
)
    OpenWindow((WinResConfig.HomelandRoomWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.InitDefaultData = function(...)
  -- function num : 0_4 , upvalues : _ENV
  (HomelandData.InitRoomInfo)((HomelandData.AllRoomData)[(HomelandData.RoomData).DefaultId])
  ;
  (HomelandData.InitRoomStyleInfo)((((HomelandData.AllRoomData)[(HomelandData.RoomData).DefaultId]).roomStyle)[(HomelandData.RoomData).DefaultStyleId], ((HomelandData.StyleWF)[(HomelandData.RoomData).DefaultStyleId]).Wall, ((HomelandData.StyleWF)[(HomelandData.RoomData).DefaultStyleId]).Floor)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.UnDeployCard = function(cardId, ...)
  -- function num : 0_5 , upvalues : _ENV
  local cardIds = {}
  local count = #(HomelandData.RoomData).Role
  local used = {}
  for i = 1, count do
    if not used[(((HomelandData.RoomData).Role)[i]).cardId] and (((HomelandData.RoomData).Role)[i]).cardId ~= cardId then
      (table.insert)(cardIds, (((HomelandData.RoomData).Role)[i]).cardId)
      used[(((HomelandData.RoomData).Role)[i]).cardId] = true
    end
  end
  ;
  (HomelandService.ReqRoomEnter)(cardIds, (HomelandData.RoomData).Id, (HomelandData.RoomData).StyleId)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.DeployCard = function(cardId, maxCount, availableCoor, ...)
  -- function num : 0_6 , upvalues : _ENV
  if availableCoor == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000596))
    return 
  end
  local cardIds = {}
  local count = #(HomelandData.RoomData).Role
  local used = {}
  for i = 1, count do
    if not used[(((HomelandData.RoomData).Role)[i]).cardId] then
      (table.insert)(cardIds, (((HomelandData.RoomData).Role)[i]).cardId)
      used[(((HomelandData.RoomData).Role)[i]).cardId] = true
    end
  end
  ;
  (table.insert)(cardIds, cardId)
  if maxCount < #cardIds then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000549))
    return 
  end
  ;
  (HomelandService.ReqRoomEnter)(cardIds, (HomelandData.RoomData).Id, (HomelandData.RoomData).StyleId)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.RecvRoomEnter = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV
  local count = #(HomelandData.RoomData).Role
  local originCard = {}
  for i = 1, count do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

    (HomelandData.UsedCard)[(((HomelandData.RoomData).Role)[i]).cardId] = nil
    originCard[(((HomelandData.RoomData).Role)[i]).cardId] = true
  end
  if count < #msg.cardInfo then
    count = #msg.cardInfo
    for i = 1, count do
      if not originCard[((msg.cardInfo)[i]).cardId] then
        local config = (CardData.GetFashionConfig)({id = ((msg.cardInfo)[i]).cardId, quality = ((msg.cardInfo)[i]).quality}, true)
        ;
        (AudioManager.PlayBubbleAndVoice)(false, true, config.id, CVAudioType.HomelandDeployBubble, nil, nil, false, false, false, false, nil, true)
        break
      end
    end
  else
    do
      if #msg.cardInfo < count then
        count = #msg.cardInfo
        for i = 1, count do
          originCard[((msg.cardInfo)[i]).cardId] = nil
        end
        for k,v in pairs(originCard) do
          UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_STOP_ROLE_VOICE, k)
        end
      end
      do
        -- DECOMPILER ERROR at PC105: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (HomelandData.RoomData).Role = msg.cardInfo
        -- DECOMPILER ERROR at PC114: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((((HomelandData.AllRoomData)[msg.roomId]).roomStyle)[msg.styleId]).roomCardInfo = msg.cardInfo
        count = #(HomelandData.RoomData).Role
        for i = 1, count do
          -- DECOMPILER ERROR at PC130: Confused about usage of register: R7 in 'UnsetPending'

          (HomelandData.UsedCard)[(((HomelandData.RoomData).Role)[i]).cardId] = true
        end
        UIMgr:SendWindowMessage((WinResConfig.HomelandDeployCardWindow).name, (WindowMsgEnum.Family).E_MSG_REFRESH_ROOM_ROLES)
        UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_REFRESH_ROOM_ROLES)
      end
    end
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.ReqChangeRoomLayout = function(data, ...)
  -- function num : 0_8 , upvalues : _ENV
  local roomStyle = {}
  local lastData = nil
  for k,v in pairs(data) do
    local eachData = {}
    local furnitureData = {}
    for subk,subv in pairs(v.FurnitureInfo) do
      if subv.Status ~= FurnitureEditStatus.Remove then
        local item = {}
        item.uid = subv.Uid
        item.id = subv.ConfigId
        item.orientation = subv.Turn and 1 or 0
        item.time = (HomelandData.GetFurnitureTime)(v.Uid)
        item.xCoordinate = (subv.Coordinate).x
        item.yCoordinate = (subv.Coordinate).y
        item.zCoordinate = (subv.Coordinate).z
        ;
        (table.insert)(furnitureData, item)
      end
    end
    eachData.styleId = k
    if (v.Wall).Id ~= 0 then
      (table.insert)(furnitureData, {uid = (v.Wall).Uid, id = (v.Wall).Id, time = (HomelandData.GetFurnitureTime)((v.Wall).Uid)})
    end
    if (v.Floor).Id ~= 0 then
      (table.insert)(furnitureData, {uid = (v.Floor).Uid, id = (v.Floor).Id, time = (HomelandData.GetFurnitureTime)((v.Floor).Uid)})
    end
    if (v.Background).Id ~= 0 then
      (table.insert)(furnitureData, {uid = (v.Background).Uid, id = (v.Background).Id, time = (HomelandData.GetFurnitureTime)((v.Background).Uid)})
    end
    eachData.furnitureData = furnitureData
    if k == (HomelandData.RoomData).StyleId then
      lastData = eachData
    else
      ;
      (table.insert)(roomStyle, eachData)
    end
  end
  ;
  (table.insert)(roomStyle, lastData)
  loge("roomStyle:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
  PrintTable(roomStyle)
  ;
  (HomelandService.ReqRoomLayout)((HomelandData.RoomData).Id, roomStyle)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.FurnitureTimeUp = function(uid, name, ...)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (HomelandData.Furnitures)[uid] = nil
  ;
  (MessageMgr.SendCenterTips)((PUtil.get)(60000555, name))
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.ReqClearRoom = function(...)
  -- function num : 0_10 , upvalues : _ENV
  loge("ReqClearRoom")
  local roomStyle = {}
  roomStyle.styleId = (HomelandData.RoomData).StyleId
  roomStyle.furnitureData = {}
  ;
  (HomelandService.ReqRoomLayout)((HomelandData.RoomData).Id, {roomStyle})
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.RecvChangeRoomLayout = function(msg, ...)
  -- function num : 0_11 , upvalues : _ENV
  local count = #msg.roomStyle
  local data, subCount, config, subData, currentRoomData = nil, nil, nil, nil, nil
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (HomelandData.RoomData).DefaultStyleId = (HomelandData.RoomData).StyleId
  for i = 1, count do
    data = (msg.roomStyle)[i]
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((((HomelandData.AllRoomData)[msg.roomId]).roomStyle)[data.styleId]).furnitureData = data.furnitureData
    subCount = #data.furnitureData
    for j = 1, subCount do
      subData = (data.furnitureData)[j]
      config = ((TableData.gTable).BaseFamilyFurnitureData)[subData.id]
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R15 in 'UnsetPending'

      if config.type == HomelandFurnitureType.Wall then
        ((HomelandData.StyleWF)[data.styleId]).Wall = {Id = subData.id, Uid = subData.uid}
      else
        -- DECOMPILER ERROR at PC67: Confused about usage of register: R15 in 'UnsetPending'

        if config.type == HomelandFurnitureType.Floor then
          ((HomelandData.StyleWF)[data.styleId]).Floor = {Id = subData.id, Uid = subData.uid}
        else
          -- DECOMPILER ERROR at PC83: Confused about usage of register: R15 in 'UnsetPending'

          if config.type == HomelandFurnitureType.Background then
            ((HomelandData.StyleWF)[data.styleId]).Background = {Id = subData.id, Uid = subData.uid}
          end
        end
      end
    end
    if data.styleId == (HomelandData.RoomData).StyleId then
      currentRoomData = data
      -- DECOMPILER ERROR at PC95: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (HomelandData.RoomData).Furniture = data.furnitureData
    end
  end
  do
    if UIMgr:IsWindowOpen((WinResConfig.HomelandRoomWindow).name) then
      if currentRoomData.furnitureData == nil or (_G.next)(currentRoomData.furnitureData) == nil then
        local operate = {}
        if ((HomelandData.RoomData).Wall).Id ~= 0 then
          operate.Wall = (((HomelandData.StyleWF)[currentRoomData.styleId]).Wall).Uid
          -- DECOMPILER ERROR at PC132: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (HomelandData.RoomData).Wall = {Id = 0}
          -- DECOMPILER ERROR at PC137: Confused about usage of register: R8 in 'UnsetPending'

          ;
          ((HomelandData.StyleWF)[currentRoomData.styleId]).Wall = nil
        end
        if ((HomelandData.RoomData).Floor).Id ~= 0 then
          operate.Floor = (((HomelandData.StyleWF)[currentRoomData.styleId]).Floor).Uid
          -- DECOMPILER ERROR at PC155: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (HomelandData.RoomData).Floor = {Id = 0}
          -- DECOMPILER ERROR at PC160: Confused about usage of register: R8 in 'UnsetPending'

          ;
          ((HomelandData.StyleWF)[currentRoomData.styleId]).Floor = nil
        end
        if ((HomelandData.RoomData).Background).Id ~= 0 then
          operate.Background = (((HomelandData.StyleWF)[currentRoomData.styleId]).Background).Uid
          -- DECOMPILER ERROR at PC178: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (HomelandData.RoomData).Background = {Id = 0}
          -- DECOMPILER ERROR at PC183: Confused about usage of register: R8 in 'UnsetPending'

          ;
          ((HomelandData.StyleWF)[currentRoomData.styleId]).Background = nil
        end
        -- DECOMPILER ERROR at PC187: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (HomelandData.RoomData).GridUsage = {}
        -- DECOMPILER ERROR at PC191: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (HomelandData.RoomData).CarpetGridUsage = {}
        UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_CLEAR_ROOM, operate)
      else
        do
          UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_CHANGE_ROOM_LAYOUT_SUCCESS)
          -- DECOMPILER ERROR at PC227: Confused about usage of register: R7 in 'UnsetPending'

          if ((HomelandData.StyleWF)[currentRoomData.styleId]).Wall then
            (HomelandData.RoomData).Wall = ((HomelandData.StyleWF)[currentRoomData.styleId]).Wall
          end
          -- DECOMPILER ERROR at PC242: Confused about usage of register: R7 in 'UnsetPending'

          if ((HomelandData.StyleWF)[currentRoomData.styleId]).Floor then
            (HomelandData.RoomData).Floor = ((HomelandData.StyleWF)[currentRoomData.styleId]).Floor
          end
          -- DECOMPILER ERROR at PC257: Confused about usage of register: R7 in 'UnsetPending'

          if ((HomelandData.StyleWF)[currentRoomData.styleId]).Background then
            (HomelandData.RoomData).Background = ((HomelandData.StyleWF)[currentRoomData.styleId]).Background
          end
          ;
          (HomelandData.RefreshFurnitureData)()
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.ReqRoomLevelUp = function(roomId, styleId, ...)
  -- function num : 0_12 , upvalues : _ENV
  local roomType = (((TableData.gTable).BaseFamilyRoomData)[roomId]).type
  local level = ((HomelandData.AllRoomData)[roomId]).level
  local data = ((HomelandData.RoomByLevel)[roomType])[level + 1]
  if data == nil then
    loge("reach max level")
    return 
  end
  if (HomelandData.GetFarmLevel)() < data.FarmLevel then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000611, data.FarmLevel))
    return 
  end
  if (Util.CheckCostResources)(data.Cost, nil, nil, false, true) then
    local costStr = split(data.Cost, ",")
    local str = ""
    for k,v in pairs(costStr) do
      str = str .. (MessageMgr.GetCostImgHtmlByStr)(v)
    end
    ;
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000557, str), function(...)
    -- function num : 0_12_0 , upvalues : _ENV, roomId, styleId
    (HomelandService.ReqRoomLevelUp)(roomId, styleId)
  end
)
  end
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.RecvRoomLevelUp = function(msg, ...)
  -- function num : 0_13 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ((HomelandData.AllRoomData)[msg.id]).level = msg.level
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (HomelandData.RoomData).Level = msg.level
  ;
  (HomelandData.SetFloorAndWallArea)()
  UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_UPGRADE_ROOM)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.ReqRoomCallOn = function(objectIndex, serverId, ...)
  -- function num : 0_14 , upvalues : _ENV
  (HomelandService.ReqRoomCallOn)(objectIndex, serverId)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.RecvRoomCallOn = function(msg, ...)
  -- function num : 0_15 , upvalues : _ENV
  (HomelandData.InitRoomInfo)(msg.roomInfo, (HomelandData.GetRelation)(tonumber(msg.objectIndex)))
  ;
  (HomelandData.InitRoomStyleInfo)(((msg.roomInfo).roomStyle)[1])
  ;
  (HomelandMgr.ChangeHouse)(msg)
  UIMgr:SendWindowMessage((WinResConfig.HomelandVisitRoomWindow).name, (WindowMsgEnum.Family).E_MSG_REFRESH_HOUSE)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.ChangeHouse = function(data, ...)
  -- function num : 0_16 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (HomelandData.RoomData).CurrentPlayInfo = data
  UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_REFRESH_HOUSE)
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.ReqRandomPlayerInfo = function(...)
  -- function num : 0_17 , upvalues : _ENV
  ld("Guild")
  ;
  (GuildMgr.CheckMemberList)()
  ;
  (HomelandMgr.ReqRoomCallOn)(nil, 0)
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.ReqQuitRoom = function(...)
  -- function num : 0_18 , upvalues : _ENV
  (HomelandService.ReqQuitRoom)((HomelandData.RoomData).SelfId, (HomelandData.RoomData).SelfStyleId)
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.RecvQuitRoom = function(msg, ...)
  -- function num : 0_19 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (HomelandData.RoomData).DefaultId = msg.roomId
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (HomelandData.RoomData).DefaultStyleId = msg.styleId
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.OpenVisitUI = function(...)
  -- function num : 0_20 , upvalues : _ENV
  if (ActorData.GetGuildID)() == 0 then
    OpenWindow((WinResConfig.HomelandVisitRoomWindow).name, UILayer.HUD)
  else
    ld("Guild")
    ;
    (GuildMgr.CheckMemberList)()
    OpenWindow((WinResConfig.HomelandVisitRoomWindow).name, UILayer.HUD, true)
  end
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.ChangeStyle = function(styleId, ...)
  -- function num : 0_21 , upvalues : _ENV
  if (HomelandData.RoomData).StyleId == styleId then
    return 
  end
  local roomData = (HomelandData.AllRoomData)[(HomelandData.RoomData).Id]
  local styleData = (roomData.roomStyle)[styleId]
  ;
  (HomelandData.InitRoomStyleInfo)(styleData, ((HomelandData.StyleWF)[styleData.styleId]).Wall, ((HomelandData.StyleWF)[styleData.styleId]).Floor)
  UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_REFRESH_ROOM)
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.AddFurnitureToUI = function(id, uid, ...)
  -- function num : 0_22 , upvalues : _ENV
  if id == nil or uid == nil then
    return 
  end
  do
    if (HomelandData.EditPileFurnitures)[id] == nil then
      local config = ((TableData.gTable).BaseFamilyFurnitureData)[id]
      if HomelandData.EditCurrentType == HomelandFurnitureType.All or HomelandData.EditCurrentType == config.type or HomelandData.EditCurrentType == HomelandFurnitureType.Furniture and config.type == HomelandFurnitureType.Carpet then
        (table.insert)(HomelandData.EditCurrentFurnitures, id)
      end
      ;
      (table.insert)(HomelandData.EditUndeployFurnitures, id)
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (HomelandData.EditPileFurnitures)[id] = {}
    end
    ;
    (table.insert)((HomelandData.EditPileFurnitures)[id], uid)
    UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_REFRESH_FURNITURE_VIRTUAL_LIST)
  end
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.RemoveFurnitureFromUI = function(id, uid, timeUp, ...)
  -- function num : 0_23 , upvalues : _ENV
  local count = #(HomelandData.EditPileFurnitures)[id]
  for i = 1, count do
    if uid == ((HomelandData.EditPileFurnitures)[id])[i] then
      (table.remove)((HomelandData.EditPileFurnitures)[id], i)
      break
    end
  end
  do
    if #(HomelandData.EditPileFurnitures)[id] == 0 then
      count = #HomelandData.EditCurrentFurnitures
      for i = 1, count do
        if (HomelandData.EditCurrentFurnitures)[i] == id then
          (table.remove)(HomelandData.EditCurrentFurnitures, i)
        end
      end
      count = #HomelandData.EditUndeployFurnitures
      for i = 1, count do
        if (HomelandData.EditUndeployFurnitures)[i] == id then
          (table.remove)(HomelandData.EditUndeployFurnitures, i)
        end
      end
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (HomelandData.EditPileFurnitures)[id] = nil
    end
    UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_REFRESH_FURNITURE_VIRTUAL_LIST)
  end
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R0 in 'UnsetPending'

HomelandMgr.UpdateCardGridUsage = function(x, y, id, ...)
  -- function num : 0_24 , upvalues : _ENV
  if (HomelandData.UpdateCardGridUsage)(x, y, id) and not id and ((HomelandData.RoomData).GridWaiting)[x] and (((HomelandData.RoomData).GridWaiting)[x])[y] and #(((HomelandData.RoomData).GridWaiting)[x])[y] > 0 then
    local data = (table.remove)((((HomelandData.RoomData).GridWaiting)[x])[y], 1)
    data.Reason = nil
    UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_CONTINUE_PATROL, data)
  end
end


