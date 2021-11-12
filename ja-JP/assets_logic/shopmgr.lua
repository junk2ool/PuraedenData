-- params : ...
-- function num : 0 , upvalues : _ENV
ShopMgr = {}
local self = ShopMgr
self.ShopData = {}
self.isExternalRequest = false
self.ExternalFun = {}
self.ExternalType = {}
self.ActivityData = {}
self.ProductData = {}
ShopType = {Recharge = 11, GiftBuy = 12, Grocer = 1, MysteryShop = 2, TokenShop = 3, ExpeditionShop = 4, ActivityDungeonShop = 5, Family_NormalShop = 6, Family_SeedShop = 7, Family_SecretShop = 8, RelicShop = 9, TuiSongLiBao = 10}
ShopBtnTxt = {(PUtil.get)(20000314), (PUtil.get)(20000315), (PUtil.get)(20000661), (PUtil.get)(20000065), (PUtil.get)(20000066), (PUtil.get)(20000067), (PUtil.get)(20000068)}
ShopBtnName = {"Recharge", "GiftBuy", "TuiSongLiBao", "Grocer", "MysteryShop", "TokenShop", "ExpeditionShop"}
ShopBtnTab = {
Recharge = {btnName = "Recharge", tapType = 1}
, 
GiftBuy = {btnName = "GiftBuy", tapType = 2}
, 
TuiSongLiBao = {btnName = "TuiSongLiBao", tapType = 3}
, 
Grocer = {btnName = "Grocer", tapType = 4}
, 
MysteryShop = {btnName = "MysteryShop", tapType = 5}
, 
TokenShop = {btnName = "TokenShop", tapType = 6}
, 
ExpeditionShop = {btnName = "ExpeditionShop", tapType = 7}
}
-- DECOMPILER ERROR at PC101: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.InitShop = function(msg, ...)
  -- function num : 0_0 , upvalues : self, _ENV
  self.ShopData = {}
  for _,v in pairs(msg.shopData) do
    (table.insert)(self.ShopData, v)
  end
  ;
  (table.sort)(self.ShopData, function(a, b, ...)
    -- function num : 0_0_0
    do return a.shopId < b.shopId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if self.isExternalRequest then
    self.isExternalRequest = false
    for i,v in ipairs(self.ExternalType) do
      ((self.ExternalFun)[i])((ShopMgr.isContainShopType)(self.ShopData, v))
    end
    self.ExternalFun = {}
    self.ExternalType = {}
  else
    if #self.ShopData <= 0 then
      local productTips = (ShopMgr.GetProductData)()
      local isProductActivity = (ActivityMgr.GetActivityIsOpen)((ActivityMgr.ActivityType).Product)
      if productTips.productId and isProductActivity == true then
        (ShopMgr.ExternalGotoShop)(ShopType.TuiSongLiBao)
      else
        ;
        (ShopMgr.ExternalGotoShop)(ShopType.GiftBuy)
      end
    else
      do
        ;
        (ShopService.ReqShopGridDataByShopId)(((self.ShopData)[1]).shopId)
      end
    end
  end
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.isContainShopType = function(shops, type, ...)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in ipairs(shops) do
    local BaseShop = ((TableData.gTable).BaseShopData)[v.shopId]
    if tonumber(BaseShop.type) == tonumber(type) then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.GetOpenShopData = function(...)
  -- function num : 0_2 , upvalues : self
  return self.ShopData
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.InitShopGridData = function(msg, ...)
  -- function num : 0_3 , upvalues : _ENV
  local GridData = {}
  for _,v in pairs(msg.shopGridData) do
    (table.insert)(GridData, v)
  end
  ;
  (ShopMgr.InitOpenShop)(msg.shopId, msg.updateTime, msg.resetNum)
  ;
  (table.sort)(GridData, function(a, b, ...)
    -- function num : 0_3_0 , upvalues : _ENV
    local aGrid = ((TableData.gTable).BaseShopGridData)[a.shopGridId]
    local bGrid = ((TableData.gTable).BaseShopGridData)[b.shopGridId]
    do return tonumber(aGrid.sort_index) < tonumber(bGrid.sort_index) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (ShopMgr.ShopGridData)(GridData)
  if not UIMgr:IsWindowOpen((WinResConfig.ShopWindow).name) then
    UIMgr:SetOnShownComplete((WinResConfig.ShopWindow).name, function(...)
    -- function num : 0_3_1 , upvalues : _ENV
    UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_REFRESH)
  end
)
    if (GuideMgr.IsInMainGuide)() then
      OpenWindowByDelayClose((WinResConfig.ShopWindow).name, UILayer.HUD, Const.GuideDelayTime)
    else
      OpenWindow((WinResConfig.ShopWindow).name, UILayer.HUD)
    end
  else
    UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_REFRESH)
  end
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.ExternalGotoShop = function(type, ...)
  -- function num : 0_4 , upvalues : _ENV
  if type == ShopType.Recharge and (FunctionControlMgr.GetFunctionState)(ControlID.Shop_Recharge, true) then
    if UIMgr:IsWindowOpen((WinResConfig.ShopWindow).name) then
      UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_SET_TYPE, ShopType.Recharge)
    else
      OpenWindow((WinResConfig.ShopWindow).name, UILayer.HUD, ShopType.Recharge)
    end
  end
  if type == ShopType.GiftBuy and (FunctionControlMgr.GetFunctionState)(ControlID.Shop_Gift, true) then
    OpenWindow((WinResConfig.ShopWindow).name, UILayer.HUD, ShopType.GiftBuy)
  end
  if type == ShopType.TuiSongLiBao then
    OpenWindow((WinResConfig.ShopWindow).name, UILayer.HUD, ShopType.TuiSongLiBao)
  else
    ;
    (ShopService.OnReqShopGridData)(type)
  end
  ;
  (PayService.ReqPayData)(false)
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.ExternalGetShopState = function(fid, shopType, fun, ...)
  -- function num : 0_5 , upvalues : _ENV, self
  if (FunctionControlMgr.GetFunctionState)(fid, false) == false then
    fun(false)
    return 
  end
  ;
  (table.insert)(self.ExternalFun, fun)
  ;
  (table.insert)(self.ExternalType, shopType)
  if not self.isExternalRequest then
    (ShopService.OnReqShopData)()
    self.isExternalRequest = true
  end
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.InitOpenShop = function(shopId, time, refreshTimes, ...)
  -- function num : 0_6 , upvalues : self, _ENV
  if shopId then
    self.OpenShopId = tonumber(shopId)
    self.OpenShopTime = time
    self.refreshTimes = refreshTimes
  else
    return self.OpenShopId, self.OpenShopTime, self.refreshTimes
  end
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.ShopGridData = function(data, ...)
  -- function num : 0_7 , upvalues : self, _ENV
  if data then
    self.mShopGridData = data
  else
    local mTable = {}
    for _,v in ipairs(self.mShopGridData) do
      if v.shopPoolId ~= 0 then
        (table.insert)(mTable, v)
      end
    end
    return mTable
  end
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.SetShopGridData = function(data, ...)
  -- function num : 0_8 , upvalues : _ENV, self
  for k,v in ipairs(self.mShopGridData) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    if v.shopGridId == data.shopGridId then
      (self.mShopGridData)[k] = data
    end
  end
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.GetRefreshConsumption = function(shopId, times, ...)
  -- function num : 0_9 , upvalues : _ENV
  local buyData = {}
  local shopData = ((TableData.gTable).BaseShopData)[tonumber(shopId)]
  local BuyTimeData = (TableData.gTable).BaseBuyTimeData
  for _,v in pairs(BuyTimeData) do
    if v.type == shopData.buy_type then
      (table.insert)(buyData, v)
    end
  end
  ;
  (table.sort)(buyData, function(a, b, ...)
    -- function num : 0_9_0
    do return a.start < b.start end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,v in ipairs(buyData) do
    if v.start <= times and times <= v.finish then
      return v.cost
    end
  end
  if (buyData[#buyData]).finish == -1 then
    return (buyData[#buyData]).cost
  end
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.GetQualityUpCard = function(propID, ...)
  -- function num : 0_10 , upvalues : _ENV
  propID = tonumber(propID)
  local data, propType = (Util.GetConfigDataByID)(propID)
  if tonumber(propType) ~= PropType.ITEM or tonumber(data.type) ~= PropItemType.UP_STEP_ITEM then
    return {}
  end
  local cardList = (CardData.GetObtainedRankingList)(18)
  local needList = {}
  for _,v in ipairs(cardList) do
    local qualityData = (CardData.GetCardQualityUpConfig)(v.id, v.quality + 1)
    if qualityData then
      local goods = (Util.ParseConfigStr)(qualityData.need_goods)
      for _,v2 in ipairs(goods) do
        if tonumber(v2[2]) == propID then
          local num = (ActorData.GetPropsByID)(propID)
          if num < tonumber(v2[3]) then
            (table.insert)(needList, v.id)
          end
        end
      end
    end
  end
  return needList
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.GetRangeStr = function(orderStr, contentStr, buyTime, ...)
  -- function num : 0_11 , upvalues : _ENV
  local contentTable = (Util.ParseConfigStr)(contentStr)
  if orderStr == "0" then
    return contentTable[1]
  end
  local orderTable = (Util.ParseConfigStr)(orderStr)
  buyTime = buyTime + 1
  for i,v in ipairs(orderTable) do
    if tonumber(v[1]) <= buyTime and buyTime <= tonumber(v[2]) then
      return contentTable[(math.min)(i, #contentTable)]
    end
  end
  return contentTable[#contentTable]
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.SetActivityData = function(data, ...)
  -- function num : 0_12 , upvalues : self
  self.ActivityData = {}
  if not data then
    self.ActivityData = {}
  end
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.SetProductData = function(data, ...)
  -- function num : 0_13 , upvalues : self, _ENV
  self.ProductData = {}
  if not data then
    self.ProductData = {}
    local isOpen = UIMgr:IsWindowOpen((WinResConfig.HomeWindow).name)
    if isOpen then
      UIMgr:SendWindowMessage((WinResConfig.HomeWindow).name, (WindowMsgEnum.HomeWindow).E_MSG_REFRESH_PRODUCT, data.productId)
    end
  end
end

-- DECOMPILER ERROR at PC143: Confused about usage of register: R1 in 'UnsetPending'

ShopMgr.GetGiftCountDown = function(actId, ...)
  -- function num : 0_14 , upvalues : _ENV, self
  for index,value in pairs(self.ActivityData) do
    if value.actId == actId then
      return value.endTime
    end
  end
end

local ShopIdFilter = function(shopDataItem, shopId, ...)
  -- function num : 0_15 , upvalues : _ENV
  do return tonumber(shopDataItem.id) == tonumber(shopId) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local ActivityIdFilter = function(shopDataItem, activityId, ...)
  -- function num : 0_16
  do return shopDataItem.activity_id == activityId end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local ShopTypeFilter = function(shopDataItem, shopType, ...)
  -- function num : 0_17 , upvalues : _ENV
  do return tonumber(shopDataItem.type) == tonumber(shopType) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC149: Confused about usage of register: R4 in 'UnsetPending'

ShopMgr.GetShopDataItem = function(filter, ...)
  -- function num : 0_18 , upvalues : _ENV
  local shopData = (TableData.gTable).BaseShopData
  for _,item in pairs(shopData) do
    if filter and filter(item, ...) then
      return item
    end
  end
end

-- DECOMPILER ERROR at PC152: Confused about usage of register: R4 in 'UnsetPending'

ShopMgr.GetShopDataItemByShopId = function(shopId, ...)
  -- function num : 0_19 , upvalues : _ENV, ShopIdFilter
  return (ShopMgr.GetShopDataItem)(ShopIdFilter, shopId)
end

-- DECOMPILER ERROR at PC155: Confused about usage of register: R4 in 'UnsetPending'

ShopMgr.GetShopDataItemByShopType = function(shopType, ...)
  -- function num : 0_20 , upvalues : _ENV, ShopTypeFilter
  return (ShopMgr.GetShopDataItem)(ShopTypeFilter, shopType)
end

-- DECOMPILER ERROR at PC158: Confused about usage of register: R4 in 'UnsetPending'

ShopMgr.GetShopDataItemByActivityId = function(activityId, ...)
  -- function num : 0_21 , upvalues : _ENV, ActivityIdFilter
  return (ShopMgr.GetShopDataItem)(ActivityIdFilter, activityId)
end

-- DECOMPILER ERROR at PC161: Confused about usage of register: R4 in 'UnsetPending'

ShopMgr.GetShopTypeByShopId = function(shopId, ...)
  -- function num : 0_22 , upvalues : _ENV
  local shopDataItem = (ShopMgr.GetShopDataItemByShopId)(shopId)
  if shopDataItem then
    return tonumber(shopDataItem.type)
  end
  return -1
end

-- DECOMPILER ERROR at PC164: Confused about usage of register: R4 in 'UnsetPending'

ShopMgr.GetShopIdByShopType = function(shopType, ...)
  -- function num : 0_23 , upvalues : _ENV
  local shopDataItem = (ShopMgr.GetShopDataItemByShopType)(shopType)
  if shopDataItem then
    return shopDataItem.id
  end
  return -1
end

-- DECOMPILER ERROR at PC167: Confused about usage of register: R4 in 'UnsetPending'

ShopMgr.GetProductData = function(...)
  -- function num : 0_24 , upvalues : self
  return self.ProductData
end


