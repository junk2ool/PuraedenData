-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_ChoiceShopByName")
require("ActivityDungeon_ShopTipsByName")
require("ActivityDungeon_StageNumberByName")
local ActivityDungeonShopWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local shopData = nil
local cardListData = {}
local selectCardId = 0
local MAX_STAGE = (((TableData.gTable).BaseFixedData)[Const.MAX_CARDSTAGE]).int_value
local mGoodInfo = {}
local shopListData = {}
ActivityDungeonShopWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, shopData, ActivityDungeonShopWindow
  bridgeObj:SetView((WinResConfig.ActivityDungeonShopWindow).package, (WinResConfig.ActivityDungeonShopWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetActivityDungeon_ChoiceShopUis(contentPane)
  if argTable[1] and not (argTable[1]).shopGridData then
    shopData = {}
    ;
    (ActivityDungeonShopWindow.InitAssetStrip)()
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.TipsTxt).text = (PUtil.get)(235, (((TableData.gTable).BaseAssetData)[AssetType.ACTIVITYDUNGEON_COIN]).name)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.CardHeadList).itemRenderer = ActivityDungeonShopWindow.CardListRenderer
    ;
    (uis.CardHeadList):SetVirtual()
    ;
    (ActivityDungeonShopWindow.InitCardList)()
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.CommodityList).itemRenderer = ActivityDungeonShopWindow.RendererList
    ;
    (uis.CommodityList):SetVirtual()
    ;
    (uis.CommodityList):SetBeginAnim(false, "up", 0.05, 0.05, true)
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.StageList).StageList).itemRenderer = ActivityDungeonShopWindow.ArticleRenderer
    ;
    (ActivityDungeonShopWindow.SortItems)()
    ;
    (ActivityDungeonShopWindow.SetBreakArticleShow)()
    ;
    (ActivityDungeonShopWindow.FilterShopData)()
  end
end

ActivityDungeonShopWindow.FilterShopData = function(...)
  -- function num : 0_1 , upvalues : shopListData, shopData, uis
  shopListData = {}
  shopListData = shopData
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CommodityList).numItems = #shopListData
end

ActivityDungeonShopWindow.ArticleRenderer = function(index, obj, ...)
  -- function num : 0_2 , upvalues : mGoodInfo, _ENV
  local mData = mGoodInfo[index + 1]
  if not mData then
    return 
  end
  local model = GetActivityDungeon_StageNumberUis(obj)
  local configData = (Util.GetConfigDataByID)(mData.id)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (model.NameTxt).text = configData.name
  local have = mData.have
  local need = mData.need
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

  if need <= have then
    (model.c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (model.NumberTxt).visible = false
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((model.CirclePropFrame).c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((model.CirclePropFrame).StageTxt).text = (PUtil.get)(20000063, have, need)
  else
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (model.c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (model.NumberTxt).visible = true
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (model.NumberTxt).text = (PUtil.get)(20000623, need - have)
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((model.CirclePropFrame).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((model.CirclePropFrame).StageTxt).text = (PUtil.get)(20000064, have, need)
  end
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((model.CirclePropFrame).c2Ctr).selectedIndex = configData.quality - 1
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((model.CirclePropFrame).IconLoader).url = (Util.GetItemUrl)(configData.icon)
end

ActivityDungeonShopWindow.InitCardList = function(...)
  -- function num : 0_3 , upvalues : cardListData, _ENV, selectCardId, uis
  cardListData = (ActivityData.GetCards)()
  selectCardId = (cardListData[1]).id
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CardHeadList).numItems = #cardListData
  ;
  (((uis.CardHeadList).scrollPane).onScroll):Add(function(...)
    -- function num : 0_3_0 , upvalues : uis
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    (uis.LeftBtn).visible = not ((uis.CardHeadList).scrollPane).isLeftMost
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.RightBtn).visible = not ((uis.CardHeadList).scrollPane).isRightMost
  end
)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.LeftBtn).visible = not ((uis.CardHeadList).scrollPane).isLeftMost
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.RightBtn).visible = not ((uis.CardHeadList).scrollPane).isRightMost
end

ActivityDungeonShopWindow.CardListRenderer = function(index, obj, ...)
  -- function num : 0_4 , upvalues : cardListData, _ENV, selectCardId, uis, ActivityDungeonShopWindow
  local data = cardListData[index + 1]
  local cardID = data.id
  ;
  (Util.SetHeadFrame)(obj, data, false, false)
  if cardID == selectCardId then
    ChangeUIController(obj, "c1", 1)
  else
    ChangeUIController(obj, "c1", 0)
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : cardID, selectCardId, uis, ActivityDungeonShopWindow
    if cardID ~= selectCardId then
      selectCardId = cardID
      ;
      (uis.CardHeadList):RefreshVirtualList()
      ;
      (ActivityDungeonShopWindow.SetBreakArticleShow)()
    end
  end
)
end

ActivityDungeonShopWindow.SetBreakArticleShow = function(...)
  -- function num : 0_5 , upvalues : _ENV, selectCardId, mGoodInfo, MAX_STAGE, uis
  local cardData = (CardData.GetCardData)(selectCardId)
  mGoodInfo = {}
  ld("Card")
  MAX_STAGE = (CardData.GetRoleMaxStage)(selectCardId)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  if cardData.quality < MAX_STAGE then
    ((uis.StageList).c1Ctr).selectedIndex = 0
    local StageData = (CardMgr.GetBaseCardQualityData)(cardData.quality + 1, cardData.id)
    local needGoods = (Util.ParseConfigStr)(StageData.need_goods)
    for _,v2 in ipairs(needGoods) do
      if tonumber(v2[1]) == PropType.ITEM then
        local itemID = tonumber(v2[2])
        local needNum = tonumber(v2[3])
        local haveNum = (ActorData.GetPropsByID)(itemID)
        ;
        (table.insert)(mGoodInfo, {id = itemID, have = haveNum, need = needNum})
      end
    end
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.StageList).StageList).numItems = #mGoodInfo
  else
    do
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.StageList).c1Ctr).selectedIndex = 1
      -- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.StageList).WordTxt).text = cardData.name
    end
  end
end

ActivityDungeonShopWindow.RendererList = function(index, obj, ...)
  -- function num : 0_6 , upvalues : _ENV, shopListData, ActivityDungeonShopWindow
  obj = obj:GetChild("ShopTips")
  local model = GetActivityDungeon_ShopTipsUis(obj)
  index = index + 1
  local data = shopListData[index]
  if not data or data.shopPoolId == 0 then
    return 
  end
  local GridData = ((TableData.gTable).BaseShopGridData)[data.shopGridId]
  local PoolData = ((TableData.gTable).BaseShopPoolData)[data.shopPoolId]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  local itemData, DataType = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (model.c1Ctr).selectedIndex = itemData.quality
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (model.IconLoader).url = (Util.GetItemUrl)(itemData.icon)
  local PoolDataStr = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, data.useNum)
  local amount = tonumber(PoolDataStr[3])
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.IconNumberTxt).visible = amount > 1
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.IconNumberTxt).text = amount
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.ItemNameTxt).text = itemData.name
  local times = GridData.sell_limit_time - data.useNum
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R12 in 'UnsetPending'

  if tonumber(GridData.reset_type) == 0 then
    ((model.DayBuyNumber).root).visible = true
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((model.DayBuyNumber).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
  else
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R12 in 'UnsetPending'

    if GridData.sell_limit_time > 1 then
      ((model.DayBuyNumber).root).visible = true
      -- DECOMPILER ERROR at PC96: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((model.DayBuyNumber).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
    else
      -- DECOMPILER ERROR at PC100: Confused about usage of register: R12 in 'UnsetPending'

      ((model.DayBuyNumber).root).visible = false
    end
  end
  -- DECOMPILER ERROR at PC108: Confused about usage of register: R12 in 'UnsetPending'

  if (ActivityDungeonShopWindow.IsInfiniteTime)(GridData.sell_limit_time) then
    ((model.DayBuyNumber).DayBuyNumberTxt).text = "∞"
  end
  local cost = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, data.useNum)
  local contNum = tonumber(cost[3])
  ;
  (Util.SetConsumptionByID)(cost[2], cost[3], model.CostLoader, model.CostTxt, false)
  local needList = (ShopMgr.GetQualityUpCard)(itemData.id)
  -- DECOMPILER ERROR at PC135: Confused about usage of register: R15 in 'UnsetPending'

  if GridData.sell_limit_time <= data.useNum then
    (model.c2Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC138: Confused about usage of register: R15 in 'UnsetPending'

    (model.c2Ctr).selectedIndex = 0
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : data, GridData, _ENV, ActivityDungeonShopWindow, needList
    if GridData.sell_limit_time <= data.useNum then
      log("已售罄")
      return 
    end
    local buyData = {}
    if (ActivityDungeonShopWindow.IsInfiniteTime)(GridData.sell_limit_time) then
      buyData.MaxNum = 100
    else
      buyData.MaxNum = GridData.sell_limit_time - data.useNum
    end
    buyData.needCards = needList
    buyData.gridID = data.shopGridId
    buyData.poolID = data.shopPoolId
    buyData.shopType = ShopType.ActivityDungeonShop
    buyData.buyTime = data.useNum
    OpenWindow((WinResConfig.ActivityDungeonShopBuyWindow).name, UILayer.HUD, buyData)
  end
)
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

ActivityDungeonShopWindow.IsInfiniteTime = function(limit_time, ...)
  -- function num : 0_7
  do return limit_time == -1 or limit_time >= 99999 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityDungeonShopWindow.InitAssetStrip = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ActivityDungeonShopWindow).name
  m.Tip = (PUtil.get)(20000069)
  m.model = uis.AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.ACTIVITYDUNGEON_COIN, AssetType.ACTIVITY_SCORE_NEW}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ActivityDungeonShopWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9 , upvalues : _ENV, shopData, ActivityDungeonShopWindow
  if msgId == (WindowMsgEnum.ActivityDungeonShopWindow).E_MSG_REFRESH_ITEMLIST then
    for k,v in ipairs(shopData) do
      if v.shopGridId == (para.data).shopGridId then
        shopData[k] = para.data
      end
    end
    ;
    (ActivityDungeonShopWindow.SortItems)()
    ;
    (ActivityDungeonShopWindow.SetBreakArticleShow)()
  else
    if msgId == (WindowMsgEnum.ActivityDungeonShopWindow).E_MSG_REFRESH_LEFT_SHOW then
      (ActivityDungeonShopWindow.SetBreakArticleShow)()
    end
  end
end

ActivityDungeonShopWindow.SortItems = function(...)
  -- function num : 0_10 , upvalues : shopData, _ENV
  if shopData and #shopData then
    (table.sort)(shopData, function(a, b, ...)
    -- function num : 0_10_0 , upvalues : _ENV
    local ad = ((TableData.gTable).BaseShopGridData)[a.shopGridId]
    local bd = ((TableData.gTable).BaseShopGridData)[b.shopGridId]
    do return tonumber(ad.sort_index) < tonumber(bd.sort_index) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
end

ActivityDungeonShopWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : uis, contentPane, argTable, shopData, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  shopData = nil
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ActivityDungeonShopWindow).name)
end

return ActivityDungeonShopWindow

