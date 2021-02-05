-- params : ...
-- function num : 0 , upvalues : _ENV
require("Prize_PrizeRewardShowByName")
local PrizeRewardShowWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local data, timer1, timer2 = nil, nil, nil
local count = 0
PrizeRewardShowWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, data, uis, PrizeRewardShowWindow
  bridgeObj:SetView((WinResConfig.PrizeRewardShowWindow).package, (WinResConfig.PrizeRewardShowWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  data = argTable[1]
  uis = GetPrize_PrizeRewardShowUis(contentPane)
  ;
  ((GRoot.inst).onClick):Add(PrizeRewardShowWindow.SetRootClick)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ItemIconList).itemRenderer = PrizeRewardShowWindow.ItemRenderer
  ;
  (PrizeRewardShowWindow.RefreshList)()
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(20000224)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : PrizeRewardShowWindow, _ENV
    if (PrizeRewardShowWindow.TimerIsPause)() then
      UIMgr:CloseWindow((WinResConfig.PrizeRewardShowWindow).name)
    end
  end
)
end

PrizeRewardShowWindow.RefreshList = function(...)
  -- function num : 0_1 , upvalues : uis, data, _ENV, count, timer1, timer2
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ItemIconList).numItems = #data
  ;
  (SimpleTimer.setTimeout)(0.4, function(...)
    -- function num : 0_1_0 , upvalues : count, timer1, _ENV, data, uis, timer2
    count = 0
    timer1 = (SimpleTimer.new)(0.5, #data, function(...)
      -- function num : 0_1_0_0 , upvalues : _ENV, count, uis, timer1
      local scollIndex = (math.max)(0, count - 3 + 1)
      ;
      (uis.ItemIconList):ScrollToView(scollIndex, true, true)
      local obj = (uis.ItemIconList):GetChildAt(count)
      obj.visible = true
      count = count + 1
      PlayUITrans(obj, "up")
      if uis.ItemIconList == nil then
        timer1:stop()
        return 
      end
    end
)
    timer2 = (SimpleTimer.new)(0.03, #data - count, function(...)
      -- function num : 0_1_0_1 , upvalues : _ENV, count, uis, data, timer2
      local scollIndex = (math.max)(0, count - 3 + 1)
      ;
      (uis.ItemIconList):ScrollToView(scollIndex, true, true)
      local obj = (uis.ItemIconList):GetChildAt(count)
      obj.visible = true
      count = count + 1
      if #data == count then
        timer2:stop()
      end
    end
)
    timer1:start()
  end
)
end

PrizeRewardShowWindow.SetRootClick = function(...)
  -- function num : 0_2 , upvalues : timer1, timer2
  if timer1:IsRunIng() then
    timer1:stop()
    timer2:start()
  end
end

PrizeRewardShowWindow.TimerIsPause = function(...)
  -- function num : 0_3 , upvalues : timer1
  do return (not timer1.isRun and not timer1.isRun) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

PrizeRewardShowWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_4 , upvalues : data, _ENV
  local mData = data[index + 1]
  local Item = obj:GetChild("Reward")
  local title = Item:GetChild("NameTxt")
  local list = Item:GetChild("ItemList")
  local PoolData = ((TableData.gTable).BaseSlotsPoolData)[mData.poolId]
  local reward = (split(PoolData.reward, ":"))
  local goods = nil
  if PoolData.intelligence == 1 then
    ChangeUIController(Item, "c1", 2)
    goods = Item:GetChild("PrizeItemB")
  else
    if PoolData.intelligence == 2 then
      ChangeUIController(Item, "c1", 1)
      goods = Item:GetChild("PrizeItemA")
    else
      if PoolData.intelligence == 3 then
        ChangeUIController(Item, "c1", 0)
        goods = Item:GetChild("PrizeItemS")
      else
        ChangeUIController(Item, "c1", 3)
        goods = Item:GetChild("PrizeItemLast")
      end
    end
  end
  if PoolData.group_name and not (Util.StringIsNullOrEmpty)(PoolData.group_name) then
    title.text = PoolData.group_name
  else
    local configData = (Util.GetConfigDataByID)(tonumber(reward[2]))
    title.text = configData.name
  end
  do
    if PoolData.group_icon and not (Util.StringIsNullOrEmpty)(PoolData.group_icon) then
      (goods:GetChild("ItemLoader")).url = (Util.GetItemUrl)(PoolData.group_icon)
    else
      ;
      (goods:GetChild("ItemLoader")).url = (Util.GetIconPathByID)(tonumber(reward[2]))
    end
    ;
    (goods:GetChild("NumberTxt")).text = reward[3]
    list:RemoveChildrenToPool()
    for _,v in ipairs(mData.goods) do
      local one = list:AddItemFromPool()
      ;
      (Util.SetAllItemIcon)(one, v.id, v.value)
    end
    obj.visible = false
  end
end

PrizeRewardShowWindow.OnShown = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis, contentPane
  (Util.PlayUIEffect)(uis, contentPane, 1)
end

PrizeRewardShowWindow.OnHide = function(...)
  -- function num : 0_6
end

PrizeRewardShowWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : _ENV, PrizeRewardShowWindow, uis, contentPane, argTable, timer1, timer2, count
  ((GRoot.inst).onClick):Remove(PrizeRewardShowWindow.SetRootClick)
  uis = nil
  contentPane = nil
  argTable = {}
  timer1 = nil
  timer2 = nil
  count = 0
end

PrizeRewardShowWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8
end

return PrizeRewardShowWindow

