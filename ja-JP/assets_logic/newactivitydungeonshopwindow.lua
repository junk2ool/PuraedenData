-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_ChoiceShopByName")
require("ActivityDungeonTwo_ShopTipsByName")
local NewActivityDungeonShopWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _currentRoleIndex = 1
local _cards = {}
NewActivityDungeonShopWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, NewActivityDungeonShopWindow
  bridgeObj:SetView((WinResConfig.NewActivityDungeonShopWindow).package, (WinResConfig.NewActivityDungeonShopWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivityDungeonTwo_ChoiceShopUis(contentPane)
  ;
  (NewActivityDungeonShopWindow.InitTopMenu)()
  ;
  (NewActivityDungeonShopWindow.InitText)()
  ;
  (NewActivityDungeonShopWindow.InitList)()
  local activityId = (ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).NewActivityDungeon)
  ;
  (NewActivityDungeonShopWindow.InitPanelIcons)(activityId)
end

NewActivityDungeonShopWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.NewActivityDungeonShopWindow).name
  m.Tip = (PUtil.get)(20000069)
  m.model = uis.AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.ACTIVITYDUNGEON_COIN, AssetType.ACTIVITY_SCORE_NEW}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

NewActivityDungeonShopWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TipsTxt).text = (PUtil.get)(235, (((TableData.gTable).BaseAssetData)[AssetType.ACTIVITYDUNGEON_COIN]).name)
end

NewActivityDungeonShopWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : _cards, _ENV, uis, NewActivityDungeonShopWindow, _currentRoleIndex
  _cards = (CardMgr.SetButtomRoleList)(uis.CardHeadList, function(index, data, ...)
    -- function num : 0_3_0 , upvalues : NewActivityDungeonShopWindow
    (NewActivityDungeonShopWindow.ChoseRole)(index, data)
  end
, _currentRoleIndex, uis.LeftBtn, uis.RightBtn, (WinResConfig.NewActivityDungeonShopWindow).name, true, ActivityData.GetCards)
  ;
  (uis.CommodityList):SetVirtual()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CommodityList).itemRenderer = NewActivityDungeonShopWindow.RefreshCommodityItem
  ;
  (uis.CommodityList):SetBeginAnim(false, "up", 0.05, 0.05, true)
end

NewActivityDungeonShopWindow.InitPanelIcons = function(activityId, ...)
  -- function num : 0_4 , upvalues : _ENV, uis
  local bgLoader = (FairyUIUtils.FindLoader)(uis.root, "BgLoader")
  local imageConfigData = ((TableData.gTable).BaseActivityImageConfigData)[activityId]
  if imageConfigData then
    bgLoader.url = (Util.GetItemUrl)(imageConfigData.activity_shop_bkg)
  else
    loge("Can Not Find Image Config Data With Activity Id:" .. tostring(activityId))
  end
end

NewActivityDungeonShopWindow.OnShown = function(...)
  -- function num : 0_5 , upvalues : NewActivityDungeonShopWindow
  (NewActivityDungeonShopWindow.Init)()
end

NewActivityDungeonShopWindow.OnHide = function(...)
  -- function num : 0_6
end

NewActivityDungeonShopWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : _cards, _ENV, _currentRoleIndex, uis, contentPane, argTable
  _cards = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.NewActivityDungeonShopWindow).name)
  _currentRoleIndex = 1
  uis = nil
  contentPane = nil
  argTable = {}
end

NewActivityDungeonShopWindow.Init = function(...)
  -- function num : 0_8 , upvalues : NewActivityDungeonShopWindow, _currentRoleIndex, uis, _ENV
  (NewActivityDungeonShopWindow.ChoseRole)(_currentRoleIndex)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CommodityList).numItems = #(NewActivityDungeonData.ShopData).shopGridData
end

NewActivityDungeonShopWindow.ChoseRole = function(index, roleData, ...)
  -- function num : 0_9 , upvalues : _currentRoleIndex, _cards, NewActivityDungeonShopWindow, uis
  _currentRoleIndex = index
  if roleData == nil then
    roleData = _cards[index]
  end
  ;
  (NewActivityDungeonShopWindow.RefreshStageUpInfo)(roleData)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.StageList).WordTxt).text = roleData.name
end

NewActivityDungeonShopWindow.RefreshStageUpInfo = function(roleData, ...)
  -- function num : 0_10 , upvalues : _ENV, uis, NewActivityDungeonShopWindow
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if roleData.quality < (CardData.GetRoleMaxStage)(roleData.id) then
    ((uis.StageList).c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    NewActivityDungeonData.RoleNeedGoods = (CardData.GetRoleStageUpNeeds)(roleData)
    ;
    ((uis.StageList).StageList):RemoveChildrenToPool()
    local item = nil
    local count = #NewActivityDungeonData.RoleNeedGoods
    for i = 1, count do
      item = ((uis.StageList).StageList):AddItemFromPool()
      ;
      (NewActivityDungeonShopWindow.RefreshNeedsItem)(i, item)
    end
  else
    do
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.StageList).c1Ctr).selectedIndex = 1
    end
  end
end

NewActivityDungeonShopWindow.RefreshCommodityItem = function(index, item, ...)
  -- function num : 0_11 , upvalues : _ENV
  item = item:GetChild("ShopTips")
  local model = GetActivityDungeonTwo_ShopTipsUis(item)
  index = index + 1
  local data = ((NewActivityDungeonData.ShopData).shopGridData)[index]
  if not data or data.shopPoolId == 0 then
    return 
  end
  local GridData = ((TableData.gTable).BaseShopGridData)[data.shopGridId]
  local PoolData = ((TableData.gTable).BaseShopPoolData)[data.shopPoolId]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  local itemData, DataType = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (model.c1Ctr).selectedIndex = itemData.quality
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (model.IconLoader).url = (Util.GetItemUrl)(itemData.icon)
  local PoolDataStr = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, data.useNum)
  local amount = tonumber(PoolDataStr[3])
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.IconNumberTxt).visible = amount > 1
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.IconNumberTxt).text = amount
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (model.ItemNameTxt).text = itemData.name
  local times = GridData.sell_limit_time - data.useNum
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R12 in 'UnsetPending'

  if tonumber(GridData.reset_type) == 0 then
    ((model.DayBuyNumber).root).visible = true
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((model.DayBuyNumber).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
  else
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R12 in 'UnsetPending'

    if GridData.sell_limit_time > 1 then
      ((model.DayBuyNumber).root).visible = true
      -- DECOMPILER ERROR at PC99: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((model.DayBuyNumber).DayBuyNumberTxt).text = (PUtil.get)(20000320, times)
    else
      -- DECOMPILER ERROR at PC103: Confused about usage of register: R12 in 'UnsetPending'

      ((model.DayBuyNumber).root).visible = false
    end
  end
  -- DECOMPILER ERROR at PC112: Confused about usage of register: R12 in 'UnsetPending'

  if GridData.sell_limit_time == -1 or GridData.sell_limit_time >= 99999 then
    ((model.DayBuyNumber).DayBuyNumberTxt).text = "∞"
  end
  local cost = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, data.useNum)
  local contNum = tonumber(cost[3])
  ;
  (Util.SetConsumptionByID)(cost[2], cost[3], model.CostLoader, model.CostTxt, false)
  local needList = (ShopMgr.GetQualityUpCard)(itemData.id)
  -- DECOMPILER ERROR at PC139: Confused about usage of register: R15 in 'UnsetPending'

  if GridData.sell_limit_time <= data.useNum then
    (model.c2Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC142: Confused about usage of register: R15 in 'UnsetPending'

    (model.c2Ctr).selectedIndex = 0
  end
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : data, GridData, _ENV, needList
    if GridData.sell_limit_time <= data.useNum then
      log("已售罄")
      return 
    end
    local buyData = {}
    if GridData.sell_limit_time == -1 or GridData.sell_limit_time >= 99999 then
      buyData.MaxNum = 100
    else
      buyData.MaxNum = GridData.sell_limit_time - data.useNum
    end
    buyData.needCards = needList
    buyData.gridID = data.shopGridId
    buyData.poolID = data.shopPoolId
    buyData.shopType = ShopType.ActivityDungeonShop
    buyData.buyTime = data.useNum
    ;
    (NewActivityDungeonData.InitBuyingData)(buyData)
    OpenWindow((WinResConfig.NewActivityDungeonShopBuyWindow).name, UILayer.HUD)
  end
)
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

NewActivityDungeonShopWindow.RefreshNeedsItem = function(index, item, ...)
  -- function num : 0_12 , upvalues : _ENV
  local mData = (NewActivityDungeonData.RoleNeedGoods)[index]
  if not mData then
    return 
  end
  local configData = (Util.GetConfigDataByID)(mData.id)
  ;
  (item:GetChild("NameTxt")).text = configData.name
  local have = mData.have
  local need = mData.need
  local numberTxt = item:GetChild("NumberTxt")
  local circlePropFrame = item:GetChild("CirclePropFrame")
  if need <= have then
    (item:GetController("c1")).selectedIndex = 0
    numberTxt.visible = false
    ;
    (circlePropFrame:GetController("c1")).selectedIndex = 0
    ;
    (circlePropFrame:GetChild("StageTxt")).text = (PUtil.get)(20000063, have, need)
  else
    ;
    (item:GetController("c1")).selectedIndex = 1
    numberTxt.visible = true
    numberTxt.text = (PUtil.get)(20000623, need - have)
    ;
    (circlePropFrame:GetController("c1")).selectedIndex = 1
    ;
    (circlePropFrame:GetChild("StageTxt")).text = (PUtil.get)(20000064, have, need)
  end
  ;
  (circlePropFrame:GetController("c2")).selectedIndex = configData.quality - 1
  ;
  (circlePropFrame:GetChild("IconLoader")).url = (Util.GetItemUrl)(configData.icon)
end

NewActivityDungeonShopWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : _ENV, NewActivityDungeonShopWindow, _currentRoleIndex
  if msgId == (WindowMsgEnum.ActivityDungeonShopWindow).E_MSG_REFRESH_ITEMLIST then
    (NewActivityDungeonShopWindow.ChoseRole)(_currentRoleIndex)
  end
end

return NewActivityDungeonShopWindow

