-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_BuyWindowByName")
local NewActivityDungeonShopBuyWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
NewActivityDungeonShopBuyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, NewActivityDungeonShopBuyWindow
  bridgeObj:SetView((WinResConfig.NewActivityDungeonShopBuyWindow).package, (WinResConfig.NewActivityDungeonShopBuyWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivityDungeonTwo_BuyWindowUis(contentPane)
  uis = uis.Buy
  ;
  (NewActivityDungeonShopBuyWindow.InitText)()
  ;
  (NewActivityDungeonShopBuyWindow.InitButtonEvent)()
end

NewActivityDungeonShopBuyWindow.InitText = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.BuyBtn).text = (PUtil.get)(20000079)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.titilenameTxt).text = (PUtil.get)(20000361)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.HaveNumber_01_Txt).text = (PUtil.get)(20000348)
end

NewActivityDungeonShopBuyWindow.InitButtonEvent = function(...)
  -- function num : 0_2 , upvalues : uis, NewActivityDungeonShopBuyWindow
  ((uis.BuyBtn).onClick):Set(NewActivityDungeonShopBuyWindow.ClickBuyBtn)
  ;
  ((uis.ReduceBtn).onClick):Set(NewActivityDungeonShopBuyWindow.ClickReduceBtn)
  ;
  ((uis.AddBtn).onClick):Set(NewActivityDungeonShopBuyWindow.ClickAddBtn)
  ;
  ((uis.Add10Btn).onClick):Set(NewActivityDungeonShopBuyWindow.ClickMultipleAddBtn)
  ;
  ((uis.MaxBtn).onClick):Set(NewActivityDungeonShopBuyWindow.ClickMaxBtn)
  ;
  ((uis.CloseBtn).onClick):Set(NewActivityDungeonShopBuyWindow.ClickCloseBtn)
end

NewActivityDungeonShopBuyWindow.OnShown = function(...)
  -- function num : 0_3 , upvalues : NewActivityDungeonShopBuyWindow
  (NewActivityDungeonShopBuyWindow.Init)()
end

NewActivityDungeonShopBuyWindow.OnHide = function(...)
  -- function num : 0_4
end

NewActivityDungeonShopBuyWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

NewActivityDungeonShopBuyWindow.Init = function(...)
  -- function num : 0_6 , upvalues : NewActivityDungeonShopBuyWindow
  (NewActivityDungeonShopBuyWindow.InitBasicInfo)()
  ;
  (NewActivityDungeonShopBuyWindow.Refresh)(1)
end

NewActivityDungeonShopBuyWindow.InitBasicInfo = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis
  local PoolData = ((TableData.gTable).BaseShopPoolData)[(NewActivityDungeonData.BuyingData).poolID]
  local str = (ShopMgr.GetRangeStr)(PoolData.sell_time, PoolData.item, (NewActivityDungeonData.BuyingData).buyTime)
  local Number = str[3]
  local configItem = ((Util.ParseConfigStr)(PoolData.item))[1]
  local itemData, type = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.ItemLoader).url = (Util.GetItemUrl)(itemData.icon)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

  NewActivityDungeonData.BuyingType = type
  if type == PropType.EQUIP then
    (CommonWinMgr.RegisterItemLongPress)(uis.ItemLoader, itemData.id)
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (uis.HaveNumberGrp).visible = false
  else
    if type == PropType.ITEM and (itemData.type == PropItemType.CHARACTER_DEBRIS or itemData.type == PropItemType.UNIVERSAL_DEBRIS) then
      (CommonWinMgr.RegisterItemLongPress)(uis.ItemLoader, itemData.id)
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (uis.HaveNumberGrp).visible = true
    else
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (uis.HaveNumberGrp).visible = true
    end
  end
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.ItemNameTxt).text = itemData.name
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.HaveNumberTxt).text = (ActorData.GetGoodsCount)(itemData.id, type)
  local DesText = uis.ItemWordTxt
  DesText.UBBEnabled = true
  DesText.text = itemData.remark
end

NewActivityDungeonShopBuyWindow.Refresh = function(times, ...)
  -- function num : 0_8 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.ChangeNumberTxt).text = times
  local itemId, Num, getID, getNum, propType = (NewActivityDungeonData.GetNADConsumptionIdAndNum)(times)
  itemId = tonumber(itemId)
  local pData = ((TableData.gTable).BaseAssetData)[itemId]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.OneLoader).url = (Util.GetItemUrl)(pData.icon)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.OneLoader).visible = Num > 0
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R7 in 'UnsetPending'

  if Num <= 0 then
    (uis.OneTxt).text = (PUtil.get)(20000281)
  else
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

    (uis.OneTxt).text = Num
  end
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R7 in 'UnsetPending'

  if propType == PropType.ASSET and not (Util.CheckAssetEnough)(itemId, Num) then
    (uis.OneTxt).color = Const.LackColorRGB
  else
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

    (uis.OneTxt).color = Const.EnoughColorRGB
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

NewActivityDungeonShopBuyWindow.ClickCloseBtn = function(...)
  -- function num : 0_9 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.NewActivityDungeonShopBuyWindow).name)
end

NewActivityDungeonShopBuyWindow.ClickBuyBtn = function(...)
  -- function num : 0_10 , upvalues : _ENV, uis
  (NewActivityDungeonMgr.NADPurchaseItem)(tonumber((uis.ChangeNumberTxt).text), (uis.ItemNameTxt).text)
end

NewActivityDungeonShopBuyWindow.ClickReduceBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis
  (NewActivityDungeonMgr.ChangeNADPurchaseTime)((uis.ChangeNumberTxt).text, -1, true)
end

NewActivityDungeonShopBuyWindow.ClickAddBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis
  (NewActivityDungeonMgr.ChangeNADPurchaseTime)((uis.ChangeNumberTxt).text, 1, true)
end

NewActivityDungeonShopBuyWindow.ClickMultipleAddBtn = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis
  (NewActivityDungeonMgr.ChangeNADPurchaseTime)((uis.ChangeNumberTxt).text, 10, true)
end

NewActivityDungeonShopBuyWindow.ClickMaxBtn = function(...)
  -- function num : 0_14 , upvalues : _ENV, uis
  (NewActivityDungeonMgr.ChangeNADPurchaseTime)((uis.ChangeNumberTxt).text, 0, true)
end

NewActivityDungeonShopBuyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15 , upvalues : _ENV, NewActivityDungeonShopBuyWindow
  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_PURCHASE_INFO then
    (NewActivityDungeonShopBuyWindow.Refresh)(para)
  end
end

return NewActivityDungeonShopBuyWindow

