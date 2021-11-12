-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_ShopWindowByName")
require("Shop_ShopItemByName")
local ShopWindow = {}
local uis, contentPane, mTime, productCdTime, ShopGridData = nil, nil, nil, nil, nil
local isSendMsg = false
local currentType = -1
local isBackOpen = false
local freeItem = nil
local ShopBtnTab = {}
local tapIndex = 2
local productList = {}
local curProductData = nil
local isSendProductMsg = false
ShopWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, tapIndex, currentType, isBackOpen, ShopWindow, isSendMsg, isSendProductMsg
  bridgeObj:SetView((WinResConfig.ShopWindow).package, (WinResConfig.ShopWindow).comName)
  contentPane = bridgeObj.contentPane
  uis = GetShop_ShopWindowUis(contentPane)
  local mType = nil
  if (bridgeObj.argTable)[1] then
    mType = (bridgeObj.argTable)[1]
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    if mType == ShopType.Recharge then
      ((uis.ShopPanelGrp).BtnList).selectedIndex = 1
      tapIndex = 0
    else
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

      if mType == ShopType.GiftBuy then
        ((uis.ShopPanelGrp).BtnList).selectedIndex = 2
        tapIndex = 1
      else
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

        if mType == ShopType.TuiSongLiBao then
          ((uis.ShopPanelGrp).BtnList).selectedIndex = 3
          tapIndex = 2
        end
      end
    end
    currentType = mType
  end
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

  PayMgr.LimitBuy = false
  isBackOpen = bridgeObj.OpenFromClose
  ;
  (ShopWindow.InitAssetStrip)()
  ;
  (ShopWindow.InitShopBtn)()
  ;
  (ShopWindow.InitFunctionControl)()
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.CommodityList).itemRenderer = ShopWindow.RendererList
  ;
  (uis.CommodityList):SetVirtual()
  ;
  (uis.CommodityList):SetBeginAnim(false, "up", 0.05, 0.05, true)
  isSendMsg = false
  isSendProductMsg = false
  ;
  (ShopWindow.Binding)()
  GuideSetDelayShow(contentPane)
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.TimeNameTxt).text = (PUtil.get)(20000364)
end

ShopWindow.Binding = function(...)
  -- function num : 0_1 , upvalues : _ENV, ShopBtnTab
  local winName = (WinResConfig.ShopWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.Shop_Grocer, ShopBtnTab[ShopBtnNameTab[1]])
  BindingUI(winName, RedDotComID.Shop_Mystical, ShopBtnTab[ShopBtnNameTab[5]])
  BindingUI(winName, RedDotComID.Shop_Token, ShopBtnTab[ShopBtnNameTab[6]])
  BindingUI(winName, RedDotComID.Shop_Expedition, ShopBtnTab[ShopBtnNameTab[7]])
  BindingUI(winName, RedDotComID.Shop_Gift, ShopBtnTab[ShopBtnNameTab[2]])
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

ShopWindow.RendererList = function(index, obj, ...)
  -- function num : 0_2 , upvalues : _ENV, ShopGridData, ShopWindow
  obj = obj:GetChild("ShopItem")
  local model = GetShop_ShopItemUis(obj)
  index = index + 1
  local data = ShopGridData[index]
  if not data or data.shopPoolId == 0 then
    return 
  end
  local GridData = ((TableData.gTable).BaseShopGridData)[data.shopGridId]
  local PoolData = ((TableData.gTable).BaseShopPoolData)[data.shopPoolId]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  local itemData, DataType = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R9 in 'UnsetPending'

  if DataType == PropType.EQUIP then
    (model.c1Ctr).selectedIndex = itemData.intelligence
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (model.EquiptStarList).visible = true
    ;
    (model.EquiptStarList):RemoveChildrenToPool()
    for i = 1, itemData.star do
      (model.EquiptStarList):AddItemFromPool()
    end
  else
    do
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (model.EquiptStarList).visible = false
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (model.c1Ctr).selectedIndex = itemData.quality
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (model.IconLoader).url = (Util.GetItemUrl)(itemData.icon)
      local PoolDataStr = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, data.useNum)
      local amount = tonumber(PoolDataStr[3])
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (model.IconNumberTxt).visible = amount > 1
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (model.IconNumberTxt).text = amount
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (model.ItemNameTxt).text = itemData.name
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((model.NewCompGrp).root).visible = data.corner
      -- DECOMPILER ERROR at PC105: Confused about usage of register: R11 in 'UnsetPending'

      if PoolData.sell_type ~= tostring(10) or PoolData.sell_type == tostring(0) then
        ((model.SaleTipCompGrp).root).visible = false
      else
        -- DECOMPILER ERROR at PC109: Confused about usage of register: R11 in 'UnsetPending'

        ((model.SaleTipCompGrp).root).visible = true
        -- DECOMPILER ERROR at PC117: Confused about usage of register: R11 in 'UnsetPending'

        ;
        ((model.SaleTipCompGrp).SaleTxt).text = (PUtil.get)(20000071, PoolData.sell_type)
      end
      local times = GridData.sell_limit_time - data.useNum
      -- DECOMPILER ERROR at PC131: Confused about usage of register: R12 in 'UnsetPending'

      if GridData.begin_time == "0" then
        if tonumber(GridData.reset_type) == 0 then
          ((model.DayBuy).root).visible = true
          -- DECOMPILER ERROR at PC139: Confused about usage of register: R12 in 'UnsetPending'

          ;
          ((model.DayBuy).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
        else
          -- DECOMPILER ERROR at PC146: Confused about usage of register: R12 in 'UnsetPending'

          if GridData.sell_limit_time > 1 then
            ((model.DayBuy).root).visible = true
            -- DECOMPILER ERROR at PC154: Confused about usage of register: R12 in 'UnsetPending'

            ;
            ((model.DayBuy).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
          else
            -- DECOMPILER ERROR at PC158: Confused about usage of register: R12 in 'UnsetPending'

            ((model.DayBuy).root).visible = false
          end
        end
        -- DECOMPILER ERROR at PC166: Confused about usage of register: R12 in 'UnsetPending'

        if (ShopWindow.IsInfiniteTime)(GridData.sell_limit_time) then
          ((model.DayBuy).DayBuyNumberTxt).text = "∞"
        end
      else
        -- DECOMPILER ERROR at PC170: Confused about usage of register: R12 in 'UnsetPending'

        ((model.DayBuy).root).visible = true
        local str = (LuaTime.GetTimeStrDHM2)((math.floor)(data.endTime * 0.001) - (LuaTime.GetTimeStamp)())
        str = "[color=" .. "#3DFFBD" .. "]" .. str .. "[/color] "
        str = (PUtil.get)(60000661, str)
        -- DECOMPILER ERROR at PC197: Confused about usage of register: R13 in 'UnsetPending'

        ;
        ((model.DayBuy).DayBuyNumberTxt).text = str
      end
      local cost = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, data.useNum)
      local contNum = tonumber(cost[3])
      -- DECOMPILER ERROR at PC210: Confused about usage of register: R14 in 'UnsetPending'

      if contNum <= 0 then
        (model.c3Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC213: Confused about usage of register: R14 in 'UnsetPending'

        (model.c3Ctr).selectedIndex = 0
        ;
        (Util.SetConsumptionByID)(cost[2], cost[3], model.CostLoader, model.CostTxt, false)
      end
      local needList = (ShopMgr.GetQualityUpCard)(itemData.id)
      -- DECOMPILER ERROR at PC231: Confused about usage of register: R15 in 'UnsetPending'

      if GridData.sell_limit_time <= data.useNum then
        (model.c2Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC234: Confused about usage of register: R15 in 'UnsetPending'

        (model.c2Ctr).selectedIndex = 0
      end
      ;
      (obj.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : data, GridData, _ENV, ShopWindow, needList
    if GridData.sell_limit_time <= data.useNum then
      log("已售罄")
      return 
    end
    local buyData = {}
    if (ShopWindow.IsInfiniteTime)(GridData.sell_limit_time) then
      buyData.MaxNum = 500
    else
      buyData.MaxNum = GridData.sell_limit_time - data.useNum
    end
    buyData.needCards = needList
    buyData.gridID = data.shopGridId
    buyData.poolID = data.shopPoolId
    buyData.shopId = (ShopMgr.InitOpenShop)()
    buyData.buyTime = data.useNum
    buyData.reset_type = GridData.reset_type
    buyData.sell_limit_time = GridData.sell_limit_time
    OpenWindow((WinResConfig.ShopBuyWindow).name, UILayer.HUD, buyData)
  end
)
      -- DECOMPILER ERROR at PC240: Confused about usage of register: R15 in 'UnsetPending'

      ;
      (model.RedDollGrp).visible = false
      -- DECOMPILER ERROR at PC252: Confused about usage of register: R15 in 'UnsetPending'

      ;
      ((model.CardUse).root).visible = #needList > 0 and data.useNum < GridData.sell_limit_time
      -- DECOMPILER ERROR: 15 unprocessed JMP targets
    end
  end
end

ShopWindow.IsInfiniteTime = function(limit_time, ...)
  -- function num : 0_3
  do return limit_time == -1 or limit_time >= 99999 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ShopWindow.GetLimitBuyTimes = function(type, ...)
  -- function num : 0_4 , upvalues : _ENV
  local clientNum = 0
  if type == TimeType.EVERYDAY_TIME then
    clientNum = 20000072
  else
    if type == TimeType.EVERY_WEEK_TIME then
      clientNum = 20000073
    else
      if type == TimeType.EVERY_MOON_DAY_TIME then
        clientNum = 20000074
      end
    end
  end
  return (PUtil.get)(clientNum)
end

ShopWindow.RendererBtnList = function(index, obj, ...)
  -- function num : 0_5
  obj = obj:GetChild("ChoiceBtn")
  index = index + 1
end

ShopWindow.InitFunctionControl = function(...)
  -- function num : 0_6 , upvalues : _ENV, ShopBtnTab
  local winName = (WinResConfig.ShopWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  if (PayData.HaveTuiSongLiBao)() == true then
    RegisterGuideAndControl(ControlID.Shop_Recharge, ShopBtnTab[ShopBtnNameTab[1]], winName)
    RegisterGuideAndControl(ControlID.Shop_Gift, ShopBtnTab[ShopBtnNameTab[2]], winName)
    RegisterGuideAndControl(ControlID.Shop_Grocer, ShopBtnTab[ShopBtnNameTab[4]], winName)
    RegisterGuideAndControl(ControlID.Shop_Mystery, ShopBtnTab[ShopBtnNameTab[5]], winName)
    RegisterGuideAndControl(ControlID.Shop_Token, ShopBtnTab[ShopBtnNameTab[6]], winName)
    RegisterGuideAndControl(ControlID.Shop_Expedition, ShopBtnTab[ShopBtnNameTab[7]], winName)
  else
    RegisterGuideAndControl(ControlID.Shop_Recharge, ShopBtnTab[ShopBtnNameTab[1]], winName)
    RegisterGuideAndControl(ControlID.Shop_Gift, ShopBtnTab[ShopBtnNameTab[2]], winName)
    RegisterGuideAndControl(ControlID.Shop_Grocer, ShopBtnTab[ShopBtnNameTab[3]], winName)
    RegisterGuideAndControl(ControlID.Shop_Mystery, ShopBtnTab[ShopBtnNameTab[4]], winName)
    RegisterGuideAndControl(ControlID.Shop_Token, ShopBtnTab[ShopBtnNameTab[5]], winName)
    RegisterGuideAndControl(ControlID.Shop_Expedition, ShopBtnTab[ShopBtnNameTab[6]], winName)
  end
end

ShopWindow.RefreshItemList = function(...)
  -- function num : 0_7 , upvalues : ShopGridData, _ENV, uis
  ShopGridData = (ShopMgr.ShopGridData)()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CommodityList).numItems = #ShopGridData
end

ShopWindow.RefreshWin = function(...)
  -- function num : 0_8 , upvalues : _ENV, currentType, uis, ShopWindow, mTime, isSendMsg
  loge("刷新商店界面")
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  if currentType == ShopType.Recharge then
    (uis.c1Ctr).selectedIndex = 0
    ;
    (ShopWindow.SetTypeShow)(currentType)
    ;
    (ShopWindow.RefreshRechargePanel)()
    ;
    (SuperSDKUtil.SendAdStoreOpened)()
    return 
  else
    if currentType == ShopType.GiftBuy then
      (ShopService.ReqActivityInfoList)()
      return 
    else
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

      if currentType == ShopType.TuiSongLiBao then
        (uis.c1Ctr).selectedIndex = 1
        ;
        (ShopWindow.SetTypeShow)(currentType)
        ;
        (ShopWindow.RefreshProductPanel)()
        return 
      end
    end
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = 2
  ;
  (ShopWindow.SetInputIgnore)()
  local shopId, time, refreshTimes = (ShopMgr.InitOpenShop)()
  local shopType = (ShopMgr.GetShopTypeByShopId)(shopId)
  currentType = shopType
  if shopType == nil or shopType == -1 then
    return 
  end
  if mTime then
    mTime:Stop()
  end
  mTime = (LuaTime.CountDown)(time.bTime * 0.001 - (ActorData.GetServerTime)() * 0.001, uis.TimeTxt, function(...)
    -- function num : 0_8_0 , upvalues : isSendMsg, _ENV, shopId
    if not isSendMsg then
      isSendMsg = true
      ;
      (SimpleTimer.setTimeout)(1, function(...)
      -- function num : 0_8_0_0 , upvalues : _ENV, shopId
      (ShopService.ReqShopGridDataByShopId)(shopId)
    end
)
      ;
      (SimpleTimer.setTimeout)(2, function(...)
      -- function num : 0_8_0_1 , upvalues : isSendMsg
      isSendMsg = false
    end
)
    end
  end
)
  ;
  (ShopWindow.SetTypeShow)(shopType)
  local shopData = (ShopMgr.GetShopDataItemByShopType)(shopType)
  ;
  (ShopWindow.RefreshItemList)()
  local RefreshNumberTxt = (uis.RefreshBtn):GetChild("RefreshNumberTxt")
  local consume = (ShopMgr.GetRefreshConsumption)(shopData.id, refreshTimes + 1)
  -- DECOMPILER ERROR at PC102: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.RefreshBtn).text = (PUtil.get)(20000070)
  ;
  ((uis.RefreshBtn).onClick):Set(function(...)
    -- function num : 0_8_1 , upvalues : consume, _ENV, shopType
    if consume then
      (MessageMgr.OpenCostResConfirmWindow)(60000410, consume, function(...)
      -- function num : 0_8_1_0 , upvalues : _ENV, shopType
      (ShopService.OnReqShopReset)(shopType)
    end
)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000075))
    end
  end
)
  ;
  (ShopWindow.SetRefreshBtnShow)(shopData.reset_type)
  if consume then
    local consumeConfigs = ((Util.ParseConfigStr)(consume))[1]
    local consumeData = (Util.GetConfigDataByID)(consumeConfigs[2])
    ;
    ((uis.RefreshBtn):GetChild("RefreshItemLoader")).url = (Util.GetItemUrl)(consumeData.icon)
    RefreshNumberTxt.text = consumeConfigs[3]
  else
    do
      -- DECOMPILER ERROR at PC135: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (uis.RefreshBtn).visible = false
      ;
      ((uis.RefreshBtn):GetChild("RefreshItemLoader")).url = nil
      RefreshNumberTxt.text = (PUtil.get)(20000113)
    end
  end
end

ShopWindow.ShowGiftBuy = function(...)
  -- function num : 0_9 , upvalues : uis, ShopWindow, currentType, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = 1
  ;
  (ShopWindow.SetTypeShow)(currentType)
  ;
  (ShopWindow.RefreshGiftPanel)()
  ;
  (SuperSDKUtil.SendAdStoreOpened)()
end

ShopWindow.SetRefreshBtnShow = function(type, ...)
  -- function num : 0_10 , upvalues : uis
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  (uis.RefreshBtn).visible = type == 1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ShopWindow.RefreshRechargePanel = function(...)
  -- function num : 0_11 , upvalues : uis, _ENV, ShopWindow
  local diamondGrp = uis.Diamonds
  local chargeList = (PayData.GetChargeListInfo)()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if #chargeList > 0 then
    (diamondGrp.root).visible = true
  else
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (diamondGrp.root).visible = false
  end
  for i,v in ipairs(chargeList) do
    local tipsGrp = diamondGrp["Tips_0" .. i .. "_Grp"]
    if tipsGrp then
      (ShopWindow.RefreshDiamondTips)(tipsGrp, v, i)
    end
  end
end

ShopWindow.RefreshDiamondTips = function(tips, info, index, ...)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if tips and info then
    (tips.root).visible = true
    ;
    ((tips.root).onClick):Set(function(...)
    -- function num : 0_12_0 , upvalues : _ENV, info
    (PayMgr.SendPayCheck)(info.id)
  end
)
    ChangeController(tips.c1Ctr, index - 1)
    if info.totalBuyCount <= 0 then
      ChangeController(tips.c2Ctr, 0)
    else
      ChangeController(tips.c2Ctr, 1)
    end
  end
end

ShopWindow.RefreshGiftPanel = function(...)
  -- function num : 0_13 , upvalues : uis, _ENV, ShopWindow
  local list = uis.GiftList
  local chargeList = (PayData.GetGiftBuyListInfo)()
  list:RemoveChildrenToPool()
  local config = (TableData.gTable).BasePayProductData
  for i,v in ipairs(chargeList) do
    local id = v.id
    if config[id] and (config[id]).icon then
      local gift = list:AddItemFromPool((Util.GetResUrl)((config[id]).icon))
      if gift then
        (ShopWindow.RefreshGift)(gift, v, i)
      end
    end
  end
end

ShopWindow.RefreshProductPanel = function(...)
  -- function num : 0_14 , upvalues : _ENV, uis, curProductData, productList, productCdTime, isSendProductMsg, ShopWindow
  local config = (TableData.gTable).BasePayProductData
  local list = uis.GiftList
  local curProduct = nil
  list:RemoveChildrenToPool()
  if not curProductData then
    productList = (PayData.GetProducListInfo)()
    curProductData = productList[1]
    if not curProductData then
      log("没有推送礼包")
      return 
    end
    local data = config[curProductData.id]
    do
      curProductData.id = data.id
      curProductData.icon = data.icon
      curProductData.keepSec = data.keep_sec
      curProductData.got = false
      curProductData.isTimeout = false
      curProduct = list:AddItemFromPool((Util.GetResUrl)(data.icon))
      if curProduct then
        local TimeTxt = (curProduct:GetChild("GiftTips")):GetChild("WordTxt")
        if productCdTime then
          productCdTime:Stop()
        end
        productCdTime = (LuaTime.CountDown)(curProductData.unlockTime * 0.001 + curProductData.keepSec - (ActorData.GetServerTime)() * 0.001, TimeTxt, function(...)
    -- function num : 0_14_0 , upvalues : isSendProductMsg, TimeTxt, _ENV, curProductData, curProduct
    if isSendProductMsg == false then
      isSendProductMsg = true
      TimeTxt.text = (PUtil.get)(20000663)
      curProductData.isTimeout = true
      ;
      (curProduct.onClick):Set(function(...)
      -- function num : 0_14_0_0 , upvalues : _ENV
      (MessageMgr.SendCenterTips)((PUtil.get)(20000662))
    end
)
    end
  end
)
        ;
        (curProduct.onClick):Set(function(...)
    -- function num : 0_14_1 , upvalues : ShopWindow, data
    (ShopWindow.OnClickProduct)(data.id)
  end
)
      end
    end
  else
    do
      curProduct = list:AddItemFromPool((Util.GetResUrl)(curProductData.icon))
      if productCdTime then
        productCdTime:Stop()
      end
      if curProductData.got == true then
        (curProduct:GetController("c1")).selectedIndex = 1
        ;
        (curProduct.onClick):Set(function(...)
    -- function num : 0_14_2 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(20000662))
  end
)
      else
        local TimeTxt = (curProduct:GetChild("GiftTips")):GetChild("WordTxt")
        if curProductData.isTimeout and curProductData.isTimeout == true then
          TimeTxt.text = (PUtil.get)(20000663)
          ;
          (curProduct.onClick):Set(function(...)
    -- function num : 0_14_3 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(20000662))
  end
)
        else
          productCdTime = (LuaTime.CountDown)(curProductData.unlockTime * 0.001 + curProductData.keepSec - (ActorData.GetServerTime)() * 0.001, TimeTxt, function(...)
    -- function num : 0_14_4 , upvalues : isSendProductMsg, curProductData, TimeTxt, _ENV, curProduct
    if isSendProductMsg == false then
      isSendProductMsg = true
      curProductData.isTimeout = true
      TimeTxt.text = (PUtil.get)(20000663)
      ;
      (curProduct.onClick):Set(function(...)
      -- function num : 0_14_4_0 , upvalues : _ENV
      (MessageMgr.SendCenterTips)((PUtil.get)(20000662))
    end
)
    end
  end
)
          ;
          (curProduct.onClick):Set(function(...)
    -- function num : 0_14_5 , upvalues : ShopWindow, curProductData
    (ShopWindow.OnClickProduct)(curProductData.id)
  end
)
        end
      end
    end
  end
end

ShopWindow.JugeFreeGiftRedDot = function(...)
  -- function num : 0_15 , upvalues : _ENV, freeItem
  local node = RedDotManager:GetNodeByObj((WinResConfig.ShopWindow).name, RedDotComID.FREE_GIFT)
  if freeItem then
    (freeItem:GetChild("RedDot")).visible = node.NodeValue
  end
end

ShopWindow.RefreshGift = function(gift, info, ...)
  -- function num : 0_16 , upvalues : _ENV, freeItem, ShopWindow
  local config = ((TableData.gTable).BasePayProductData)[info.id]
  if gift and info and config then
    local sell_level = split(config.sell_level, ":")
    do
      local lv = (ActorData.GetLevel)()
      local isSatisfy = tonumber(sell_level[1]) <= lv and lv <= tonumber(sell_level[2])
      if isSatisfy then
        ChangeUIController(gift, "Lock", 0)
      else
        ChangeUIController(gift, "Lock", 1)
      end
      local wordTxt = (gift:GetChild("GiftTips")):GetChild("WordTxt")
      do
        local remainTime = (PayData.GetProductRemainTimes)(info.id)
        if config.product_id == "jp.red.free" then
          if freeItem == nil then
            freeItem = gift
          end
          ;
          (ShopWindow.JugeFreeGiftRedDot)()
        end
        if config.type == PayProductType.LittleMonthCard or config.type == PayProductType.BigMonthCard then
          local remainDay = (PayData.GetRemainMonthCardDay)(config.type)
          if remainDay > 0 then
            wordTxt.text = (PUtil.get)(20000325, remainDay)
          else
            wordTxt.text = (PUtil.get)(20000330)
          end
          local canGet = (PayData.GetMonthCardCanGet)(config.type)
          ;
          (gift:GetChild("RedDot")).visible = canGet
        elseif config.sell_limit_type == PayProductLimitType.NoLimit then
          wordTxt.text = (PUtil.get)(20000331)
        elseif config.sell_limit_type == PayProductLimitType.DayLimit then
          if remainTime > 0 then
            ChangeUIController(gift, "c1", 0)
            wordTxt.text = (PUtil.get)(20000332, remainTime)
          else
            ChangeUIController(gift, "c1", 1)
          end
        elseif config.sell_limit_type == PayProductLimitType.WeekLimit then
          if remainTime > 0 then
            ChangeUIController(gift, "c1", 0)
            wordTxt.text = (PUtil.get)(20000333, remainTime)
          else
            ChangeUIController(gift, "c1", 1)
          end
        elseif config.sell_limit_type == PayProductLimitType.MouthLimit then
          if remainTime > 0 then
            ChangeUIController(gift, "c1", 0)
            wordTxt.text = (PUtil.get)(20000334, remainTime)
          else
            ChangeUIController(gift, "c1", 1)
          end
        elseif config.sell_limit_type == PayProductLimitType.ForeverLimit then
          if remainTime > 0 then
            ChangeUIController(gift, "c1", 0)
            wordTxt.text = (PUtil.get)(20000335, remainTime)
          else
            ChangeUIController(gift, "c1", 1)
          end
        end
        do
          if config.type == PayProductType.ActivityGift and config.activity_id ~= nil and config.product_id ~= "jp.red.free" then
            local endTime = (ShopMgr.GetGiftCountDown)(config.activity_id)
            if endTime then
              wordTxt.text = (PUtil.get)(229, (LuaTime.GetLeftTimeStr)((math.floor)(endTime * 0.001), true))
            end
          end
          ;
          (gift.onClick):Set(function(...)
    -- function num : 0_16_0 , upvalues : config, _ENV, remainTime, ShopWindow, info
    if config.sell_limit_type == PayProductLimitType.NoLimit or remainTime > 0 then
      (ShopWindow.OnClickProduct)(info.id)
    end
  end
)
        end
        -- DECOMPILER ERROR: 20 unprocessed JMP targets
      end
    end
  end
end

ShopWindow.OnClickProduct = function(id, ...)
  -- function num : 0_17 , upvalues : _ENV
  local config = ((TableData.gTable).BasePayProductData)[id]
  if not config then
    return 
  end
  if config.type == PayProductType.BigMonthCard or config.type == PayProductType.LittleMonthCard then
    OpenWindow((WinResConfig.ShopMonthCardWindow).name, UILayer.HUD1, id)
  else
    if config.type == PayProductType.RechargeGift or config.type == PayProductType.ActivityGift then
      OpenWindow((WinResConfig.ShopGiftWindow).name, UILayer.HUD1, id)
    else
      if config.type == PayProductType.Product then
        OpenWindow((WinResConfig.ShopGiftWindow).name, UILayer.HUD1, id)
      else
        ;
        (PayMgr.SendPayCheck)(id)
      end
    end
  end
end

ShopWindow.InitShopBtn = function(...)
  -- function num : 0_18 , upvalues : uis, _ENV, ShopBtnTab, ShopWindow, tapIndex
  local list = (uis.ShopPanelGrp).BtnList
  local shopBtnTNameTab = {}
  local shopBtnTxtTab = {}
  ;
  (Util.CopyOne)(shopBtnTNameTab, ShopBtnNameTab)
  ;
  (Util.CopyOne)(shopBtnTxtTab, ShopBtnTxtTab)
  list:RemoveChildrenToPool()
  if (PayData.HaveTuiSongLiBao)() == false then
    (table.remove)(shopBtnTNameTab, 3)
    ;
    (table.remove)(shopBtnTxtTab, 3)
  end
  for i = 1, #shopBtnTNameTab do
    do
      local btn = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.ShopWindow).package, "ChoiceBtn"))
      if i == #shopBtnTNameTab then
        (btn:GetChild("DecorateImage")).visible = false
      end
      ;
      (btn:GetChild("NameTxt")).text = shopBtnTxtTab[i]
      btn.name = shopBtnTNameTab[i]
      ShopBtnTab[btn.name] = btn
      ;
      (btn.onClick):Set(function(...)
    -- function num : 0_18_0 , upvalues : i, ShopWindow, _ENV, btn
    local index = i - 1
    ;
    (ShopWindow.OnClickShopType)(ShopType[btn.name], index)
  end
)
    end
  end
  ;
  (((uis.Diamonds).Diamonds_A_Btn):GetChild("WordTxt")).text = (PUtil.get)(20000366)
  ;
  (((uis.Diamonds).Diamonds_B_Btn):GetChild("WordTxt")).text = (PUtil.get)(20000367)
  ;
  (((uis.Diamonds).Diamonds_A_Btn).onClick):Set(function(...)
    -- function num : 0_18_1 , upvalues : _ENV
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, (PUtil.get)(89102003), (PUtil.get)(20000366))
  end
)
  ;
  (((uis.Diamonds).Diamonds_B_Btn).onClick):Set(function(...)
    -- function num : 0_18_2 , upvalues : _ENV
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, (PUtil.get)(89102001), (PUtil.get)(20000367))
  end
)
  list.selectedIndex = tapIndex
end

ShopWindow.OnClickShopType = function(type, index, ...)
  -- function num : 0_19 , upvalues : currentType, uis, ShopWindow, _ENV
  if type == currentType then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.ShopPanelGrp).BtnList).selectedIndex = index
  ;
  (ShopWindow.SetTypeShow)(type)
  if type == ShopType.Recharge then
    currentType = ShopType.Recharge
    ;
    (PayService.ReqPayData)(false)
  else
    if type == ShopType.GiftBuy then
      currentType = ShopType.GiftBuy
      ;
      (PayService.ReqPayData)(false)
    else
      if type == ShopType.TuiSongLiBao then
        currentType = ShopType.TuiSongLiBao
        ;
        (PayService.ReqPayData)(false)
      else
        currentType = -1
        ;
        (ShopService.OnReqShopGridData)(type)
      end
    end
  end
end

ShopWindow.SetInputIgnore = function(...)
  -- function num : 0_20 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  (GRoot.inst).touchable = false
  ;
  (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_20_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = true
  end
)
end

ShopWindow.SetTypeShow = function(shopType, ...)
  -- function num : 0_21 , upvalues : _ENV, ShopWindow
  if shopType == ShopType.Grocer then
    local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
    ;
    (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
  else
    do
      if shopType == ShopType.MysteryShop then
        local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
        ;
        (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
      else
        do
          if shopType == ShopType.TokenShop then
            local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
            ;
            (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
          else
            do
              if shopType == ShopType.ExpeditionShop then
                local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.EXPEDITION_TOKEN}
                ;
                (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
              else
                do
                  if shopType == ShopType.Recharge then
                    local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
                    ;
                    (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
                  else
                    do
                      if shopType == ShopType.GiftBuy then
                        local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
                        ;
                        (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
                      else
                        do
                          do
                            if shopType == ShopType.TuiSongLiBao then
                              local moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
                              ;
                              (CommonWinMgr.ChangeAssetsType)((WinResConfig.ShopWindow).name, moneyTypes)
                            end
                            ;
                            (ShopWindow.SetShopTapIndex)(shopType)
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

ShopWindow.SetShopTapIndex = function(type, ...)
  -- function num : 0_22 , upvalues : _ENV, uis
  local tapIndex = nil
  if type == ShopType.Recharge then
    tapIndex = 0
  else
    if type == ShopType.GiftBuy then
      tapIndex = 1
    end
  end
  if (PayData.HaveTuiSongLiBao)() == true then
    if type == ShopType.TuiSongLiBao then
      tapIndex = 2
    else
      if type == ShopType.Grocer then
        tapIndex = 3
      else
        if type == ShopType.MysteryShop then
          tapIndex = 4
        else
          if type == ShopType.TokenShop then
            tapIndex = 5
          else
            if type == ShopType.ExpeditionShop then
              tapIndex = 6
            end
          end
        end
      end
    end
  else
    if type == ShopType.Grocer then
      tapIndex = 2
    else
      if type == ShopType.MysteryShop then
        tapIndex = 3
      else
        if type == ShopType.TokenShop then
          tapIndex = 4
        else
          if type == ShopType.ExpeditionShop then
            tapIndex = 5
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.ShopPanelGrp).BtnList).selectedIndex = tapIndex
end

ShopWindow.CheckProductState = function(para, ...)
  -- function num : 0_23 , upvalues : curProductData
  if not curProductData then
    return 
  end
  if para and para.productId and para.productId == curProductData.productId then
    curProductData.got = true
  end
end

ShopWindow.OnShown = function(...)
  -- function num : 0_24 , upvalues : isBackOpen, ShopWindow, _ENV
  if isBackOpen then
    (ShopWindow.RefreshWin)()
  end
  ;
  (ShopMgr.SetProductData)({})
end

ShopWindow.OnHide = function(...)
  -- function num : 0_25 , upvalues : mTime, productCdTime
  if mTime then
    mTime:Stop()
  end
  if productCdTime then
    productCdTime:Stop()
  end
end

ShopWindow.InitAssetStrip = function(...)
  -- function num : 0_26 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ShopWindow).name
  m.Tip = (PUtil.get)(20000069)
  m.model = uis.AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ShopWindow.OnClose = function(...)
  -- function num : 0_27 , upvalues : _ENV, ShopGridData, uis, freeItem, contentPane, currentType, ShopBtnTab, productList, curProductData
  (GuideData.AbolishControlRefer)((WinResConfig.ShopWindow).name)
  ;
  (RedDotMgr.RemoveUIRefer)((WinResConfig.ShopWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ShopWindow).name)
  ShopGridData = nil
  uis = nil
  freeItem = nil
  contentPane = nil
  currentType = -1
  ShopBtnTab = {}
  productList = {}
  curProductData = nil
end

ShopWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_28 , upvalues : _ENV, ShopWindow, uis, ShopGridData, currentType
  if msgId == (WindowMsgEnum.ShopWindow).E_MSG_CLEAR_CHECKPRODUCTSTATE then
    (ShopWindow.CheckProductState)(para)
  else
    if msgId == (WindowMsgEnum.ShopWindow).E_MSG_REFRESH then
      (ShopWindow.RefreshWin)()
    else
      if msgId == (WindowMsgEnum.ShopWindow).E_MSG_REFRESH_ITEM then
        (uis.CommodityList):SetAnimIsPlay(false)
        ;
        (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_28_0 , upvalues : uis
    (uis.CommodityList):SetAnimIsPlay(true)
  end
)
        ;
        (ShopWindow.RefreshItemList)()
        if not (ShopService.CheckIsContainFreeItem)(ShopGridData) then
          (RedDotService.ReqRemoveRedDot)((WinResConfig.ShopWindow).name, RedDotComID.Shop_Main, 23000000 + currentType)
        end
      else
        if msgId == (WindowMsgEnum.ShopWindow).E_MSG_SET_TYPE then
          currentType = para
          ;
          (ShopWindow.RefreshWin)()
        else
          if msgId == (WindowMsgEnum.ShopWindow).E_MSG_GET_ACTIVITYINFO then
            (ShopWindow.ShowGiftBuy)()
          else
            if msgId == (WindowMsgEnum.ShopWindow).E_MSG_CLEAR_FREEGIFTREDDOT then
              (ShopWindow.JugeFreeGiftRedDot)()
            end
          end
        end
      end
    end
  end
  if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
    (ShopWindow.RefreshWin)()
  end
end

return ShopWindow

