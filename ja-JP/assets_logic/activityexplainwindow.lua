-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_ExplainByName")
local ActivityExplainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local picData = {}
local curPicIndex = 1
local lastPicIndex = 1
local MAXNUM = 0
local itemX = nil
ActivityExplainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, curPicIndex, lastPicIndex, picData, MAXNUM, ActivityExplainWindow, itemX
  bridgeObj:SetView((WinResConfig.ActivityExplainWindow).package, (WinResConfig.ActivityExplainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetActivityDungeon_ExplainUis(contentPane)
  curPicIndex = 1
  lastPicIndex = 1
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ActivityExplainWindow).name)
  end
)
  local test = (((TableData.gTable).BaseActivityData)[(ActivityDungeonData.GetCurrentActivityDungeonId)()]).pic
  for index,value in ipairs(split(test, ",")) do
    (table.insert)(picData, value)
  end
  MAXNUM = #split(test, ",")
  ;
  (ActivityExplainWindow.RefreshPic)()
  ;
  (((uis.PicList).scrollPane).onScroll):Add(function(...)
    -- function num : 0_0_1 , upvalues : uis
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (uis.LeftBtn).touchable = false
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.RightBtn).touchable = false
  end
)
  ;
  (((uis.PicList).scrollPane).onScrollEnd):Add(function(...)
    -- function num : 0_0_2 , upvalues : uis, curPicIndex, _ENV, itemX, lastPicIndex, MAXNUM, ActivityExplainWindow
    local x = ((uis.PicList).scrollPane).posX
    curPicIndex = (math.ceil)(x / (itemX + (uis.PicList).columnGap)) + 1
    do
      if lastPicIndex ~= curPicIndex then
        local item = nil
        if curPicIndex == MAXNUM then
          item = (uis.PicList):GetChildAt(1)
        else
          item = (uis.PicList):GetChildAt(0)
        end
      end
      lastPicIndex = curPicIndex
      ;
      (ActivityExplainWindow.CheckArrow)()
      ;
      (ActivityExplainWindow.SetPageShow)()
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.LeftBtn).touchable = true
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.RightBtn).touchable = true
    end
  end
)
  ;
  (ActivityExplainWindow.CheckArrow)()
  ;
  (ActivityExplainWindow.InitPageList)()
  ;
  ((uis.LeftBtn).onClick):Set(function(...)
    -- function num : 0_0_3 , upvalues : uis, curPicIndex
    (uis.PicList):ScrollToView(curPicIndex - 2, true)
  end
)
  ;
  ((uis.RightBtn).onClick):Set(function(...)
    -- function num : 0_0_4 , upvalues : uis, curPicIndex
    (uis.PicList):ScrollToView(curPicIndex, true)
  end
)
end

ActivityExplainWindow.RefreshPic = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, picData, itemX
  (uis.PicList):RemoveChildrenToPool()
  for index,value in ipairs(picData) do
    local item = (uis.PicList):AddItemFromPool()
    ;
    (item:GetChild("PicLoader")).url = (UIPackage.GetItemURL)((split(value, ":"))[1], (split(value, ":"))[2])
    if itemX == nil then
      itemX = item.width
    end
  end
end

ActivityExplainWindow.InitPageList = function(...)
  -- function num : 0_2 , upvalues : uis, MAXNUM, ActivityExplainWindow
  (uis.PageNumberList):RemoveChildrenToPool()
  for i = 1, MAXNUM do
    (uis.PageNumberList):AddItemFromPool()
  end
  ;
  (ActivityExplainWindow.SetPageShow)()
end

ActivityExplainWindow.SetPageShow = function(...)
  -- function num : 0_3 , upvalues : MAXNUM, uis, curPicIndex, _ENV
  for i = 1, MAXNUM do
    local obj = (uis.PageNumberList):GetChildAt(i - 1)
    if i == curPicIndex then
      ChangeUIController(obj, "c1", 1)
    else
      ChangeUIController(obj, "c1", 0)
    end
  end
end

ActivityExplainWindow.CheckArrow = function(...)
  -- function num : 0_4 , upvalues : uis, curPicIndex, MAXNUM
  if uis.LeftBtn == nil or uis.RightBtn == nil then
    return 
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if curPicIndex == 1 then
    (uis.LeftBtn).visible = false
  else
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.LeftBtn).visible = true
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  if curPicIndex == MAXNUM then
    (uis.RightBtn).visible = false
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.RightBtn).visible = true
  end
end

ActivityExplainWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable, itemX, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  itemX = nil
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ActivityExplainWindow).name)
end

return ActivityExplainWindow

