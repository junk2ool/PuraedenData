-- params : ...
-- function num : 0 , upvalues : _ENV
HomelandService = {}
local self = HomelandService
self.reqInFamilyCallBack = nil
self.shopType = nil
-- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResInFamily, HomelandService.OnResInFamily)
  ;
  (Net.AddListener)((Proto.MsgName).ResSeedWarehouse, HomelandService.OnResSeedWarehouse)
  ;
  (Net.AddListener)((Proto.MsgName).ResLandPlanting, HomelandService.OnResLandPlanting)
  ;
  (Net.AddListener)((Proto.MsgName).ResLandHarvest, HomelandService.OnResLandHarvest)
  ;
  (Net.AddListener)((Proto.MsgName).ResLandUproot, HomelandService.OnResLandUproot)
  ;
  (Net.AddListener)((Proto.MsgName).ResLandUnlock, HomelandService.OnResLandUnlock)
  ;
  (Net.AddListener)((Proto.MsgName).ResRoomInfo, HomelandService.RecvRoomInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResRoomEnter, HomelandService.RecvRoomEnter)
  ;
  (Net.AddListener)((Proto.MsgName).ResRoomLayout, HomelandService.RecvRoomLayout)
  ;
  (Net.AddListener)((Proto.MsgName).ResRoomLevelUp, HomelandService.RecvRoomLevelUp)
  ;
  (Net.AddListener)((Proto.MsgName).ResRoomCallOn, HomelandService.RecvRoomCallOn)
  ;
  (Net.AddListener)((Proto.MsgName).ResQuitRoom, HomelandService.RecvQuitRoom)
  ;
  (Net.AddListener)((Proto.MsgName).ResRandomPlayerInfo, HomelandService.RecvRandomPlayerInfo)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqRoomInfo = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqRoomInfo, m, (Proto.MsgName).ResRoomInfo)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.RecvRoomInfo = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (HomelandMgr.RecvRoomInfo)(msg)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqRoomEnter = function(cardIds, roomId, styleId, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.cardId = cardIds
  m.roomId = roomId
  m.styleId = styleId
  ;
  (Net.Send)((Proto.MsgName).ReqRoomEnter, m, (Proto.MsgName).ResRoomEnter)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.RecvRoomEnter = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (HomelandMgr.RecvRoomEnter)(msg)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqRoomLayout = function(roomId, roomStyle, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.roomId = roomId
  m.roomStyle = roomStyle
  ;
  (Net.Send)((Proto.MsgName).ReqRoomLayout, m, (Proto.MsgName).ResRoomLayout)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.RecvRoomLayout = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  (HomelandMgr.RecvChangeRoomLayout)(msg)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqRoomLevelUp = function(roomId, styleId, ...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  m.id = roomId
  m.styleId = styleId
  ;
  (Net.Send)((Proto.MsgName).ReqRoomLevelUp, m, (Proto.MsgName).ResRoomLevelUp)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.RecvRoomLevelUp = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  (HomelandMgr.RecvRoomLevelUp)(msg)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqRoomCallOn = function(objectIndex, serverId, ...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  m.objectIndex = objectIndex
  m.serverId = serverId
  ;
  (Net.Send)((Proto.MsgName).ReqRoomCallOn, m, (Proto.MsgName).ResRoomCallOn)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.RecvRoomCallOn = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  (HomelandMgr.RecvRoomCallOn)(msg)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqQuitRoom = function(roomId, styleId, ...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  m.roomId = roomId
  m.styleId = styleId
  ;
  (Net.Send)((Proto.MsgName).ReqQuitRoom, m, (Proto.MsgName).ResQuitRoom)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.RecvQuitRoom = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  (HomelandMgr.RecvQuitRoom)(msg)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqRandomPlayerInfo = function(...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqRandomPlayerInfo, m, (Proto.MsgName).ResRandomPlayerInfo)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.RecvRandomPlayerInfo = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  (HomelandMgr.RecvRandomPlayerInfo)(msg)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqInFamily = function(callBack, ...)
  -- function num : 0_15 , upvalues : _ENV, self
  print("请求进入农场")
  if callBack then
    self.reqInFamilyCallBack = callBack
  end
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqInFamily, m, (Proto.MsgName).ResInFamily)
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.OnResInFamily = function(msg, ...)
  -- function num : 0_16 , upvalues : _ENV, self
  print("返回农场数据", msg.framInfo)
  ld("Homeland", function(...)
    -- function num : 0_16_0 , upvalues : _ENV, msg
    (HomelandData.SetFarmInfo)(msg.framInfo)
    OpenWindow((WinResConfig.HomelandFarmWindow).name, UILayer.HUD)
  end
)
  if self.reqInFamilyCallBack then
    (self.reqInFamilyCallBack)()
  end
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqSeedWarehouse = function(...)
  -- function num : 0_17 , upvalues : _ENV
  print("2303请求种子仓库")
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqSeedWarehouse, m, (Proto.MsgName).ResSeedWarehouse)
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.OnResSeedWarehouse = function(msg, ...)
  -- function num : 0_18 , upvalues : _ENV
  print("2304返回种子仓库")
  UIMgr:SendWindowMessage("HomelandFarmWindow", (WindowMsgEnum.Family).E_MSG_GET_SEEDS_INFO, {data = msg})
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqLandPlanting = function(plantInfo, ...)
  -- function num : 0_19 , upvalues : _ENV
  print("2305请求土地种植")
  local m = {plantInfo = plantInfo}
  ;
  (Net.Send)((Proto.MsgName).ReqLandPlanting, m, (Proto.MsgName).ResLandPlanting)
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.OnResLandPlanting = function(msg, ...)
  -- function num : 0_20 , upvalues : _ENV
  print("2306返回土地种植")
  UIMgr:SendWindowMessage("HomelandFarmWindow", (WindowMsgEnum.Family).E_MSG_SEED_PLANT_SUCCESS, {data = msg})
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqLandHarvest = function(landId, ...)
  -- function num : 0_21 , upvalues : _ENV
  print("2307请求土地收割")
  local m = {landId = landId}
  ;
  (Net.Send)((Proto.MsgName).ReqLandHarvest, m, (Proto.MsgName).ResLandHarvest)
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.OnResLandHarvest = function(msg, ...)
  -- function num : 0_22 , upvalues : _ENV
  print("2308返回土地收割", #msg.goods, (msg.framInfo).farmLevel, (HomelandData.GetFarmLevel)())
  local isNeedLvl = (HomelandData.GetFarmLevel)() < (msg.framInfo).farmLevel
  UIMgr:SendWindowMessage("HomelandFarmWindow", (WindowMsgEnum.Family).E_MSG_PLANT_HARVEST, {data = msg})
  if msg.landId == 0 then
    local items = {}
    do
      for index,value in ipairs(msg.goods) do
        print("土地收割获得", value.id, value.value, value.type)
        if value.type ~= (ProtoEnum.E_GOODS_TYPE).OTHER then
          (table.insert)(items, {id = value.id, Num = value.value, Type = value.type})
        end
      end
      if #items > 0 then
        (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_22_0 , upvalues : _ENV, items, isNeedLvl, msg
    (MessageMgr.OpenRewardShowWindow)(items, function(...)
      -- function num : 0_22_0_0 , upvalues : isNeedLvl, _ENV, msg
      if isNeedLvl then
        OpenWindow((WinResConfig.FarmLevelUpWindow).name, UILayer.HUD, (msg.framInfo).farmLevel)
      end
    end
)
  end
)
      else
        (MessageMgr.SendCenterTips)((PUtil.get)(258))
      end
    end
  else
    for index,value in ipairs(msg.goods) do
      (MessageMgr.OpenItemBuyTipsWindowBySingle)({id = value.id, Num = value.value})
    end
    if isNeedLvl then
      OpenWindow((WinResConfig.FarmLevelUpWindow).name, UILayer.HUD, (msg.framInfo).farmLevel)
    end
  end
  ;
  (HomelandService.CheckFarmRedDot)(msg.framInfo)
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.CheckFarmRedDot = function(fInfo, ...)
  -- function num : 0_23 , upvalues : _ENV
  local isNeedEl = true
  if fInfo and fInfo.landInfo then
    for index,value in ipairs(fInfo.landInfo) do
      if value.status == (ProtoEnum.LAND_STATUS).HARVEST then
        if isNeedEl then
          do
            isNeedEl = false
            if value.status == (ProtoEnum.LAND_STATUS).DEFAULT_LOCK then
              local farmLvl = fInfo.farmLevel
              local landConfigData = nil
              for key,value in pairs((TableData.gTable).BaseFamilyFarmLandData) do
                if value.type == index then
                  landConfigData = value
                end
              end
              local needLvl = landConfigData.farm_level
              print("判断是否可以解锁", farmLvl, needLvl)
              isNeedEl = not isNeedEl or farmLvl < needLvl
            elseif isNeedEl then
              isNeedEl = true
            end
            -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  if isNeedEl then
    (RedDotMgr.EliminateRedDot)((WinResConfig.HomeWindow).name, RedDotComID.Homeland_Farm_Harve)
    ;
    (RedDotMgr.EliminateRedDot)((WinResConfig.HomeWindow).name, RedDotComID.Homeland_Farm_Unlock)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqLandUproot = function(landId, ...)
  -- function num : 0_24 , upvalues : _ENV
  print("2309请求土地铲除")
  local m = {landId = landId}
  ;
  (Net.Send)((Proto.MsgName).ReqLandUproot, m, (Proto.MsgName).ResLandUproot)
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.OnResLandUproot = function(msg, ...)
  -- function num : 0_25 , upvalues : _ENV
  print("2310返回土地铲除")
  UIMgr:SendWindowMessage("HomelandFarmWindow", (WindowMsgEnum.Family).E_MSG_ROOT_LAND, {data = msg})
  local items = {}
  local seedData = ((TableData.gTable).BaseFamilyFarmSeedData)[msg.seedId]
  ;
  (MessageMgr.OpenItemBuyTipsWindowBySingle)({id = msg.seedId, Num = seedData.use_num})
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqLandUnlock = function(landId, ...)
  -- function num : 0_26 , upvalues : _ENV
  print("2311请求土地解锁", landId)
  local m = {landId = landId}
  ;
  (Net.Send)((Proto.MsgName).ReqLandUnlock, m, (Proto.MsgName).ResLandUnlock)
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.OnResLandUnlock = function(msg, ...)
  -- function num : 0_27 , upvalues : _ENV
  print("2312返回土地解锁")
  UIMgr:SendWindowMessage("HomelandFarmWindow", (WindowMsgEnum.Family).E_MSG_UNLOCK_LAND, {data = msg})
  ;
  (HomelandService.CheckFarmRedDot)(msg.framInfo)
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqFarmShopTypeData = function(shopType, ...)
  -- function num : 0_28 , upvalues : _ENV, self
  ld("Shop", function(...)
    -- function num : 0_28_0 , upvalues : self, shopType, _ENV
    self.shopType = shopType
    ;
    (ShopService.OnReqShopData)(1)
  end
)
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ResFarmShopTypeData = function(msg, ...)
  -- function num : 0_29 , upvalues : _ENV, self
  (HomelandService.ReqShopGridDataByType)(self.shopType)
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqShopGridDataByType = function(shopType, ...)
  -- function num : 0_30 , upvalues : _ENV
  if shopType then
    (ShopService.OnReqShopGridData)(shopType)
  end
end

-- DECOMPILER ERROR at PC100: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ResShopGridDataByType = function(msg, ...)
  -- function num : 0_31 , upvalues : _ENV
  print("返回商店类型格子")
  if UIMgr:IsWindowOpen((WinResConfig.FamilyShopWindow).name) then
    UIMgr:SendWindowMessage((WinResConfig.FamilyShopWindow).name, (WindowMsgEnum.Family).E_MSG_FARMSHOP_SHOPGRIP_RES, {data = msg})
  else
    if (_G.next)(HomelandData.AllRoomData) == nil then
      (HomelandMgr.InitRoomInfo)()
    end
    OpenWindow((WinResConfig.FamilyShopWindow).name, UILayer.HUD, msg)
  end
end

-- DECOMPILER ERROR at PC103: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqShopReset = function(shopType, ...)
  -- function num : 0_32
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ResShopReset = function(msg, ...)
  -- function num : 0_33
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ReqShopBuy = function(shopType, ...)
  -- function num : 0_34
end

-- DECOMPILER ERROR at PC112: Confused about usage of register: R1 in 'UnsetPending'

HomelandService.ResShopBuy = function(msg, ...)
  -- function num : 0_35 , upvalues : _ENV
  if msg.success then
    UIMgr:SendWindowMessage((WinResConfig.FamilyShopWindow).name, (WindowMsgEnum.Family).E_MSG_FARMSHOP_BUY_RES, {data = msg})
  else
    ;
    (MessageMgr.SendCenterTips)((Util.get)(257))
  end
end

;
(HomelandService.Init)()

