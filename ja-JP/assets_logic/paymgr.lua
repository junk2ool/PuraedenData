-- params : ...
-- function num : 0 , upvalues : _ENV
PayMgr = {}
PayProductType = {RechargeDiamond = 1, LittleMonthCard = 2, BigMonthCard = 3, RechargeGift = 4, ActivityGift = 5, Product = 6}
PayProductLimitType = {NoLimit = 0, DayLimit = 1, WeekLimit = 2, MouthLimit = 3, ForeverLimit = 4}
PayProductTapType = {Recharge = 1, GiftBuy = 2, TuiSongLiBao = 3, Grocer = 4, MysteryShop = 5, TokenShop = 6, ExpeditionShop = 7}
ShopBtnTxtTab = {(PUtil.get)(20000314), (PUtil.get)(20000315), (PUtil.get)(20000661), (PUtil.get)(20000065), (PUtil.get)(20000066), (PUtil.get)(20000067), (PUtil.get)(20000068)}
ShopBtnNameTab = {"Recharge", "GiftBuy", "TuiSongLiBao", "Grocer", "MysteryShop", "TokenShop", "ExpeditionShop"}
-- DECOMPILER ERROR at PC68: Confused about usage of register: R0 in 'UnsetPending'

PayMgr.LimitBuy = false
-- DECOMPILER ERROR at PC70: Confused about usage of register: R0 in 'UnsetPending'

PayMgr.RecodeProductID = 0
-- DECOMPILER ERROR at PC72: Confused about usage of register: R0 in 'UnsetPending'

PayMgr.LimitProductID = 0
-- DECOMPILER ERROR at PC74: Confused about usage of register: R0 in 'UnsetPending'

PayMgr.RecodeTimes = 0
-- DECOMPILER ERROR at PC77: Confused about usage of register: R0 in 'UnsetPending'

PayMgr.SendPayCheck = function(configId, ...)
  -- function num : 0_0 , upvalues : _ENV
  local config = ((TableData.gTable).BasePayProductData)[configId]
  if config then
    if Game.useSDK == false then
      (LoginService.OnReqSendChar)("gm,payTest," .. config.product_id .. "," .. (string.format)("%.01f", config.price) .. "," .. (PayData.GetPayCheckParam)())
    else
      ;
      (SuperSDKUtil.SendAdSPayInciated)()
      ;
      (PayService.ReqPayCheck)(config.product_id, config.price)
    end
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R0 in 'UnsetPending'

PayMgr.DealAfterPayCheck = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  if msg then
    if PayMgr.LimitBuy and msg.productId == PayMgr.LimitProductID then
      (MessageMgr.SendCenterTipsByWordID)(20000626)
      return 
    end
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

    PayMgr.RecodeProductID = msg.productId
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

    PayMgr.RecodeTimes = (PayData.GetProductRemainTimesByProductId)(msg.productId)
    -- DECOMPILER ERROR at PC43: Unhandled construct in 'MakeBoolean' P1

    if msg.productId ~= "jp.red.free" and Game.useSDK == true then
      (SuperSDKUtil.Pay)(msg.productId, msg.sOrderId .. "_" .. msg.sParam .. "_" .. (PayData.GetPayCheckParam)())
    end
  end
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.ShopWindow).name, RedDotComID.FREE_GIFT)
end


