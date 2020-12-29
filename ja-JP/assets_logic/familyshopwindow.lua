-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_FamilyShopByName")
require("Family_ShopItemByName")
require("Family_ShopItemListByName")
local FamilyShopWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local resetTime = nil
local isSendMsg = false
local ShopType = {Family_NormalShop = 6, Family_SeedShop = 7, Family_SecretShop = 8}
local shopType, initType, tmpShopGridData, create = nil, nil, nil, nil
FamilyShopWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, initType, ShopType, isSendMsg, tmpShopGridData, shopType, FamilyShopWindow
  bridgeObj:SetView((WinResConfig.FamilyShopWindow).package, (WinResConfig.FamilyShopWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetFamily_FamilyShopUis(contentPane)
  local m = {}
  m.windowName = (WinResConfig.FamilyShopWindow).name
  m.Tip = (PUtil.get)(244)
  m.model = uis.AssetStripGrp
  m.CloseBtnFun = function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
  end

  m.BackBtnFun = function(...)
    -- function num : 0_0_1 , upvalues : initType, ShopType, _ENV
    if initType == ShopType.Family_NormalShop then
      UIMgr:CloseWindow((WinResConfig.FamilyShopWindow).name)
    else
      if initType == ShopType.Family_SeedShop then
        (HomelandService.ReqInFamily)(function(...)
      -- function num : 0_0_1_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.FamilyShopWindow).name)
    end
)
      else
        UIMgr:CloseWindow((WinResConfig.FamilyShopWindow).name)
      end
    end
  end

  m.isSelfClose = true
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.FAMILY_SHOP_COIN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  isSendMsg = false
  tmpShopGridData = nil
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.TimeNameTxt).text = (PUtil.get)(248)
  ;
  ((uis.RefreshBtn).onClick):Set(function(...)
    -- function num : 0_0_2
  end
)
  ;
  (((uis.ShopPanel).ShenMiBtn).onClick):Set(function(...)
    -- function num : 0_0_3 , upvalues : shopType, ShopType, _ENV
    if shopType == ShopType.Family_NormalShop then
      return 
    end
    shopType = ShopType.Family_NormalShop
    ;
    (HomelandService.ReqShopGridDataByType)(shopType)
  end
)
  ;
  (((uis.ShopPanel).ShenMiBtn):GetChild("NameTxt")).text = (PUtil.get)(245)
  ;
  (((uis.ShopPanel).JiaJuBtn).onClick):Set(function(...)
    -- function num : 0_0_4 , upvalues : shopType, ShopType, _ENV
    if shopType == ShopType.Family_SeedShop then
      return 
    end
    shopType = ShopType.Family_SeedShop
    ;
    (HomelandService.ReqShopGridDataByType)(shopType)
  end
)
  ;
  (((uis.ShopPanel).JiaJuBtn):GetChild("NameTxt")).text = (PUtil.get)(246)
  ;
  (((uis.ShopPanel).ZhongZiBtn).onClick):Set(function(...)
    -- function num : 0_0_5 , upvalues : shopType, ShopType, _ENV
    if shopType == ShopType.Family_SecretShop then
      return 
    end
    shopType = ShopType.Family_SecretShop
    ;
    (HomelandService.ReqShopGridDataByType)(shopType)
  end
)
  ;
  (((uis.ShopPanel).ZhongZiBtn):GetChild("NameTxt")).text = (PUtil.get)(247)
  -- DECOMPILER ERROR at PC113: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.ShopPanel).ZhongZiBtn).visible = false
  if argTable[1] then
    shopType = (argTable[1]).shopType
    initType = (argTable[1]).shopType
    print("===================shopType", shopType)
    ;
    (FamilyShopWindow.RefreshShopWindow)(argTable[1])
    -- DECOMPILER ERROR at PC134: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.ShopPanel).c1Ctr).selectedIndex = shopType - 6
  end
end

FamilyShopWindow.RefreshShopWindow = function(_data, ...)
  -- function num : 0_1 , upvalues : tmpShopGridData, _ENV, uis, resetTime, isSendMsg, create, FamilyShopWindow
  if _data then
    tmpShopGridData = _data
  else
    if tmpShopGridData == nil then
      return 
    end
  end
  local data = tmpShopGridData
  print("商店类型", data.shopType, data.resetNum, #data.shopGridData)
  local shopConfig = ((TableData.gTable).BaseShopData)[23000000 + data.shopType]
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.RefreshBtn).visible = shopConfig.reset_type == 1
  if data.updateTime and (data.updateTime).bTime then
    if resetTime then
      resetTime:Stop()
      resetTime = nil
    end
    resetTime = (LuaTime.CountDown)((data.updateTime).bTime * 0.001 - (ActorData.GetServerTime)() * 0.001, uis.TimeTxt, function(...)
    -- function num : 0_1_0 , upvalues : isSendMsg, _ENV, data
    if not isSendMsg then
      isSendMsg = true
      ;
      (SimpleTimer.setTimeout)(1, function(...)
      -- function num : 0_1_0_0 , upvalues : _ENV, data
      (HomelandService.ReqShopGridDataByType)(data.shopType)
    end
)
      ;
      (SimpleTimer.setTimeout)(2, function(...)
      -- function num : 0_1_0_1 , upvalues : isSendMsg
      isSendMsg = false
    end
)
    end
  end
)
  end
  if create then
    create:stop()
    create = nil
  end
  ;
  (uis.CommodityList):RemoveChildrenToPool()
  local shopNum = #data.shopGridData
  local shopGrpNum = (math.ceil)(shopNum / 5)
  local t = 1
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (GRoot.inst).touchable = false
  ;
  (SimpleTimer.setTimeout)(0.06 * shopGrpNum, function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = true
  end
)
  create = (SimpleTimer.setInterval)(0.05, shopGrpNum, function(...)
    -- function num : 0_1_2 , upvalues : uis, _ENV, t, shopNum, data, FamilyShopWindow
    local shopGrpItem = (uis.CommodityList):AddItemFromPool()
    for j = 1, 5 do
      local shopItem = shopGrpItem:GetChild("Item_0" .. tostring(j))
      shopItem.visible = false
    end
    for j = 1, 5 do
      local shopIndex = (t - 1) * 5 + j
      if shopNum < shopIndex then
        return 
      end
      local shopData = (data.shopGridData)[shopIndex]
      local shopItem = shopGrpItem:GetChild("Item_0" .. tostring(j))
      shopItem.visible = true
      ;
      (FamilyShopWindow.SetShopItem)(shopData, shopItem)
    end
    t = t + 1
  end
)
  for i = 1, shopGrpNum do
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

FamilyShopWindow.SetShopItem = function(shopData, shopItem, ...)
  -- function num : 0_2 , upvalues : _ENV, shopType, ShopType, FamilyShopWindow
  local model = GetFamily_ShopItemUis(shopItem)
  print("-------------shopType", shopType)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  if shopType == ShopType.Family_NormalShop then
    (model.c3Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

    if shopType == ShopType.Family_SecretShop then
      (model.c3Ctr).selectedIndex = 0
    else
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

      if shopType == ShopType.Family_SeedShop then
        (model.c3Ctr).selectedIndex = 2
      end
    end
  end
  local data = shopData
  if not data or data.shopPoolId == 0 then
    return 
  end
  local GridData = ((TableData.gTable).BaseShopGridData)[data.shopGridId]
  local PoolData = ((TableData.gTable).BaseShopPoolData)[data.shopPoolId]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  local itemData, DataType = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (model.IconLoader).url = (Util.GetItemUrl)(itemData.icon)
  local PoolDataStr = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, data.useNum)
  local amount = tonumber(PoolDataStr[3])
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.IconNumberTxt).visible = amount > 1
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.IconNumberTxt).text = amount
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.ItemNameTxt).text = itemData.name
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R11 in 'UnsetPending'

  ;
  ((model.NewCompGrp).root).visible = data.corner
  local times = GridData.sell_limit_time - data.useNum
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R12 in 'UnsetPending'

  if tonumber(GridData.reset_type) == 0 then
    ((model.DayBuy).root).visible = true
    -- DECOMPILER ERROR at PC101: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((model.DayBuy).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
  else
    -- DECOMPILER ERROR at PC108: Confused about usage of register: R12 in 'UnsetPending'

    if GridData.sell_limit_time > 1 then
      ((model.DayBuy).root).visible = true
      -- DECOMPILER ERROR at PC116: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((model.DayBuy).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
    else
      -- DECOMPILER ERROR at PC120: Confused about usage of register: R12 in 'UnsetPending'

      ((model.DayBuy).root).visible = false
    end
  end
  -- DECOMPILER ERROR at PC128: Confused about usage of register: R12 in 'UnsetPending'

  if (FamilyShopWindow.IsInfiniteTime)(GridData.sell_limit_time) then
    ((model.DayBuy).DayBuyNumberTxt).text = "∞"
  end
  local cost = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, data.useNum)
  local contNum = tonumber(cost[3])
  -- DECOMPILER ERROR at PC141: Confused about usage of register: R14 in 'UnsetPending'

  if contNum <= 0 then
    (model.c3Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC144: Confused about usage of register: R14 in 'UnsetPending'

    (model.c3Ctr).selectedIndex = 0
    ;
    (Util.SetConsumptionByID)(cost[2], cost[3], model.CostLoader, model.CostTxt, false)
  end
  local needList = (ShopMgr.GetQualityUpCard)(itemData.id)
  -- DECOMPILER ERROR at PC162: Confused about usage of register: R15 in 'UnsetPending'

  if GridData.sell_limit_time <= data.useNum then
    (model.c2Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC165: Confused about usage of register: R15 in 'UnsetPending'

    (model.c2Ctr).selectedIndex = 0
  end
  ;
  (shopItem.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : data, GridData, _ENV, FamilyShopWindow, needList, shopType
    if GridData.sell_limit_time <= data.useNum then
      log("已售罄")
      return 
    end
    local buyData = {}
    if (FamilyShopWindow.IsInfiniteTime)(GridData.sell_limit_time) then
      buyData.MaxNum = 100
    else
      buyData.MaxNum = GridData.sell_limit_time - data.useNum
    end
    buyData.needCards = needList
    buyData.gridID = data.shopGridId
    buyData.poolID = data.shopPoolId
    buyData.shopType = shopType
    buyData.buyTime = data.useNum
    OpenWindow((WinResConfig.ShopBuyWindow).name, UILayer.HUD, buyData)
  end
)
  -- DECOMPILER ERROR at PC171: Confused about usage of register: R15 in 'UnsetPending'

  ;
  (model.RedDollGrp).visible = false
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

FamilyShopWindow.IsInfiniteTime = function(limit_time, ...)
  -- function num : 0_3
  do return limit_time == -1 or limit_time >= 99999 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FamilyShopWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : uis, contentPane, argTable, resetTime, create, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  if resetTime then
    resetTime:Stop()
    resetTime = nil
  end
  if create then
    create:stop()
    create = nil
  end
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.FamilyShopWindow).name)
end

FamilyShopWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5 , upvalues : _ENV, FamilyShopWindow, tmpShopGridData
  local windowMsgEnum = WindowMsgEnum.Family
  if msgId == windowMsgEnum.E_MSG_FARMSHOP_SHOPGRIP_RES then
    (FamilyShopWindow.RefreshShopWindow)(para.data)
  else
    if msgId == windowMsgEnum.E_MSG_FARMSHOP_BUY_RES then
      print("--------E_MSG_FARMSHOP_BUY_RES", (para.data).success, (para.data).shopGridData, #(para.data).shopGridData)
      for k,v in ipairs(tmpShopGridData) do
        if v.shopGridId == ((para.data).shopGridData).shopGridId then
          tmpShopGridData[k] = (para.data).shopGridData
        end
      end
    end
  end
end

return FamilyShopWindow

