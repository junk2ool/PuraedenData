-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_ExplainByName")
local NewActivityExplainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _curPicIndex = 1
local _itemWidth = nil
NewActivityExplainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, NewActivityExplainWindow
  bridgeObj:SetView((WinResConfig.NewActivityExplainWindow).package, (WinResConfig.NewActivityExplainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivityDungeonTwo_ExplainUis(contentPane)
  ;
  (NewActivityExplainWindow.InitButtonEvent)()
end

NewActivityExplainWindow.InitButtonEvent = function(...)
  -- function num : 0_1 , upvalues : uis, NewActivityExplainWindow
  ((uis.CloseBtn).onClick):Set(NewActivityExplainWindow.ClickCloseBtn)
  ;
  ((uis.LeftBtn).onClick):Set(NewActivityExplainWindow.ClickLeftBtn)
  ;
  ((uis.RightBtn).onClick):Set(NewActivityExplainWindow.ClickRightBtn)
  ;
  (((uis.PicList).scrollPane).onScrollEnd):Add(NewActivityExplainWindow.ScrollEndList)
end

NewActivityExplainWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : NewActivityExplainWindow
  (NewActivityExplainWindow.Init)()
end

NewActivityExplainWindow.OnHide = function(...)
  -- function num : 0_3
end

NewActivityExplainWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : _itemWidth, uis, contentPane, argTable
  _itemWidth = nil
  uis = nil
  contentPane = nil
  argTable = {}
end

NewActivityExplainWindow.Init = function(...)
  -- function num : 0_5 , upvalues : NewActivityExplainWindow
  (NewActivityExplainWindow.RefreshPic)()
  ;
  (NewActivityExplainWindow.InitPageList)()
end

NewActivityExplainWindow.RefreshPic = function(...)
  -- function num : 0_6 , upvalues : uis, _ENV, _itemWidth
  (uis.PicList):RemoveChildrenToPool()
  local item = nil
  for index,value in ipairs(NewActivityDungeonData.ADExplainPicData) do
    item = (uis.PicList):AddItemFromPool()
    ;
    (item:GetChild("PicLoader")).url = (UIPackage.GetItemURL)((split(value, ":"))[1], (split(value, ":"))[2])
    if _itemWidth == nil then
      _itemWidth = item.width
    end
  end
end

NewActivityExplainWindow.InitPageList = function(...)
  -- function num : 0_7 , upvalues : uis, _ENV, NewActivityExplainWindow
  (uis.PageNumberList):RemoveChildrenToPool()
  for i = 1, #NewActivityDungeonData.ADExplainPicData do
    (uis.PageNumberList):AddItemFromPool()
  end
  ;
  (NewActivityExplainWindow.SetPageShow)()
end

NewActivityExplainWindow.SetPageShow = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis, _curPicIndex
  for i = 1, #NewActivityDungeonData.ADExplainPicData do
    local obj = (uis.PageNumberList):GetChildAt(i - 1)
    if i == _curPicIndex then
      ChangeUIController(obj, "c1", 1)
    else
      ChangeUIController(obj, "c1", 0)
    end
  end
end

NewActivityExplainWindow.CheckArrow = function(...)
  -- function num : 0_9 , upvalues : uis, _curPicIndex, _ENV
  if uis.LeftBtn == nil or uis.RightBtn == nil then
    return 
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if _curPicIndex == 1 then
    (uis.LeftBtn).visible = false
  else
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.LeftBtn).visible = true
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

  if _curPicIndex == #NewActivityDungeonData.ADExplainPicData then
    (uis.RightBtn).visible = false
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.RightBtn).visible = true
  end
end

NewActivityExplainWindow.ScrollEndList = function(...)
  -- function num : 0_10 , upvalues : uis, _curPicIndex, _ENV, _itemWidth, NewActivityExplainWindow
  local x = ((uis.PicList).scrollPane).posX
  _curPicIndex = (math.ceil)(x / (_itemWidth + (uis.PicList).columnGap)) + 1
  ;
  (NewActivityExplainWindow.CheckArrow)()
  ;
  (NewActivityExplainWindow.SetPageShow)()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.LeftBtn).touchable = true
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.RightBtn).touchable = true
end

NewActivityExplainWindow.ClickCloseBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.NewActivityExplainWindow).name)
end

NewActivityExplainWindow.ClickLeftBtn = function(...)
  -- function num : 0_12 , upvalues : uis, _curPicIndex
  (uis.PicList):ScrollToView(_curPicIndex - 2, true)
end

NewActivityExplainWindow.ClickRightBtn = function(...)
  -- function num : 0_13 , upvalues : uis, _curPicIndex
  (uis.PicList):ScrollToView(_curPicIndex, true)
end

NewActivityExplainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14
end

return NewActivityExplainWindow

