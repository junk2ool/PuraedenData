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
  local m = {}
  m.shopType = tonumber(shopType)
  ;
  (Net.Send)((Proto.MsgName).ReqShopGridData, m, (Proto.MsgName).ResShopGridData)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopGridData = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  if msg then
    if msg.shopType == ShopType.ActivityDungeonShop then
      OpenWindow((WinResConfig.ActivityDungeonShopWindow).name, UILayer.HUD, msg)
    else
      if msg.shopType == ShopType.Family_NormalShop or msg.shopType == ShopType.Family_SeedShop or msg.shopType == ShopType.Family_SecretShop then
        (HomelandService.ResShopGridDataByType)(msg)
      else
        if not (ShopService.CheckIsContainFreeItem)(msg.shopGridData) then
          (RedDotService.ReqRemoveRedDot)((WinResConfig.ShopWindow).name, RedDotComID.Shop_Main, 23000000 + msg.shopType)
        end
        ;
        (ShopMgr.InitShopGridData)(msg)
      end
    end
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

ShopService.CheckIsContainFreeItem = function(shopGridData, ...)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in ipairs(shopGridData) do
    local PoolData = ((TableData.gTable).BaseShopPoolData)[v.shopPoolId]
    local cost = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, v.useNum)
    if tonumber(cost[3]) <= 0 then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnReqShopReset = function(type, ...)
  -- function num : 0_6 , upvalues : _ENV
  local m = {}
  m.shopType = type
  ;
  (Net.Send)((Proto.MsgName).ReqShopReset, m, (Proto.MsgName).ResShopReset)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopReset = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV
  if msg then
    (ShopMgr.InitShopGridData)(msg)
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnReqShopBuy = function(type, poolId, gridId, num, ...)
  -- function num : 0_8 , upvalues : _ENV
  local m = {}
  m.shopType = type
  m.shopPoolId = poolId
  m.shopGridId = gridId
  m.shopNum = num
  ;
  (Net.Send)((Proto.MsgName).ReqShopBuy, m, (Proto.MsgName).ResShopBuy)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResShopBuy = function(msg, ...)
  -- function num : 0_9 , upvalues : _ENV
  if msg.success then
    UIMgr:CloseWindow((WinResConfig.ShopBuyWindow).name)
    if msg.shopType == ShopType.ActivityDungeonShop then
      UIMgr:SendWindowMessage((WinResConfig.ActivityDungeonShopWindow).name, (WindowMsgEnum.ActivityDungeonShopWindow).E_MSG_REFRESH_ITEMLIST, {data = msg.shopGridData})
    else
      if msg.shopType == ShopType.Family_NormalShop or msg.shopType == ShopType.Family_SeedShop or msg.shopType == ShopType.Family_SecretShop then
        (HomelandService.ResShopBuy)(msg)
      else
        ;
        (ShopMgr.SetShopGridData)(msg.shopGridData)
        UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_REFRESH_ITEM)
      end
    end
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

ShopService.ReqActivityInfoList = function(...)
  -- function num : 0_10 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqActivityInfoList, m, (Proto.MsgName).ResActivityInfoList)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

ShopService.OnResActivityInfoList = function(msg, ...)
  -- function num : 0_11 , upvalues : _ENV
  (ShopMgr.SetActivityData)(msg.baseActivityInfo)
  UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_GET_ACTIVITYINFO)
end

;
(ShopService.Init)()

