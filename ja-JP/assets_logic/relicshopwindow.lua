-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_ChoiceShopByName")
require("Relic_ShopTipsByName")
require("CommonResource_RedDollByName")
local RelicShopWindow = {}
local uis, contentPane, bridge, argTable, resetTime = nil, nil, nil, nil, nil
local shopListData = {}
local resetTime = nil
local isSendMsg = false
RelicShopWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, uis, shopListData, isSendMsg, RelicShopWindow
  bridgeObj:SetView((WinResConfig.RelicShopWindow).package, (WinResConfig.RelicShopWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetRelic_ChoiceShopUis(contentPane)
  if argTable[1] and not (argTable[1]).shopGridData then
    shopListData = {}
    local m = {}
    m.windowName = (WinResConfig.RelicShopWindow).name
    m.Tip = (PUtil.get)(283)
    m.model = uis.AssetStrip
    m.closeToWindow = (WinResConfig.HomeWindow).name
    m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
    ;
    (CommonWinMgr.RegisterAssets)(m)
    isSendMsg = false
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.CommodityList).itemRenderer = RelicShopWindow.RendererList
    ;
    (uis.CommodityList):SetVirtual()
    ;
    (uis.CommodityList):SetBeginAnim(false, "up", 0.05, 0.05, true)
    ;
    (RelicShopWindow.RefreshWindow)()
  end
end

RelicShopWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV, shopListData, uis, argTable, resetTime, isSendMsg
  print("--------------", #shopListData)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CommodityList).numItems = #shopListData
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TimeNameTxt).text = (PUtil.get)(20000364)
  local data = argTable[1]
  if data.updateTime and (data.updateTime).bTime then
    if resetTime then
      resetTime:Stop()
      resetTime = nil
    end
    resetTime = (LuaTime.CountDown)((data.updateTime).bTime * 0.001 - (ActorData.GetServerTime)() * 0.001, uis.TimeTxt, function(...)
    -- function num : 0_1_0 , upvalues : isSendMsg, _ENV
    if not isSendMsg then
      isSendMsg = true
      ;
      (SimpleTimer.setTimeout)(1, function(...)
      -- function num : 0_1_0_0 , upvalues : _ENV
      (ShopService.OnReqShopGridData)(ShopType.RelicShop)
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
end

RelicShopWindow.RendererList = function(index, obj, ...)
  -- function num : 0_2 , upvalues : _ENV, shopListData, RelicShopWindow
  obj = obj:GetChild("ShopTips")
  local model = GetRelic_ShopTipsUis(obj)
  index = index + 1
  local data = shopListData[index]
  if not data or data.shopPoolId == 0 then
    return 
  end
  local GridData = ((TableData.gTable).BaseShopGridData)[data.shopGridId]
  local PoolData = ((TableData.gTable).BaseShopPoolData)[data.shopPoolId]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  local itemData, DataType = (Util.GetConfigDataByID)(configItem[2])
  print("============", itemData, DataType, configItem[2])
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (model.c1Ctr).selectedIndex = itemData.quality
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (model.IconLoader).url = (Util.GetItemUrl)(itemData.icon)
  local PoolDataStr = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, data.useNum)
  local amount = tonumber(PoolDataStr[3])
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.IconNumberTxt).visible = amount > 1
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.IconNumberTxt).text = amount
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.ItemNameTxt).text = itemData.name
  local times = GridData.sell_limit_time - data.useNum
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R12 in 'UnsetPending'

  if tonumber(GridData.reset_type) == 0 then
    ((model.DayBuyNumber).root).visible = true
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((model.DayBuyNumber).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
  else
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R12 in 'UnsetPending'

    if GridData.sell_limit_time > 1 then
      ((model.DayBuyNumber).root).visible = true
      -- DECOMPILER ERROR at PC102: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((model.DayBuyNumber).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
    else
      -- DECOMPILER ERROR at PC106: Confused about usage of register: R12 in 'UnsetPending'

      ((model.DayBuyNumber).root).visible = false
    end
  end
  -- DECOMPILER ERROR at PC114: Confused about usage of register: R12 in 'UnsetPending'

  if (RelicShopWindow.IsInfiniteTime)(GridData.sell_limit_time) then
    ((model.DayBuyNumber).DayBuyNumberTxt).text = "∞"
  end
  local cost = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, data.useNum)
  local contNum = tonumber(cost[3])
  ;
  (Util.SetConsumptionByID)(cost[2], cost[3], model.CostLoader, model.CostTxt, false)
  local needList = (ShopMgr.GetQualityUpCard)(itemData.id)
  -- DECOMPILER ERROR at PC141: Confused about usage of register: R15 in 'UnsetPending'

  if GridData.sell_limit_time <= data.useNum then
    (model.c2Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC144: Confused about usage of register: R15 in 'UnsetPending'

    (model.c2Ctr).selectedIndex = 0
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : data, GridData, _ENV, RelicShopWindow, needList
    if GridData.sell_limit_time <= data.useNum then
      log("已售罄")
      return 
    end
    local buyData = {}
    if (RelicShopWindow.IsInfiniteTime)(GridData.sell_limit_time) then
      buyData.MaxNum = 100
    else
      buyData.MaxNum = GridData.sell_limit_time - data.useNum
    end
    buyData.needCards = needList
    buyData.gridID = data.shopGridId
    buyData.poolID = data.shopPoolId
    buyData.shopType = ShopType.RelicShop
    buyData.buyTime = data.useNum
    OpenWindow((WinResConfig.ShopBuyWindow).name, UILayer.HUD, buyData)
  end
)
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

RelicShopWindow.IsInfiniteTime = function(limit_time, ...)
  -- function num : 0_3
  do return limit_time == -1 or limit_time >= 99999 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

RelicShopWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_4 , upvalues : _ENV, shopListData, RelicShopWindow
  if msgId == (WindowMsgEnum.Relic).E_MSG_SHOP_BUY then
    for k,v in ipairs(shopListData) do
      if v.shopGridId == (para.data).shopGridId then
        shopListData[k] = para.data
      end
    end
    ;
    (RelicShopWindow.RefreshWindow)()
  end
end

RelicShopWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV, contentPane, bridge, argTable
  uis = nil
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.RelicShopWindow).name)
  contentPane = nil
  bridge = nil
  argTable = nil
end

return RelicShopWindow

