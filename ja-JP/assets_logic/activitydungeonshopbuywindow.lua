-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_BuyWindowByName")
local ShopBuyData = {}
local ActivityDungeonShopBuyWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local buyData, _currentType, itemID = nil, nil, nil
ActivityDungeonShopBuyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, buyData, ActivityDungeonShopBuyWindow, itemID
  bridgeObj:SetView((WinResConfig.ActivityDungeonShopBuyWindow).package, (WinResConfig.ActivityDungeonShopBuyWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivityDungeon_BuyWindowUis(contentPane)
  uis = uis.Buy
  buyData = argTable[1]
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ChangeNumberTxt).text = 1
  ;
  (ActivityDungeonShopBuyWindow.InitBtn)()
  local PoolData = ((TableData.gTable).BaseShopPoolData)[buyData.poolID]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  itemID = tonumber(configItem[2])
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.titilenameTxt).text = (PUtil.get)(20000361)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.HaveNumber_01_Txt).text = (PUtil.get)(20000348)
end

ActivityDungeonShopBuyWindow.InitBtn = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, ActivityDungeonShopBuyWindow, itemID, buyData, _currentType
  ((uis.ReduceBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, uis, ActivityDungeonShopBuyWindow
    local times = tonumber((uis.ChangeNumberTxt).text) - 1
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    if (ActivityDungeonShopBuyWindow.CheckIsSatisfiedTimes)(times, true) then
      (uis.ChangeNumberTxt).text = times
      ;
      (ActivityDungeonShopBuyWindow.SetBuyConsume)(times)
    end
  end
)
  ;
  ((uis.AddBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV, uis, ActivityDungeonShopBuyWindow, itemID
    local times = tonumber((uis.ChangeNumberTxt).text) + 1
    local maxPhysical = (ActivityDungeonShopBuyWindow.GetMaxPhysicalTimes)()
    if maxPhysical <= tonumber((uis.ChangeNumberTxt).text) and itemID == AssetType.PHYSICAL then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
      return 
    end
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

    if (ActivityDungeonShopBuyWindow.CheckIsSatisfiedTimes)(times, true) then
      (uis.ChangeNumberTxt).text = times
      ;
      (ActivityDungeonShopBuyWindow.SetBuyConsume)(times)
    end
  end
)
  ;
  ((uis.Add10Btn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : ActivityDungeonShopBuyWindow, _ENV, uis, itemID, buyData
    local maxTime = (ActivityDungeonShopBuyWindow.GetMaxBuyTimes)()
    local maxPhysical = (ActivityDungeonShopBuyWindow.GetMaxPhysicalTimes)()
    maxTime = (math.min)(maxTime, maxPhysical)
    local cutTime = tonumber((uis.ChangeNumberTxt).text)
    if maxPhysical <= cutTime and itemID == AssetType.PHYSICAL then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
      return 
    end
    local times = (math.min)(cutTime + 10, maxTime)
    if maxTime < buyData.MaxNum and cutTime == maxTime then
      local itemId = (ActivityDungeonShopBuyWindow.GetConsumptionIdAndNum)(cutTime)
      local asset = ((TableData.gTable).BaseAssetData)[tonumber(itemId)]
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000125, asset.name))
      return 
    end
    do
      if not (ActivityDungeonShopBuyWindow.CheckIsSatisfiedTimes)(times, maxTime == cutTime) then
        times = maxTime
      end
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.ChangeNumberTxt).text = times
      ;
      (ActivityDungeonShopBuyWindow.SetBuyConsume)(times)
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
)
  ;
  ((uis.MaxBtn).onClick):Set(function(...)
    -- function num : 0_1_3 , upvalues : ActivityDungeonShopBuyWindow, _ENV, uis, itemID
    local maxTime = (ActivityDungeonShopBuyWindow.GetMaxBuyTimes)()
    local maxPhysical = (ActivityDungeonShopBuyWindow.GetMaxPhysicalTimes)()
    maxTime = (math.min)(maxTime, maxPhysical)
    local cutTime = tonumber((uis.ChangeNumberTxt).text)
    if maxPhysical <= cutTime and itemID == AssetType.PHYSICAL then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
      return 
    end
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.ChangeNumberTxt).text = maxTime
    ;
    (ActivityDungeonShopBuyWindow.SetBuyConsume)(tonumber((uis.ChangeNumberTxt).text))
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_4 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ActivityDungeonShopBuyWindow).name)
  end
)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BuyBtn).text = (PUtil.get)(20000079)
  ;
  ((uis.BuyBtn).onClick):Set(function(...)
    -- function num : 0_1_5 , upvalues : ActivityDungeonShopBuyWindow, _ENV, uis, buyData, _currentType
    local itemId, Num, getId, getNum, type = (ActivityDungeonShopBuyWindow.GetConsumptionIdAndNum)(tonumber((uis.ChangeNumberTxt).text))
    ;
    (MessageMgr.OpenCostResConfirmWindow)(60000523, type .. ":" .. itemId .. ":" .. Num, function(...)
      -- function num : 0_1_5_0 , upvalues : _ENV, buyData, _currentType, getNum, uis
      local PoolData = ((TableData.gTable).BaseShopPoolData)[buyData.poolID]
      local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, buyData.buyTime)
      if _currentType == PropType.EQUIP and (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Shop, nil, true) then
        return 
      end
      if tonumber(str[2]) == AssetType.PHYSICAL then
        local FixedData = ((TableData.gTable).BaseFixedData)[Const.MaxPhysicalFixedID]
        local configData = split(FixedData.array_value, ":")
        local max = tonumber(configData[2])
        local possess = (ActorData.GetAssetCount)(AssetType.PHYSICAL)
        if max < possess + getNum then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000290))
          return 
        end
      end
      do
        ;
        (ShopService.OnReqShopBuy)(buyData.shopType, buyData.poolID, buyData.gridID, tonumber((uis.ChangeNumberTxt).text))
      end
    end
, nil, function(...)
      -- function num : 0_1_5_1 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.ActivityDungeonShopBuyWindow).name)
    end
, true, (uis.ItemNameTxt).text)
  end
)
end

ActivityDungeonShopBuyWindow.GetMaxPhysicalTimes = function(...)
  -- function num : 0_2 , upvalues : buyData, _ENV
  local maxTime = buyData.MaxNum
  local PoolData = ((TableData.gTable).BaseShopPoolData)[buyData.poolID]
  local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, 1)
  if tonumber(str[2]) ~= AssetType.PHYSICAL then
    return maxTime
  end
  local FixedData = ((TableData.gTable).BaseFixedData)[Const.MaxPhysicalFixedID]
  local configData = split(FixedData.array_value, ":")
  local max = tonumber(configData[2])
  local remain = max - (ActorData.GetAssetCount)(AssetType.PHYSICAL)
  local count = 0
  for i = 1, maxTime do
    local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, i - 1)
    count = count + tonumber(str[3])
    if remain < count then
      return (math.max)(i - 1, 1)
    end
  end
  return maxTime
end

ActivityDungeonShopBuyWindow.GetMaxBuyTimes = function(...)
  -- function num : 0_3 , upvalues : buyData, ActivityDungeonShopBuyWindow, _ENV
  local maxTime = buyData.MaxNum
  while 1 do
    while 1 do
      if maxTime > 0 then
        local itemId, Num = (ActivityDungeonShopBuyWindow.GetConsumptionIdAndNum)(maxTime)
        local haveNum = (ActorData.GetAssetCount)(tonumber(itemId))
        if tonumber(itemId) == AssetType.DIAMOND_BIND then
          haveNum = (ActorData.GetAssetCount)(AssetType.DIAMOND) + haveNum
        end
        if Num <= haveNum then
          do return maxTime end
          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    maxTime = maxTime - 1
  end
  do
    return 1
  end
end

ActivityDungeonShopBuyWindow.CheckIsSatisfiedTimes = function(times, isShowTips, ...)
  -- function num : 0_4 , upvalues : _ENV, buyData, ActivityDungeonShopBuyWindow
  if times <= 0 then
    if isShowTips then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000076))
    end
    return false
  else
    if buyData.MaxNum < times then
      if isShowTips then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000077))
      end
      return false
    else
      local itemId, Num = (ActivityDungeonShopBuyWindow.GetConsumptionIdAndNum)(times)
      local haveNum = (ActorData.GetAssetCount)(tonumber(itemId))
      local asset = ((TableData.gTable).BaseAssetData)[tonumber(itemId)]
      if tonumber(itemId) == AssetType.DIAMOND_BIND then
        haveNum = (ActorData.GetAssetCount)(AssetType.DIAMOND) + haveNum
      end
      if haveNum < Num then
        if isShowTips then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000125, asset.name))
        end
        return false
      end
    end
  end
  do
    return true
  end
end

ActivityDungeonShopBuyWindow.SetBuyConsume = function(times, ...)
  -- function num : 0_5 , upvalues : ActivityDungeonShopBuyWindow, _ENV, uis
  local itemId, Num, getID, getNum, propType = (ActivityDungeonShopBuyWindow.GetConsumptionIdAndNum)(times)
  itemId = tonumber(itemId)
  local pData = ((TableData.gTable).BaseAssetData)[itemId]
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.OneLoader).url = (Util.GetItemUrl)(pData.icon)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.OneLoader).visible = Num > 0
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

  if Num <= 0 then
    (uis.OneTxt).text = (PUtil.get)(20000281)
  else
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R7 in 'UnsetPending'

    (uis.OneTxt).text = Num
  end
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

  if propType == PropType.ASSET and not (Util.CheckAssetEnough)(itemId, Num) then
    (uis.OneTxt).color = Const.LackColorRGB
  else
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

    (uis.OneTxt).color = Const.EnoughColorRGB
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

ActivityDungeonShopBuyWindow.GetConsumptionIdAndNum = function(times, ...)
  -- function num : 0_6 , upvalues : _ENV, buyData
  local PoolData = ((TableData.gTable).BaseShopPoolData)[buyData.poolID]
  local consumeConfigs = ((Util.ParseConfigStr)(PoolData.sell_price))[1]
  local costNum = 0
  local getNum = 0
  local costType = nil
  for i = 1, times do
    local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.sell_price, buyData.buyTime + i - 1)
    costNum = costNum + tonumber(str[3])
    costType = tonumber(str[1])
    local getStr = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, buyData.buyTime + i - 1)
    getNum = getNum + tonumber(getStr[3])
  end
  return consumeConfigs[2], costNum, tonumber(consumeConfigs[1]), getNum, costType
end

ActivityDungeonShopBuyWindow.InitBasicInformation = function(...)
  -- function num : 0_7 , upvalues : _ENV, buyData, uis, _currentType
  local PoolData = ((TableData.gTable).BaseShopPoolData)[buyData.poolID]
  local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, buyData.buyTime)
  local Number = str[3]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  local itemData, type = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.ItemLoader).url = (Util.GetItemUrl)(itemData.icon)
  _currentType = type
  if type == PropType.EQUIP then
    (CommonWinMgr.RegisterItemLongPress)(uis.ItemLoader, itemData.id)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (uis.HaveNumberGrp).visible = false
  else
    if type == PropType.ITEM and (itemData.type == PropItemType.CHARACTER_DEBRIS or itemData.type == PropItemType.UNIVERSAL_DEBRIS) then
      (CommonWinMgr.RegisterItemLongPress)(uis.ItemLoader, itemData.id)
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (uis.HaveNumberGrp).visible = true
    else
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (uis.HaveNumberGrp).visible = true
    end
  end
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.ItemNameTxt).text = itemData.name
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.HaveNumberTxt).text = (ActorData.GetGoodsCount)(itemData.id, type)
  local DesText = uis.ItemWordTxt
  DesText.UBBEnabled = true
  DesText.text = itemData.remark
end

ActivityDungeonShopBuyWindow.SetNeedCardList = function(...)
  -- function num : 0_8 , upvalues : buyData
  if not buyData.needCards or #buyData.needCards > 0 then
  end
end

ActivityDungeonShopBuyWindow.OnShown = function(...)
  -- function num : 0_9 , upvalues : ActivityDungeonShopBuyWindow, _ENV, uis, buyData
  (ActivityDungeonShopBuyWindow.InitBasicInformation)()
  ;
  (ActivityDungeonShopBuyWindow.SetBuyConsume)(tonumber((uis.ChangeNumberTxt).text))
  -- DECOMPILER ERROR at PC29: Unhandled construct in 'MakeBoolean' P3

  if (#buyData.needCards == 0 and buyData.MaxNum == 1 and #buyData.needCards ~= 0) or #buyData.needCards > 0 then
    (ActivityDungeonShopBuyWindow.SetNeedCardList)()
  end
end

ActivityDungeonShopBuyWindow.OnHide = function(...)
  -- function num : 0_10
end

ActivityDungeonShopBuyWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : uis, contentPane, argTable, buyData
  uis = nil
  contentPane = nil
  argTable = {}
  buyData = nil
end

ActivityDungeonShopBuyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return ActivityDungeonShopBuyWindow

