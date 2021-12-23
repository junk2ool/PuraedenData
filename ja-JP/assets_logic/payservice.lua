-- params : ...
-- function num : 0 , upvalues : _ENV
PayService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

PayService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResPayCheck, PayService.OnResPayCheck)
  ;
  (Net.AddListener)((Proto.MsgName).ResPayData, PayService.OnResPayData)
  ;
  (Net.AddListener)((Proto.MsgName).ResPayCardReward, PayService.OnResPayCardReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResPaySuccess, PayService.OnResPaySuccess)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

PayService.ReqPayData = function(isLogin, needResend, ...)
  -- function num : 0_1 , upvalues : _ENV
  (PayData.ClearData)()
  local m = {}
  m.login = isLogin
  if needResend then
    (Net.Send)((Proto.MsgName).ReqPayData, m, (Proto.MsgName).ResPayData, function(...)
    -- function num : 0_1_0 , upvalues : _ENV, isLogin, needResend
    (PayService.ReqPayData)(isLogin, needResend)
  end
)
  else
    ;
    (Net.Send)((Proto.MsgName).ReqPayData, m, (Proto.MsgName).ResPayData)
  end
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

PayService.OnResPayData = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (PayData.SavePayData)(msg)
  if UIMgr:IsWindowOpen((WinResConfig.ShopWindow).name) then
    UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_REFRESH)
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

PayService.ReqPayCheck = function(productId, amount, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.productId = productId
  m.amount = amount
  m.cParam = (PayData.GetPayCheckParam)()
  ;
  (Net.Send)((Proto.MsgName).ReqPayCheck, m, (Proto.MsgName).ResPayCheck)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

PayService.OnResPayCheck = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  PrintTable(msg, "服务器校验结果：")
  ;
  (PayMgr.DealAfterPayCheck)(msg)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

PayService.ReqPayCardReward = function(type, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.cardType = type
  ;
  (Net.Send)((Proto.MsgName).ReqPayCardReward, m, (Proto.MsgName).ResPayCardReward)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

PayService.OnResPayCardReward = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  if msg.cardType then
    if msg.cardType == PayProductType.LittleMonthCard then
      ((PayData.GetCardDataByType)(PayProductType.LittleMonthCard)).cardReceive = true
      ;
      (RedDotMgr.EliminateRedDot)((WinResConfig.ShopWindow).name, RedDotComID.Moon_Res)
    else
      if msg.cardType == PayProductType.BigMonthCard then
        ((PayData.GetCardDataByType)(PayProductType.BigMonthCard)).cardReceive = true
        ;
        (RedDotMgr.EliminateRedDot)((WinResConfig.ShopWindow).name, RedDotComID.Moon_Dia)
      else
        if msg.cardType == PayProductType.WeekCard then
          ((PayData.GetCardDataByType)(PayProductType.WeekCard)).cardReceive = true
          ;
          (RedDotMgr.EliminateRedDot)((WinResConfig.ShopWindow).name, RedDotComID.Card_Week)
        end
      end
    end
    UIMgr:SendWindowMessage((WinResConfig.TaskWindow).name, (WindowMsgEnum.TaskWindow).TASK_REFRESH_WINDOW)
    UIMgr:CloseWindow((WinResConfig.ShopMonthCardWindow).name)
    UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_REFRESH)
  end
  ;
  (TaskMgr.CheckDisposeRedDot)()
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

PayService.OnResPaySuccess = function(msg, ...)
  -- function num : 0_7 , upvalues : _ENV
  if UIMgr:IsWindowOpen((WinResConfig.ShopMonthCardWindow).name) then
    UIMgr:CloseWindow((WinResConfig.ShopMonthCardWindow).name)
  else
    if UIMgr:IsWindowOpen((WinResConfig.ShopGiftWindow).name) then
      UIMgr:CloseWindow((WinResConfig.ShopGiftWindow).name)
    end
  end
  UIMgr:RemoveWindowList((WinResConfig.ShopMonthCardWindow).name)
  UIMgr:RemoveWindowList((WinResConfig.ShopGiftWindow).name)
  UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_CLEAR_CHECKPRODUCTSTATE, msg)
end

;
(PayService.Init)()

