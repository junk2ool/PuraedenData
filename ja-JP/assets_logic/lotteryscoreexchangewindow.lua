-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_PtExchangeByName")
local LotteryScoreExchangeWindow = {}
local uis, contentPane, bridge, argTable = nil, nil, nil, nil
local lotteryType = 1
local scoreNum = 0
local goodsInfo = {}
LotteryScoreExchangeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, uis, lotteryType, scoreNum, goodsInfo, LotteryScoreExchangeWindow
  bridgeObj:SetView((WinResConfig.LotteryScoreExchangeWindow).package, (WinResConfig.LotteryScoreExchangeWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetLottery_PtExchangeUis(contentPane)
  local m = {}
  m.windowName = (WinResConfig.LotteryScoreExchangeWindow).name
  m.Tip = (PUtil.get)(273)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.LotteryWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.AssetStripGrp).ExplainBtn).visible = true
  ;
  (((uis.AssetStripGrp).ExplainBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV, lotteryType
    local integral_des = (((TableData.gTable).BaseLotteryShowData)[lotteryType]).integral_des
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, integral_des)
  end
)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_01_Grp).root).visible = false
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_02_Grp).root).visible = false
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_03_Grp).root).visible = false
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_04_Grp).root).visible = false
  scoreNum = argTable[1] or 0
  lotteryType = argTable[2] or 1
  if not argTable[3] then
    goodsInfo = {}
    ;
    (LotteryScoreExchangeWindow.RefreshWindow)()
  end
end

LotteryScoreExchangeWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV, lotteryType, uis, scoreNum, goodsInfo
  local lotteryConfig = ((TableData.gTable).BaseLotteryShowData)[lotteryType]
  local integral_exchange = split(lotteryConfig.integral_exchange, ":")
  local exchangeName = ""
  if tonumber(integral_exchange[1]) == PropType.ASSET then
    local assetConfig = ((TableData.gTable).BaseAssetData)[tonumber(integral_exchange[2])]
    exchangeName = assetConfig.name
  else
    do
      do
        if tonumber(integral_exchange[1]) == PropType.ITEM then
          local propConfig = ((TableData.gTable).BasePropData)[tonumber(integral_exchange[2])]
          exchangeName = propConfig.name
        end
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.WordTxt).text = (PUtil.get)(271, "[color=" .. Const.OrangeColor .. "]" .. exchangeName .. "[/color]")
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R3 in 'UnsetPending'

        if scoreNum == 0 then
          (uis.PtNumberTxt).text = (PUtil.get)(272, scoreNum)
        else
          -- DECOMPILER ERROR at PC77: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (uis.PtNumberTxt).text = (PUtil.get)(272, "[color=" .. Const.GreenColor .. "]" .. scoreNum .. "[/color]")
        end
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.TipsTxt).text = (PUtil.get)(274)
        ;
        (uis.CardList):RemoveChildrenToPool()
        local convert = split(lotteryConfig.integral_convert, ",")
        for index,value in ipairs(convert) do
          do
            print("===========", value)
            local config = split(value, ":")
            local item = (uis.CardList):AddItemFromPool()
            local itemId = tonumber(config[2])
            local itemType = tonumber(config[1])
            local itemNeedScore = tonumber(config[4])
            local itemChargeMax = tonumber(config[5])
            print("-------------", itemType, itemId, itemNeedScore, itemChargeMax)
            local color = "[color=#ff5656]"
            local goodInfo = {}
            for index,value in ipairs(goodsInfo) do
              if value.id == itemId then
                goodInfo = value
              end
            end
            print("++++++++++++++++++", goodInfo.value, goodInfo.id)
            local alreadyChargeNum = goodInfo.value or 0
            local curChargeNum = itemChargeMax - alreadyChargeNum
            if itemChargeMax >= 99999 then
              ((item:GetChild("BuyNumber")):GetChild("DayBuyNumberTxt")).text = (PUtil.get)(280)
            else
              ;
              ((item:GetChild("BuyNumber")):GetChild("DayBuyNumberTxt")).text = curChargeNum
            end
            ;
            (item:GetChild("n4")).visible = curChargeNum <= 0
            ;
            (item:GetChild("NumberTxt")).visible = curChargeNum > 0
            ;
            (item:GetChild("PtBackImage")).visible = curChargeNum > 0
            if curChargeNum > 0 then
              (item:GetController("c1")).selectedIndex = 0
            else
              (item:GetController("c1")).selectedIndex = 1
            end
            local isSatisfiy = itemNeedScore <= scoreNum
            if isSatisfiy then
              color = "[color=" .. Const.GreenColor .. "]"
            else
              color = "[color=" .. Const.RedColor .. "]"
            end
            ;
            (item:GetChild("NumberTxt")).text = color .. itemNeedScore .. "[/color]"
            ;
            ((item:GetChild("SureBtn")):GetChild("title")).text = (PUtil.get)(275)
            ;
            ((item:GetChild("SureBtn")).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, lotteryType, isSatisfiy, itemId
    local isExsit = (ActorData.GetLotteryActivityNum)(lotteryType)
    if isExsit then
      if isSatisfiy then
        (LotteryService.ReqLotteryConversion)(lotteryType, itemId)
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(276))
      end
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(281))
    end
  end
)
            local cardShow = item:GetChild("CardShow")
            local cardData = ((TableData.gTable).BaseCardData)[itemId]
            ;
            (cardShow:GetChild("NameTxt")).text = cardData.name
            local starList = cardShow:GetChild("StarList")
            for i = 1, cardData.intelligence do
              starList:AddItemFromPool()
            end
            ;
            (Util.SetSliverHeadIcon)(tonumber((split(cardData.fashion_ids, ":"))[1]), (cardShow:GetChild("CardLoaderPic")):GetChild("CardLoader"))
          end
        end
        -- DECOMPILER ERROR: 9 unprocessed JMP targets
      end
    end
  end
end

LotteryScoreExchangeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_2 , upvalues : _ENV, lotteryType, scoreNum, goodsInfo, LotteryScoreExchangeWindow
  local windowMsgEnum = WindowMsgEnum.Lottery
  if msgId == windowMsgEnum.E_MSG_LOTTERYCONVERSION then
    lotteryType = (para.data).type
    scoreNum = (para.data).integral
    goodsInfo = (para.data).initConversion
    ;
    (LotteryScoreExchangeWindow.RefreshWindow)()
    local conNum = 0
    for index,value in ipairs(goodsInfo) do
      conNum = conNum + value.value
    end
    do
      if scoreNum <= 0 or conNum <= 0 then
        (RedDotMgr.EliminateRedDot)((WinResConfig.LotteryWindow).name, 2039994 + lotteryType)
      end
    end
  end
end

LotteryScoreExchangeWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, contentPane, bridge, argTable, goodsInfo, _ENV
  uis = nil
  contentPane = nil
  bridge = nil
  argTable = nil
  goodsInfo = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.LotteryScoreExchangeWindow).name)
  UIMgr:SendWindowMessage((WinResConfig.LotteryWindow).name, (WindowMsgEnum.Lottery).E_MSG_CLOSEEXCHANGE)
end

return LotteryScoreExchangeWindow

