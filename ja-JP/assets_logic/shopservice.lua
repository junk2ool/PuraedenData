-- params : ...
-- function num : 0 , upvalues : _ENV
ShopService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

ShopService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResShopData, ShopService.OnResShopData)
  ;
  (Net.AddListener)((Proto.MsgName).ResShopGridData, ShopService.OnResShopGridData)
  ;
  (Net.AddListener)((Proto.MsgName).ResShopReset, ShopService.OnResShopReset)
  ;
  (Net.AddListener)((Proto.MsgName).ResShopBuy, ShopService.OnResShopBuy)
  ;
  (Net.AddListener)((Proto.MsgName).ResActivityInfoList, ShopService.OnResActivityInfoList)
  ;
  (Net.AddListener)((Proto.MsgName).ResUnlockProduct, ShopService.OnResUnlockProduct)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnReqShopData = function(flag, ...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {flag = flag or 0}
  ;
  (Net.Send)((Proto.MsgName).ReqShopData, m, (Proto.MsgName).ResShopData)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopData = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  if msg.flag == 0 then
    (ShopMgr.InitShop)(msg)
  else
    if msg.flag == 1 then
      (HomelandService.ResFarmShopTypeData)(msg)
    end
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnReqShopGridData = function(shopType, ...)
  -- function num : 0_3 , upvalues : _ENV
  local shopId = nil
  if shopType ~= ShopType.ActivityDungeonShop then
    shopId = (ShopMgr.GetShopIdByShopType)(shopType)
  else
    local shopDataItem = (ShopMgr.GetShopDataItemByActivityId)((ActivityDungeonData.GetCurrentActivityDungeonId)())
    if shopDataItem == nil then
      loge("Can Not Find ShopDataItem With " .. tostring((ActivityDungeonData.GetCurrentActivityDungeonId)()))
      return 
    end
    shopId = shopDataItem.id
  end
  do
    ;
    (ShopService.ReqShopGridDataByShopId)(shopId)
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

ShopService.ReqShopGridDataByShopId = function(shopId, ...)
  -- function num : 0_4 , upvalues : _ENV
  (Net.Send)((Proto.MsgName).ReqShopGridData, {shopId = shopId}, (Proto.MsgName).ResShopGridData)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopGridData = function(msg, ...)
  -- function num : 0_5 , upvalues : _ENV
  if msg then
    local shopId = msg.shopId
    local shopType = (ShopMgr.GetShopTypeByShopId)(shopId)
    if shopType == ShopType.ActivityDungeonShop then
      OpenWindow((WinResConfig.ActivityDungeonShopWindow).name, UILayer.HUD, msg)
    else
      if shopType == ShopType.Family_NormalShop or shopType == ShopType.Family_SeedShop or shopType == ShopType.Family_SecretShop then
        (HomelandService.ResShopGridDataByType)(msg)
      else
        if shopType == ShopType.RelicShop then
          OpenWindow((WinResConfig.RelicShopWindow).name, UILayer.HUD, msg)
        else
          if not (ShopService.CheckIsContainFreeItem)(msg.shopGridData) then
            (RedDotService.ReqRemoveRedDot)((WinResConfig.ShopWindow).name, RedDotComID.Shop_Main, 23000000 + shopId)
          end
          ;
          (ShopMgr.InitShopGridData)(msg)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

ShopService.CheckIsContainFreeItem = function(shopGridData, ...)
  -- function num : 0_6 , upvalues : _ENV
  for _,v in ipairs(shopGridData) do
    local PoolData = ((TableData.gTable).BaseShopPoolData)[v.shopPoolId]
    local cost = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, v.useNum)
    if tonumber(cost[3]) <= 0 then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnReqShopReset = function(shopType, ...)
  -- function num : 0_7 , upvalues : _ENV
  (ShopService.ReqShopRestByShopId)((ShopMgr.GetShopIdByShopType)(shopType))
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

ShopService.ReqShopRestByShopId = function(shopId, ...)
  -- function num : 0_8 , upvalues : _ENV
  (Net.Send)((Proto.MsgName).ReqShopReset, {shopId = shopId}, (Proto.MsgName).ResShopReset)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopReset = function(msg, ...)
  -- function num : 0_9 , upvalues : _ENV
  if msg then
    (ShopMgr.InitShopGridData)(msg)
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnReqShopBuy = function(shopId, poolId, gridId, num, ...)
  -- function num : 0_10 , upvalues : _ENV
  local m = {}
  m.shopId = shopId
  m.shopPoolId = poolId
  m.shopGridId = gridId
  m.shopNum = num
  ;
  (Net.Send)((Proto.MsgName).ReqShopBuy, m, (Proto.MsgName).ResShopBuy)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopBuy = function(msg, ...)
  -- function num : 0_11 , upvalues : _ENV
  if msg.success then
    UIMgr:CloseWindow((WinResConfig.ShopBuyWindow).name)
    local shopType = (ShopMgr.GetShopTypeByShopId)(msg.shopId)
    if shopType == ShopType.ActivityDungeonShop then
      UIMgr:SendWindowMessage((WinResConfig.ActivityDungeonShopWindow).name, (WindowMsgEnum.ActivityDungeonShopWindow).E_MSG_REFRESH_ITEMLIST, {data = msg.shopGridData})
    else
      if shopType == ShopType.Family_NormalShop or shopType == ShopType.Family_SeedShop or shopType == ShopType.Family_SecretShop then
        (HomelandService.ResShopBuy)(msg)
      else
        if shopType == ShopType.RelicShop then
          UIMgr:SendWindowMessage((WinResConfig.RelicShopWindow).name, (WindowMsgEnum.Relic).E_MSG_SHOP_BUY, {data = msg.shopGridData})
        else
          ;
          (ShopMgr.SetShopGridData)(msg.shopGridData)
          UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_REFRESH_ITEM)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

ShopService.ReqActivityInfoList = function(...)
  -- function num : 0_12 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqActivityInfoList, m, (Proto.MsgName).ResActivityInfoList)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResActivityInfoList = function(msg, ...)
  -- function num : 0_13 , upvalues : _ENV
  (ShopMgr.SetActivityData)(msg.baseActivityInfo)
  UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_GET_ACTIVITYINFO)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

ShopService.ReqUnLockProduct = function(...)
  -- function num : 0_14 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqUnlockProduct, m, (Proto.MsgName).ResUnlockProduct)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResUnlockProduct = function(msg, ...)
  -- function num : 0_15 , upvalues : _ENV
  (ShopMgr.SetProductData)(msg)
end

;
(ShopService.Init)()

