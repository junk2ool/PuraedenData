-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_MonthWindowByName")
local ShopMonthCardWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local configData = nil
local canBuy = false
ShopMonthCardWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, canBuy, configData, ShopMonthCardWindow
  bridgeObj:SetView((WinResConfig.ShopMonthCardWindow).package, (WinResConfig.ShopMonthCardWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  local productID = tonumber(argTable[1])
  uis = GetShop_MonthWindowUis(contentPane)
  uis = uis.Month
  canBuy = false
  configData = ((TableData.gTable).BasePayProductData)[productID]
  local addEffect = function(component, ...)
    -- function num : 0_0_0 , upvalues : _ENV
    local count = component.numChildren
    local effect, item = nil, nil
    for i = 0, count - 1 do
      item = component:GetChildAt(i)
      effect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_MONTHLYCARD_SMALL, true, true)
      item:AddChild(effect)
      effect:SetXY(item.width * 0.5, item.height * 0.5)
    end
  end

  local tarItem = nil
  local tarType = (ActivityMgr.MouthDoubleType).AssetMouth
  local activityId = 33000241
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

  if configData.type == PayProductType.LittleMonthCard then
    (uis.c1Ctr).selectedIndex = 0
    local obj = UIMgr:CreateObject("Shop", "RewardA")
    ;
    (uis.RewardAList):AddChild(obj)
    canBuy = ((PayData.GetCardDataByType)(PayProductType.LittleMonthCard)).cardCanBuy
    addEffect(obj)
    tarItem = obj
    tarType = (ActivityMgr.MouthDoubleType).AssetMouth
    activityId = 33000241
    ;
    ((obj:GetChildAt(0)):GetChild("WordTxt")).text = (PUtil.get)(85000001)
    ;
    ((obj:GetChildAt(1)):GetChild("WordTxt")).text = (PUtil.get)(85000002)
    ;
    ((obj:GetChildAt(2)):GetChild("WordTxt")).text = (PUtil.get)(85000002)
    ;
    ((obj:GetChildAt(3)):GetChild("WordTxt")).text = (PUtil.get)(85000002)
  else
    do
      -- DECOMPILER ERROR at PC116: Confused about usage of register: R6 in 'UnsetPending'

      if configData.type == PayProductType.BigMonthCard then
        (uis.c1Ctr).selectedIndex = 1
        local obj = UIMgr:CreateObject("Shop", "RewardB")
        ;
        (uis.RewardBList):AddChild(obj)
        canBuy = ((PayData.GetCardDataByType)(PayProductType.BigMonthCard)).cardCanBuy
        addEffect(obj)
        tarItem = obj
        tarType = (ActivityMgr.MouthDoubleType).DiamondMouth
        activityId = 33000242
        ;
        ((obj:GetChildAt(0)):GetChild("WordTxt")).text = (PUtil.get)(85000001)
        ;
        ((obj:GetChildAt(1)):GetChild("WordTxt")).text = (PUtil.get)(85000002)
        ;
        ((obj:GetChildAt(2)):GetChild("WordTxt")).text = (PUtil.get)(85000002)
      else
        do
          -- DECOMPILER ERROR at PC181: Confused about usage of register: R6 in 'UnsetPending'

          if configData.type == PayProductType.WeekCard then
            (uis.c1Ctr).selectedIndex = 2
            local obj = UIMgr:CreateObject("Shop", "RewardC")
            ;
            (uis.RewardCList):AddChild(obj)
            canBuy = ((PayData.GetCardDataByType)(PayProductType.WeekCard)).cardCanBuy
            addEffect(obj)
            tarItem = obj
            tarType = (ActivityMgr.MouthDoubleType).DiamondMouth
            activityId = 87301801
            ;
            ((obj:GetChildAt(0)):GetChild("WordTxt")).text = (PUtil.get)(85000001)
            ;
            ((obj:GetChildAt(1)):GetChild("WordTxt")).text = (PUtil.get)(85000001)
            ;
            ((obj:GetChildAt(2)):GetChild("WordTxt")).text = (PUtil.get)(85000002)
          end
          do
            ;
            (ShopMonthCardWindow.InitEvent)()
            ;
            (ShopMonthCardWindow.SetDouble)(tarItem, tarType, activityId)
            -- DECOMPILER ERROR at PC251: Confused about usage of register: R6 in 'UnsetPending'

            ;
            (uis.TipsTxt).text = (PUtil.get)(20000356)
            -- DECOMPILER ERROR at PC267: Confused about usage of register: R6 in 'UnsetPending'

            if configData.type == PayProductType.LittleMonthCard or configData.type == PayProductType.BigMonthCard then
              (uis.TitleTxt).text = (PUtil.get)(20000406)
              -- DECOMPILER ERROR at PC273: Confused about usage of register: R6 in 'UnsetPending'

              ;
              (uis.ItemNameTxt).text = (PUtil.get)(20000355)
            else
              -- DECOMPILER ERROR at PC285: Confused about usage of register: R6 in 'UnsetPending'

              if configData.type == PayProductType.WeekCard then
                (uis.TitleTxt).text = (PUtil.get)(20000664)
                -- DECOMPILER ERROR at PC291: Confused about usage of register: R6 in 'UnsetPending'

                ;
                (uis.ItemNameTxt).text = (PUtil.get)(20000665)
              end
            end
            local lod = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_MONTHLYCARD_HUGE, true, true)
            ;
            (uis.root):AddChild(lod)
            lod:SetXY((uis.Decorate_03_Image).x + (uis.Decorate_03_Image).width * 0.5, (uis.Decorate_03_Image).y + (uis.Decorate_03_Image).height * 0.5)
          end
        end
      end
    end
  end
end

ShopMonthCardWindow.SetDouble = function(obj, type, activityId, ...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local childNum = (obj:GetChildren()).Length
  local isHave = (ActivityMgr.GetMouthRewardDouble)(type)
  local actData = ((TableData.gTable).BaseActivityData)[activityId]
  for i = 0, childNum - 1 do
    local item = obj:GetChildAt(i)
    local ctr = item:GetController("c1")
    if ctr and isHave then
      ctr.selectedIndex = 1
    else
      ctr.selectedIndex = 0
    end
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

  if isHave then
    (uis.TimeTxt).text = actData.remark
  else
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (uis.TimeTxt).text = ""
  end
end

ShopMonthCardWindow.InitEvent = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, canBuy, configData
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ShopMonthCardWindow).name)
  end
)
  if canBuy then
    ChangeUIController(uis.SureBtn, "c1", 0)
  else
    ChangeUIController(uis.SureBtn, "c1", 1)
  end
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : canBuy, _ENV, configData
    if canBuy then
      (PayMgr.SendPayCheck)(configData.id)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000386))
    end
  end
)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000324)
  local canGet = (PayData.GetMonthCardCanGet)(configData.type)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  if canGet then
    (uis.GetBtn).text = (PUtil.get)(20000293)
    ChangeUIController(uis.GetBtn, "c1", 0)
  else
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.GetBtn).text = (PUtil.get)(20000011)
    ChangeUIController(uis.GetBtn, "c1", 1)
  end
  ;
  ((uis.GetBtn).onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : canGet, _ENV, configData
    if canGet then
      (PayService.ReqPayCardReward)(configData.type)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000387))
    end
  end
)
end

ShopMonthCardWindow.OnShown = function(...)
  -- function num : 0_3 , upvalues : _ENV, configData, uis
  local remainDay = (PayData.GetRemainMonthCardDay)(configData.type)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if remainDay > 0 then
    (uis.c2Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.DayTxt).text = (PUtil.get)(20000325, remainDay)
  else
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.c2Ctr).selectedIndex = 0
  end
end

ShopMonthCardWindow.OnHide = function(...)
  -- function num : 0_4
end

ShopMonthCardWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

ShopMonthCardWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

return ShopMonthCardWindow

