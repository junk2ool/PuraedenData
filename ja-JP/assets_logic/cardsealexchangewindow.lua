-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_ImprintDebrisChangeWindowByName")
local CardSealExchangeWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
CardSealExchangeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, CardSealExchangeWindow
  bridgeObj:SetView((WinResConfig.CardSealExchangeWindow).package, (WinResConfig.CardSealExchangeWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argTable.Card = argTable[1]
  contentPane:Center()
  uis = GetCard_ImprintDebrisChangeWindowUis(contentPane)
  uis = uis.ImprintDebrisChange
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  CardData.CurrentExchangePieces = 0
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(60000504)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(60000073)
  ;
  (CardData.SetWildCardId)((argTable.Card).id)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  CardData.CurrentCardPieceInfo = (ActorData.GetCardPieceInfo)((argTable.Card).id)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

  CardData.CurrentPieceID = (CardData.CurrentCardPieceInfo).id
  local config = ((TableData.gTable).BasePropData)[CardData.CurrentPieceID]
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.JueSeDebrisTxt).text = config.name
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R2 in 'UnsetPending'

  CardData.WildCardAmount = (ActorData.GetGoodsCount)(CardData.WildCardId, PropType.ITEM)
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.WangNengItemTxt).text = (((TableData.gTable).BasePropData)[CardData.WildCardId]).name
  ;
  (CardSealExchangeWindow.Refresh)()
end

CardSealExchangeWindow.SetExchange = function(num, ...)
  -- function num : 0_1 , upvalues : _ENV, CardSealExchangeWindow
  local count = (ActorData.GetPropsByID)(CardData.WildCardId)
  if CardData.CurrentExchangePieces == count and num > 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000650))
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  CardData.CurrentExchangePieces = (math.min)((math.max)(CardData.CurrentExchangePieces + num, 0), count)
  ;
  (CardSealExchangeWindow.Refresh)()
end

CardSealExchangeWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : uis, CardSealExchangeWindow, _ENV
  ((uis.ReduceBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : CardSealExchangeWindow
    (CardSealExchangeWindow.SetExchange)(-1)
  end
)
  ;
  ((uis.AddBtn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : CardSealExchangeWindow
    (CardSealExchangeWindow.SetExchange)(1)
  end
)
  ;
  ((uis.MinBtn).onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : CardSealExchangeWindow
    (CardSealExchangeWindow.SetExchange)(10)
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_2_3 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.CardSealExchangeWindow).name)
  end
)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_2_4 , upvalues : _ENV
    if CardData.CurrentExchangePieces > 0 then
      UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SEAL_INFORMATION, {type = 5})
      ;
      (CardService.ReqExchangeDebris)((ActorData.GetItemObjectIndex)(CardData.WildCardId), CardData.CurrentExchangePieces, CardData.CurrentPieceID)
      UIMgr:CloseWindow((WinResConfig.CardSealExchangeWindow).name)
    else
      ;
      (MessageMgr.SendCenterTipsByWordID)(20000651)
    end
  end
)
end

CardSealExchangeWindow.Refresh = function(...)
  -- function num : 0_3 , upvalues : _ENV, uis
  (Util.SetItemFrame)((uis.WangNengItemGrp).root, CardData.WildCardId, CardData.WildCardAmount - CardData.CurrentExchangePieces)
  local debrisAmount = (CardData.CurrentCardPieceInfo).haveNum + CardData.CurrentExchangePieces
  ;
  (Util.SetDebrisFrame)((uis.JueSeDebrisGrp).root, CardData.CurrentPieceID, debrisAmount)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ChangeNumberTxt).text = tostring(CardData.CurrentExchangePieces)
end

CardSealExchangeWindow.OnHide = function(...)
  -- function num : 0_4
end

CardSealExchangeWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SEAL_INFORMATION, {type = 5})
end

CardSealExchangeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6 , upvalues : _ENV, CardSealExchangeWindow
  if msgId == (WindowMsgEnum.CardWindow).E_MSG_CARD_PIECE_EXCHANGE_COUNT then
    (CardSealExchangeWindow.Refresh)()
  end
end

return CardSealExchangeWindow

