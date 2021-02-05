-- params : ...
-- function num : 0 , upvalues : _ENV
HomelandData = {
farmInfo = {}
}
local Random = (CS.UnityEngine).Random
-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.DefaultZoomRange = 72010060
-- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.DefaultRoomResources = 72010061
-- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.MaxChooseCircleSize = 72010073
-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.RolePatrolArgument = 72010074
-- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.RoleScale = 72010075
-- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.RandomBubbleGap = 72010076
-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.OpenUI = false
HomelandRoomResources = {WhiteGrid = "WhiteLine", WhiteWallGrid = "WhiteLineTwo", RedLine = "RedLine", RedGrid = "RedBlock", GreenLine = "GreenLine", GreenGrid = "GreenBlock", MoveFurnitureCom = "Furniture", FurnitureCom = "FurnitureItem", Shadow = "Shadow", TalkL = "TalkL", TalkR = "TalkR"}
HomelandRoomConstant = {OriginalPoint = Vector2.zero, WallHeight = 0, WallVGridAmount = 0, FloorAngle = 0, 
LeftWallRect = {}
, 
RightWallRect = {}
, 
FloorRect = {}
, DefaultGridCount = 0, GridLength = 0, GridProject = Vector2.zero, XAxis = Vector2.zero, YAxis = Vector2.zero, ZAxis = Vector2.zero, ZAxisYScale = 1, NormalizeXAxis = Vector2.zero, NormalizeYAxis = Vector2.zero, DefaultFloor = 0, DefaultWall = 0, DefaultZoom = 0, MaxZoom = 0, MinZoom = 0, MaxChooseCircleSize = 0, RoleMaxMoveDistance = 5, RoleMaxWaitDuration = 5, RoleMinWaitDuration = 0, RoleScale = 1, RandomBubbleGap = 10}
-- DECOMPILER ERROR at PC82: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.AllRoomData = {}
-- DECOMPILER ERROR at PC85: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.UsedCard = {}
HomelandHostRelation = {Self = 0, Guild = 1, Friend = 2, Stranger = 3}
-- DECOMPILER ERROR at PC124: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.RoomData = {Relation = HomelandHostRelation.Self, DefaultId = 0, Id = 0, DefaultStyleId = 0, StyleId = 0, SelfId = 0, SelfStyleId = 0, Type = 0, 
Role = {}
, Wall = 0, Floor = 0, 
Furniture = {}
, Level = 0, 
GridUsage = {}
, 
CarpetGridUsage = {}
, 
CardGridUsage = {}
, 
CurrentPlayInfo = {}
, CardGridCount = 0, 
CardGrid = {}
, 
GridWaiting = {}
}
HomelandRoomStatus = {Normal = 0, Edit = 1}
HomelandFurnitureType = {All = 0, Wall = 1, Floor = 2, Furniture = 3, Decorate = 4, Carpet = 5}
HomelandRoomGridType = {Floor = 1, LeftWall = 2, RightWall = 3}
HomelandRoomGridStatus = {Unknown = 0, Available = 1, OutOfRoom = 2, Occupied = 3}
HomelandRoomDecorateDirection = {None = 0, Left = 1, Right = 2}
-- DECOMPILER ERROR at PC155: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.FurnituresAmount = {}
-- DECOMPILER ERROR at PC158: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.PileFurnitures = {}
-- DECOMPILER ERROR at PC161: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.UndeployFurnitures = {}
-- DECOMPILER ERROR at PC164: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.EditUndeployFurnitures = {}
-- DECOMPILER ERROR at PC166: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.EditCurrentFurnitures = nil
-- DECOMPILER ERROR at PC168: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.EditCurrentType = nil
-- DECOMPILER ERROR at PC170: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.EditPileFurnitures = nil
-- DECOMPILER ERROR at PC173: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.Furnitures = {}
-- DECOMPILER ERROR at PC176: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.RoomByLevel = {}
-- DECOMPILER ERROR at PC179: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.StyleWF = {}
-- DECOMPILER ERROR at PC185: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.UnavailableColor = ((CS.UnityEngine).Color).red
-- DECOMPILER ERROR at PC187: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.UnavailableAlpha = 0.5
-- DECOMPILER ERROR at PC190: Confused about usage of register: R1 in 'UnsetPending'

HomelandData.VisitInfo = {}
local _roomData = HomelandData.RoomData
-- DECOMPILER ERROR at PC195: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetCurrentRoomSize = function(...)
  -- function num : 0_0 , upvalues : _ENV, _roomData
  return (((HomelandData.RoomByLevel)[_roomData.Type])[_roomData.Level]).Size
end

-- DECOMPILER ERROR at PC198: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.InitRoomConstantPart1 = function(...)
  -- function num : 0_1 , upvalues : _ENV
  if HomelandRoomConstant.DefaultFloor ~= 0 then
    return 
  end
  local info = split((((TableData.gTable).BaseFixedData)[HomelandData.DefaultZoomRange]).array_value, ":")
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.DefaultZoom = (((TableData.gTable).BaseFixedData)[HomelandData.DefaultZoomRange]).int_value / 10000
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.MaxZoom = tonumber(info[2]) / 10000
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.MinZoom = tonumber(info[1]) / 10000
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.RoleScale = tonumber((((TableData.gTable).BaseFixedData)[HomelandData.RoleScale]).int_value) / 10000
  info = split((((TableData.gTable).BaseFixedData)[HomelandData.DefaultRoomResources]).array_value, ":")
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.DefaultWall = tonumber(info[1])
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.DefaultFloor = tonumber(info[2])
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.MaxChooseCircleSize = (((TableData.gTable).BaseFixedData)[HomelandData.MaxChooseCircleSize]).int_value
  info = split((((TableData.gTable).BaseFixedData)[HomelandData.RolePatrolArgument]).array_value, ":")
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.RoleMaxMoveDistance = tonumber(info[1])
  -- DECOMPILER ERROR at PC99: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.RoleMinWaitDuration = tonumber(info[2])
  -- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.RoleMaxWaitDuration = tonumber(info[3])
  -- DECOMPILER ERROR at PC113: Confused about usage of register: R1 in 'UnsetPending'

  HomelandRoomConstant.RandomBubbleGap = (((TableData.gTable).BaseFixedData)[HomelandData.RandomBubbleGap]).int_value
  -- DECOMPILER ERROR at PC116: Confused about usage of register: R1 in 'UnsetPending'

  HomelandData.RoomByLevel = {}
  local configs = (TableData.gTable).BaseFamilyRoomUpData
  for k,v in pairs(configs) do
    -- DECOMPILER ERROR at PC134: Confused about usage of register: R7 in 'UnsetPending'

    if (HomelandData.RoomByLevel)[v.type] == nil then
      (HomelandData.RoomByLevel)[v.type] = {}
    end
    -- DECOMPILER ERROR at PC156: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((HomelandData.RoomByLevel)[v.type])[v.level] = {Id = k, RoleAmount = v.role_num, Size = tonumber((split(v.size, ":"))[1]), Cost = v.cost, FarmLevel = v.farmLevel}
  end
end

-- DECOMPILER ERROR at PC201: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.InitFurnitureData = function(usedFurniture, ...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  HomelandData.Furnitures = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  HomelandData.UndeployFurnitures = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  HomelandData.PileFurnitures = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  HomelandData.FurnituresAmount = {}
  local config = nil
  local furnitures = (ActorData.GetFurniture)()
  local timestamp = (LuaTime.GetTimeStamp)()
  for k,v in pairs(furnitures) do
    config = ((TableData.gTable).BaseFamilyFurnitureData)[v.id]
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

    if config ~= nil and (config.time == -1 or timestamp < v.time + config.time) then
      (HomelandData.Furnitures)[v.uid] = v
      if not usedFurniture[v.uid] then
        if (HomelandData.PileFurnitures)[v.id] == nil then
          (table.insert)(HomelandData.UndeployFurnitures, v.id)
          -- DECOMPILER ERROR at PC62: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (HomelandData.PileFurnitures)[v.id] = {}
        end
        ;
        (table.insert)((HomelandData.PileFurnitures)[v.id], v.uid)
      end
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R9 in 'UnsetPending'

      if (HomelandData.FurnituresAmount)[v.id] == nil then
        (HomelandData.FurnituresAmount)[v.id] = 0
      end
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (HomelandData.FurnituresAmount)[v.id] = (HomelandData.FurnituresAmount)[v.id] + 1
    end
  end
end

-- DECOMPILER ERROR at PC204: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.InitData = function(msg, ...)
  -- function num : 0_3 , upvalues : _ENV, _roomData
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  HomelandData.AllRoomData = {}
  local availableFurniture = {}
  local usedFurniture = {}
  local style = msg.defaultStyle
  local roomId = msg.defaultRoomId
  local roomData, styleData, subCount1, subCount2, config, subData, roomInfo = nil, nil, nil, nil, nil, nil, nil
  local timestamp = (LuaTime.GetTimeStamp)()
  local count = #msg.roomInfo
  local defaultStyleData = nil
  for i = 1, count do
    roomData = (msg.roomInfo)[i]
    roomInfo = {id = roomData.id, level = roomData.level, 
roomStyle = {}
}
    subCount1 = #roomData.roomStyle
    for k = 1, subCount1 do
      styleData = (roomData.roomStyle)[k]
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R23 in 'UnsetPending'

      ;
      (HomelandData.StyleWF)[styleData.styleId] = {}
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R23 in 'UnsetPending'

      ;
      (roomInfo.roomStyle)[styleData.styleId] = styleData
      if styleData.furnitureData ~= nil then
        subCount2 = #styleData.furnitureData
        availableFurniture = {}
        for j = 1, subCount2 do
          subData = (styleData.furnitureData)[j]
          config = ((TableData.gTable).BaseFamilyFurnitureData)[subData.id]
          -- DECOMPILER ERROR at PC76: Confused about usage of register: R27 in 'UnsetPending'

          if config.type == HomelandFurnitureType.Wall then
            ((HomelandData.StyleWF)[styleData.styleId]).Wall = {Id = subData.id, Uid = subData.uid}
          else
            -- DECOMPILER ERROR at PC92: Confused about usage of register: R27 in 'UnsetPending'

            if config.type == HomelandFurnitureType.Floor then
              ((HomelandData.StyleWF)[styleData.styleId]).Floor = {Id = subData.id, Uid = subData.uid}
            end
          end
          if config ~= nil and (config.time == -1 or timestamp < subData.time + config.time) then
            (table.insert)(availableFurniture, subData)
            usedFurniture[subData.uid] = true
          end
        end
        styleData.furnitureData = availableFurniture
      end
      if (style == 0 and k == 1) or style == styleData.styleId then
        defaultStyleData = styleData
        if style == 0 then
          style = styleData.styleId
        end
      end
    end
    ;
    (HomelandData.InitRoomStyleInfo)(defaultStyleData, ((HomelandData.StyleWF)[styleData.styleId]).Wall, ((HomelandData.StyleWF)[styleData.styleId]).Floor)
    if (roomId == 0 and i == 1) or roomId == roomData.id then
      (HomelandData.InitRoomInfo)(roomData)
      if roomId == 0 then
        roomId = roomData.id
      end
    end
    -- DECOMPILER ERROR at PC155: Confused about usage of register: R19 in 'UnsetPending'

    ;
    (HomelandData.AllRoomData)[roomData.id] = roomInfo
  end
  _roomData.DefaultId = roomId
  _roomData.DefaultStyleId = style
  ;
  (HomelandData.InitFurnitureData)(usedFurniture)
end

-- DECOMPILER ERROR at PC207: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.RefreshFurnitureData = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local usedFurniture = {}
  local timestamp = ((LuaTime.GetTimeStamp)())
  local count, subData, config = nil, nil, nil
  for k,v in pairs(HomelandData.AllRoomData) do
    for subk,subv in pairs(v.roomStyle) do
      count = #subv.furnitureData
      for i = 1, count do
        subData = (subv.furnitureData)[i]
        config = ((TableData.gTable).BaseFamilyFurnitureData)[subData.id]
        if config ~= nil and (config.time == -1 or timestamp < subData.time + config.time) then
          usedFurniture[subData.uid] = true
        end
      end
    end
  end
  ;
  (HomelandData.InitFurnitureData)(usedFurniture)
end

-- DECOMPILER ERROR at PC210: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetFurnituresByType = function(type, ...)
  -- function num : 0_5 , upvalues : _ENV
  local furnitures = {}
  local count = #HomelandData.EditUndeployFurnitures
  local config = nil
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  HomelandData.EditCurrentType = type
  for i = 1, count do
    config = ((TableData.gTable).BaseFamilyFurnitureData)[(HomelandData.EditUndeployFurnitures)[i]]
    if type == HomelandFurnitureType.All or type == config.type or type == HomelandFurnitureType.Furniture and config.type == HomelandFurnitureType.Carpet then
      (table.insert)(furnitures, config.id)
    end
  end
  return furnitures
end

-- DECOMPILER ERROR at PC213: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.ClearData = function(...)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.AllRoomData = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.UsedCard = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.PileFurnitures = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.UndeployFurnitures = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.EditUndeployFurnitures = {}
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.EditCurrentFurnitures = nil
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.EditCurrentType = nil
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.EditPileFurnitures = nil
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.Furnitures = {}
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.StyleWF = {}
end

-- DECOMPILER ERROR at PC216: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.InitCurrentPlayerInfo = function(data, ...)
  -- function num : 0_7 , upvalues : _roomData
  _roomData.CurrentPlayInfo = data
end

-- DECOMPILER ERROR at PC219: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetRelation = function(objectIndex, ...)
  -- function num : 0_8 , upvalues : _ENV
  if (FriendsData.IsSelfFriend)(objectIndex) then
    return HomelandHostRelation.Friend
  else
    if GuildData ~= nil and GuildData.MemberList ~= nil and (GuildData.MemberList)[objectIndex] ~= nil then
      return HomelandHostRelation.Guild
    else
      return HomelandHostRelation.Stranger
    end
  end
end

-- DECOMPILER ERROR at PC222: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.UpdateFurnitureData = function(data, ...)
  -- function num : 0_9 , upvalues : _ENV
  local config, uniqueid = nil, nil
  local timestamp = (LuaTime.GetTimeStamp)()
  config = ((TableData.gTable).BaseFamilyFurnitureData)[data.id]
  uniqueid = tonumber(data.objectIndex)
  -- DECOMPILER ERROR at PC30: Unhandled construct in 'MakeBoolean' P1

  if (HomelandData.Furnitures)[uniqueid] == nil and (config.time == -1 or timestamp < data.time + config.time) then
    (HomelandData.AddFurniture)(uniqueid, data)
  end
  ;
  (HomelandData.RemoveFurinture)(uniqueid, data)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

  if HomelandData.FurnituresAmount == nil then
    HomelandData.FurnituresAmount = {}
  end
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

  if (HomelandData.FurnituresAmount)[data.id] == nil then
    (HomelandData.FurnituresAmount)[data.id] = 0
  end
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (HomelandData.FurnituresAmount)[data.id] = (HomelandData.FurnituresAmount)[data.id] + 1
  UIMgr:SendWindowMessage((WinResConfig.HomelandRoomWindow).name, (WindowMsgEnum.Family).E_MSG_REFRESH_FURNITURE_LIST)
end

-- DECOMPILER ERROR at PC225: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetFurnitureTime = function(uid, ...)
  -- function num : 0_10 , upvalues : _ENV
  if (HomelandData.Furnitures)[uid] ~= nil then
    return ((HomelandData.Furnitures)[uid]).time
  else
    return (LuaTime.GetTimeStamp)()
  end
end

-- DECOMPILER ERROR at PC228: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.AddFurniture = function(uid, data, ...)
  -- function num : 0_11 , upvalues : _ENV
  local id = nil
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if data ~= nil then
    (HomelandData.Furnitures)[uid] = data
    id = data.id
  else
    id = ((HomelandData.Furnitures)[uid]).id
  end
  if (HomelandData.PileFurnitures)[id] == nil then
    (table.insert)(HomelandData.UndeployFurnitures, id)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (HomelandData.PileFurnitures)[id] = {}
  end
  ;
  (table.insert)((HomelandData.PileFurnitures)[id], uid)
end

-- DECOMPILER ERROR at PC231: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.RemoveFurinture = function(uid, data, ...)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (HomelandData.Furnitures)[uid] = nil
  if (HomelandData.PileFurnitures)[data.id] ~= nil then
    local datas = (HomelandData.PileFurnitures)[data.id]
    local count = #datas
    for i = 1, count do
      if uid == datas[i] then
        (table.remove)(datas, i)
        if (_G.next)(datas) == nil then
          count = #HomelandData.UndeployFurnitures
          for i = 1, count do
            if data.id == (HomelandData.UndeployFurnitures)[i] then
              (table.remove)(HomelandData.UndeployFurnitures, i)
              break
            end
          end
          do
            do
              -- DECOMPILER ERROR at PC56: Confused about usage of register: R8 in 'UnsetPending'

              ;
              (HomelandData.PileFurnitures)[data.id] = nil
              do break end
              -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC234: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.InitRoomConstantPart2 = function(totalSize, angle, pos, wallHeight, ...)
  -- function num : 0_13 , upvalues : _ENV
  if HomelandRoomConstant.OriginalPoint ~= Vector2.zero then
    return 
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  HomelandRoomConstant.OriginalPoint = pos
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  HomelandRoomConstant.WallHeight = wallHeight
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  HomelandRoomConstant.FloorAngle = angle
  local roomConfig = (TableData.gTable).BaseFamilyRoomUpData
  for k,v in pairs(roomConfig) do
    if v.level == 1 then
      local sizeStr = split(v.size, ":")
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R11 in 'UnsetPending'

      HomelandRoomConstant.DefaultGridCount = tonumber(sizeStr[1])
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R11 in 'UnsetPending'

      HomelandRoomConstant.WallVGridAmount = tonumber(sizeStr[3])
    end
  end
  local eachSize = totalSize / HomelandRoomConstant.DefaultGridCount
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R6 in 'UnsetPending'

  HomelandRoomConstant.GridProject = {cos = eachSize * (math.cos)(angle * math.pi / 180), sin = eachSize * (math.sin)(angle * math.pi / 180)}
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R6 in 'UnsetPending'

  HomelandRoomConstant.XAxis = Vector3((HomelandRoomConstant.GridProject).cos, (HomelandRoomConstant.GridProject).sin)
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R6 in 'UnsetPending'

  HomelandRoomConstant.YAxis = Vector3(-(HomelandRoomConstant.GridProject).cos, (HomelandRoomConstant.GridProject).sin)
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R6 in 'UnsetPending'

  HomelandRoomConstant.ZAxis = Vector3(0, -wallHeight / HomelandRoomConstant.WallVGridAmount)
  -- DECOMPILER ERROR at PC97: Confused about usage of register: R6 in 'UnsetPending'

  HomelandRoomConstant.NormalizeXAxis = (HomelandRoomConstant.XAxis).normalized
  -- DECOMPILER ERROR at PC102: Confused about usage of register: R6 in 'UnsetPending'

  HomelandRoomConstant.NormalizeYAxis = (HomelandRoomConstant.YAxis).normalized
  -- DECOMPILER ERROR at PC104: Confused about usage of register: R6 in 'UnsetPending'

  HomelandRoomConstant.GridLength = eachSize
  ;
  (HomelandData.SetFloorAndWallArea)()
end

-- DECOMPILER ERROR at PC237: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.InitRoomInfo = function(data, relation, ...)
  -- function num : 0_14 , upvalues : _roomData, _ENV
  if relation == nil then
    _roomData.Relation = HomelandHostRelation.Self
    _roomData.SelfId = data.id
  else
    _roomData.Relation = relation
  end
  _roomData.Id = data.id
  _roomData.Level = data.level or 1
  _roomData.Type = (((TableData.gTable).BaseFamilyRoomData)[data.id]).type
end

-- DECOMPILER ERROR at PC240: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.InitRoomStyleInfo = function(data, wall, floor, ...)
  -- function num : 0_15 , upvalues : _roomData, _ENV
  if _roomData.Relation == HomelandHostRelation.Self then
    _roomData.SelfStyleId = data.styleId
  end
  _roomData.StyleId = data.styleId
  if wall then
    _roomData.Wall = wall
  else
    _roomData.Wall = {Id = 0}
  end
  if floor then
    _roomData.Floor = floor
  else
    _roomData.Floor = {Id = 0}
  end
  if not wall or not floor then
    local count = #data.furnitureData
    local subData, config = nil, nil
    for i = 1, count do
      subData = (data.furnitureData)[i]
      config = ((TableData.gTable).BaseFamilyFurnitureData)[subData.id]
      if config.type == HomelandFurnitureType.Wall and not wall then
        _roomData.Wall = {Id = subData.id, Uid = subData.uid}
      else
        if config.type == HomelandFurnitureType.Floor and not floor then
          _roomData.Floor = {Id = subData.id, Uid = subData.uid}
        end
      end
    end
  end
  do
    if not data.roomCardInfo then
      _roomData.Role = {}
      -- DECOMPILER ERROR at PC76: Confused about usage of register: R3 in 'UnsetPending'

      HomelandData.UsedCard = {}
      local count = #_roomData.Role
      for i = 1, count do
        -- DECOMPILER ERROR at PC88: Confused about usage of register: R8 in 'UnsetPending'

        (HomelandData.UsedCard)[((_roomData.Role)[i]).cardId] = true
      end
      do
        if not data.furnitureData then
          _roomData.Furniture = {}
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC243: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.SetFloorAndWallArea = function(...)
  -- function num : 0_16 , upvalues : _ENV
  local wallHeight = HomelandRoomConstant.WallHeight
  local totalSize = HomelandRoomConstant.GridLength * (HomelandData.GetCurrentRoomSize)()
  local angle = HomelandRoomConstant.FloorAngle
  local pos = HomelandRoomConstant.OriginalPoint
  local sin = totalSize * (math.sin)(angle * math.pi / 180)
  local cos = totalSize * (math.cos)(angle * math.pi / 180)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'

  HomelandRoomConstant.LeftWallRect = {
TopLeft = {x = pos.x - cos, y = pos.y - wallHeight + sin}
, 
TopRight = {x = pos.x, y = pos.y - wallHeight}
, 
BottomLeft = {x = pos.x - cos, y = pos.y + sin}
, 
BottomRight = {x = pos.x, y = pos.y}
}
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R6 in 'UnsetPending'

  HomelandRoomConstant.RightWallRect = {
TopLeft = {x = pos.x, y = pos.y - wallHeight}
, 
TopRight = {x = pos.x + cos, y = pos.y - wallHeight + sin}
, 
BottomLeft = {x = pos.x, y = pos.y}
, 
BottomRight = {x = pos.x + cos, y = pos.y + sin}
}
  -- DECOMPILER ERROR at PC126: Confused about usage of register: R6 in 'UnsetPending'

  HomelandRoomConstant.FloorRect = {
TopLeft = {x = pos.x, y = pos.y}
, 
TopRight = {x = pos.x + cos, y = pos.y + sin}
, 
BottomLeft = {x = pos.x - cos, y = pos.y + sin}
, 
BottomRight = {x = pos.x, y = pos.y + 2 * sin}
}
end

-- DECOMPILER ERROR at PC246: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.UpdateCardGridUsage = function(x, y, id, ...)
  -- function num : 0_17 , upvalues : _roomData, _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  if id then
    if (_roomData.CardGridUsage)[x] == nil then
      (_roomData.CardGridUsage)[x] = {}
    end
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((_roomData.CardGridUsage)[x])[y] = id
    ;
    (HomelandData.Change2DSet)((HomelandData.RoomData).CardGrid, x, y)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (HomelandData.RoomData).CardGridCount = (HomelandData.RoomData).CardGridCount - 1
    return true
  else
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

    if (_roomData.CardGridUsage)[x] then
      ((_roomData.CardGridUsage)[x])[y] = nil
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

      if (_G.next)((_roomData.CardGridUsage)[x]) == nil then
        (_roomData.CardGridUsage)[x] = nil
      end
      ;
      (HomelandData.Change2DSet)((HomelandData.RoomData).CardGrid, x, y, true)
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (HomelandData.RoomData).CardGridCount = (HomelandData.RoomData).CardGridCount + 1
      return true
    else
      return false
    end
  end
end

-- DECOMPILER ERROR at PC249: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.CheckGridAvailableForRole = function(x, y, ...)
  -- function num : 0_18 , upvalues : _roomData
  do return ((_roomData.GridUsage)[x] == nil or ((_roomData.GridUsage)[x])[y] == nil or (((_roomData.GridUsage)[x])[y])[0] == nil) and (_roomData.CardGridUsage)[x] == nil or ((_roomData.CardGridUsage)[x])[y] == nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC252: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.InitCardGridData = function(...)
  -- function num : 0_19 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (HomelandData.RoomData).CardGridUsage = {}
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (HomelandData.RoomData).CardGrid = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (HomelandData.RoomData).CardGridCount = 0
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (HomelandData.RoomData).GridWaiting = {}
  local size = (HomelandData.GetCurrentRoomSize)()
  for i = 1, size do
    for j = 1, size do
      if (HomelandData.CheckGridAvailableForRole)(i, j) then
        (HomelandData.Change2DSet)((HomelandData.RoomData).CardGrid, i, j, true)
        -- DECOMPILER ERROR at PC48: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (HomelandData.RoomData).CardGridCount = (HomelandData.RoomData).CardGridCount + 1
      end
    end
  end
end

-- DECOMPILER ERROR at PC255: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetRandomAvailableCoordinate = function(...)
  -- function num : 0_20 , upvalues : _ENV, Random
  local index = (math.floor)((Random.Range)(1, (HomelandData.RoomData).CardGridCount))
  for k,v in pairs((HomelandData.RoomData).CardGrid) do
    for subk,subv in pairs(v) do
      index = index - 1
      if index <= 0 then
        return Vector2(k, subk)
      end
    end
  end
  return nil
end

-- DECOMPILER ERROR at PC258: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.Change2DSet = function(set, x, y, data, ...)
  -- function num : 0_21 , upvalues : _ENV
  if data then
    if set[x] == nil then
      set[x] = {}
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (set[x])[y] = data
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

    if set[x] ~= nil and (set[x])[y] ~= nil then
      (set[x])[y] = nil
      if (_G.next)(set[x]) == nil then
        set[x] = nil
      end
    end
  end
end

-- DECOMPILER ERROR at PC261: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetFurnitureAmount = function(id, ...)
  -- function num : 0_22 , upvalues : _ENV
  if (HomelandData.FurnituresAmount)[id] then
    return (HomelandData.FurnituresAmount)[id]
  else
    return 0
  end
end

-- DECOMPILER ERROR at PC264: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.RemoveFromWaitingList = function(coordinate, roleId, ...)
  -- function num : 0_23 , upvalues : _ENV
  if ((HomelandData.RoomData).GridWaiting)[coordinate.x] ~= nil then
    local waiting = (((HomelandData.RoomData).GridWaiting)[coordinate.x])[coordinate.y]
    if waiting then
      local count = #waiting
      for i = 1, count do
        if (waiting[i]).Id == roleId then
          (table.remove)(waiting, i)
          break
        end
      end
      do
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'

        if (_G.next)(waiting) == nil then
          (((HomelandData.RoomData).GridWaiting)[coordinate.x])[coordinate.y] = nil
          -- DECOMPILER ERROR at PC59: Confused about usage of register: R4 in 'UnsetPending'

          if (_G.next)(((HomelandData.RoomData).GridWaiting)[coordinate.x]) == nil then
            ((HomelandData.RoomData).GridWaiting)[coordinate.x] = nil
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC267: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.IncreaseVisitIndex = function(...)
  -- function num : 0_24 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if (HomelandData.VisitInfo).Index == #(HomelandData.VisitInfo).Content then
    (HomelandData.VisitInfo).Index = 1
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (HomelandData.VisitInfo).Index = (HomelandData.VisitInfo).Index + 1
  end
end

-- DECOMPILER ERROR at PC270: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetPath = function(start, destination, ...)
  -- function num : 0_25 , upvalues : _ENV
  local openSet = {}
  local closeSet = {}
  local nearBySet = {}
  if start.x == destination.x and start.y == destination.y then
    return 
  end
  ;
  (HomelandData.Change2DSet)(openSet, start.x, start.y, {Priority = 0})
  local index = 0
  ;
  (table.insert)(nearBySet, start)
  local count, node, minNode, checkNode = nil, nil, nil, nil
  local roomSize = (HomelandData.GetCurrentRoomSize)()
  local runCount = 0
  local evenWeightCheckpoint = {}
  while 1 do
    while 1 do
      count = #nearBySet
      runCount = runCount + 1
      if roomSize * roomSize < runCount then
        loge("妈蛋，越界了")
      else
        minNode = nearBySet[1]
        index = index + 1
        if minNode == nil then
          local checkpointCount = #evenWeightCheckpoint
          do
            if checkpointCount > 0 then
              local info = evenWeightCheckpoint[checkpointCount]
              minNode = (table.remove)(info.Nodes, 1)
              openSet = (Util.Copy)(info.OpenSet)
              closeSet = (Util.Copy)(info.CloseSet)
              index = info.Index
              if #info.Nodes == 0 then
                (table.remove)(evenWeightCheckpoint, checkpointCount)
              end
            else
              -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
        local nearByData, minData = nil, nil
        local evenWeight = {}
        for i = 2, count do
          nearByData = (openSet[(nearBySet[i]).x])[(nearBySet[i]).y]
          minData = (openSet[minNode.x])[minNode.y]
          if nearByData.Priority < minData.Priority then
            minNode = nearBySet[i]
          else
            if nearByData.Priority == minData.Priority then
              (table.insert)(evenWeight, nearBySet[i])
            end
          end
        end
        if (_G.next)(evenWeight) ~= nil then
          evenWeightCheckpoint[#evenWeightCheckpoint + 1] = {Nodes = evenWeight, OpenSet = (Util.Copy)(openSet), CloseSet = (Util.Copy)(closeSet), Index = index}
        end
        ;
        (HomelandData.Change2DSet)(closeSet, minNode.x, minNode.y, (openSet[minNode.x])[minNode.y])
        ;
        (HomelandData.Change2DSet)(openSet, minNode.x, minNode.y)
        local addNewNode = function(newNode, ...)
    -- function num : 0_25_0 , upvalues : closeSet, minNode, _ENV, destination, openSet, nearBySet, checkNode
    local t = ((closeSet[minNode.x])[minNode.y]).Priority + 1 + (math.abs)(destination.x - newNode.x) + (math.abs)(destination.y - newNode.y)
    ;
    (HomelandData.Change2DSet)(openSet, newNode.x, newNode.y, {Parent = minNode, Priority = ((closeSet[minNode.x])[minNode.y]).Priority + 1 + (math.abs)(destination.x - newNode.x) + (math.abs)(destination.y - newNode.y)})
    ;
    (table.insert)(nearBySet, checkNode)
  end

        local checkNearByNode = function(x, y, condition, ...)
    -- function num : 0_25_1 , upvalues : checkNode, _ENV, destination, node, closeSet, addNewNode
    checkNode = Vector2(x, y)
    if checkNode.x == destination.x and checkNode.y == destination.y then
      node = checkNode
      return true
    else
      if condition(checkNode) and (HomelandData.CheckGridAvailableForRole)(checkNode.x, checkNode.y) and (not closeSet[checkNode.x] or not (closeSet[checkNode.x])[checkNode.y]) then
        addNewNode(checkNode)
      end
      return false
    end
  end

        nearBySet = {}
        -- DECOMPILER ERROR at PC183: LeaveBlock: unexpected jumping out IF_ELSE_STMT

        -- DECOMPILER ERROR at PC183: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  do
    if checkNearByNode(minNode.x - 1, minNode.y, function(checkNode, ...)
    -- function num : 0_25_2
    do return checkNode.x > 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
) or checkNearByNode(minNode.x, minNode.y + 1, function(checkNode, ...)
    -- function num : 0_25_3 , upvalues : roomSize
    do return checkNode.y <= roomSize end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
) or checkNearByNode(minNode.x + 1, minNode.y, function(checkNode, ...)
    -- function num : 0_25_4 , upvalues : roomSize
    do return checkNode.x <= roomSize end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
) or checkNearByNode(minNode.x, minNode.y - 1, function(checkNode, ...)
    -- function num : 0_25_5
    do return checkNode.y > 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
) or node then
      local path = {}
      path[index + 1] = node
      node = minNode
      repeat
        path[index] = node
        index = index - 1
        node = ((closeSet[node.x])[node.y]).Parent
      until node == nil
      return path
    else
      do
        do return nil end
      end
    end
  end
end

-- DECOMPILER ERROR at PC273: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.SetFarmInfo = function(farmInfo, ...)
  -- function num : 0_26 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if not farmInfo then
    HomelandData.farmInfo = {}
  end
end

-- DECOMPILER ERROR at PC276: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetFarmInfo = function(...)
  -- function num : 0_27 , upvalues : _ENV
  return HomelandData.farmInfo
end

-- DECOMPILER ERROR at PC279: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetFarmLevel = function(...)
  -- function num : 0_28 , upvalues : _ENV
  return HomelandData.farmInfo and (HomelandData.farmInfo).farmLevel or 0
end

-- DECOMPILER ERROR at PC282: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetLandInfoByIndex = function(index, ...)
  -- function num : 0_29 , upvalues : _ENV
  local landInfo = {
serverData = {}
, 
configData = {}
}
  for key,value in pairs((HomelandData.farmInfo).landInfo) do
    local landConfig = ((TableData.gTable).BaseFamilyFarmLandData)[value.id]
    local type = landConfig.type
    if type == index then
      landInfo = {serverData = value, configData = landConfig}
    end
  end
  return landInfo
end

-- DECOMPILER ERROR at PC285: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.SetLandInfoByIndex = function(index, status, countDown, ...)
  -- function num : 0_30 , upvalues : _ENV
  for key,value in pairs((HomelandData.farmInfo).landInfo) do
    local landConfig = ((TableData.gTable).BaseFamilyFarmLandData)[value.id]
    local type = landConfig.type
    if not status then
      do
        value.status = type ~= index or 1
        value.countDown = countDown or 0
        -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

-- DECOMPILER ERROR at PC288: Confused about usage of register: R2 in 'UnsetPending'

HomelandData.GetSeedNumById = function(seedId, ...)
  -- function num : 0_31 , upvalues : _ENV
  local num = 0
  if (HomelandData.farmInfo).seedInfo then
    for index,value in ipairs((HomelandData.farmInfo).seedInfo) do
      if value.id == seedId then
        num = value.stock
      end
    end
  end
  do
    return num
  end
end


