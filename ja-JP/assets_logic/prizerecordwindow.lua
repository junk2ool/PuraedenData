-- params : ...
-- function num : 0 , upvalues : _ENV
require("Prize_RecordByName")
local PrizeRecordWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local recordData = {}
PrizeRecordWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, recordData, uis, PrizeRecordWindow
  bridgeObj:SetView((WinResConfig.PrizeRecordWindow).package, (WinResConfig.PrizeRecordWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  local Data = argTable[1]
  local recordDataTemp = {}
  recordData = {}
  for _,v in ipairs(Data) do
    if recordDataTemp[v.time] == nil then
      recordDataTemp[v.time] = {}
    end
    ;
    (table.insert)(recordDataTemp[v.time], v)
  end
  for _,v in pairs(recordDataTemp) do
    (table.insert)(recordData, v)
  end
  ;
  (table.sort)(recordData, function(a, b, ...)
    -- function num : 0_0_0
    do return (b[1]).time < (a[1]).time end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  uis = GetPrize_RecordUis(contentPane)
  ;
  (PrizeRecordWindow.InitAssetStrip)()
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.TipsList).itemRenderer = PrizeRecordWindow.ListRenderer
  ;
  (uis.TipsList):SetVirtual()
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.TipsList).numItems = #recordData
end

PrizeRecordWindow.ListRenderer = function(index, obj, ...)
  -- function num : 0_1 , upvalues : recordData, _ENV
  local data = recordData[index + 1]
  if data == nil then
    return 
  end
  local time = obj:GetChild("WordTxt")
  time.text = (PUtil.get)(20000639, (LuaTime.GetFormatTimeStr)("(%Y/%m/%d)", (data[1]).time))
  local list = obj:GetChild("ItemList")
  list.numItems = 0
  for _,v in ipairs(data) do
    local PoolData = ((TableData.gTable).BaseSlotsPoolData)[v.poolId]
    for _,v2 in ipairs(v.goods) do
      local obj = nil
      if PoolData.intelligence == 1 then
        obj = UIMgr:CreateObject("Prize", "PrizeItemB")
      else
        if PoolData.intelligence == 2 then
          obj = UIMgr:CreateObject("Prize", "PrizeItemA")
        else
          if PoolData.intelligence == 3 then
            obj = UIMgr:CreateObject("Prize", "PrizeItemS")
          else
            obj = UIMgr:CreateObject("Prize", "PrizeItemLast")
          end
        end
      end
      local name = obj:GetChild("NameTxt")
      local icon = obj:GetChild("ItemLoader")
      local Number = obj:GetChild("NumberTxt")
      name.visible = false
      if PoolData.group_icon and not (Util.StringIsNullOrEmpty)(PoolData.group_icon) then
        icon.url = (Util.GetItemUrl)(PoolData.group_icon)
      else
        icon.url = (Util.GetIconPathByID)(tonumber(v2.id))
      end
      Number.text = v2.value
      list:AddChild(obj)
      if PoolData.tip_id and PoolData.tip_id > 0 then
        (CommonWinMgr.RegisterItemLongPress)(obj, tonumber(PoolData.tip_id))
      else
        ;
        (CommonWinMgr.RegisterItemLongPress)(obj, tonumber(v2.id))
      end
    end
  end
end

PrizeRecordWindow.OnShown = function(...)
  -- function num : 0_2
end

PrizeRecordWindow.OnHide = function(...)
  -- function num : 0_3
end

PrizeRecordWindow.InitAssetStrip = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.PrizeRecordWindow).name
  m.Tip = (PUtil.get)(20000636)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

PrizeRecordWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.PrizeRecordWindow).name)
end

PrizeRecordWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

return PrizeRecordWindow

