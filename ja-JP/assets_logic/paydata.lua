-- params : ...
-- function num : 0 , upvalues : _ENV
PayData = {savePayData = nil}
-- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

PayData.ClearData = function(...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  PayData.savePayData = nil
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

PayData.SavePayData = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  PrintTable(msg, "充值初始化返回数据：")
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  PayData.savePayData = msg
  for i,v in ipairs((PayData.savePayData).productList) do
    print("礼包活动id   ", v.productId)
  end
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetPayData = function(...)
  -- function num : 0_2 , upvalues : _ENV
  return PayData.savePayData
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductInfo = function(productId, ...)
  -- function num : 0_3 , upvalues : _ENV
  if PayData.savePayData and (PayData.savePayData).productList then
    for i,v in ipairs((PayData.savePayData).productList) do
      if v.productId == productId then
        return (Util.Copy)(v)
      end
    end
  end
  do
    return 
  end
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetPayCardInfo = function(productId, ...)
  -- function num : 0_4 , upvalues : _ENV
  if PayData.savePayData and (PayData.savePayData).payCardList then
    for _,v in ipairs((PayData.savePayData).payCardList) do
      if v.productId == productId and (v.cardSurplus > 0 or v.cardCanBuy == true) then
        return (Util.Copy)(v)
      end
    end
  end
  do
    return 
  end
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetChargeListInfo = function(...)
  -- function num : 0_5 , upvalues : _ENV
  local list = {}
  local config = (TableData.gTable).BasePayProductData
  local platform = "ANDROID"
  if Application.platform == RuntimePlatform.Android then
    platform = "ANDROID"
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      platform = "IOS"
    end
  end
  for i,v in pairs(config) do
    if v.platform == platform and v.type == PayProductType.RechargeDiamond then
      local info = (PayData.GetProductInfo)(v.product_id)
      if info then
        info.id = v.id
        info.sort = v.sort
        ;
        (table.insert)(list, info)
      end
    end
  end
  ;
  (table.sort)(list, function(a, b, ...)
    -- function num : 0_5_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetGiftBuyListInfo = function(...)
  -- function num : 0_6 , upvalues : _ENV
  local list = {}
  local config = (TableData.gTable).BasePayProductData
  local platform = "ANDROID"
  if Application.platform == RuntimePlatform.Android then
    platform = "ANDROID"
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      platform = "IOS"
    end
  end
  for _,v in pairs(config) do
    if v.platform == platform then
      local info = nil
      if (v.type == PayProductType.LittleMonthCard or v.type == PayProductType.ActivityGift or v.type == PayProductType.BigMonthCard or v.type == PayProductType.RechargeGift) and v.tap_type == (ShopBtnTab.GiftBuy).tapType then
        info = (PayData.GetProductInfo)(v.product_id)
      else
        if v.type == PayProductType.WeekCard then
          info = (PayData.GetPayCardInfo)(v.product_id)
        end
      end
      if info then
        info.id = v.id
        info.sort = v.sort
        ;
        (table.insert)(list, info)
      end
    end
  end
  ;
  (table.sort)(list, function(a, b, ...)
    -- function num : 0_6_0 , upvalues : _ENV
    local aRe = (PayData.GetProductSortWeight)(a.id)
    local bRe = (PayData.GetProductSortWeight)(b.id)
    do return a.sort + aRe < b.sort + bRe end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProducListInfo = function(...)
  -- function num : 0_7 , upvalues : _ENV
  local list = {}
  local config = (TableData.gTable).BasePayProductData
  local platform = "ANDROID"
  if Application.platform == RuntimePlatform.Android then
    platform = "ANDROID"
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      platform = "IOS"
    end
  end
  for _,v in pairs(config) do
    if v.platform == platform and v.tap_type == (ShopBtnTab.TuiSongLiBao).tapType then
      local info = (PayData.GetProductInfo)(v.product_id)
      if info and info.unlockTime > 0 then
        info.id = v.id
        info.sort = v.sort
        ;
        (table.insert)(list, info)
      end
    end
  end
  ;
  (table.sort)(list, function(a, b, ...)
    -- function num : 0_7_0 , upvalues : _ENV
    local aRe = (PayData.GetProductSortWeight)(a.id)
    local bRe = (PayData.GetProductSortWeight)(b.id)
    do return a.sort + aRe < b.sort + bRe end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

PayData.HaveTuiSongLiBao = function(...)
  -- function num : 0_8 , upvalues : _ENV
  local productList = (PayData.GetProducListInfo)()
  if #productList > 0 then
    return true
  end
  return false
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetCurTuiSongLiBao = function(...)
  -- function num : 0_9 , upvalues : _ENV
  local isProductActivity = (ActivityMgr.GetActivityIsOpen)((ActivityMgr.ActivityType).TuiSongProduct)
  if isProductActivity == false then
    return 
  end
  local productList = (PayData.GetProducListInfo)()
  local config = (TableData.gTable).BasePayProductData
  for _,v in pairs(productList) do
    if (config[v.id]).type == (ShopBtnTab.TuiSongLiBao).type and (config[v.id]).tap_type == (ShopBtnTab.TuiSongLiBao).tapType then
      local data = config[v.id]
      local curTuiSongProductData = v
      curTuiSongProductData.id = data.id
      curTuiSongProductData.icon = data.icon
      curTuiSongProductData.keepSec = data.keep_sec
      curTuiSongProductData.got = false
      curTuiSongProductData.isTimeout = false
      return curTuiSongProductData
    end
  end
  return nil
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductSortWeight = function(id, ...)
  -- function num : 0_10 , upvalues : _ENV
  local config = ((TableData.gTable).BasePayProductData)[id]
  if config.type == PayProductType.BigMonthCard or config.type == PayProductType.LittleMonthCard or config.type == PayProductType.WeekCard then
    return 0
  else
    local Re = (PayData.GetProductRemainTimes)(id)
    if Re <= 0 then
      return 10000
    else
      return 0
    end
  end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductConfig = function(productId, ...)
  -- function num : 0_11 , upvalues : _ENV
  local config = (TableData.gTable).BasePayProductData
  local platform = "ANDROID"
  if Application.platform == RuntimePlatform.Android then
    platform = "ANDROID"
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      platform = "IOS"
    end
  end
  for i,v in pairs(config) do
    if v.product_id == productId and v.platform == platform then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetPayCheckParam = function(...)
  -- function num : 0_12 , upvalues : _ENV
  local platform = "ANDROID"
  if Application.platform == RuntimePlatform.Android then
    platform = "ANDROID"
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      platform = "IOS"
    end
  end
  return platform
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetRemainMonthCardDay = function(type, ...)
  -- function num : 0_13 , upvalues : _ENV
  local cardData = (PayData.GetCardDataByType)(type)
  if cardData then
    return cardData.cardSurplus
  else
    return 0
  end
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetMonthCardCanGet = function(type, ...)
  -- function num : 0_14 , upvalues : _ENV
  local day = (PayData.GetRemainMonthCardDay)(type)
  if day > 0 then
    local get = (PayData.GetMonthCardIsGet)(type)
    return not get
  else
    do
      do return false end
    end
  end
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetMonthCardIsGet = function(type, ...)
  -- function num : 0_15 , upvalues : _ENV
  local cardData = (PayData.GetCardDataByType)(type)
  if cardData then
    return cardData.cardReceive
  else
    log("没有" .. type .. "类型的充值卡信息")
  end
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductDataByType = function(type, ...)
  -- function num : 0_16 , upvalues : _ENV
  local config = (TableData.gTable).BasePayProductData
  local platform = (PayData.GetPayCheckParam)()
  for _,v in pairs(config) do
    if v.platform == platform and v.type == type then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductTimes = function(config, Limit_type, ...)
  -- function num : 0_17 , upvalues : _ENV
  local list = nil
  local productList = (PayData.savePayData).productList
  local payCardList = (PayData.savePayData).payCardList
  if config.type == PayProductType.WeekCard then
    list = payCardList
  else
    list = productList
  end
  for _,v in ipairs(list) do
    if v.productId == config.product_id then
      if Limit_type == PayProductLimitType.NoLimit or Limit_type == PayProductLimitType.ForeverLimit then
        return v.totalBuyCount
      else
        if Limit_type == PayProductLimitType.DayLimit then
          return v.todayBuyCount
        else
          if Limit_type == PayProductLimitType.WeekLimit then
            return v.weekBuyCount
          else
            if Limit_type == PayProductLimitType.MouthLimit then
              return v.monthBuyCount
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetCardDataByType = function(type, ...)
  -- function num : 0_18 , upvalues : _ENV
  local config = (TableData.gTable).BasePayProductData
  for _,v in pairs(config) do
    if v.type == type then
      for i = 1, #(PayData.savePayData).payCardList do
        if v.product_id == (((PayData.savePayData).payCardList)[i]).productId then
          local cardData = ((PayData.savePayData).payCardList)[i]
          return cardData
        end
      end
    end
  end
  return nil
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductRemainTimes = function(id, ...)
  -- function num : 0_19 , upvalues : _ENV
  local config = ((TableData.gTable).BasePayProductData)[id]
  local buyTime = (PayData.GetProductTimes)(config, config.sell_limit_type)
  local limitTime = config.sell_limit_max
  if limitTime and config.sell_limit_type ~= PayProductLimitType.NoLimit then
    return limitTime - buyTime
  else
    return 9999
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R0 in 'UnsetPending'

PayData.GetProductRemainTimesByProductId = function(id, ...)
  -- function num : 0_20 , upvalues : _ENV
  local config = nil
  local allConfig = (TableData.gTable).BasePayProductData
  for i,v in pairs(allConfig) do
    if v.product_id == tostring(id) then
      config = v
    end
  end
  local buyTime = (PayData.GetProductTimes)(config, config.sell_limit_type)
  local limitTime = config.sell_limit_max
  if limitTime and config.sell_limit_type ~= PayProductLimitType.NoLimit then
    return limitTime - buyTime
  else
    return 9999
  end
end


