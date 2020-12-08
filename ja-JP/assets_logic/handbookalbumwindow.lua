-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_AlbumByName")
require("HandBook_AlbumCGByName")
local HandBookAlbumWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local winType = {Main = 1, Branch = 2, Activity = 3}
local OpenType = winType.Main
local listData = {}
local isInit = true
HandBookAlbumWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, isInit, uis, HandBookAlbumWindow
  bridgeObj:SetView((WinResConfig.HandBookAlbumWindow).package, (WinResConfig.HandBookAlbumWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  isInit = true
  uis = GetHandBook_AlbumUis(contentPane)
  ;
  (HandBookAlbumWindow.InitAssetStrip)()
  ;
  (HandBookAlbumWindow.InitBtn)()
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.AlbumCGList).CGList).itemRenderer = HandBookAlbumWindow.ListRender
  ;
  ((uis.AlbumCGList).CGList):SetBeginAnim(false, "up", 0.05, 0.05, true)
  ;
  ((uis.AlbumCGList).CGList):SetVirtual()
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.AlbumActivityCG).CGList).itemRenderer = HandBookAlbumWindow.SetActivityListRender
  ;
  ((uis.AlbumActivityCG).CGList):SetVirtual()
  ;
  (HandBookAlbumWindow.BindingUI)()
  ;
  (((uis.AlbumPanelGrp).MuJianBtn).onClick):Call()
end

HandBookAlbumWindow.BindingUI = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.HandBookAlbumWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.HandBook_Collection_Album, (uis.AlbumPanelGrp).MuJianBtn)
  BindingUI(winName, RedDotComID.HandBook_Collection_Album_Activity, (uis.AlbumPanelGrp).ShouXinBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

HandBookAlbumWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : OpenType, winType, uis, HandBookAlbumWindow
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  if OpenType == winType.Main then
    ((uis.AlbumPanelGrp).c1Ctr).selectedIndex = 0
    ;
    (((uis.AlbumPanelGrp).MuJianBtn).onClick):Call()
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.AlbumPanelGrp).c1Ctr).selectedIndex = 1
    ;
    (((uis.AlbumPanelGrp).ShouXinBtn).onClick):Call()
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.AlbumPanelGrp).root).visible = (HandBookAlbumWindow.GetCountNum)(winType.Activity) > 0
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HandBookAlbumWindow.GetCountNum = function(type, ...)
  -- function num : 0_3 , upvalues : _ENV
  local count = 0
  local data = (TableData.gTable).BaseHandbookCGData
  for _,v in pairs(data) do
    if v.type == type then
      count = count + 1
    end
  end
  return count
end

HandBookAlbumWindow.SetCollectionNum = function(...)
  -- function num : 0_4 , upvalues : _ENV, OpenType, winType, uis, listData
  local num = (HandBookMgr.GetAlbumCollectionNumByType)(OpenType)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  if num == 0 then
    if OpenType == winType.Activity then
      (uis.NumberTxt).text = (PUtil.get)(20000135, num, #listData)
    else
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.NumberTxt).text = (PUtil.get)(20000511, num, #listData)
    end
  else
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

    if OpenType == winType.Activity then
      (uis.NumberTxt).text = (PUtil.get)(20000152, num, #listData)
    else
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.NumberTxt).text = (PUtil.get)(20000510, num, #listData)
    end
  end
end

HandBookAlbumWindow.RefreshList = function(...)
  -- function num : 0_5 , upvalues : listData, _ENV, OpenType, winType, uis, HandBookAlbumWindow
  listData = {}
  local data = (TableData.gTable).BaseHandbookCGData
  local activityList = {}
  for _,v in pairs(data) do
    if tonumber(v.type) == OpenType then
      if OpenType == winType.Branch then
        local cardData = ((TableData.gTable).BaseCardData)[v.chapter_id]
        if cardData and cardData.is_handbookstage_open == 1 then
          (table.insert)(listData, v)
        end
      else
        do
          if not v.open_time then
            local configTime = OpenType ~= winType.Activity or 0
          end
          local serverTime = (LuaTime.GetTimeStamp)()
          local isSatisfy = tonumber(configTime) <= tonumber(serverTime)
          do
            do
              if isSatisfy then
                local activity_sort = v.activity_sort
                if activityList[activity_sort] == nil then
                  activityList[activity_sort] = {}
                end
                ;
                (table.insert)(activityList[activity_sort], v)
              end
              if OpenType == winType.Main then
                (table.insert)(listData, v)
              end
              -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  if OpenType == winType.Activity then
    for i,v in pairs(activityList) do
      local mList = v
      ;
      (table.sort)(mList, function(a, b, ...)
    -- function num : 0_5_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      ;
      (table.insert)(listData, {sort = i, list = mList})
    end
    ;
    (table.sort)(listData, function(a, b, ...)
    -- function num : 0_5_1
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    -- DECOMPILER ERROR at PC114: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.AlbumActivityCG).CGList).numItems = #listData
    -- DECOMPILER ERROR at PC116: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 1
    ;
    (((uis.AlbumActivityCG).CGList).scrollPane):ScrollBottom()
  else
    (table.sort)(listData, function(a, b, ...)
    -- function num : 0_5_2
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    -- DECOMPILER ERROR at PC132: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.AlbumCGList).CGList).numItems = #listData
    -- DECOMPILER ERROR at PC134: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 0
  end
  ;
  (HandBookAlbumWindow.SetCollectionNum)()
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

HandBookAlbumWindow.CheckRedDot = function(...)
  -- function num : 0_6 , upvalues : OpenType, winType, _ENV, HandBookAlbumWindow
  if OpenType == winType.Main then
    (RedDotMgr.EliminateRedDot)((WinResConfig.HandBookAlbumWindow).name, RedDotComID.HandBook_Collection_Album)
  else
    ;
    (RedDotMgr.EliminateRedDot)((WinResConfig.HandBookAlbumWindow).name, RedDotComID.HandBook_Collection_Album_Activity)
  end
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_6_0 , upvalues : HandBookAlbumWindow
    (HandBookAlbumWindow.DeleteNewLabel)()
  end
)
end

HandBookAlbumWindow.DeleteNewLabel = function(...)
  -- function num : 0_7 , upvalues : _ENV, listData
  for _,v in ipairs(listData) do
    local isGet, isNew = (HandBookMgr.GetAlbumState)(v.id)
    if isNew and isGet then
      (HandBookMgr.SetAlbumNotNew)(v.id)
    end
  end
end

HandBookAlbumWindow.CheckIsContainNew = function(...)
  -- function num : 0_8 , upvalues : _ENV, listData
  for _,v in ipairs(listData) do
    local isGet, isNew = (HandBookMgr.GetAlbumState)(v.id)
    if isNew then
      return true
    end
  end
  return false
end

HandBookAlbumWindow.SetActivityListRender = function(index, obj, ...)
  -- function num : 0_9 , upvalues : listData, _ENV, isInit
  local data = listData[index + 1]
  local AlbumList = data.list
  local mList = obj:GetChild("CGList")
  mList:RemoveChildrenToPool()
  local possessTime = 0
  local activity_name = nil
  for i,v in ipairs(AlbumList) do
    do
      local album = mList:AddItemFromPool()
      if isInit then
        album.alpha = 0
        ;
        (SimpleTimer.setTimeout)(0.05 * i, function(...)
    -- function num : 0_9_0 , upvalues : album, _ENV
    album.alpha = 1
    PlayUITrans(album, "up", nil)
  end
)
      end
      local isGet, isNew = (HandBookMgr.GetAlbumState)(v.id)
      local albumObj = album:GetChild("AlbumCG")
      local model = GetHandBook_AlbumCGUis(albumObj)
      ;
      (albumObj:GetChild("IconImage")).url = (Util.GetItemUrl)(v.icon)
      ChangeUIController(albumObj, "c2", 0)
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R17 in 'UnsetPending'

      ;
      (model.NumberTxt).text = "No." .. (string.format)("%03d", v.index)
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R17 in 'UnsetPending'

      if isGet then
        (model.WordTxt).text = v.name
      end
      if isGet then
        possessTime = possessTime + 1
        ChangeUIController(albumObj, "c1", 0)
      else
        ChangeUIController(albumObj, "c1", 1)
      end
      if isNew then
        ChangeUIController(albumObj, "c3", 0)
      else
        ChangeUIController(albumObj, "c3", 1)
      end
      ;
      (albumObj.onClick):Set(function(...)
    -- function num : 0_9_1 , upvalues : isGet, isNew, _ENV, v, albumObj
    if isGet then
      if isNew then
        (HandBookService.OnReqOpenCG)(v.id)
        ChangeUIController(albumObj, "c3", 1)
      end
      ;
      (CommonWinMgr.OpenCGShow)(v.id, false)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(20000507))
    end
  end
)
      activity_name = v.activity_name
    end
  end
  mList.height = (math.ceil)(#AlbumList / 4) * 170
  if possessTime > 0 then
    (obj:GetChild("NumberTxt")).text = activity_name .. "  [color=#3dffbd]" .. possessTime .. "[/color]/" .. #AlbumList
  else
    ;
    (obj:GetChild("NumberTxt")).text = activity_name .. "  " .. possessTime .. "/" .. #AlbumList
  end
end

HandBookAlbumWindow.ListRender = function(index, obj, ...)
  -- function num : 0_10 , upvalues : listData, _ENV, OpenType, winType
  local data = listData[index + 1]
  local isGet, isNew = nil, nil
  obj = obj:GetChild("AlbumCG")
  local model = GetHandBook_AlbumCGUis(obj)
  ;
  (obj:GetChild("IconImage")).url = (Util.GetItemUrl)(data.icon)
  ChangeUIController(obj, "c2", 0)
  isGet = (HandBookMgr.GetAlbumState)(data.id)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

  if OpenType == winType.Main or OpenType == winType.Activity then
    (model.NumberTxt).text = "No." .. (string.format)("%03d", data.index)
  else
    local cardData = ((TableData.gTable).BaseCardData)[data.chapter_id]
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (model.NumberTxt).text = cardData.name
  end
  do
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

    if isGet then
      (model.WordTxt).text = data.name
    end
    if isGet then
      ChangeUIController(obj, "c1", 0)
    else
      ChangeUIController(obj, "c1", 1)
    end
    if isNew then
      ChangeUIController(obj, "c3", 0)
    else
      ChangeUIController(obj, "c3", 1)
    end
    ;
    (obj.onClick):Set(function(...)
    -- function num : 0_10_0 , upvalues : isGet, isNew, _ENV, data, obj, OpenType, winType
    if isGet then
      if isNew then
        (HandBookService.OnReqOpenCG)(data.id)
        ChangeUIController(obj, "c3", 1)
      end
      ;
      (CommonWinMgr.OpenCGShow)(data.id, false)
    else
      if OpenType == winType.Activity then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000507))
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000246))
      end
    end
  end
)
  end
end

HandBookAlbumWindow.OnHide = function(...)
  -- function num : 0_11
end

HandBookAlbumWindow.InitBtn = function(...)
  -- function num : 0_12 , upvalues : uis, _ENV, OpenType, winType, HandBookAlbumWindow, isInit
  (((uis.AlbumPanelGrp).MuJianBtn):GetChild("NameTxt")).text = (PUtil.get)(20000253)
  ;
  (((uis.AlbumPanelGrp).MuJianBtn).onClick):Set(function(...)
    -- function num : 0_12_0 , upvalues : OpenType, winType, HandBookAlbumWindow
    OpenType = winType.Main
    ;
    (HandBookAlbumWindow.RefreshList)()
    ;
    (HandBookAlbumWindow.CheckRedDot)()
  end
)
  ;
  (((uis.AlbumPanelGrp).ShouXinBtn):GetChild("NameTxt")).text = (PUtil.get)(20000506)
  ;
  (((uis.AlbumPanelGrp).ShouXinBtn).onClick):Set(function(...)
    -- function num : 0_12_1 , upvalues : OpenType, winType, isInit, HandBookAlbumWindow, _ENV
    OpenType = winType.Activity
    isInit = true
    ;
    (HandBookAlbumWindow.RefreshList)()
    ;
    (HandBookAlbumWindow.CheckRedDot)()
    ;
    (SimpleTimer.setTimeout)(0.01, function(...)
      -- function num : 0_12_1_0 , upvalues : isInit
      isInit = false
    end
)
  end
)
end

HandBookAlbumWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis, contentPane, argTable, listData
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookAlbumWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
  listData = {}
end

HandBookAlbumWindow.InitAssetStrip = function(...)
  -- function num : 0_14 , upvalues : _ENV, uis, OpenType, winType
  local m = {}
  m.windowName = (WinResConfig.HandBookAlbumWindow).name
  m.Tip = (PUtil.get)(20000132)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HandBookMainWindow).name
  m.moneyTypes = {}
  m.CloseBtnFun = function(...)
    -- function num : 0_14_0 , upvalues : OpenType, winType
    OpenType = winType.Album
  end

  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookAlbumWindow.GetIDIndex = function(id, ...)
  -- function num : 0_15 , upvalues : _ENV, listData
  for i,v in ipairs(listData) do
    if v.id == id then
      return i
    end
  end
end

HandBookAlbumWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_16 , upvalues : HandBookAlbumWindow, uis, _ENV
  if msgId == 1 then
    (HandBookAlbumWindow.RefreshList)()
  else
    if msgId == 2 then
      local obj = ((uis.AlbumCGList).CGList):GetChildAt((HandBookAlbumWindow.GetIDIndex)(para) - 1)
      ChangeUIController(obj, "c3", 1)
      ;
      (HandBookMgr.SetAlbumNotNew)(para)
    end
  end
end

return HandBookAlbumWindow

