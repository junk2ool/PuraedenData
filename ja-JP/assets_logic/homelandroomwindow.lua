-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_RoomByName")
local HomelandRoomWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local MOVE_SINGLE_GRID_COST_TIME = 0.4
local ASYNC_EACH_AMOUNT = 4
local ASYNC_EACH_DURATION = 0.2
local ROLE_HEIGHT_FIX = 45
local SELECTED_ALPHA = 0.5
local Stage = FairyGUI.Stage
local Random = (CS.UnityEngine).Random
local GTween = FairyGUI.GTween
local WhiteColor = ((CS.UnityEngine).Color).white
local Rect = (CS.UnityEngine).Rect
local AudioMgr = (CS.AudioAssetManager).Singleton
local Random = (CS.UnityEngine).Random
FurnitureEditStatus = {Add = 1, MoveOrRotate = 2, Remove = 3}
local BubbleHandle = {NoEffect = 1, Both = 2, OnlyBubble = 3}
local RoleMoveDirection = {RightDown = 0, LeftUp = 1, LeftDown = 2, RightUp = 3}
local RoleCoverRange = {Up = 4, Side = 1}
local RoleCoverType = {SelfCor = 1, LeftSide = 2, RightSide = 3, Upward = 4}
local ROLE_SIZE = (Vector2(100, 200))
local _floorHolder, _leftWallHolder, _rightWallHolder, _floor, _leftWall, _rightWall = nil, nil, nil, nil, nil, nil
local _furnitureInfo = {}
local _editGridUsage = {}
local _editCarpetGridUsage = {}
local _currentEditGridUsage = nil
local _editInfo = {}
local _editWall, _editFloor = nil, nil
local _editFurnitureInfo = {}
local _editGrid = {}
local _roles = {}
local _moveComInfo = {}
local _furnitureType = HomelandFurnitureType.All
local _zoomSize = nil
local _swipeArea = {}
local _bgImg, _bgImgOriginScale, _bgImgUVRect = nil, nil, nil
local _roomAdjustScale = 1
local _xChanged = 0
local _posDiff, _originPosDiff = nil, nil
local _roomWidth = {}
local _roomOffset = {}
local _swipeGestures = {}
local _roomSwipeGesture = nil
local DRAG_MAP_STOP_DURATION = 0.2
local _hemmingOirginPos, _roomOriginHeight = nil, nil
local _reusePool = {}
local _loaderPool = {}
local _leftSideDecorateSortList = {}
local _leftSideDecorateSortListIndex = {}
local _rightSideDecorateSortList = {}
local _rightSideDecorateSortListIndex = {}
local _tan, _sin, _cos, _sin2 = nil, nil, nil, nil
local _furnitureMoving = false
local _occupiedFurniture = {Count = 0}
local _touch1, _touch2, _lastTouchPos, _lastDis, _editor, _ui, _lastClickBtn = nil, nil, nil, nil, nil, nil, nil
local _styleBtns = {}
local _lastChosedBtn = nil
local _furnitureItemTimer = {}
local _floorLayerOwner = {}
local _furnitureRelation = {}
local _floorLayerOwnerByRole = {}
local _uiAnim, _topUIAnim, _sort, _dragLoader = nil, nil, nil, nil
local _dragingCard = false
local _initStyleId, _asyncTimer, _infoAnim = nil, nil, nil
local _audioId = 0
local _speakingRole, _leftBubble, _rightBubble, _randomBubbleTimer, _currentBubble = nil, nil, nil, nil, nil
HomelandRoomWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HomelandRoomWindow, _floorHolder, _leftWallHolder
  bridgeObj:SetView((WinResConfig.HomelandRoomWindow).package, (WinResConfig.HomelandRoomWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetFamily_RoomUis(contentPane)
  ;
  (HomelandRoomWindow.InitVariable)()
  ;
  (HomelandData.InitRoomConstantPart2)(_floorHolder.width, (_floorHolder.skew).y, _floorHolder.xy, _leftWallHolder.height)
  ;
  (HomelandRoomWindow.InitTopMenu)()
  ;
  (HomelandRoomWindow.InitText)()
  ;
  (HomelandRoomWindow.InitList)()
  ;
  (HomelandRoomWindow.InitButtonEvent)()
  ;
  (HomelandRoomWindow.BindingUI)()
  ;
  (HomelandRoomWindow.InitFunctionControl)()
end

HomelandRoomWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, HomelandRoomWindow
  local m = {}
  m.windowName = (WinResConfig.HomelandRoomWindow).name
  m.Tip = (PUtil.get)(60000585)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.FAMILY_SHOP_COIN}
  m.BackBtnFun = function(...)
    -- function num : 0_1_0 , upvalues : uis, _ENV, HomelandRoomWindow
    if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Normal then
      if (HomelandData.RoomData).Relation == HomelandHostRelation.Self then
        (HomelandService.ReqInFamily)(function(...)
      -- function num : 0_1_0_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.HomelandRoomWindow).name)
    end
)
      else
        ;
        (HomelandMgr.InitDefaultData)()
        ;
        (HomelandRoomWindow.RefreshHouse)()
        if not ((HomelandData.RoomData).CurrentPlayInfo).isRandomVisit then
          (HomelandRoomWindow.ClickVisitBtn)()
        end
      end
    else
      if (HomelandRoomWindow.ModifiedCheck)() then
        (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000595), function(...)
      -- function num : 0_1_0_1 , upvalues : HomelandRoomWindow
      (HomelandRoomWindow.ClickSaveBtn)()
    end
, function(...)
      -- function num : 0_1_0_2 , upvalues : HomelandRoomWindow
      (HomelandRoomWindow.AbortEdit)()
      ;
      (HomelandRoomWindow.DeactiveEditMode)(true)
    end
)
      else
        ;
        (HomelandRoomWindow.AbortEdit)()
        ;
        (HomelandRoomWindow.DeactiveEditMode)(true)
      end
    end
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.HomelandRoomWindow).name)
  end

  m.isSelfClose = true
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HomelandRoomWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : _editor, _ENV, _ui, uis, _bgImg, _bgImgOriginScale, _bgImgUVRect, _posDiff, _originPosDiff, _floorHolder, _leftWallHolder, _rightWallHolder, _hemmingOirginPos, _roomOriginHeight, _roomWidth, _roomOffset, _tan, _sin, _cos, _sin2, _styleBtns, _uiAnim, _topUIAnim, _infoAnim
  _editor = Application.platform == RuntimePlatform.WindowsEditor or Application.platform == RuntimePlatform.OSXEditor
  _ui = (uis.root):GetChild("My")
  _bgImg = ((uis.CurrencyWindow).root):GetChild("n6")
  _bgImgOriginScale = (_bgImg.scale).x
  _bgImgUVRect = (_bgImg.texture).uvRect
  uis.Currency = (uis.CurrencyWindow).Currency
  _posDiff = Vector2(_bgImg.x - ((uis.Currency).root).x, _bgImg.y - ((uis.Currency).root).y)
  _originPosDiff = (Util.CopyVec)(_posDiff)
  _floorHolder = ((uis.Currency).root):GetChild("CellImage")
  _floorHolder.gameObjectName = "FloorHolder"
  _leftWallHolder = ((uis.Currency).root):GetChild("LeftWallImage")
  _leftWallHolder.gameObjectName = "LeftWallHolder"
  _rightWallHolder = ((uis.Currency).root):GetChild("RightWallImage")
  _rightWallHolder.gameObjectName = "RightWallHolder"
  _hemmingOirginPos = (((uis.Currency).Hemming).root).xy
  _roomOriginHeight = ((uis.Currency).root).height
  local calculator = function(com1, com2, ...)
    -- function num : 0_2_0
    return com2.x - com1.x + com2.actualWidth
  end

  _roomWidth[1] = calculator((((uis.Currency).Extend).root):GetChild("n33"), (((uis.Currency).Extend).root):GetChild("n32"))
  _roomWidth[2] = calculator((((uis.Currency).Extend).root):GetChild("n23"), (((uis.Currency).Extend).root):GetChild("n24"))
  _roomWidth[3] = (((uis.Currency).Extend).root).width
  _roomOffset[1] = ((((uis.Currency).Extend).root):GetChild("n33")).x
  _roomOffset[2] = ((((uis.Currency).Extend).root):GetChild("n23")).x
  _roomOffset[3] = 0
  _tan = (math.tan)((math.rad)((_floorHolder.skew).y * 2))
  _sin = (math.sin)((math.rad)((_floorHolder.skew).y * 2))
  _cos = (math.cos)((math.rad)((_floorHolder.skew).y * 2))
  _sin2 = (math.sin)((math.rad)(90 - (_floorHolder.skew).y))
  ;
  (table.insert)(_styleBtns, uis.ABtn)
  ;
  (table.insert)(_styleBtns, uis.BBtn)
  ;
  (table.insert)(_styleBtns, uis.CBtn)
  ;
  (table.insert)(_styleBtns, uis.DBtn)
  _uiAnim = (uis.root):GetTransition("in")
  _topUIAnim = ((uis.AssetStripGrp).root):GetTransition("in")
  _infoAnim = (uis.root):GetTransition("Visit")
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HomelandRoomWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.Warehouse).FunctionBtn).text = (PUtil.get)(60000026)
end

HomelandRoomWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, HomelandRoomWindow
  ((uis.Warehouse).BtnList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Warehouse).BtnList).itemRenderer = HomelandRoomWindow.RefreshFurnitureTagItem
  ;
  ((uis.Warehouse).CardHeadList):SetVirtual()
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Warehouse).CardHeadList).itemRenderer = HomelandRoomWindow.RefreshFurnitureItem
end

HomelandRoomWindow.InitButtonEvent = function(...)
  -- function num : 0_5 , upvalues : uis, HomelandRoomWindow
  ((uis.StorageBtn).onClick):Set(HomelandRoomWindow.ClickStorageBtn)
  ;
  ((uis.ClearBtn).onClick):Set(HomelandRoomWindow.ClickClearBtn)
  ;
  (((uis.Warehouse).FunctionBtn).onClick):Set(HomelandRoomWindow.ClickSaveBtn)
  ;
  (((uis.CurrencyWindow).root).onClick):Set(HomelandRoomWindow.ClickBlankBtn)
  ;
  ((uis.HideBtn).onClick):Set(HomelandRoomWindow.ClickHideBtn)
  ;
  ((uis.RandomVisitBtn).onClick):Set(HomelandRoomWindow.ClickRandomVisitBtn)
  ;
  ((uis.VisitBtn).onClick):Set(HomelandRoomWindow.ClickVisitBtn)
  ;
  ((uis.LiveBtn).onClick):Set(HomelandRoomWindow.ClickDeployBtn)
  ;
  ((uis.ShopBtn).onClick):Set(HomelandRoomWindow.ClickShopBtn)
  ;
  ((((uis.Currency).Hemming).ExtensionBtn).onClick):Set(HomelandRoomWindow.ClickExtendBtn)
  ;
  (((uis.Warehouse).SortBtn).onClick):Set(HomelandRoomWindow.ClickSortBtn)
end

HomelandRoomWindow.BindingUI = function(...)
  -- function num : 0_6
end

HomelandRoomWindow.InitFunctionControl = function(...)
  -- function num : 0_7
end

HomelandRoomWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : HomelandRoomWindow
  (HomelandRoomWindow.Init)()
end

HomelandRoomWindow.OnHide = function(...)
  -- function num : 0_9
end

HomelandRoomWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : HomelandRoomWindow, _ENV, _asyncTimer, _swipeGestures, _zoomSize, _uiAnim, _topUIAnim, _infoAnim, _lastChosedBtn, _audioId, AudioMgr, _randomBubbleTimer, _currentBubble, _leftBubble, _rightBubble, _leftSideDecorateSortList, _leftSideDecorateSortListIndex, _rightSideDecorateSortList, _rightSideDecorateSortListIndex, _floor, _leftWall, _rightWall, _loaderPool, _reusePool, _editGrid, _furnitureItemTimer, _styleBtns, uis, contentPane, argTable
  if (HomelandRoomWindow.ModifiedCheck)() then
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000595), function(...)
    -- function num : 0_10_0 , upvalues : HomelandRoomWindow
    (HomelandRoomWindow.ClickSaveBtn)()
    ;
    (HomelandRoomWindow.ClearEditData)()
  end
)
  else
    ;
    (HomelandRoomWindow.ClearEditData)()
  end
  if _asyncTimer ~= nil then
    _asyncTimer:stop()
    _asyncTimer = nil
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  Input.multiTouchEnabled = false
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.HomelandRoomWindow).name)
  ;
  (UpdateMgr.RemoveUpdateHandler)(HomelandRoomWindow.Update)
  _swipeGestures = (HomelandRoomWindow.RecycleResources)(_swipeGestures)
  ;
  (HomelandRoomWindow.CleanMoveComInfo)()
  ;
  (HomelandRoomWindow.RecycleAllFurniture)(true)
  ;
  (HomelandRoomWindow.HideCards)()
  _zoomSize = nil
  _uiAnim = nil
  _topUIAnim = nil
  _infoAnim = nil
  _lastChosedBtn = nil
  if _audioId ~= 0 then
    AudioMgr:RemoveSound(_audioId)
    _audioId = 0
  end
  if _randomBubbleTimer then
    _randomBubbleTimer:stop()
    _randomBubbleTimer = nil
  end
  _currentBubble = nil
  _leftBubble = (HomelandRoomWindow.RecycleResources)(_leftBubble)
  _rightBubble = (HomelandRoomWindow.RecycleResources)(_rightBubble)
  _leftSideDecorateSortList = {}
  _leftSideDecorateSortListIndex = {}
  _rightSideDecorateSortList = {}
  _rightSideDecorateSortListIndex = {}
  _floor = (HomelandRoomWindow.RecycleResources)(_floor)
  _leftWall = (HomelandRoomWindow.RecycleResources)(_leftWall)
  _rightWall = (HomelandRoomWindow.RecycleResources)(_rightWall)
  for k,v in pairs(_loaderPool) do
    (HomelandRoomWindow.RecycleResources)(v.Shadow)
    ;
    (HomelandRoomWindow.RecycleResources)(v.Loader)
  end
  _loaderPool = {}
  for k,v in pairs(_reusePool) do
    (HomelandRoomWindow.RecycleResources)(v)
  end
  _reusePool = {}
  for k,v in pairs(_editGrid) do
    (HomelandRoomWindow.RecycleResources)(v)
  end
  _editGrid = {}
  for k,v in pairs(_furnitureItemTimer) do
    v:stop()
  end
  _furnitureItemTimer = {}
  _styleBtns = {}
  uis = nil
  contentPane = nil
  argTable = {}
end

HomelandRoomWindow.Init = function(...)
  -- function num : 0_11 , upvalues : _ENV, HomelandRoomWindow
  (GuideMgr.PictureTriggerGuide)((WinResConfig.HomelandRoomWindow).name)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  Input.multiTouchEnabled = true
  ;
  (UpdateMgr.AddUpdateHandler)(HomelandRoomWindow.Update)
  ;
  (HomelandRoomWindow.InitRoomGesture)()
  ;
  (HomelandRoomWindow.RefreshHouse)()
end

HomelandRoomWindow.RefreshHouse = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis, HomelandRoomWindow, _audioId, AudioMgr
  local data = nil
  if (HomelandData.RoomData).Relation == HomelandHostRelation.Self then
    data = ((HomelandData.AllRoomData)[(HomelandData.RoomData).Id]).roomStyle
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.c2Ctr).selectedIndex = 0
    ;
    (HomelandRoomWindow.RefreshStyleBtn)(data)
  else
    if _audioId ~= 0 then
      AudioMgr:RemoveSound(_audioId)
      _audioId = 0
    end
    ;
    (HomelandRoomWindow.RefreshPlayerInfo)()
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.c2Ctr).selectedIndex = 1
  end
  ;
  (HomelandRoomWindow.RefreshRoom)(true)
  ;
  (HomelandRoomWindow.SetRoomZoom)(HomelandRoomConstant.DefaultZoom, true)
  ;
  (HomelandRoomWindow.SetRoomXY)(-((uis.Currency).root).actualWidth * 0.5 + ResolutionHandler.Width * 0.5 - (ResolutionHandler.AdaptOffset).X, -((uis.Currency).root).actualHeight * 0.5 + ResolutionHandler.Height * 0.5 - (ResolutionHandler.AdaptOffset).Y)
end

HomelandRoomWindow.RefreshPlayerInfo = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis, HomelandRoomWindow, _infoAnim
  local data = (HomelandData.RoomData).CurrentPlayInfo
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.PlayerInfo).PlayerNameTxt).text = data.name
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.PlayerInfo).PlayerHead).LevelTxt).text = "Lv." .. data.level
  local fashionConfig = ((TableData.gTable).BasePlayerHeadIconData)[data.fashionHead]
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  if fashionConfig then
    (((uis.PlayerInfo).PlayerHead).ActorHeadLoader).url = (Util.GetResUrl)(fashionConfig.icon_path)
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.PlayerInfo).BattleInfo).NameTxt).text = (PUtil.get)(60000235)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.PlayerInfo).BattleInfo).WordTxt).text = data.fc
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

  if data.title == 0 then
    (((uis.PlayerInfo).TitlePic).PicLoader).url = nil
  else
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((uis.PlayerInfo).TitlePic).PicLoader).url = (Util.GetItemUrl)((((TableData.gTable).BasePlayerTitleData)[data.title]).icon)
  end
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.PlayerInfo).c1Ctr).selectedIndex = 1
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.PlayerInfo).NextBtn).text = (PUtil.get)(60000558)
  if data.isRandomVisit then
    (((uis.PlayerInfo).NextBtn).onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : _ENV
    (HomelandMgr.ReqRandomPlayerInfo)()
  end
)
  else
    ;
    (((uis.PlayerInfo).NextBtn).onClick):Set(function(...)
    -- function num : 0_13_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    if (HomelandData.VisitInfo).Index == #(HomelandData.VisitInfo).Content then
      (HomelandData.VisitInfo).Index = 1
    else
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (HomelandData.VisitInfo).Index = (HomelandData.VisitInfo).Index + 1
    end
    local data = ((HomelandData.VisitInfo).Content)[(HomelandData.VisitInfo).Index]
    if not data.objectindex then
      (HomelandMgr.ReqRoomCallOn)(data.playerIndex, data.serverId)
    end
  end
)
  end
  ;
  (HomelandRoomWindow.RefreshOtherRelation)()
  if (uis.c2Ctr).selectedIndex == 1 then
    _infoAnim:PlayReverse(function(...)
    -- function num : 0_13_2 , upvalues : _infoAnim
    _infoAnim:Play()
  end
)
  else
    _infoAnim:Play()
  end
end

HomelandRoomWindow.RefreshOtherRelation = function(...)
  -- function num : 0_14 , upvalues : _ENV, uis
  local data = (HomelandData.RoomData).CurrentPlayInfo
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  if (FriendsData.IsSelfFriend)(tonumber(data.objectIndex)) then
    ((uis.PlayerInfo).WordTxt).text = "(" .. (PUtil.get)(20000566) .. ")"
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.PlayerInfo).ApplyBtn).text = (PUtil.get)(20000572)
    ;
    (((uis.PlayerInfo).ApplyBtn).onClick):Set(function(...)
    -- function num : 0_14_0 , upvalues : _ENV, data
    OpenWindow((WinResConfig.FriendChatWindow).name, UILayer.HUD, data.objectIndex)
  end
)
  else
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

    if (FriendsData.IsAlreadyApply)(data.objectIndex) then
      ((uis.PlayerInfo).ApplyBtn).text = (PUtil.get)(20000583)
      ;
      (((uis.PlayerInfo).ApplyBtn).onClick):Set(function(...)
    -- function num : 0_14_1 , upvalues : _ENV, data
    (FriendsService.ReqChangeRelation)((ProtoEnum.FriendOperationType).CANCAL_INVITE, data.objectIndex)
  end
)
    else
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.PlayerInfo).ApplyBtn).text = (PUtil.get)(20000582)
      ;
      (((uis.PlayerInfo).ApplyBtn).onClick):Set(function(...)
    -- function num : 0_14_2 , upvalues : _ENV, data
    (FriendsService.ReqChangeRelation)((ProtoEnum.FriendOperationType).ADD_FRIEND, data.objectIndex)
  end
)
    end
    -- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

    if GuildData ~= nil and (GuildData.MemberList)[data.objectIndex] ~= nil then
      ((uis.PlayerInfo).WordTxt).text = "(" .. (PUtil.get)(60000254) .. ")"
    else
      -- DECOMPILER ERROR at PC90: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.PlayerInfo).WordTxt).text = ""
    end
  end
end

HomelandRoomWindow.RefreshRoom = function(cutAudio, ...)
  -- function num : 0_15 , upvalues : HomelandRoomWindow, BubbleHandle
  (HomelandRoomWindow.RefreshWall)()
  ;
  (HomelandRoomWindow.RefreshFloor)()
  ;
  (HomelandRoomWindow.HideCards)()
  ;
  (HomelandRoomWindow.RefreshFurniture)()
  ;
  (HomelandRoomWindow.RefreshExtendArea)()
  ;
  (HomelandRoomWindow.RefreshRoomSwipeArea)()
  ;
  (HomelandRoomWindow.RefreshCards)()
  if cutAudio then
    (HomelandRoomWindow.PlayRandomBubble)(BubbleHandle.Both)
  else
    ;
    (HomelandRoomWindow.PlayRandomBubble)(BubbleHandle.OnlyBubble)
  end
end

HomelandRoomWindow.RefreshEditRoom = function(...)
  -- function num : 0_16 , upvalues : _editInfo, _ENV, HomelandRoomWindow, _occupiedFurniture, _editWall, _editFloor
  local styleData = _editInfo[(HomelandData.RoomData).StyleId]
  if styleData == nil then
    (HomelandRoomWindow.RefreshFurniture)()
  else
    _occupiedFurniture = styleData.OccupiedFurniture
    ;
    (HomelandRoomWindow.RefreshFurniture)(styleData.FurnitureInfo)
  end
  ;
  (HomelandRoomWindow.InitEditData)(false, styleData)
  ;
  (HomelandRoomWindow.RefreshWall)(_editWall.Id)
  ;
  (HomelandRoomWindow.RefreshFloor)(_editFloor.Id)
  ;
  (HomelandRoomWindow.RefreshExtendArea)()
  ;
  (HomelandRoomWindow.RefreshRoomSwipeArea)()
end

HomelandRoomWindow.Update = function(...)
  -- function num : 0_17 , upvalues : _editor, _ENV, HomelandRoomWindow, uis, _rightWallHolder, _furnitureMoving, _dragingCard, _touch1, _lastTouchPos, _touch2, _lastDis
  if _editor then
    if (Input.GetKey)(KeyCode.Z) then
      (HomelandRoomWindow.ZoomInRoom)()
    else
      if (Input.GetKey)(KeyCode.X) then
        (HomelandRoomWindow.ZoomOutRoom)()
      else
        if (Input.GetKeyDown)(KeyCode.F1) then
          (HomelandRoomWindow.ClickStyleBtn)(1)
        else
          if (Input.GetKeyDown)(KeyCode.F2) then
            (HomelandRoomWindow.ClickStyleBtn)(2)
          else
            if (Input.GetKeyDown)(KeyCode.F3) then
              (HomelandRoomWindow.ClickStyleBtn)(3)
            else
              if (Input.GetKeyDown)(KeyCode.F4) then
                (HomelandRoomWindow.ClickStyleBtn)(4)
              else
                if (Input.GetKeyDown)(KeyCode.C) then
                  logw("~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                  local index = ((uis.Currency).root):GetChildIndex(_rightWallHolder)
                  local endIndex = ((uis.Currency).root).numChildren - 1
                  for i = index, endIndex do
                    logw((((uis.Currency).root):GetChildAt(i)).gameObjectName)
                  end
                  logw("#################################")
                end
              end
            end
          end
        end
      end
    end
  else
    do
      if not _furnitureMoving and not _dragingCard then
        if Input.touchCount == 1 then
          _touch1 = (Input.GetTouch)(0)
          _lastTouchPos = _touch1.position
        else
          if Input.touchCount > 1 then
            _touch1 = (Input.GetTouch)(0)
            _touch2 = (Input.GetTouch)(1)
            if _touch2.phase == ((CS.UnityEngine).TouchPhase).Began then
              _lastDis = (math.abs)((_touch1.position).x - (_touch2.position).x) + (math.abs)((_touch1.position).y - (_touch2.position).y)
            else
              if _touch1.phase == ((CS.UnityEngine).TouchPhase).Moved or _touch2.phase == ((CS.UnityEngine).TouchPhase).Moved then
                local dis = (math.abs)((_touch1.position).x - (_touch2.position).x) + (math.abs)((_touch1.position).y - (_touch2.position).y)
                ;
                (HomelandRoomWindow.ZoomRoom)((dis - _lastDis) * 0.003)
                _lastDis = dis
              end
            end
            do
              if _touch1.phase == ((CS.UnityEngine).TouchPhase).Ended then
                _lastTouchPos = _touch2.position
              end
              if _touch2.phase == ((CS.UnityEngine).TouchPhase).Ended then
                _lastTouchPos = _touch1.position
              end
            end
          end
        end
      end
    end
  end
end

HomelandRoomWindow.RefreshStyleBtn = function(data, ...)
  -- function num : 0_18 , upvalues : _ENV, _styleBtns, _lastChosedBtn, HomelandRoomWindow
  local index = 0
  for k,v in pairs(data) do
    local styleId = v.styleId
    do
      index = index + 1
      local btn = _styleBtns[index]
      ;
      (btn.onClick):Set(function(...)
    -- function num : 0_18_0 , upvalues : _ENV, styleId, _lastChosedBtn, HomelandRoomWindow, btn
    if (HomelandData.RoomData).StyleId == styleId then
      return 
    end
    _lastChosedBtn.selected = false
    ;
    (HomelandRoomWindow.ClickStyleBtn)(styleId)
    _lastChosedBtn = btn
  end
)
      btn.selected = styleId == (HomelandData.RoomData).StyleId
      if btn.selected then
        _lastChosedBtn = btn
      end
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

HomelandRoomWindow.InitRoomGesture = function(...)
  -- function num : 0_19 , upvalues : _roomSwipeGesture, HomelandRoomWindow, uis, _ENV, _furnitureMoving, _dragingCard, _zoomSize
  _roomSwipeGesture = (HomelandRoomWindow.GetSwipeGesture)((uis.CurrencyWindow).root)
  ;
  (_roomSwipeGesture.onMove):Add(function(context, ...)
    -- function num : 0_19_0 , upvalues : _ENV, _furnitureMoving, _dragingCard, uis, _roomSwipeGesture, _zoomSize, HomelandRoomWindow
    if Input.touchCount > 1 or _furnitureMoving or _dragingCard then
      return 
    end
    local x = ((uis.Currency).root).x + (_roomSwipeGesture.delta).x / _zoomSize
    local y = ((uis.Currency).root).y + (_roomSwipeGesture.delta).y / _zoomSize
    ;
    (HomelandRoomWindow.SetRoomXY)(x, y)
  end
)
end

HomelandRoomWindow.SetRoomXY = function(x, y, ...)
  -- function num : 0_20 , upvalues : _swipeArea, uis, _posDiff, _zoomSize, _bgImg
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  -- DECOMPILER ERROR at PC26: Unhandled construct in 'MakeBoolean' P3

  -- DECOMPILER ERROR at PC26: Unhandled construct in 'MakeBoolean' P3

  -- DECOMPILER ERROR at PC26: Unhandled construct in 'MakeBoolean' P3

  if ((((((_swipeArea.MaxX < x and _swipeArea.MaxX) or x < _swipeArea.MinX)) and _swipeArea.MaxY >= y)) or y < _swipeArea.MinY) then
    ((uis.Currency).root).x = x
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.Currency).root).y = y
    local newPosDiff = _posDiff * _zoomSize
    _bgImg.x = x + newPosDiff.x
    _bgImg.y = y + newPosDiff.y
    ;
    ((uis.Currency).root):InvalidateBatchingState()
  end
end

HomelandRoomWindow.RefreshRoomSwipeArea = function(...)
  -- function num : 0_21 , upvalues : HomelandRoomWindow, _ENV, _swipeArea, uis
  local width = (HomelandRoomWindow.GetCurrentRoomWidth)()
  if width < ResolutionHandler.Width then
    _swipeArea.MinX = (DesignScreen.width - width) * 0.5 - (HomelandRoomWindow.GetRoomOffset)()
    _swipeArea.MaxX = _swipeArea.MinX
  else
    local offset = (HomelandRoomWindow.GetRoomOffset)()
    local distance = -width - offset + DesignScreen.width
    if distance < 0 then
      _swipeArea.MinX = distance + (ResolutionHandler.AdaptOffset).X
      _swipeArea.MaxX = -offset - (ResolutionHandler.AdaptOffset).X
    else
      _swipeArea.MaxX = distance - (ResolutionHandler.AdaptOffset).X
      _swipeArea.MinX = -offset + (ResolutionHandler.AdaptOffset).X
    end
  end
  do
    local maxY = nil
    if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Edit then
      maxY = DesignScreen.height - ((uis.Warehouse).root).height
    else
      maxY = DesignScreen.height
    end
    if ((uis.Currency).root).actualHeight < maxY then
      _swipeArea.MinY = (maxY - ((uis.Currency).root).actualHeight) * 0.5
      _swipeArea.MaxY = _swipeArea.MinY
    else
      _swipeArea.MaxY = 0
      _swipeArea.MinY = -((uis.Currency).root).actualHeight + maxY
    end
  end
end

HomelandRoomWindow.GetCurrentRoomWidth = function(...)
  -- function num : 0_22 , upvalues : _zoomSize, _roomWidth, _ENV, _roomAdjustScale
  if _zoomSize then
    return _roomWidth[(HomelandData.RoomData).Level] * _zoomSize * _roomAdjustScale
  else
    return _roomWidth[(HomelandData.RoomData).Level] * HomelandRoomConstant.DefaultZoom * _roomAdjustScale
  end
end

HomelandRoomWindow.GetRoomOffset = function(...)
  -- function num : 0_23 , upvalues : _zoomSize, _roomOffset, _ENV, _roomAdjustScale
  if _zoomSize then
    return _roomOffset[(HomelandData.RoomData).Level] * _zoomSize * _roomAdjustScale
  else
    return _roomOffset[(HomelandData.RoomData).Level] * HomelandRoomConstant.DefaultZoom * _roomAdjustScale
  end
end

HomelandRoomWindow.HideCards = function(...)
  -- function num : 0_24 , upvalues : _ENV, _roles, HomelandRoomWindow, _floorLayerOwnerByRole
  for k,v in pairs(_roles) do
    v.Alive = false
    if v.MoveToGrid then
      (HomelandMgr.UpdateCardGridUsage)((v.MoveToGrid).x, (v.MoveToGrid).y)
    end
    ;
    (HomelandMgr.UpdateCardGridUsage)((v.Coordinate).x, (v.Coordinate).y)
    ;
    (HomelandRoomWindow.RecycleCardLoader)(v.Loader, v.Shadow)
    if v.PatrolTween then
      (LeanTween.cancel)((v.PatrolTween).uniqueId)
      v.PatrolTween = nil
    end
  end
  _roles = {}
  _floorLayerOwnerByRole = {}
end

HomelandRoomWindow.RefreshCards = function(...)
  -- function num : 0_25 , upvalues : HomelandRoomWindow, _ENV, _roles
  (HomelandRoomWindow.HideCards)()
  local count = #(HomelandData.RoomData).Role
  local cardData, loader, model, shadow = nil, nil, nil, nil
  ;
  (HomelandData.InitCardGridData)()
  local coordinate = nil
  for i = 1, count do
    cardData = ((HomelandData.RoomData).Role)[i]
    local id = cardData.cardId
    do
      do
        local fashion = (CardData.GetFashionConfig)({id = cardData.cardId, quality = cardData.quality}, true)
        loader = (HomelandRoomWindow.GetCardLoader)()
        loader.gameObjectName = id
        model = (Util.CreateMiniModel)(loader, fashion.id)
        if (HomelandData.RoomData).CardGridCount > 0 then
          coordinate = (HomelandData.GetRandomAvailableCoordinate)()
          local x = coordinate.x
          local y = coordinate.y
          ;
          (HomelandMgr.UpdateCardGridUsage)(x, y, id)
          ;
          (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.IDLE_WITHOUT_WEAPON, true)
          _roles[id] = {Id = id, Model = model, Quality = cardData.quality, Loader = loader, Alive = true, Coordinate = Vector2(x, y), Shadow = shadow}
          ;
          (HomelandRoomWindow.SetCardLoaderPos)(_roles[id], (HomelandRoomWindow.GetRolePosByCoordinate)(x, y))
          -- DECOMPILER ERROR at PC93: Confused about usage of register: R14 in 'UnsetPending'

          ;
          (_roles[id]).CoverGrid = (HomelandRoomWindow.SetRoleLayerIndex)(loader, id, (_roles[id]).Coordinate)
          if (HomelandData.RoomData).Relation == HomelandHostRelation.Self then
            (HomelandRoomWindow.InitCardGesture)(_roles[id], fashion.id, true)
            ;
            (loader.onClick):Set(function(...)
    -- function num : 0_25_0 , upvalues : HomelandRoomWindow, fashion, _roles, id
    (HomelandRoomWindow.PlayBubble)(fashion, _roles[id])
  end
)
          else
            ;
            (HomelandRoomWindow.InitCardGesture)(_roles[id], fashion.id)
            ;
            (loader.onClick):Clear()
          end
        else
          do
            loge("no available room for role!")
          end
        end
        -- DECOMPILER ERROR at PC123: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for k,v in pairs(_roles) do
    v.PatrolTween = (HomelandRoomWindow.StartPatrol)(v)
  end
end

HomelandRoomWindow.GetRolePosByCoordinate = function(x, y, ...)
  -- function num : 0_26 , upvalues : _ENV
  local vec1 = HomelandRoomConstant.XAxis * (x - 1)
  local vec2 = HomelandRoomConstant.YAxis * (y - 1)
  return Vector2((HomelandRoomConstant.OriginalPoint).x + vec1.x + vec2.x, (HomelandRoomConstant.OriginalPoint).y + vec1.y + vec2.y + (HomelandRoomConstant.GridProject).sin)
end

HomelandRoomWindow.InitCardGesture = function(roleData, fashionId, use, ...)
  -- function num : 0_27 , upvalues : HomelandRoomWindow, _dragingCard, _dragLoader, uis, _ENV
  roleData.SwipGes = (HomelandRoomWindow.GetSwipeGesture)(roleData.Loader)
  if use then
    ((roleData.SwipGes).onBegin):Set(function(...)
    -- function num : 0_27_0 , upvalues : _dragingCard, _dragLoader, HomelandRoomWindow, uis, roleData, fashionId
    _dragingCard = true
    _dragLoader = (HomelandRoomWindow.GetCardLoader)(true)
    ;
    ((uis.Currency).root):SetChildIndex(_dragLoader, ((uis.Currency).root).numChildren - 1)
    ;
    (HomelandRoomWindow.PickCard)(roleData, fashionId)
  end
)
    ;
    ((roleData.SwipGes).onMove):Set(function(...)
    -- function num : 0_27_1 , upvalues : HomelandRoomWindow, _dragLoader, _ENV
    local point = (HomelandRoomWindow.GetTouchPosition)()
    _dragLoader.xy = Vector2(point.x, point.y)
  end
)
    ;
    ((roleData.SwipGes).onEnd):Set(function(context, ...)
    -- function num : 0_27_2 , upvalues : _dragingCard, HomelandRoomWindow, _dragLoader, roleData
    _dragingCard = false
    ;
    (HomelandRoomWindow.RecycleCardLoader)(_dragLoader)
    ;
    (HomelandRoomWindow.PlaceCard)(roleData)
  end
)
  else
    ;
    ((roleData.SwipGes).onBegin):Clear()
    ;
    ((roleData.SwipGes).onMove):Clear()
    ;
    ((roleData.SwipGes).onEnd):Clear()
  end
end

HomelandRoomWindow.PlayRandomBubble = function(status, ...)
  -- function num : 0_28 , upvalues : _randomBubbleTimer, BubbleHandle, _currentBubble, _audioId, AudioMgr, _ENV, uis, Random, _roles, HomelandRoomWindow
  if _randomBubbleTimer and _randomBubbleTimer:IsRunIng() then
    _randomBubbleTimer:stop()
  end
  if status ~= BubbleHandle.NoEffect then
    if _currentBubble then
      _currentBubble.visible = false
    end
    if status == BubbleHandle.Both and _audioId ~= 0 then
      AudioMgr:RemoveSound(_audioId)
      _audioId = 0
    end
  end
  _randomBubbleTimer = (SimpleTimer.setTimeout)(HomelandRoomConstant.RandomBubbleGap, function(...)
    -- function num : 0_28_0 , upvalues : uis, _ENV, Random, _roles, HomelandRoomWindow, BubbleHandle
    if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Normal and #(HomelandData.RoomData).Role > 0 and not UIMgr:IsWindowOpen((WinResConfig.HomelandDeployCardWindow).name) then
      local index = ((math.floor)((Random.Range)(1, #(HomelandData.RoomData).Role + 0.5)))
      local roleData = nil
      for k,v in pairs(_roles) do
        index = index - 1
        if index <= 0 then
          roleData = v
          break
        end
      end
      do
        do
          local fashion = (CardData.GetFashionConfig)({id = roleData.Id, quality = roleData.Quality}, true)
          ;
          (HomelandRoomWindow.PlayBubble)(fashion, roleData, function(...)
      -- function num : 0_28_0_0 , upvalues : HomelandRoomWindow, BubbleHandle
      (HomelandRoomWindow.PlayRandomBubble)(BubbleHandle.NoEffect)
    end
)
          ;
          (HomelandRoomWindow.PlayRandomBubble)(BubbleHandle.NoEffect)
        end
      end
    end
  end
)
end

HomelandRoomWindow.StopBubble = function(id, ...)
  -- function num : 0_29 , upvalues : _speakingRole, _currentBubble, _audioId, AudioMgr
  if id and _speakingRole ~= id then
    return 
  end
  if _currentBubble ~= nil then
    _currentBubble.visible = false
  end
  if _audioId ~= 0 then
    AudioMgr:RemoveSound(_audioId)
    _audioId = 0
  end
end

HomelandRoomWindow.PlayBubble = function(fashion, roleData, cb, ...)
  -- function num : 0_30 , upvalues : _ENV, _audioId, HomelandRoomWindow, _floor, _currentBubble, _speakingRole
  if (AudioManager.PlayingAudio)() or _audioId ~= 0 then
    return 
  end
  local bubbleId = (AudioManager.GetBubbleIds)(fashion.id, CVAudioType.homelandRandomBubble, true)
  local bubbleData = ((TableData.gTable).BaseFashionBubbleData)[bubbleId]
  roleData.Bubble = (HomelandRoomWindow.GetBubble)((roleData.Loader).x < _floor.x)
  ;
  ((roleData.Bubble):GetChild("TalkTxt")).text = bubbleData.bubble_text
  _currentBubble = roleData.Bubble
  if not (Util.StringIsNullOrEmpty)(fashion.top_positoin) then
    local offsetStr = split(fashion.top_positoin, ":")
    roleData.BubbleOffset = {x = tonumber(offsetStr[1]), y = tonumber(offsetStr[2])}
  else
    roleData.BubbleOffset = Vector2.zero
  end
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R5 in 'UnsetPending'

  if (roleData.BubbleOffset).x == 0 then
    (roleData.BubbleOffset).x = 1
  end
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

  if _floor.x <= (roleData.Loader).x then
    (roleData.BubbleOffset).x = -(roleData.BubbleOffset).x
  end
  ;
  (HomelandRoomWindow.SetCardLoaderPos)(roleData, (roleData.Loader).xy)
  _speakingRole = roleData.Id
  _audioId = (LuaSound.AudioMgrPlaySound)(bubbleData.voice_path, false, function(...)
    -- function num : 0_30_0 , upvalues : roleData, _currentBubble, _audioId, cb
    roleData.Bubble = nil
    _currentBubble.visible = false
    _audioId = 0
    if cb then
      cb()
    end
  end
)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

HomelandRoomWindow.GetBubble = function(left, ...)
  -- function num : 0_31 , upvalues : _leftBubble, _ENV, uis, _rightBubble
  if left then
    if _leftBubble == nil then
      _leftBubble = ((FairyGUI.UIPackage).CreateObject)((WinResConfig.HomelandRoomWindow).package, HomelandRoomResources.TalkL)
      ;
      ((uis.Currency).root):AddChild(_leftBubble)
    end
    _leftBubble.visible = true
    ;
    ((uis.Currency).root):SetChildIndex(_leftBubble, ((uis.Currency).root).numChildren - 1)
    return _leftBubble
  else
    if _rightBubble == nil then
      _rightBubble = ((FairyGUI.UIPackage).CreateObject)((WinResConfig.HomelandRoomWindow).package, HomelandRoomResources.TalkR)
      ;
      ((uis.Currency).root):AddChild(_rightBubble)
    end
    _rightBubble.visible = true
    ;
    ((uis.Currency).root):SetChildIndex(_rightBubble, ((uis.Currency).root).numChildren - 1)
    return _rightBubble
  end
end

HomelandRoomWindow.PickCard = function(roleData, fashionId, ...)
  -- function num : 0_32 , upvalues : _ENV, _dragLoader, HomelandRoomWindow
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (roleData.Loader).alpha = 0.5
  if roleData.PatrolTween then
    logw("cancel:" .. (roleData.PatrolTween).uniqueId)
    ;
    (LeanTween.cancel)((roleData.PatrolTween).uniqueId)
    roleData.PatrolTween = nil
  end
  if roleData.Reason then
    (HomelandData.RemoveFromWaitingList)((roleData.Path)[roleData.PathIndex], roleData.Id)
    roleData.Reason = nil
  end
  if roleData.MoveToGrid then
    (HomelandMgr.UpdateCardGridUsage)((roleData.MoveToGrid).x, (roleData.MoveToGrid).y)
    roleData.MoveToGrid = nil
    ;
    (SkeletonAnimationUtil.SetAnimation)(roleData.Model, 0, BattleCardState.IDLE_WITHOUT_WEAPON, true)
  end
  local model = (Util.CreateMiniModel)(_dragLoader, fashionId)
  ;
  (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.CATCH, true)
  local count = #roleData.CoverGrid
  local pos = nil
  for i = 1, count do
    pos = ((roleData.CoverGrid)[i]).Coordinate
    ;
    (HomelandRoomWindow.ChangeFloorOwnerByRole)(pos, roleData.Id)
  end
  ;
  (HomelandMgr.UpdateCardGridUsage)((roleData.Coordinate).x, (roleData.Coordinate).y)
end

HomelandRoomWindow.PlaceCard = function(roleData, ...)
  -- function num : 0_33 , upvalues : HomelandRoomWindow, _ENV, _currentBubble, uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (roleData.Loader).alpha = 1
  local point, coordinate = (HomelandRoomWindow.GetTouchPositionAndCoordinate)(HomelandFurnitureType.Furniture, false, Vector2(0, -(HomelandRoomConstant.GridProject).sin))
  local availableCoordinate = (HomelandRoomWindow.FindAvailableCoordinate)(coordinate, 0)
  if availableCoordinate == nil then
    return 
  end
  if availableCoordinate.x ~= coordinate.x or coordinate.y ~= availableCoordinate.y then
    point = (HomelandRoomWindow.GetRolePosByCoordinate)(availableCoordinate.x, availableCoordinate.y)
  end
  ;
  (HomelandRoomWindow.SetCardLoaderPos)(roleData, point)
  roleData.Coordinate = availableCoordinate
  roleData.CoverGrid = (HomelandRoomWindow.SetRoleLayerIndex)(roleData.Loader, roleData.Id, availableCoordinate)
  ;
  (SkeletonAnimationUtil.SetAnimation)(roleData.Model, 0, BattleCardState.LAND, false, function(...)
    -- function num : 0_33_0 , upvalues : _ENV, roleData
    (SkeletonAnimationUtil.SetAnimation)(roleData.Model, 0, BattleCardState.IDLE_WITHOUT_WEAPON, true)
  end
)
  local count = #roleData.CoverGrid
  local data = nil
  for i = 1, count do
    data = (roleData.CoverGrid)[i]
    ;
    (HomelandRoomWindow.ChangeFloorOwnerByRole)(data.Coordinate, roleData.Id, data.Half and 0.5 or 1)
  end
  ;
  (HomelandMgr.UpdateCardGridUsage)((roleData.Coordinate).x, (roleData.Coordinate).y, roleData.Id)
  roleData.Path = nil
  roleData.PatrolTween = (HomelandRoomWindow.StartPatrol)(roleData)
  if _currentBubble then
    ((uis.Currency).root):SetChildIndex(_currentBubble, ((uis.Currency).root).numChildren - 1)
  end
end

HomelandRoomWindow.FindAvailableCoordinate = function(coordinate, round, ...)
  -- function num : 0_34 , upvalues : _ENV, HomelandRoomWindow
  local roomSize = (HomelandData.GetCurrentRoomSize)()
  if round == 0 then
    if roomSize < coordinate.x or roomSize < coordinate.y or coordinate.x < 1 or coordinate.y < 1 then
      local newCoor = (Util.CopyVec)(coordinate)
      do
        if newCoor.x < 1 then
          newCoor.x = 1
        else
          if roomSize < newCoor.x then
            newCoor.x = roomSize
          end
        end
        if newCoor.y < 1 then
          newCoor.y = 1
        else
          if roomSize < newCoor.y then
            newCoor.y = roomSize
          end
        end
        return (HomelandRoomWindow.FindAvailableCoordinate)(newCoor, round)
      end
    else
      do
        if (HomelandData.CheckGridAvailableForRole)(coordinate.x, coordinate.y) then
          return coordinate
        else
          return (HomelandRoomWindow.FindAvailableCoordinate)(coordinate, round + 1)
        end
        local x, y, destination = nil, nil, nil
        local outOfLimit = true
        local Checker = function(getter, ...)
    -- function num : 0_34_0 , upvalues : round, x, y, roomSize, outOfLimit, _ENV
    for i = round, 1, -1 do
      x = getter(i)
      if x <= roomSize and y <= roomSize and x > 0 and y > 0 then
        outOfLimit = false
        if (HomelandData.CheckGridAvailableForRole)(x, y) then
          return Vector2(x, y)
        end
      end
    end
    return nil
  end

        destination = Checker(function(i, ...)
    -- function num : 0_34_1 , upvalues : coordinate, round
    return coordinate.x + round - i, coordinate.y + i
  end
)
        if destination then
          return destination
        end
        destination = Checker(function(i, ...)
    -- function num : 0_34_2 , upvalues : coordinate, round
    return coordinate.x + i, coordinate.y - (round - i)
  end
)
        if destination then
          return destination
        end
        destination = Checker(function(i, ...)
    -- function num : 0_34_3 , upvalues : coordinate, round
    return coordinate.x - (round - i), coordinate.y - i
  end
)
        if destination then
          return destination
        end
        destination = Checker(function(i, ...)
    -- function num : 0_34_4 , upvalues : coordinate, round
    return coordinate.x - i, coordinate.y - (round - i)
  end
)
        if destination then
          return destination
        end
        if outOfLimit then
          return nil
        else
          return (HomelandRoomWindow.FindAvailableCoordinate)(coordinate, round + 1)
        end
      end
    end
  end
end

HomelandRoomWindow.ChangeFloorOwnerByRole = function(pos, roleId, occupied, ...)
  -- function num : 0_35 , upvalues : _floorLayerOwnerByRole, _ENV
  if occupied then
    if _floorLayerOwnerByRole[pos.x] == nil then
      _floorLayerOwnerByRole[pos.x] = {}
    end
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

    if (_floorLayerOwnerByRole[pos.x])[pos.y] == nil then
      (_floorLayerOwnerByRole[pos.x])[pos.y] = {}
    end
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((_floorLayerOwnerByRole[pos.x])[pos.y])[roleId] = occupied
  else
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

    if _floorLayerOwnerByRole[pos.x] ~= nil and (_floorLayerOwnerByRole[pos.x])[pos.y] ~= nil then
      ((_floorLayerOwnerByRole[pos.x])[pos.y])[roleId] = nil
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

      if (_G.next)((_floorLayerOwnerByRole[pos.x])[pos.y]) == nil then
        (_floorLayerOwnerByRole[pos.x])[pos.y] = nil
        if (_G.next)(_floorLayerOwnerByRole[pos.x]) == nil then
          _floorLayerOwnerByRole[pos.x] = nil
        end
      end
    end
  end
end

HomelandRoomWindow.ReStartPatrol = function(role, ...)
  -- function num : 0_36 , upvalues : _ENV, HomelandRoomWindow
  if role.MoveToGrid then
    (HomelandMgr.UpdateCardGridUsage)((role.MoveToGrid).x, (role.MoveToGrid).y)
    role.MoveToGrid = nil
  end
  role.Reason = nil
  role.Path = nil
  return (HomelandRoomWindow.StartPatrol)(role)
end

HomelandRoomWindow.StartPatrol = function(role, ...)
  -- function num : 0_37 , upvalues : _ENV, Random, _roles, HomelandRoomWindow, MOVE_SINGLE_GRID_COST_TIME
  if not role.Alive then
    return 
  end
  local delay = 0
  if role.Path == nil then
    local availableCoordinate = {}
    for k,v in pairs((HomelandData.RoomData).CardGrid) do
      for subk,subv in pairs(v) do
        if (math.abs)((role.Coordinate).x - k) + (math.abs)((role.Coordinate).y - subk) <= HomelandRoomConstant.RoleMaxMoveDistance then
          (table.insert)(availableCoordinate, {x = k, y = subk})
        end
      end
    end
    if #availableCoordinate > 0 then
      delay = (Random.Range)(HomelandRoomConstant.RoleMinWaitDuration, HomelandRoomConstant.RoleMaxWaitDuration)
      local index, destination = nil, nil
      repeat
        index = (math.floor)((Random.Range)(1, #availableCoordinate))
        destination = availableCoordinate[index]
        role.Path = (HomelandData.GetPath)(role.Coordinate, destination, role.Id)
        if not role.Path then
          (table.remove)(availableCoordinate, index)
        end
      until role.Path or #availableCoordinate == 0
    end
    do
      do
        if not role.Path then
          loge("id:" .. role.Id .. " can\'t move")
          return 
        end
        role.PathIndex = 2
        local destinationPos = (role.Loader).xy
        local destinationCoordinate = (role.Path)[role.PathIndex]
        -- DECOMPILER ERROR at PC123: Confused about usage of register: R4 in 'UnsetPending'

        if not (HomelandData.CheckGridAvailableForRole)(destinationCoordinate.x, destinationCoordinate.y) then
          if ((HomelandData.RoomData).GridWaiting)[destinationCoordinate.x] == nil then
            ((HomelandData.RoomData).GridWaiting)[destinationCoordinate.x] = {}
          end
          -- DECOMPILER ERROR at PC140: Confused about usage of register: R4 in 'UnsetPending'

          if (((HomelandData.RoomData).GridWaiting)[destinationCoordinate.x])[destinationCoordinate.y] == nil then
            (((HomelandData.RoomData).GridWaiting)[destinationCoordinate.x])[destinationCoordinate.y] = {}
          end
          ;
          (SkeletonAnimationUtil.SetAnimation)(role.Model, 0, BattleCardState.IDLE_WITHOUT_WEAPON, true)
          role.Reason = (((HomelandData.RoomData).CardGridUsage)[destinationCoordinate.x])[destinationCoordinate.y]
          if (_roles[role.Reason]).Reason == role.Id then
            (HomelandData.RemoveFromWaitingList)(role.Coordinate, role.Reason)
            -- DECOMPILER ERROR at PC174: Confused about usage of register: R4 in 'UnsetPending'

            ;
            (_roles[role.Reason]).PatrolTween = (HomelandRoomWindow.ReStartPatrol)(_roles[role.Reason])
            role.PatrolTween = (HomelandRoomWindow.ReStartPatrol)(role)
          else
            ;
            (table.insert)((((HomelandData.RoomData).GridWaiting)[destinationCoordinate.x])[destinationCoordinate.y], role)
          end
          return 
        end
        if (role.Coordinate).x < destinationCoordinate.x then
          (SkeletonAnimationUtil.SetFlip)(role.Model, false, false)
          destinationPos.x = destinationPos.x + (HomelandRoomConstant.XAxis).x
          destinationPos.y = destinationPos.y + (HomelandRoomConstant.XAxis).y
        else
          if destinationCoordinate.x < (role.Coordinate).x then
            (SkeletonAnimationUtil.SetFlip)(role.Model, true, false)
            destinationPos.x = destinationPos.x - (HomelandRoomConstant.XAxis).x
            destinationPos.y = destinationPos.y - (HomelandRoomConstant.XAxis).y
          else
            if (role.Coordinate).y < destinationCoordinate.y then
              (SkeletonAnimationUtil.SetFlip)(role.Model, true, false)
              destinationPos.x = destinationPos.x + (HomelandRoomConstant.YAxis).x
              destinationPos.y = destinationPos.y + (HomelandRoomConstant.YAxis).y
            else
              ;
              (SkeletonAnimationUtil.SetFlip)(role.Model, false, false)
              destinationPos.x = destinationPos.x - (HomelandRoomConstant.YAxis).x
              destinationPos.y = destinationPos.y - (HomelandRoomConstant.YAxis).y
            end
          end
        end
        ;
        (HomelandMgr.UpdateCardGridUsage)(destinationCoordinate.x, destinationCoordinate.y, role.Id)
        role.MoveToGrid = destinationCoordinate
        local tweener = (((LeanTween.value)(((role.Loader).displayObject).gameObject, function(value, ...)
    -- function num : 0_37_0 , upvalues : role, HomelandRoomWindow
    if role and role.Loader ~= nil and role.Alive then
      (HomelandRoomWindow.SetCardLoaderPos)(role, value)
    else
      role = nil
    end
  end
, (role.Loader).xy, destinationPos, MOVE_SINGLE_GRID_COST_TIME)):setDelay(delay)):setEaseLinear()
        ;
        (tweener:setOnStart(function(...)
    -- function num : 0_37_1 , upvalues : role, _ENV, HomelandRoomWindow, destinationCoordinate
    if role and not (Util.IsNil)(role.Model) and role.Alive then
      local count = #role.CoverGrid
      local pos = nil
      for i = 1, count do
        pos = ((role.CoverGrid)[i]).Coordinate
        ;
        (HomelandRoomWindow.ChangeFloorOwnerByRole)(pos, role.Id)
      end
      role.CoverGrid = (HomelandRoomWindow.SetRoleLayerIndex)(role.Loader, role.Id, destinationCoordinate)
      ;
      (SkeletonAnimationUtil.SetAnimation)(role.Model, 0, BattleCardState.WALK, true, nil, false, "0.1")
    end
  end
)):setOnComplete(function(...)
    -- function num : 0_37_2 , upvalues : role, _ENV, HomelandRoomWindow
    if role and not (Util.IsNil)(role.Model) and role.Alive then
      (HomelandMgr.UpdateCardGridUsage)((role.Coordinate).x, (role.Coordinate).y)
      if role.MoveToGrid then
        role.Coordinate = role.MoveToGrid
      end
      role.MoveToGrid = nil
      role.PathIndex = role.PathIndex + 1
      if #role.Path < role.PathIndex then
        (SkeletonAnimationUtil.SetAnimation)(role.Model, 0, BattleCardState.IDLE_WITHOUT_WEAPON, true)
        role.Path = nil
      end
      role.PatrolTween = (HomelandRoomWindow.StartPatrol)(role)
    else
      role = nil
    end
  end
)
        return tweener
      end
    end
  end
end

HomelandRoomWindow.SetRoleLayerIndex = function(model, id, coordinate, ...)
  -- function num : 0_38 , upvalues : HomelandRoomWindow, _roles, uis, _ENV
  local coverGrid = (HomelandRoomWindow.GetRoleCoverGrid)(coordinate)
  local furnitureInfo = (HomelandRoomWindow.GetCurrentFurnitureInfo)()
  local cover, coverBy = (HomelandRoomWindow.GetRoleRelation)(id, furnitureInfo, coverGrid, coordinate)
  local count = #coverGrid
  local data = nil
  for i = 1, count do
    data = coverGrid[i]
    ;
    (HomelandRoomWindow.ChangeFloorOwnerByRole)(data.Coordinate, id, data.Half and 0.5 or 1)
  end
  local coverLayer = (HomelandRoomWindow.GetCoverLayer)(cover, furnitureInfo, _roles)
  local coverByLayer = (HomelandRoomWindow.GetCoverByLayer)(coverBy, furnitureInfo, _roles)
  if coverLayer == nil or coverLayer < coverByLayer then
    ((uis.Currency).root):SetChildIndexBefore(model, coverByLayer)
  else
    if coverLayer == coverByLayer then
      ((uis.Currency).root):SetChildIndex(model, coverByLayer)
    else
      local layer = nil
      for k,v in pairs(cover) do
        if furnitureInfo[k] ~= nil then
          layer = ((uis.Currency).root):GetChildIndex((furnitureInfo[k]).Furniture)
          if coverByLayer <= layer then
            (HomelandRoomWindow.UpdateFurnitureCoverLayer)(furnitureInfo, k, coverByLayer)
            coverByLayer = (HomelandRoomWindow.GetCoverByLayer)(coverBy, furnitureInfo, _roles)
          end
        else
          layer = ((uis.Currency).root):GetChildIndex((_roles[k]).Loader)
          if coverByLayer <= layer then
            (HomelandRoomWindow.UpdateRoleCoverLayer)(furnitureInfo, k, coverByLayer)
            coverByLayer = (HomelandRoomWindow.GetCoverByLayer)(coverBy, furnitureInfo, _roles)
          end
        end
      end
      ;
      ((uis.Currency).root):SetChildIndexBefore(model, coverByLayer)
    end
  end
  do
    return coverGrid
  end
end

HomelandRoomWindow.GetRoleCoverGrid = function(coordinate, ...)
  -- function num : 0_39 , upvalues : _ENV, RoleCoverType, RoleCoverRange
  local coverGrid = {}
  ;
  (table.insert)(coverGrid, {Coordinate = (Util.CopyVec)(coordinate), Type = RoleCoverType.SelfCor, Half = false})
  local x, y = nil, nil
  for i = 1, RoleCoverRange.Up do
    for j = 1, RoleCoverRange.Side do
      x = coordinate.x - i
      y = coordinate.y - i + 1 + j - 1
      ;
      (table.insert)(coverGrid, {Coordinate = Vector2(x, y), Type = RoleCoverType.LeftSide, Half = j == RoleCoverRange.Side})
    end
  end
  for i = 1, RoleCoverRange.Up do
    for j = 1, RoleCoverRange.Side do
      x = coordinate.x - i + 1 + j - 1
      y = coordinate.y - i
      ;
      (table.insert)(coverGrid, {Coordinate = Vector2(x, y), Type = RoleCoverType.RightSide, Half = j == RoleCoverRange.Side})
    end
  end
  for i = 1, RoleCoverRange.Up do
    x = coordinate.x - i
    y = coordinate.y - i
    ;
    (table.insert)(coverGrid, {Coordinate = Vector2(x, y), Type = RoleCoverType.Upward, Half = false})
  end
  do return coverGrid end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

HomelandRoomWindow.GetRoleRelation = function(id, furnitureInfo, coverGrid, coordinate, ...)
  -- function num : 0_40 , upvalues : _floorLayerOwner, _ENV, RoleCoverType, _floorLayerOwnerByRole, _roles
  local weight = coordinate.x + coordinate.y
  local count = #coverGrid
  local info, pos, other, otherWeight = nil, nil, nil, nil
  local cover = {}
  local coverBy = {}
  local setCoverBy = function(rival, ...)
    -- function num : 0_40_0 , upvalues : cover, coverBy
    if cover[rival] then
      return 
    end
    coverBy[rival] = true
  end

  local setCover = function(rival, ...)
    -- function num : 0_40_1 , upvalues : coverBy, cover
    if coverBy[rival] then
      return 
    end
    cover[rival] = true
  end

  for i = 1, count do
    info = coverGrid[i]
    pos = info.Coordinate
    if _floorLayerOwner[pos.x] ~= nil and (_floorLayerOwner[pos.x])[pos.y] ~= nil then
      for k,v in pairs((_floorLayerOwner[pos.x])[pos.y]) do
        if not info.half or v ~= 0.5 then
          other = furnitureInfo[k]
          if other == nil then
            loge("@@@@@@@@@@@@@@@@@@@@@@:" .. tostring(k))
          else
            if info.Type == RoleCoverType.SelfCor then
              setCoverBy(k)
            else
              if info.Type == RoleCoverType.LeftSide then
                if coordinate.x <= (other.Coordinate).x and coordinate.y <= (other.Coordinate).y then
                  setCoverBy(k)
                else
                  if (other.Coordinate).x <= coordinate.x and (other.Coordinate).y <= coordinate.y then
                    setCover(k)
                  else
                    setCoverBy(k)
                  end
                end
              else
                if info.Type == RoleCoverType.RightSide then
                  if coordinate.x <= (other.Coordinate).x and coordinate.y <= (other.Coordinate).y then
                    setCoverBy(k)
                  else
                    if (other.Coordinate).x <= coordinate.x and (other.Coordinate).y <= coordinate.y then
                      setCover(k)
                    else
                      if (other.Coordinate).x < coordinate.x then
                        setCoverBy(k)
                      else
                        if coordinate.y <= (other.Coordinate).y + (other.Size).y - 1 then
                          setCoverBy(k)
                        else
                          setCover(k)
                        end
                      end
                    end
                  end
                else
                  if info.Type == RoleCoverType.Upward then
                    if coordinate.x < (other.Coordinate).x or coordinate.y < (other.Coordinate).y then
                      setCoverBy(k)
                    else
                      setCover(k)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    do
      if _floorLayerOwnerByRole[pos.x] ~= nil and (_floorLayerOwnerByRole[pos.x])[pos.y] ~= nil then
        for k,v in pairs((_floorLayerOwnerByRole[pos.x])[pos.y]) do
          if (not info.half or v ~= 0.5) and id ~= k then
            other = _roles[k]
            if other == nil then
              loge("@@@@@@@@@@@@@@@@@@@@@@:" .. tostring(k))
            else
              otherWeight = (other.Coordinate).x + (other.Coordinate).y
              if weight == otherWeight then
                if (other.Coordinate).x < coordinate.x then
                  setCoverBy(k)
                else
                  setCover(k)
                end
              else
                if otherWeight < weight then
                  setCover(k)
                else
                  setCoverBy(k)
                end
              end
            end
          end
        end
      end
      do
        -- DECOMPILER ERROR at PC239: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return cover, coverBy
end

HomelandRoomWindow.GetCoverLayer = function(cover, furnitureInfo, roles, ...)
  -- function num : 0_41 , upvalues : _ENV, uis
  local coverLayer, layer = nil, nil
  for k,v in pairs(cover) do
    if furnitureInfo[k] or roles ~= nil and roles[k] then
      if furnitureInfo[k] ~= nil then
        layer = ((uis.Currency).root):GetChildIndex((furnitureInfo[k]).Furniture)
      else
        layer = ((uis.Currency).root):GetChildIndex((roles[k]).Loader)
      end
      if coverLayer == nil or coverLayer < layer then
        coverLayer = layer
      end
    end
  end
  return coverLayer
end

HomelandRoomWindow.GetCoverByLayer = function(coverBy, furnitureInfo, roles, ...)
  -- function num : 0_42 , upvalues : _ENV, uis, _moveComInfo, _occupiedFurniture
  local coverByLayer, layer = nil, nil
  for k,v in pairs(coverBy) do
    if furnitureInfo[k] or roles ~= nil and roles[k] then
      if furnitureInfo[k] ~= nil then
        layer = ((uis.Currency).root):GetChildIndex((furnitureInfo[k]).Furniture)
      else
        layer = ((uis.Currency).root):GetChildIndex((roles[k]).Loader)
      end
      if coverByLayer == nil or layer < coverByLayer then
        coverByLayer = layer
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC66: Unhandled construct in 'MakeBoolean' P3

    -- DECOMPILER ERROR at PC66: Unhandled construct in 'MakeBoolean' P3

    if ((_moveComInfo.Com == nil or not (_moveComInfo.Com).visible or coverByLayer == nil) and (not ((uis.Currency).root).numChildren - 2 - _occupiedFurniture.Count)) then
      return coverByLayer
    end
  end
end

HomelandRoomWindow.GetCurrentFurnitureInfo = function(...)
  -- function num : 0_43 , upvalues : uis, _ENV, _furnitureInfo, _editFurnitureInfo, _editGridUsage, _editCarpetGridUsage
  if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Normal then
    return _furnitureInfo, (HomelandData.RoomData).GridUsage, (HomelandData.RoomData).CarpetGridUsage
  else
    return _editFurnitureInfo, _editGridUsage, _editCarpetGridUsage
  end
end

HomelandRoomWindow.GetCardLoader = function(noShadow, ...)
  -- function num : 0_44 , upvalues : _loaderPool, _ENV, ROLE_SIZE, uis, HomelandRoomWindow
  local loader, shadow = nil, nil
  if #_loaderPool == 0 then
    loader = ((FairyGUI.UIObjectFactory).NewObject)((FairyGUI.ObjectType).Loader)
    loader.size = ROLE_SIZE
    loader.pivot = Vector2(0.5, 1)
    loader.pivotAsAnchor = true
    loader.align = (FairyGUI.AlignType).Center
    loader.verticalAlign = (FairyGUI.VertAlignType).Bottom
    loader.scale = Vector2.one * HomelandRoomConstant.RoleScale
    ;
    ((uis.Currency).root):AddChild(loader)
  else
    local data = (table.remove)(_loaderPool, 1)
    loader = data.Loader
    shadow = data.Shadow
  end
  do
    if shadow == nil and not noShadow then
      shadow = (HomelandRoomWindow.GetRoleShadow)()
    end
    loader.visible = true
    if not noShadow then
      shadow.visible = true
    end
    return loader, shadow
  end
end

HomelandRoomWindow.GetRoleShadow = function(...)
  -- function num : 0_45 , upvalues : _ENV, uis
  local shadow = (((FairyGUI.UIPackage).CreateObject)((WinResConfig.HomelandRoomWindow).package, HomelandRoomResources.Shadow)).asImage
  shadow.pivot = Vector2(0.5, 0.5)
  shadow.width = HomelandRoomConstant.RoleScale * 110
  shadow.pivotAsAnchor = true
  ;
  ((uis.Currency).root):AddChildAt(shadow, ((uis.Currency).root):GetChildIndex(((uis.Currency).Hemming).root))
  return shadow
end

HomelandRoomWindow.SetCardLoaderPos = function(roleData, pos, ...)
  -- function num : 0_46 , upvalues : _currentBubble, ROLE_SIZE, ROLE_HEIGHT_FIX, uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (roleData.Loader).xy = pos
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (roleData.Shadow).xy = pos
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (roleData.Shadow).y = pos.y - 5
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  if roleData.Bubble then
    (roleData.Bubble).x = pos.x - _currentBubble.width * 0.5
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (roleData.Bubble).y = pos.y - ROLE_SIZE.y - ROLE_HEIGHT_FIX - _currentBubble.height + (roleData.BubbleOffset).y
    ;
    ((uis.Currency).root):InvalidateBatchingState()
  end
end

HomelandRoomWindow.RecycleCardLoader = function(loader, shadow, ...)
  -- function num : 0_47 , upvalues : _ENV, _loaderPool
  (Util.RecycleUIModel)(loader)
  loader.visible = false
  if shadow then
    shadow.visible = false
  end
  loader.gameObjectName = "NotUsing"
  ;
  (table.insert)(_loaderPool, {Loader = loader, Shadow = shadow})
end

HomelandRoomWindow.RefreshWall = function(id, ...)
  -- function num : 0_48 , upvalues : _ENV, _leftWall, HomelandRoomWindow, _leftWallHolder, _rightWall, _rightWallHolder, uis
  if id == nil then
    id = ((HomelandData.RoomData).Wall).Id
  end
  if id == 0 then
    id = HomelandRoomConstant.DefaultWall
  end
  _leftWall = (HomelandRoomWindow.InitWallOrFloor)(_leftWall, _leftWallHolder, id)
  _leftWall.scaleX = -(math.abs)(_leftWall.scaleX)
  _rightWall = (HomelandRoomWindow.InitWallOrFloor)(_rightWall, _rightWallHolder, id)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.Currency).Extend).c1Ctr).selectedIndex = (HomelandData.RoomData).Level - 1
  local gridAmount = (HomelandData.GetCurrentRoomSize)()
  _leftWall.width = gridAmount * HomelandRoomConstant.GridLength / _leftWall.scaleY
  _rightWall.width = gridAmount * HomelandRoomConstant.GridLength / _rightWall.scaleY
end

HomelandRoomWindow.RefreshFloor = function(id, ...)
  -- function num : 0_49 , upvalues : _ENV, _floor, HomelandRoomWindow, _floorHolder
  if id == nil then
    id = ((HomelandData.RoomData).Floor).Id
  end
  if id == 0 then
    id = HomelandRoomConstant.DefaultFloor
  end
  _floor = (HomelandRoomWindow.InitWallOrFloor)(_floor, _floorHolder, id, true)
  local gridAmount = (HomelandData.GetCurrentRoomSize)()
  _floor.size = Vector2.one * gridAmount * HomelandRoomConstant.GridLength / _floor.scaleX
  ;
  (_floor.displayObject):SetSkipFairyBatching(true)
end

HomelandRoomWindow.RefreshExtendArea = function(...)
  -- function num : 0_50 , upvalues : _ENV, uis, _floor, _floorHolder, _hemmingOirginPos, _roomAdjustScale, _xChanged, _posDiff, _originPosDiff
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  if ((HomelandData.RoomByLevel)[(HomelandData.RoomData).Type])[(HomelandData.RoomData).Level + 1] == nil then
    (((uis.Currency).Hemming).root).visible = false
    local size = (HomelandData.GetCurrentRoomSize)() * HomelandRoomConstant.GridLength
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.Currency).root).height = _floor.y + size * (math.sin)((_floorHolder.skew).y * math.pi / 180) * 2
  else
    do
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (((uis.Currency).Hemming).root).visible = true
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (((uis.Currency).Hemming).c1Ctr).selectedIndex = (HomelandData.RoomData).Level - 1
      local gridAmount = (HomelandData.GetCurrentRoomSize)()
      do
        local extraHeight = (gridAmount - HomelandRoomConstant.DefaultGridCount) * (HomelandRoomConstant.GridProject).sin * 2
        -- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (((uis.Currency).Hemming).root).y = _hemmingOirginPos.y + extraHeight
        -- DECOMPILER ERROR at PC75: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((uis.Currency).root).height = (((uis.Currency).Hemming).root).y
        _roomAdjustScale = _hemmingOirginPos.y / ((uis.Currency).root).height
        _xChanged = ((uis.Currency).root).width * (1 - _roomAdjustScale)
        _posDiff.x = _originPosDiff.x - _xChanged * 0.5
        -- DECOMPILER ERROR at PC104: Confused about usage of register: R0 in 'UnsetPending'

        if (HomelandData.RoomData).Relation ~= HomelandHostRelation.Self then
          (((uis.Currency).Hemming).root).visible = false
        end
      end
    end
  end
end

HomelandRoomWindow.InitWallOrFloor = function(target, source, id, isFloor, ...)
  -- function num : 0_51 , upvalues : _ENV, uis, HomelandRoomWindow
  if target ~= nil then
    target:Dispose()
  end
  local config = ((TableData.gTable).BaseFamilyFurnitureData)[id]
  local str = split(config.resource, ":")
  target = (((FairyGUI.UIPackage).CreateObject)(str[1], str[2])).asImage
  target.gameObjectName = id
  local originalHeight = target.height
  ;
  ((uis.Currency).root):AddChildAt(target, 1)
  if isFloor then
    target.scale = Vector2.one * HomelandRoomConstant.GridLength * 2 / target.width
  else
    target.scale = Vector2.one * HomelandRoomConstant.WallHeight / target.height
  end
  ;
  (HomelandRoomWindow.SetComponentArg)(target, source)
  if not isFloor then
    target.height = originalHeight
  end
  return target
end

HomelandRoomWindow.SetComponentArg = function(com, source, ...)
  -- function num : 0_52
  com.size = source.size
  com.xy = source.xy
  com.skew = source.skew
end

HomelandRoomWindow.SortDecorate = function(furnitures, customData, ...)
  -- function num : 0_53 , upvalues : _leftSideDecorateSortList, _rightSideDecorateSortList, _ENV, HomelandRoomWindow, _leftSideDecorateSortListIndex, _rightSideDecorateSortListIndex
  _leftSideDecorateSortList = {}
  _rightSideDecorateSortList = {}
  if customData then
    for k,v in pairs(furnitures) do
      if (v.Coordinate).x == 0 then
        (table.insert)(_leftSideDecorateSortList, {id = v.Uid, Coordinate = v.Coordinate})
      else
        if (v.Coordinate).y == 0 then
          (table.insert)(_rightSideDecorateSortList, {id = v.Uid, Coordinate = v.Coordinate})
        end
      end
    end
  else
    do
      for k,v in pairs(furnitures) do
        if v.xCoordinate == 0 then
          (table.insert)(_leftSideDecorateSortList, {id = v.uid, Coordinate = Vector3(v.xCoordinate, v.yCoordinate, v.zCoordinate)})
        else
          if v.yCoordinate == 0 then
            (table.insert)(_rightSideDecorateSortList, {id = v.uid, Coordinate = Vector3(v.xCoordinate, v.yCoordinate, v.zCoordinate)})
          end
        end
      end
      do
        ;
        (table.sort)(_leftSideDecorateSortList, HomelandRoomWindow.DecorateSort)
        ;
        (table.sort)(_rightSideDecorateSortList, HomelandRoomWindow.DecorateSort)
        local count = #_leftSideDecorateSortList
        for i = 1, count do
          _leftSideDecorateSortListIndex[(_leftSideDecorateSortList[i]).id] = i
        end
        count = #_rightSideDecorateSortList
        for i = 1, count do
          _rightSideDecorateSortListIndex[(_rightSideDecorateSortList[i]).id] = i
        end
      end
    end
  end
end

HomelandRoomWindow.ResortDecorateSortList = function(list, indexList, ...)
  -- function num : 0_54 , upvalues : _ENV, HomelandRoomWindow
  (table.sort)(list, HomelandRoomWindow.DecorateSort)
  local count = #list
  for i = 1, count do
    indexList[(list[i]).id] = i
  end
end

HomelandRoomWindow.DecorateSort = function(x, y, ...)
  -- function num : 0_55
  if (x.Coordinate).x == 0 then
    if (x.Coordinate).y == (y.Coordinate).y then
      if (x.Coordinate).z == (y.Coordinate).z then
        return false
      else
        return (x.Coordinate).z < (y.Coordinate).z
      end
    else
      return (x.Coordinate).y < (y.Coordinate).y
    end
  elseif (x.Coordinate).x == (y.Coordinate).x then
    if (x.Coordinate).z == (y.Coordinate).z then
      return false
    else
      return (x.Coordinate).z < (y.Coordinate).z
    end
  else
    return (x.Coordinate).x < (y.Coordinate).x
  end
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

HomelandRoomWindow.UpdateDecorateSort = function(uid, coordinate, list, ...)
  -- function num : 0_56
  local count = #list
  for i = 1, count do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R8 in 'UnsetPending'

    if (list[i]).id == uid then
      (list[i]).Coordinate = coordinate
      break
    end
  end
end

HomelandRoomWindow.AddDecorateSort = function(uid, coordinate, ...)
  -- function num : 0_57 , upvalues : _ENV, _leftSideDecorateSortList, _leftSideDecorateSortListIndex, _rightSideDecorateSortList, _rightSideDecorateSortListIndex
  if coordinate.x == 0 then
    (Util.AddToIndexList)({id = uid, Coordinate = coordinate}, _leftSideDecorateSortList, _leftSideDecorateSortListIndex, function(...)
    -- function num : 0_57_0 , upvalues : _leftSideDecorateSortList, coordinate
    local count = #_leftSideDecorateSortList
    local index = nil
    for i = 1, count do
      if coordinate.y < ((_leftSideDecorateSortList[i]).Coordinate).y then
        index = i
        break
      else
        if ((_leftSideDecorateSortList[i]).Coordinate).y == coordinate.y and coordinate.z < ((_leftSideDecorateSortList[i]).Coordinate).z then
          index = i
          break
        end
      end
    end
    do
      if index == nil then
        index = count + 1
      end
      return index
    end
  end
)
  else
    ;
    (Util.AddToIndexList)({id = uid, Coordinate = coordinate}, _rightSideDecorateSortList, _rightSideDecorateSortListIndex, function(...)
    -- function num : 0_57_1 , upvalues : _rightSideDecorateSortList, coordinate
    local count = #_rightSideDecorateSortList
    local index = nil
    for i = 1, count do
      if coordinate.x < ((_rightSideDecorateSortList[i]).Coordinate).x then
        index = i
        break
      else
        if ((_rightSideDecorateSortList[i]).Coordinate).x == coordinate.x and coordinate.z < ((_rightSideDecorateSortList[i]).Coordinate).z then
          index = i
          break
        end
      end
    end
    do
      if index == nil then
        index = count + 1
      end
      return index
    end
  end
)
  end
end

HomelandRoomWindow.RemoveDecorateSort = function(type, belongTo, uid, ...)
  -- function num : 0_58 , upvalues : _ENV, _leftSideDecorateSortList, _leftSideDecorateSortListIndex, _rightSideDecorateSortList, _rightSideDecorateSortListIndex
  if type == HomelandFurnitureType.Decorate then
    if belongTo == HomelandRoomGridType.LeftWall then
      (Util.RemoveFromIndexList)(uid, _leftSideDecorateSortList, _leftSideDecorateSortListIndex)
    else
      ;
      (Util.RemoveFromIndexList)(uid, _rightSideDecorateSortList, _rightSideDecorateSortListIndex)
    end
  end
end

HomelandRoomWindow.RefreshFurniture = function(data, cb, ...)
  -- function num : 0_59 , upvalues : HomelandRoomWindow, _leftSideDecorateSortList, _leftSideDecorateSortListIndex, _rightSideDecorateSortList, _rightSideDecorateSortListIndex, _ENV, uis
  (HomelandRoomWindow.RecycleAllFurniture)()
  _leftSideDecorateSortList = {}
  _leftSideDecorateSortListIndex = {}
  _rightSideDecorateSortList = {}
  _rightSideDecorateSortListIndex = {}
  local furnitures, sortter, setter = nil, nil, nil
  if data then
    local furnitureInfo = (HomelandRoomWindow.GetCurrentFurnitureInfo)()
    furnitures = {}
    for k,v in pairs(data) do
      (table.insert)(furnitures, v)
    end
    sortter = function(x, y, ...)
    -- function num : 0_59_0
    local xWeight = (x.Coordinate).x + (x.Coordinate).y
    local yWeight = (y.Coordinate).x + (y.Coordinate).y
    if xWeight == yWeight then
      return false
    else
      return xWeight < yWeight
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end

    setter = function(v, ...)
    -- function num : 0_59_1 , upvalues : HomelandRoomWindow
    return (HomelandRoomWindow.PlaceFurniture)(v.Uid, v.ConfigId, v.Turn, (v.Coordinate).x, (v.Coordinate).y, (v.Coordinate).z, v.GridStatus, v.ComPosition, v.BelongTo, v.OriginCoordinate, v.OriginBelongTo, v.OriginTurn, v.GridDetail, v.Status)
  end

  else
    do
      furnitures = (HomelandData.RoomData).Furniture
      sortter = function(x, y, ...)
    -- function num : 0_59_2
    local xWeight = x.xCoordinate + x.yCoordinate
    local yWeight = y.xCoordinate + y.yCoordinate
    if xWeight == yWeight then
      return false
    else
      return xWeight < yWeight
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end

      setter = function(data, ...)
    -- function num : 0_59_3 , upvalues : HomelandRoomWindow, _ENV
    do return (HomelandRoomWindow.PlaceFurniture)(data.uid, data.id, data.orientation == 1, data.xCoordinate, data.yCoordinate, data.zCoordinate, HomelandRoomGridStatus.Available) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

      ;
      (table.sort)(furnitures, sortter)
      local furniture = nil
      local count = #furnitures
      for i = 1, count do
        furniture = setter(furnitures[i])
        if (uis.c1Ctr).selectedIndex ~= HomelandRoomStatus.Edit then
          do
            furniture.touchable = not furniture
            -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
end

HomelandRoomWindow.AsyncRefreshFurniture = function(data, index, setter, touchable, cb, ...)
  -- function num : 0_60 , upvalues : _ENV, ASYNC_EACH_DURATION, ASYNC_EACH_AMOUNT, _asyncTimer, HomelandRoomWindow
  local count = #data
  if index <= count then
    return (SimpleTimer.setTimeout)(ASYNC_EACH_DURATION, function(...)
    -- function num : 0_60_0 , upvalues : index, ASYNC_EACH_AMOUNT, count, setter, data, touchable, _asyncTimer, HomelandRoomWindow, cb
    local estimateCount = index + ASYNC_EACH_AMOUNT
    local finalCount = count < estimateCount and count or estimateCount
    local furniture = nil
    for i = index, finalCount do
      furniture = setter(data[i])
      furniture.touchable = touchable
    end
    index = index + ASYNC_EACH_AMOUNT + 1
    _asyncTimer = (HomelandRoomWindow.AsyncRefreshFurniture)(data, index, setter, touchable, cb)
  end
)
  else
    if cb then
      cb()
    end
    _asyncTimer = nil
  end
end

HomelandRoomWindow.ClearData = function(destroy, ...)
  -- function num : 0_61 , upvalues : _floorLayerOwner, _furnitureRelation, _floorLayerOwnerByRole, uis, _ENV, _furnitureInfo, _editGridUsage, _editCarpetGridUsage, _editFurnitureInfo
  _floorLayerOwner = {}
  _furnitureRelation = {}
  _floorLayerOwnerByRole = {}
  if destroy or (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Normal then
    _furnitureInfo = {}
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (HomelandData.RoomData).CarpetGridUsage = {}
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (HomelandData.RoomData).GridUsage = {}
  else
    _editGridUsage = {}
    _editCarpetGridUsage = {}
    _editFurnitureInfo = {}
  end
end

HomelandRoomWindow.InitEditGrids = function(config, ...)
  -- function num : 0_62 , upvalues : HomelandRoomWindow, _moveComInfo, _ENV, _floor, _leftWall, _floorHolder, _rightWall
  (HomelandRoomWindow.HideEditGrids)()
  if _moveComInfo.BelongTo == HomelandRoomGridType.Floor then
    local editGrid = (HomelandRoomWindow.InitSingleEditGrid)(HomelandRoomGridType.Floor, _floor, Vector2.zero)
    editGrid.gameObjectName = "FloorEdit"
    ;
    (HomelandRoomWindow.SetComponentArg)(editGrid, _floor)
    editGrid.size = Vector2.one * (HomelandData.GetCurrentRoomSize)() * HomelandRoomConstant.GridLength / editGrid.scaleX
  else
    do
      local editGrid = (HomelandRoomWindow.InitSingleEditGrid)(HomelandRoomGridType.LeftWall, _leftWall, Vector2(0, 1), true)
      editGrid.gameObjectName = "LeftWallEdit"
      editGrid.scaleX = (math.abs)(editGrid.scaleX)
      editGrid.xy = _floorHolder.xy
      editGrid.skew = _leftWall.skew
      editGrid.width = (HomelandData.GetCurrentRoomSize)() * HomelandRoomConstant.GridLength / editGrid.scaleX
      editGrid.height = HomelandRoomConstant.WallHeight / editGrid.scaleY
      editGrid.scaleX = -(math.abs)(editGrid.scaleX)
      editGrid = (HomelandRoomWindow.InitSingleEditGrid)(HomelandRoomGridType.RightWall, _rightWall, Vector2(0, 1), true)
      editGrid.gameObjectName = "RightWallEdit"
      editGrid.xy = _floorHolder.xy
      editGrid.skew = _leftWall.skew
      editGrid.width = (HomelandData.GetCurrentRoomSize)() * HomelandRoomConstant.GridLength / editGrid.scaleX
      editGrid.height = HomelandRoomConstant.WallHeight / editGrid.scaleY
    end
  end
end

HomelandRoomWindow.HideEditGrids = function(...)
  -- function num : 0_63 , upvalues : _editGrid, _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  if _editGrid[HomelandRoomGridType.Floor] then
    (_editGrid[HomelandRoomGridType.Floor]).visible = false
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  if _editGrid[HomelandRoomGridType.LeftWall] then
    (_editGrid[HomelandRoomGridType.LeftWall]).visible = false
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

  if _editGrid[HomelandRoomGridType.RightWall] then
    (_editGrid[HomelandRoomGridType.RightWall]).visible = false
  end
end

HomelandRoomWindow.InitSingleEditGrid = function(type, layerCom, pivot, wall, ...)
  -- function num : 0_64 , upvalues : _editGrid, HomelandRoomWindow
  if _editGrid[type] == nil then
    _editGrid[type] = (HomelandRoomWindow.GetEditGrid)(layerCom, wall)
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (_editGrid[type]).pivot = pivot
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (_editGrid[type]).pivotAsAnchor = true
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (_editGrid[type]).visible = true
  return _editGrid[type]
end

HomelandRoomWindow.GetEditGrid = function(layerCom, wall, ...)
  -- function num : 0_65 , upvalues : _ENV, uis
  local grid = nil
  if wall then
    grid = (((FairyGUI.UIPackage).CreateObject)((WinResConfig.HomelandRoomWindow).package, HomelandRoomResources.WhiteWallGrid)).asImage
  else
    grid = (((FairyGUI.UIPackage).CreateObject)((WinResConfig.HomelandRoomWindow).package, HomelandRoomResources.WhiteGrid)).asImage
  end
  grid.scale = Vector2.one * HomelandRoomConstant.GridLength / grid.width
  ;
  ((uis.Currency).root):AddChildAt(grid, ((uis.Currency).root):GetChildIndex(layerCom) + 1)
  ;
  (grid.displayObject):SetSkipFairyBatching(true)
  return grid
end

HomelandRoomWindow.RecycleResources = function(com, ...)
  -- function num : 0_66 , upvalues : _ENV
  if com and type(com) == "table" then
    for k,v in pairs(com) do
      if not (Util.IsNil)(v) and type(v) == "table" then
        for subk,subv in pairs(v) do
          if subv ~= nil then
            subv:Dispose()
          end
        end
        v = {}
      else
        if not (Util.IsNil)(v) then
          v:Dispose()
        end
      end
      com[k] = nil
    end
    return {}
  else
    if com ~= nil then
      com:Dispose()
    end
    return nil
  end
end

HomelandRoomWindow.RefreshFurnitureTagItem = function(index, item, ...)
  -- function num : 0_67 , upvalues : _ENV, _furnitureType, uis, HomelandRoomWindow
  if index == 0 then
    (item:GetChild("NameTxt")).text = (PUtil.get)(25)
  else
    ;
    (item:GetChild("NameTxt")).text = (PUtil.get)(60000533 + index)
  end
  item.selected = _furnitureType == index
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_67_0 , upvalues : item, uis, HomelandRoomWindow, index
    item.selected = true
    ;
    ((uis.Warehouse).BtnList):RefreshVirtualList()
    ;
    (HomelandRoomWindow.RefreshFurnitureIcon)(index, true)
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HomelandRoomWindow.GetSwipeGesture = function(item, ...)
  -- function num : 0_68 , upvalues : _swipeGestures, _ENV
  if _swipeGestures[item.uid] ~= nil then
    return _swipeGestures[item.uid]
  else
    local gesture = (FairyGUI.SwipeGesture)(item)
    _swipeGestures[item.uid] = gesture
    gesture.actionDistance = 100
    return gesture
  end
end

HomelandRoomWindow.RefreshFurnitureItem = function(index, item, ...)
  -- function num : 0_69 , upvalues : _ENV, _furnitureItemTimer, uis, HomelandRoomWindow
  index = index + 1
  local id = (HomelandData.EditCurrentFurnitures)[index]
  local config = ((TableData.gTable).BaseFamilyFurnitureData)[id]
  local itemFrame = item:GetChild("ItemFrame")
  ;
  (itemFrame:GetChild("IconLoader")).url = (Util.GetItemUrl)(config.icon)
  local datas = (HomelandData.EditPileFurnitures)[id]
  ;
  (itemFrame:GetChild("NumberTxt")).text = #datas
  ;
  (item:GetController("c1")).selectedIndex = 1
  if config.type ~= HomelandFurnitureType.Wall and config.type ~= HomelandFurnitureType.Floor then
    local size = split(config.size, ":")
    ;
    (item:GetChild("WordTxt")).text = size[1] .. " x " .. size[2]
  else
    do
      ;
      (item:GetChild("WordTxt")).text = ""
      local uid = datas[1]
      local time = nil
      if config.time ~= -1 then
        time = (HomelandData.GetFurnitureTime)(uid)
        local count = #datas
        for i = 1, count do
          if time < (HomelandData.GetFurnitureTime)(datas[i]) then
            uid = datas[i]
            time = (HomelandData.GetFurnitureTime)(uid)
          end
        end
        local timer = (SimpleTimer.setTimeout)(time + config.time - (LuaTime.GetTimeStamp)() + 1, function(...)
    -- function num : 0_69_0 , upvalues : _ENV, id, uid
    (HomelandMgr.RemoveFurnitureFromUI)(id, uid, true)
  end
)
        ;
        (table.insert)(_furnitureItemTimer, timer)
      end
      do
        ;
        (item.onClick):Set(function(...)
    -- function num : 0_69_1 , upvalues : item, uis, _ENV, id, time
    local pos = item.xy
    pos.x = pos.x + item.width * 0.5 + (((uis.Warehouse).CardHeadList).container).x + ((uis.Warehouse).CardHeadList).x + ((uis.Warehouse).root).x
    pos.y = pos.y + (((uis.Warehouse).CardHeadList).container).y + ((uis.Warehouse).CardHeadList).y + ((uis.Warehouse).root).y
    OpenWindow((WinResConfig.FamilyTipsWindow).name, UILayer.HUD, 2, id, time, pos, item.size)
  end
)
        local swipeGes = ((HomelandRoomWindow.GetSwipeGesture)(item))
        local drag = nil
        ;
        (swipeGes.onBegin):Set(function(...)
    -- function num : 0_69_2 , upvalues : config, _ENV, swipeGes, drag, HomelandRoomWindow, id, uis
    local totalSize = nil
    do
      if config.type == HomelandFurnitureType.Furniture then
        local size = split(config.size, ":")
        totalSize = tonumber(size[1]) * tonumber(size[2])
        if (HomelandData.RoomData).CardGridCount < totalSize + #(HomelandData.RoomData).Role then
          (MessageMgr.SendCenterTips)((PUtil.get)(60000597))
          return 
        end
      end
      local angle = (math.atan)((swipeGes.position).y / (swipeGes.position).x)
      if (math.abs)(angle) > 1 then
        drag = (HomelandRoomWindow.InitMoveFurniture)(config, id, true, totalSize)
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

        if drag then
          (((uis.Warehouse).CardHeadList).scrollPane).touchEffect = false
        end
      end
    end
  end
)
        ;
        (swipeGes.onMove):Set(function(Context, ...)
    -- function num : 0_69_3 , upvalues : drag, HomelandRoomWindow
    if not drag then
      return 
    end
    ;
    (HomelandRoomWindow.MovingFurniture)()
  end
)
        ;
        (swipeGes.onEnd):Set(function(context, ...)
    -- function num : 0_69_4 , upvalues : drag, HomelandRoomWindow, uis
    if drag then
      (HomelandRoomWindow.AfterPlaceCom)(context, true)
    end
    drag = false
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.Warehouse).CardHeadList).scrollPane).touchEffect = true
  end
)
      end
    end
  end
end

HomelandRoomWindow.ChangePlacedFurnitureStatus = function(data, status, noAnim, ...)
  -- function num : 0_70 , upvalues : _ENV, HomelandRoomWindow
  if data ~= nil then
    if status and (data.Status == FurnitureEditStatus.MoveOrRotate or data.Status == FurnitureEditStatus.Add) and not noAnim then
      data.PlaceAnim = (HomelandRoomWindow.PlayFurniutreAnim)(data.Furniture, data.Coordinate)
    else
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (data.Furniture).visible = status
    end
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

    if data.WindowView ~= nil then
      (data.WindowView).visible = status
    end
  end
end

HomelandRoomWindow.InitMoveFurniture = function(config, uid, new, totalSize, ...)
  -- function num : 0_71 , upvalues : _ENV, _moveComInfo, HomelandRoomWindow, uis, _editFurnitureInfo, _currentEditGridUsage, _editCarpetGridUsage, _editGridUsage, SELECTED_ALPHA, _occupiedFurniture, _rightWallHolder
  if (_G.next)(_moveComInfo) == nil then
    (HomelandRoomWindow.InitMoveComponentInfo)()
  end
  ;
  (HomelandRoomWindow.PlaceNewFurniture)()
  if totalSize and (HomelandData.RoomData).CardGridCount < totalSize + #(HomelandData.RoomData).Role then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000597))
    ;
    (HomelandRoomWindow.HideMoveFurniture)()
    return false
  end
  ;
  ((uis.Currency).root):SetChildIndex(_moveComInfo.Com, ((uis.Currency).root).numChildren - 1)
  if new then
    local datas = (HomelandData.EditPileFurnitures)[uid]
    uid = datas[1]
    local count = #datas
    for i = 1, count do
      if (HomelandData.GetFurnitureTime)(uid) < (HomelandData.GetFurnitureTime)(datas[i]) then
        uid = datas[i]
      end
    end
  end
  do
    do
      if not _moveComInfo.New and _moveComInfo.Uid ~= nil and _moveComInfo.Uid ~= uid then
        local data = _editFurnitureInfo[_moveComInfo.Uid]
        if data.Status == FurnitureEditStatus.MoveOrRotate or data.Status == FurnitureEditStatus.Add then
          data.PlaceAnim = (HomelandRoomWindow.PlayFurniutreAnim)(data.Furniture, data.Coordinate)
        else
          -- DECOMPILER ERROR at PC93: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (data.Furniture).visible = true
        end
      end
      local same = false
      if _moveComInfo.Furniture ~= nil then
        if _moveComInfo.Id == config.id then
          same = true
        else
          ;
          (_moveComInfo.Furniture):Dispose()
        end
      end
      -- DECOMPILER ERROR at PC108: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (_moveComInfo.Com).visible = true
      _moveComInfo.Uid = uid
      _moveComInfo.New = new
      _moveComInfo.Id = config.id
      _moveComInfo.Type = config.type
      _moveComInfo.Direction = config.direction
      if _moveComInfo.Type == HomelandFurnitureType.Carpet then
        _currentEditGridUsage = _editCarpetGridUsage
      else
        _currentEditGridUsage = _editGridUsage
      end
      -- DECOMPILER ERROR at PC135: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (_moveComInfo.ChangeOrientationBtn).visible = _moveComInfo.Type ~= HomelandFurnitureType.Decorate
      -- DECOMPILER ERROR at PC149: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (_moveComInfo.AdjustCom).visible = _moveComInfo.Type ~= HomelandFurnitureType.Wall and _moveComInfo.Type ~= HomelandFurnitureType.Floor
      do
        if not same then
          local str = nil
          if _moveComInfo.Type == HomelandFurnitureType.Wall or _moveComInfo.Type == HomelandFurnitureType.Floor then
            str = split(config.icon, ":")
          else
            str = split(config.resource, ":")
          end
          _moveComInfo.Furniture = (((FairyGUI.UIPackage).CreateObject)(str[1], str[2])).asImage
          -- DECOMPILER ERROR at PC184: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (_moveComInfo.Furniture).alpha = SELECTED_ALPHA
          ;
          (_moveComInfo.Com):AddChildAt(_moveComInfo.Furniture, 0)
        end
        -- DECOMPILER ERROR at PC193: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (_moveComInfo.Com).size = (_moveComInfo.Furniture).size
        ;
        (HomelandRoomWindow.InitMoveBeginPos)(new, uid)
        if _occupiedFurniture[uid] then
          _moveComInfo.GridStatus = HomelandRoomGridStatus.Occupied
        else
          _moveComInfo.GridStatus = HomelandRoomGridStatus.Available
        end
        if _moveComInfo.Type ~= HomelandFurnitureType.Floor and _moveComInfo.Type ~= HomelandFurnitureType.Wall then
          local flip = false
          if _moveComInfo.Type == HomelandFurnitureType.Decorate then
            if _rightWallHolder.x > (_moveComInfo.Com).x or not HomelandRoomGridType.RightWall then
              do
                _moveComInfo.BelongTo = HomelandRoomGridType.LeftWall
                ;
                (HomelandRoomWindow.CheckDecorateFlip)(config.direction, _moveComInfo.BelongTo, _moveComInfo.Furniture)
                flip = (_moveComInfo.Furniture).flip == (FairyGUI.FlipType).Horizontal
                _moveComInfo.BelongTo = HomelandRoomGridType.Floor
                if _editFurnitureInfo[uid] ~= nil then
                  local turn = nil
                  if (_editFurnitureInfo[uid]).Status ~= FurnitureEditStatus.Remove then
                    turn = (_editFurnitureInfo[uid]).Turn
                  else
                    turn = nil
                  end
                  -- DECOMPILER ERROR at PC274: Confused about usage of register: R7 in 'UnsetPending'

                  if turn then
                    (_moveComInfo.Furniture).flip = (FairyGUI.FlipType).Horizontal
                  else
                    -- DECOMPILER ERROR at PC280: Confused about usage of register: R7 in 'UnsetPending'

                    (_moveComInfo.Furniture).flip = (FairyGUI.FlipType).None
                  end
                  _moveComInfo.Turn = turn
                  flip = _moveComInfo.Turn
                else
                  -- DECOMPILER ERROR at PC288: Confused about usage of register: R6 in 'UnsetPending'

                  (_moveComInfo.Furniture).flip = (FairyGUI.FlipType).None
                  _moveComInfo.Turn = nil
                end
                ;
                (HomelandRoomWindow.InitSelectedBelongGrid)(config.id, flip)
                -- DECOMPILER ERROR at PC305: Confused about usage of register: R6 in 'UnsetPending'

                ;
                (_moveComInfo.Furniture).xy = (HomelandRoomWindow.GetFunritureOffset)(config, _moveComInfo.BelongTo, _moveComInfo.Size, (_moveComInfo.Furniture).width, (_moveComInfo.Furniture).height, _moveComInfo.Turn)
                -- DECOMPILER ERROR at PC326: Confused about usage of register: R6 in 'UnsetPending'

                if config.type == HomelandFurnitureType.Decorate then
                  (_moveComInfo.AdjustCom).xy = Vector2((_moveComInfo.Furniture).x + (_moveComInfo.Com).width * 0.5, (_moveComInfo.Furniture).y + (_moveComInfo.Com).height * 0.5)
                end
                ;
                (HomelandRoomWindow.InitEditGrids)(config)
                if _editFurnitureInfo[uid] ~= nil then
                  if not new then
                    (HomelandRoomWindow.ChangePlacedFurnitureStatus)(_editFurnitureInfo[uid], false)
                  end
                  local coordinate = (_editFurnitureInfo[uid]).Coordinate
                  _moveComInfo.Coordinate = (Util.CopyVec)(coordinate)
                else
                  _moveComInfo.Coordinate = Vector3.zero
                end
                ;
                (HomelandRoomWindow.RefreshMoveFurnitureGridStatus)()
                _moveComInfo.BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)(_moveComInfo.BelongingGrid)
                if not (Util.StringIsNullOrEmpty)(config.perspectivity) then
                  _moveComInfo.WindowView = (HomelandRoomWindow.SetWindowView)(config, (_moveComInfo.Furniture).x + (_moveComInfo.Com).x, (_moveComInfo.Furniture).y + (_moveComInfo.Com).y, _moveComInfo.WindowView, nil, _moveComInfo.Com, (_moveComInfo.Com):GetChildIndex(_moveComInfo.Furniture) - 1)
                  -- DECOMPILER ERROR at PC388: Confused about usage of register: R5 in 'UnsetPending'

                  ;
                  (_moveComInfo.WindowView).alpha = SELECTED_ALPHA
                  -- DECOMPILER ERROR at PC395: Confused about usage of register: R5 in 'UnsetPending'

                  ;
                  (_moveComInfo.WindowView).x = (_moveComInfo.Furniture).x + (_moveComInfo.WindowViewRect).x
                  -- DECOMPILER ERROR at PC402: Confused about usage of register: R5 in 'UnsetPending'

                  ;
                  (_moveComInfo.WindowView).y = (_moveComInfo.Furniture).y + (_moveComInfo.WindowViewRect).y
                else
                  -- DECOMPILER ERROR at PC408: Confused about usage of register: R5 in 'UnsetPending'

                  if _moveComInfo.WindowView ~= nil then
                    (_moveComInfo.WindowView).visible = false
                  end
                  _moveComInfo.WindowViewRect = nil
                end
                ;
                (HomelandRoomWindow.SetAdjustComSize)(_moveComInfo.Type)
                do return true end
                -- DECOMPILER ERROR: 28 unprocessed JMP targets
              end
            end
          end
        end
      end
    end
  end
end

HomelandRoomWindow.RefreshMoveFurnitureGridStatus = function(...)
  -- function num : 0_72 , upvalues : _occupiedFurniture, _moveComInfo, _editFurnitureInfo, HomelandRoomWindow
  if _occupiedFurniture[_moveComInfo.Uid] then
    local info = _editFurnitureInfo[_moveComInfo.Uid]
    ;
    (HomelandRoomWindow.SetGridUsage)(_moveComInfo.BelongingGrid, info.GridDetail)
  else
    do
      ;
      (HomelandRoomWindow.SetGridUsage)(_moveComInfo.BelongingGrid, nil, true)
    end
  end
end

HomelandRoomWindow.InitMoveComponentInfo = function(...)
  -- function num : 0_73 , upvalues : _moveComInfo, _ENV, uis, HomelandRoomWindow
  _moveComInfo = {}
  _moveComInfo.Com = ((FairyGUI.UIPackage).CreateObject)((WinResConfig.HomelandRoomWindow).package, HomelandRoomResources.MoveFurnitureCom)
  ;
  ((uis.Currency).root):AddChild(_moveComInfo.Com)
  _moveComInfo.AdjustCom = (_moveComInfo.Com):GetChild("Adjust")
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_moveComInfo.AdjustCom).xy = Vector2.zero
  _moveComInfo.CoverImg = (_moveComInfo.AdjustCom):GetChild("n0")
  _moveComInfo.OriginCoverImgSize = (_moveComInfo.CoverImg).size
  _moveComInfo.ChangeOrientationBtn = (_moveComInfo.AdjustCom):GetChild("TurnBtn")
  _moveComInfo.DeleteBtn = (_moveComInfo.AdjustCom):GetChild("DeleteBtn")
  ;
  ((_moveComInfo.ChangeOrientationBtn).onClick):Set(HomelandRoomWindow.ChangeOrientation)
  ;
  ((_moveComInfo.DeleteBtn).onClick):Set(HomelandRoomWindow.RemoveSelectedFurniture)
end

HomelandRoomWindow.ChangeOrientation = function(context, ...)
  -- function num : 0_74 , upvalues : _moveComInfo, _ENV, HomelandRoomWindow, _currentEditGridUsage, _editFurnitureInfo
  context:StopPropagation()
  if not _moveComInfo.New then
    if _moveComInfo.GridStatus == HomelandRoomGridStatus.Available then
      if _moveComInfo.Type == HomelandFurnitureType.Furniture then
        (HomelandRoomWindow.RemoveFurnitureRelation)(_moveComInfo.Uid, _moveComInfo.Type)
      end
      ;
      (HomelandRoomWindow.RefreshRangeGridUsage)(_moveComInfo.BelongTo, _currentEditGridUsage, _moveComInfo.Size, _moveComInfo.Coordinate)
    end
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (_editFurnitureInfo[_moveComInfo.Uid]).BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)((_editFurnitureInfo[_moveComInfo.Uid]).BelongingGrid)
  end
  _moveComInfo.Turn = not _moveComInfo.Turn
  ;
  (HomelandRoomWindow.InitSelectedBelongGrid)(_moveComInfo.Id, _moveComInfo.Turn)
  ;
  (HomelandRoomWindow.ChangeCoordinateAfterChangeOrientation)()
  ;
  (HomelandRoomWindow.UpdateBelongingGridUsage)(true)
  ;
  (HomelandRoomWindow.FlipFurniture)()
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R1 in 'UnsetPending'

  if not _moveComInfo.New and _moveComInfo.GridStatus == HomelandRoomGridStatus.Available then
    if _moveComInfo.Type == HomelandFurnitureType.Furniture then
      (_editFurnitureInfo[_moveComInfo.Uid]).CoverGrid = (HomelandRoomWindow.SetFurnitureLayerIndex)((_editFurnitureInfo[_moveComInfo.Uid]).Furniture, _moveComInfo.Uid, _moveComInfo.Coordinate, _moveComInfo.Size)
    end
    ;
    (HomelandRoomWindow.RefreshRangeGridUsage)(_moveComInfo.BelongTo, _currentEditGridUsage, _moveComInfo.Size, _moveComInfo.Coordinate, true)
  end
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R1 in 'UnsetPending'

  if _editFurnitureInfo[_moveComInfo.Uid] ~= nil and (_editFurnitureInfo[_moveComInfo.Uid]).Status ~= FurnitureEditStatus.Add then
    (_editFurnitureInfo[_moveComInfo.Uid]).Status = FurnitureEditStatus.MoveOrRotate
  end
  ;
  (HomelandRoomWindow.CheckOccupiedFurnitureStatus)()
end

HomelandRoomWindow.ChangeCoordinateAfterChangeOrientation = function(...)
  -- function num : 0_75 , upvalues : _moveComInfo, _ENV, HomelandRoomWindow
  if (_moveComInfo.Size).y == (_moveComInfo.Size).x then
    return 
  end
  local halfX = (math.ceil)((_moveComInfo.Size).y * 0.5)
  local halfY = (math.ceil)((_moveComInfo.Size).x * 0.5)
  local coordX = (_moveComInfo.Coordinate).x + halfX - 1
  local coordY = (_moveComInfo.Coordinate).y + halfY - 1
  if (_moveComInfo.Size).y % 2 ~= 0 then
    coordX = coordX - halfY + 1
    coordY = coordY + halfX - (_moveComInfo.Size).y
  else
    coordY = coordY + 1
    coordX = coordX - halfY + 1
    coordY = coordY + halfX - (_moveComInfo.Size).y
  end
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (_moveComInfo.Coordinate).x = coordX
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (_moveComInfo.Coordinate).y = coordY
  local config = ((TableData.gTable).BaseFamilyFurnitureData)[_moveComInfo.Id]
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (_moveComInfo.Com).xy = (HomelandRoomWindow.GetFurniturePositionByCoordinate)(config, _moveComInfo.Turn, _moveComInfo.Coordinate, (_moveComInfo.Furniture).size)
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (_moveComInfo.Furniture).xy = (HomelandRoomWindow.GetFunritureOffset)(config, _moveComInfo.BelongTo, _moveComInfo.Size, (_moveComInfo.Furniture).width, (_moveComInfo.Furniture).height, _moveComInfo.Turn)
end

HomelandRoomWindow.FlipFurniture = function(...)
  -- function num : 0_76 , upvalues : _moveComInfo, _ENV, _editFurnitureInfo, HomelandRoomWindow, _currentEditGridUsage
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  if _moveComInfo.Furniture ~= nil then
    if (_moveComInfo.Furniture).flip == (FairyGUI.FlipType).None then
      (_moveComInfo.Furniture).flip = (FairyGUI.FlipType).Horizontal
    else
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (_moveComInfo.Furniture).flip = (FairyGUI.FlipType).None
    end
  end
  if _editFurnitureInfo[_moveComInfo.Uid] ~= nil then
    local data = _editFurnitureInfo[_moveComInfo.Uid]
    local furniture = data.Furniture
    local loader = furniture:GetChild("FurnitureItemLoader")
    local config = ((TableData.gTable).BaseFamilyFurnitureData)[data.ConfigId]
    local offsetStr = nil
    if not (Util.StringIsNullOrEmpty)(config.move_location) then
      offsetStr = split(config.move_location, ":")
    end
    local offsetX = 0
    if _moveComInfo.Turn then
      loader.scaleX = -1
      if offsetStr then
        offsetX = -tonumber(offsetStr[1])
      end
      loader.x = offsetX + (loader.size).x
    else
      loader.scaleX = 1
      if offsetStr then
        offsetX = tonumber(offsetStr[1])
      end
      loader.x = offsetX
    end
    data.Turn = _moveComInfo.Turn
    data.Size = _moveComInfo.Size
    data.Coordinate = (Util.CopyVec)(_moveComInfo.Coordinate)
    furniture.xy = (_moveComInfo.Com).xy
    data.ComPosition = furniture.xy
    data.SelectedBelongTo = _moveComInfo.BelongTo
    if _moveComInfo.GridStatus ~= HomelandRoomGridStatus.Available then
      loader.alpha = HomelandData.UnavailableAlpha
      data.BelongingGrid = (HomelandRoomWindow.InitBelongingGrid)(data.Turn, data.ConfigId, data.Furniture, data.BelongTo, (data.Furniture).size, data.Size)
      data.GridStatus = (HomelandRoomWindow.CheckGridUsage)(data.Coordinate, data.Size, data.BelongTo, data.BelongingGrid, _currentEditGridUsage)
      ;
      (HomelandRoomWindow.SetGridUsage)(data.BelongingGrid, data.GridDetail)
    else
      loader.alpha = 1
      data.GridStatus = HomelandRoomGridStatus.Available
    end
  end
end

HomelandRoomWindow.InitSelectedBelongGrid = function(id, turn, ...)
  -- function num : 0_77 , upvalues : _moveComInfo, HomelandRoomWindow
  _moveComInfo.BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)(_moveComInfo.BelongingGrid)
  _moveComInfo.BelongingGrid = (HomelandRoomWindow.InitBelongingGrid)(turn, id, _moveComInfo.Com, _moveComInfo.BelongTo, (_moveComInfo.Furniture).size)
end

HomelandRoomWindow.InitBelongingGrid = function(turn, id, com, belongTo, furnitureSize, size, ...)
  -- function num : 0_78 , upvalues : _ENV, HomelandRoomWindow, _leftWallHolder, _leftWall, _rightWallHolder, _floorHolder
  local config = ((TableData.gTable).BaseFamilyFurnitureData)[id]
  local beginPos = Vector2.zero
  local line, greenGrid, redGrid, originPoint, sizeX, sizeY = nil, nil, nil, nil, nil, nil
  if size == nil then
    local sizeInfo = split(config.size, ":")
    sizeX = tonumber(sizeInfo[1])
    sizeY = tonumber(sizeInfo[2])
    if config.type ~= HomelandFurnitureType.Decorate and turn then
      sizeX = sizeX + sizeY
      sizeY = sizeX - sizeY
      sizeX = sizeX - (sizeY)
    end
    size = Vector2(sizeX, sizeY)
  else
    do
      sizeX = size.x
      sizeY = size.y
      local belongingGrid = {}
      local getter = function(resources, belongTo, horizontal, ...)
    -- function num : 0_78_0 , upvalues : HomelandRoomWindow, com, _ENV
    local grid = (HomelandRoomWindow.PullFromPool)(resources, com)
    grid.name = resources
    com:SetChildIndex(grid, 0)
    grid.pivotAsAnchor = true
    if belongTo == HomelandRoomGridType.LeftWall then
      grid.pivot = Vector2.one
    else
      if belongTo == HomelandRoomGridType.RightWall then
        grid.pivot = Vector2(0, 1)
      else
        grid.pivot = Vector2.zero
      end
    end
    if belongTo ~= nil and belongTo ~= HomelandRoomGridType.Floor and not horizontal then
      grid.height = -(HomelandRoomConstant.ZAxis).y / grid.scaleY
    else
      grid.height = HomelandRoomConstant.GridLength / grid.scaleY
    end
    return grid
  end

      local setGrid = function(grid, i, j, skew, axis1, axis2, ...)
    -- function num : 0_78_1 , upvalues : originPoint
    grid.skew = skew
    local vec1 = axis1 * (i - 1)
    local vec2 = axis2 * (j - 1)
    grid.x = originPoint.x + vec1.x + vec2.x
    grid.y = originPoint.y + vec1.y + vec2.y
  end

      local setLine = function(line, rotation, xy, belong, ...)
    -- function num : 0_78_2 , upvalues : _ENV
    line.rotation = rotation
    line.xy = xy
    ;
    (table.insert)(belong, line)
  end

      local SetBelongingGrid = function(gridSkew, axis1, axis2, lineSkew1, lineSkew2, belongTo, ...)
    -- function num : 0_78_3 , upvalues : sizeX, sizeY, getter, _ENV, setGrid, setLine, belongingGrid
    local line, pos = nil, nil
    for i = 1, sizeX do
      for j = 1, sizeY do
        local data = {}
        data.GreenGrid = getter(HomelandRoomResources.GreenGrid, belongTo)
        setGrid(data.GreenGrid, i, j, gridSkew, axis1, axis2)
        data.RedGrid = getter(HomelandRoomResources.RedGrid, belongTo)
        setGrid(data.RedGrid, i, j, gridSkew, axis1, axis2)
        data.GreenLines = {}
        data.RedLines = {}
        if i == 1 then
          line = getter(HomelandRoomResources.GreenLine, belongTo)
          setLine(line, lineSkew1, (data.GreenGrid).xy, data.GreenLines)
          line = getter(HomelandRoomResources.RedLine, belongTo)
          setLine(line, lineSkew1, (data.GreenGrid).xy, data.RedLines)
        end
        if i == sizeX then
          pos = Vector2((data.GreenGrid).x + axis1.x, (data.GreenGrid).y + axis1.y)
          line = getter(HomelandRoomResources.GreenLine, belongTo)
          setLine(line, lineSkew1, pos, data.GreenLines)
          line = getter(HomelandRoomResources.RedLine, belongTo)
          setLine(line, lineSkew1, pos, data.RedLines)
        end
        if j == 1 then
          line = getter(HomelandRoomResources.GreenLine, belongTo, true)
          setLine(line, lineSkew2, (data.GreenGrid).xy, data.GreenLines)
          line = getter(HomelandRoomResources.RedLine, belongTo, true)
          setLine(line, lineSkew2, (data.GreenGrid).xy, data.RedLines)
        end
        if j == sizeY then
          pos = Vector2((data.GreenGrid).x + axis2.x, (data.GreenGrid).y + axis2.y)
          line = getter(HomelandRoomResources.GreenLine, belongTo, true)
          setLine(line, lineSkew2, pos, data.GreenLines)
          line = getter(HomelandRoomResources.RedLine, belongTo, true)
          setLine(line, lineSkew2, pos, data.RedLines)
        end
        if belongingGrid[i] == nil then
          belongingGrid[i] = {}
        end
        -- DECOMPILER ERROR at PC184: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (belongingGrid[i])[j] = data
      end
    end
  end

      if config.type == HomelandFurnitureType.Decorate then
        if belongTo == HomelandRoomGridType.LeftWall then
          originPoint = (HomelandRoomWindow.GetLeftWallBelongingGridOriginPoint)(config, sizeX, sizeY)
          SetBelongingGrid(Vector2((_leftWallHolder.skew).x, -(_leftWall.skew).y), HomelandRoomConstant.YAxis, HomelandRoomConstant.ZAxis, 0, -90 - (_leftWall.skew).y, HomelandRoomGridType.LeftWall)
        else
          originPoint = (HomelandRoomWindow.GetRightWallBelongingGridOriginPoint)(config, sizeX, sizeY)
          SetBelongingGrid(_rightWallHolder.skew, HomelandRoomConstant.XAxis, HomelandRoomConstant.ZAxis, 0, 90 + (_leftWall.skew).y, HomelandRoomGridType.RightWall)
        end
      else
        originPoint = (HomelandRoomWindow.GetFloorBelongingGridOriginPoint)(config, sizeX, sizeY, furnitureSize)
        SetBelongingGrid(_floorHolder.skew, HomelandRoomConstant.XAxis, HomelandRoomConstant.YAxis, (_floorHolder.skew).x, -(_floorHolder.skew).x)
      end
      return belongingGrid, size
    end
  end
end

HomelandRoomWindow.GetFunritureOffset = function(config, belongTo, size, furnitureWidth, furnitureHeight, turn, ...)
  -- function num : 0_79 , upvalues : _ENV, HomelandRoomWindow
  local offset = Vector2.zero
  if config.type == HomelandFurnitureType.Decorate then
    offset = (HomelandRoomWindow.GetDecorateOffset)(config, belongTo, size, furnitureWidth, furnitureHeight)
  else
    if not (Util.StringIsNullOrEmpty)(config.move_location) then
      local offsetStr = split(config.move_location, ":")
      if turn then
        offset.x = -tonumber(offsetStr[1])
      else
        offset.x = tonumber(offsetStr[1])
      end
      offset.y = -tonumber(offsetStr[2])
    end
  end
  do
    return offset
  end
end

HomelandRoomWindow.GetDecorateOffset = function(config, belongTo, size, furnitureWidth, furnitureHeight, ...)
  -- function num : 0_80 , upvalues : HomelandRoomWindow, _ENV
  local offset = (HomelandRoomWindow.GetDefaultDecorateOffset)(belongTo, size, furnitureWidth, furnitureHeight)
  do
    if not (Util.StringIsNullOrEmpty)(config.move_location) then
      local offsetStr = split(config.move_location, ":")
      if belongTo == HomelandRoomGridType.LeftWall then
        offset.x = offset.x + tonumber(offsetStr[1])
      else
        offset.x = offset.x - tonumber(offsetStr[1])
      end
      offset.y = offset.y - tonumber(offsetStr[2])
    end
    return offset
  end
end

HomelandRoomWindow.GetDefaultDecorateOffset = function(belongTo, size, furnitureWidth, furnitureHeight, ...)
  -- function num : 0_81 , upvalues : _ENV
  local pos = Vector2.zero
  if belongTo == HomelandRoomGridType.LeftWall then
    local total = size.x * (HomelandRoomConstant.GridProject).sin + size.y * HomelandRoomConstant.GridLength
    pos.y = size.y * HomelandRoomConstant.GridLength - (total - furnitureHeight) * 0.5 - furnitureHeight
  else
    do
      do
        local total = size.x * (HomelandRoomConstant.GridProject).sin + size.y * HomelandRoomConstant.GridLength
        pos.y = (total - furnitureHeight) * 0.5
        pos.x = (size.x * (HomelandRoomConstant.GridProject).cos - furnitureWidth) * 0.5
        return pos
      end
    end
  end
end

HomelandRoomWindow.GetFloorBelongingGridOriginPoint = function(config, sizeX, sizeY, furnitureSize, ...)
  -- function num : 0_82 , upvalues : _ENV
  local pos = Vector2.zero
  pos.y = furnitureSize.y - (sizeX + sizeY) * (HomelandRoomConstant.GridProject).sin
  pos.x = sizeY / (sizeX + sizeY) * furnitureSize.x
  return pos
end

HomelandRoomWindow.GetLeftWallBelongingGridOriginPoint = function(config, sizeX, sizeY, ...)
  -- function num : 0_83 , upvalues : _ENV
  local pos = Vector2.zero
  pos.x = sizeX * (HomelandRoomConstant.GridProject).cos
  pos.y = -(HomelandRoomConstant.GridProject).sin * sizeX + sizeY * HomelandRoomConstant.GridLength
  return pos
end

HomelandRoomWindow.GetRightWallBelongingGridOriginPoint = function(config, sizeX, sizeY, ...)
  -- function num : 0_84 , upvalues : _ENV
  local pos = Vector2.zero
  pos.x = 0
  pos.y = sizeY * HomelandRoomConstant.GridLength
  return pos
end

HomelandRoomWindow.RecycleBelongingGrid = function(belongingGrid, destroy, ...)
  -- function num : 0_85 , upvalues : _ENV, HomelandRoomWindow
  if belongingGrid ~= nil and (_G.next)(belongingGrid) ~= nil then
    local count = nil
    if destroy then
      for k,v in pairs(belongingGrid) do
        for subk,subv in pairs(v) do
          (subv.GreenGrid):Dispose()
          ;
          (subv.RedGrid):Dispose()
          count = #subv.GreenLines
          for i = 1, count do
            ((subv.GreenLines)[i]):Dispose()
          end
          count = #subv.RedLines
          for i = 1, count do
            ((subv.RedLines)[i]):Dispose()
          end
        end
      end
    else
      do
        for k,v in pairs(belongingGrid) do
          for subk,subv in pairs(v) do
            (HomelandRoomWindow.PushToPool)(subv.GreenGrid)
            ;
            (HomelandRoomWindow.PushToPool)(subv.RedGrid)
            count = #subv.GreenLines
            for i = 1, count do
              (HomelandRoomWindow.PushToPool)((subv.GreenLines)[i])
            end
            count = #subv.RedLines
            for i = 1, count do
              (HomelandRoomWindow.PushToPool)((subv.RedLines)[i])
            end
          end
        end
        do
          return nil
        end
      end
    end
  end
end

HomelandRoomWindow.CleanMoveComInfo = function(...)
  -- function num : 0_86 , upvalues : _moveComInfo, HomelandRoomWindow
  if _moveComInfo.WindowView ~= nil then
    (_moveComInfo.WindwoView):Dispose()
  end
  _moveComInfo.BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)(_moveComInfo.BelongingGrid)
  _moveComInfo.Furniture = (HomelandRoomWindow.RecycleResources)(_moveComInfo.Furniture)
  _moveComInfo.Com = (HomelandRoomWindow.RecycleResources)(_moveComInfo.Com)
  _moveComInfo = {}
end

HomelandRoomWindow.SetAdjustComSize = function(type, ...)
  -- function num : 0_87 , upvalues : _ENV, _moveComInfo
  if type == HomelandFurnitureType.Wall or type == HomelandFurnitureType.Floor then
    return 
  end
  local size = (_moveComInfo.Com).size
  if HomelandRoomConstant.MaxChooseCircleSize < size.x then
    size.x = HomelandRoomConstant.MaxChooseCircleSize
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_moveComInfo.CoverImg).width = size.x
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_moveComInfo.CoverImg).height = (_moveComInfo.OriginCoverImgSize).y * size.x / (_moveComInfo.OriginCoverImgSize).x
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_moveComInfo.AdjustCom).x = ((_moveComInfo.Com).size).x * 0.5 + (_moveComInfo.Furniture).x
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_moveComInfo.AdjustCom).y = ((_moveComInfo.Com).size).y * 0.5 + (_moveComInfo.Furniture).y
end

HomelandRoomWindow.InitMoveBeginPos = function(new, uid, ...)
  -- function num : 0_88 , upvalues : _moveComInfo, _editFurnitureInfo, HomelandRoomWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  if not new then
    (_moveComInfo.Com).xy = (_editFurnitureInfo[uid]).ComPosition
  else
    local pos = (HomelandRoomWindow.GetTouchPosition)()
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (_moveComInfo.Com).x = pos.x
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (_moveComInfo.Com).y = pos.y
  end
end

HomelandRoomWindow.BeforeMoveFurniture = function(...)
  -- function num : 0_89 , upvalues : _moveComInfo, _ENV, HomelandRoomWindow, _currentEditGridUsage
  if _moveComInfo.GridStatus == HomelandRoomGridStatus.Available then
    (HomelandRoomWindow.RefreshRangeGridUsage)(_moveComInfo.BelongTo, _currentEditGridUsage, _moveComInfo.Size, _moveComInfo.Coordinate)
    ;
    (HomelandRoomWindow.UpdateBelongingGridUsage)()
  end
end

HomelandRoomWindow.AfterPlaceCom = function(context, fromUI, ...)
  -- function num : 0_90 , upvalues : _moveComInfo, _ENV, _editWall, HomelandRoomWindow, _editFloor
  if _moveComInfo.Type == HomelandFurnitureType.Wall then
    local pos = {x = (_moveComInfo.Com).x + (_moveComInfo.Com).width * 0.5, y = (_moveComInfo.Com).y + (_moveComInfo.Com).height * 0.5}
    if (Util.isPointInRect)(pos, (HomelandRoomConstant.LeftWallRect).TopLeft, (HomelandRoomConstant.LeftWallRect).BottomLeft, (HomelandRoomConstant.LeftWallRect).TopRight, (HomelandRoomConstant.LeftWallRect).BottomRight) or (Util.isPointInRect)(pos, (HomelandRoomConstant.RightWallRect).TopLeft, (HomelandRoomConstant.RightWallRect).BottomLeft, (HomelandRoomConstant.RightWallRect).TopRight, (HomelandRoomConstant.RightWallRect).BottomRight) then
      if _editWall.Id ~= 0 then
        (HomelandMgr.AddFurnitureToUI)(_editWall.Id, _editWall.Uid)
      end
      _editWall = {Id = _moveComInfo.Id, Uid = _moveComInfo.Uid}
      ;
      (HomelandMgr.RemoveFurnitureFromUI)(_editWall.Id, _editWall.Uid)
      ;
      (HomelandRoomWindow.RefreshWall)(_editWall.Id)
    end
    ;
    (HomelandRoomWindow.HideMoveFurniture)()
  else
    do
      if _moveComInfo.Type == HomelandFurnitureType.Floor then
        local pos = {x = (_moveComInfo.Com).x + (_moveComInfo.Com).width * 0.5, y = (_moveComInfo.Com).y + (_moveComInfo.Com).height * 0.5}
        if (Util.isPointInRect)(pos, (HomelandRoomConstant.FloorRect).TopLeft, (HomelandRoomConstant.FloorRect).BottomLeft, (HomelandRoomConstant.FloorRect).TopRight, (HomelandRoomConstant.FloorRect).BottomRight) then
          if _editFloor.Id ~= 0 then
            (HomelandMgr.AddFurnitureToUI)(_editFloor.Id, _editFloor.Uid)
          end
          _editFloor = {Id = _moveComInfo.Id, Uid = _moveComInfo.Uid}
          ;
          (HomelandMgr.RemoveFurnitureFromUI)(_editFloor.Id, _editFloor.Uid)
          ;
          (HomelandRoomWindow.RefreshFloor)(_editFloor.Id)
        end
        ;
        (HomelandRoomWindow.HideMoveFurniture)()
      else
        do
          local config = ((TableData.gTable).BaseFamilyFurnitureData)[_moveComInfo.Id]
          if config.time ~= -1 and (HomelandData.GetFurnitureTime)(_moveComInfo.Uid) + config.time <= (LuaTime.GetTimeStamp)() then
            if _moveComInfo.New then
              (HomelandMgr.RemoveFurnitureFromUI)(_moveComInfo.Id, _moveComInfo.Uid, true)
              ;
              (MessageMgr.SendCenterTips)((PUtil.get)(60000555, config.name))
            else
              ;
              (HomelandRoomWindow.FurnitureTimeUp)(_moveComInfo.Uid, _moveComInfo.Type, config.name)
            end
            ;
            (HomelandRoomWindow.HideMoveFurniture)()
          else
            if _moveComInfo.GridStatus == HomelandRoomGridStatus.OutOfRoom then
              (HomelandRoomWindow.RemoveSelectedFurniture)(context, fromUI)
            else
              if _moveComInfo.GridStatus == HomelandRoomGridStatus.Occupied then
                if not _moveComInfo.New then
                  (HomelandRoomWindow.PutFurnitureBack)()
                else
                  ;
                  (HomelandRoomWindow.InitMoveComSwipeGesture)()
                  if fromUI then
                    (HomelandMgr.RemoveFurnitureFromUI)(_moveComInfo.Id, _moveComInfo.Uid)
                  end
                end
              else
                if not _moveComInfo.New then
                  (HomelandRoomWindow.MoveFurniture)()
                else
                  ;
                  (HomelandRoomWindow.InitMoveComSwipeGesture)()
                  if fromUI then
                    (HomelandMgr.RemoveFurnitureFromUI)(_moveComInfo.Id, _moveComInfo.Uid)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

HomelandRoomWindow.PutFurnitureBack = function(...)
  -- function num : 0_91 , upvalues : _editFurnitureInfo, _moveComInfo, _ENV, HomelandRoomWindow, _editCarpetGridUsage, _editGridUsage
  local data = _editFurnitureInfo[_moveComInfo.Uid]
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_moveComInfo.Com).xy = data.ComPosition
  if _moveComInfo.Type == HomelandFurnitureType.Decorate and _moveComInfo.BelongTo ~= data.SelectedBelongTo then
    _moveComInfo.BelongTo = data.SelectedBelongTo
    ;
    (HomelandRoomWindow.CheckDecorateFlip)(_moveComInfo.Direction, data.SelectedBelongTo, _moveComInfo.Furniture)
    ;
    (HomelandRoomWindow.InitSelectedBelongGrid)(_moveComInfo.Id)
    local config = ((TableData.gTable).BaseFamilyFurnitureData)[_moveComInfo.Id]
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (_moveComInfo.Furniture).xy = (HomelandRoomWindow.GetFunritureOffset)(config, _moveComInfo.BelongTo, _moveComInfo.Size, (_moveComInfo.Furniture).width, (_moveComInfo.Furniture).height, _moveComInfo.Turn)
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (_moveComInfo.AdjustCom).xy = Vector2((_moveComInfo.Furniture).x + (_moveComInfo.Com).width * 0.5, (_moveComInfo.Furniture).y + (_moveComInfo.Com).height * 0.5)
  end
  do
    _moveComInfo.Coordinate = (Util.CopyVec)(data.Coordinate)
    ;
    (HomelandRoomWindow.UpdateBelongingGridUsage)()
    do
      if data.GridStatus == HomelandRoomGridStatus.Available then
        local config = ((TableData.gTable).BaseFamilyFurnitureData)[data.ConfigId]
        if config.type == HomelandFurnitureType.Carpet then
          (HomelandRoomWindow.RefreshRangeGridUsage)(data.BelongTo, _editCarpetGridUsage, data.Size, data.Coordinate, true)
        else
          ;
          (HomelandRoomWindow.RefreshRangeGridUsage)(data.BelongTo, _editGridUsage, data.Size, data.Coordinate, true)
        end
      end
      ;
      (HomelandRoomWindow.RefreshMoveFurnitureGridStatus)()
    end
  end
end

HomelandRoomWindow.RefreshFurnitureList = function(...)
  -- function num : 0_92 , upvalues : _ENV, _furnitureItemTimer, uis
  for k,v in pairs(_furnitureItemTimer) do
    v:stop()
  end
  _furnitureItemTimer = {}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Warehouse).CardHeadList).numItems = #HomelandData.EditCurrentFurnitures
end

HomelandRoomWindow.MoveFurniture = function(...)
  -- function num : 0_93 , upvalues : _editFurnitureInfo, _moveComInfo, HomelandRoomWindow, _ENV, _currentEditGridUsage
  local data = _editFurnitureInfo[_moveComInfo.Uid]
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (data.Loader).alpha = 1
  ;
  (HomelandRoomWindow.ChangeOccupiedStatus)(_moveComInfo.Uid)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (data.Furniture).x = (_moveComInfo.Com).x
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (data.Furniture).y = (_moveComInfo.Com).y
  local config = ((TableData.gTable).BaseFamilyFurnitureData)[data.ConfigId]
  local offset = (HomelandRoomWindow.GetFunritureOffset)(config, _moveComInfo.BelongTo, _moveComInfo.Size, (_moveComInfo.Furniture).width, (_moveComInfo.Furniture).height, _moveComInfo.Turn)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

  if _moveComInfo.Type == HomelandFurnitureType.Decorate then
    if (_moveComInfo.Furniture).flip == (FairyGUI.FlipType).Horizontal then
      (data.Loader).scaleX = -1
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (data.Loader).x = ((data.Loader).size).x + offset.x
    else
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (data.Loader).scaleX = 1
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (data.Loader).x = offset.x
    end
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (data.Loader).y = offset.y
  end
  if data.WindowView ~= nil then
    (HomelandRoomWindow.SetWindowView)(nil, (data.Furniture).x + (data.Loader).x, (data.Furniture).y + (data.Loader).y, data.WindowView, data.WindowViewRect)
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (data.WindowView).x = (data.Furniture).x + (data.Loader).x
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (data.WindowView).y = (data.Furniture).y + (data.Loader).y + (data.WindowViewRect).y
    -- DECOMPILER ERROR at PC108: Confused about usage of register: R3 in 'UnsetPending'

    if (data.Loader).scaleX == -1 then
      (data.WindowView).x = (data.WindowView).x - (data.Furniture).width + (data.WindowViewRect).x
    else
      -- DECOMPILER ERROR at PC116: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (data.WindowView).x = (data.WindowView).x + (data.WindowViewRect).x
    end
  end
  local updateDecList = _moveComInfo.BelongTo ~= data.BelongTo
  local originBelongTo = data.BelongTo
  data.Coordinate = (Util.CopyVec)(_moveComInfo.Coordinate)
  data.BelongTo = _moveComInfo.BelongTo
  data.ComPosition = (_moveComInfo.Com).xy
  data.SelectedBelongTo = _moveComInfo.BelongTo
  data.GridStatus = HomelandRoomGridStatus.Available
  if data.Status ~= FurnitureEditStatus.Add then
    data.Status = FurnitureEditStatus.MoveOrRotate
  end
  ;
  (HomelandRoomWindow.RefreshRangeGridUsage)(_moveComInfo.BelongTo, _currentEditGridUsage, _moveComInfo.Size, _moveComInfo.Coordinate, true)
  if config.type == HomelandFurnitureType.Furniture then
    (HomelandRoomWindow.RemoveFurnitureRelation)(data.Uid, config.type)
    data.CoverGrid = (HomelandRoomWindow.SetFurnitureLayerIndex)(data.Furniture, _moveComInfo.Uid, data.Coordinate, data.Size)
  elseif config.type == HomelandFurnitureType.Decorate then
    (HomelandRoomWindow.RefreshDecorateSort)(data, config.type, originBelongTo)
  end
  data.BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)(data.BelongingGrid)
  ;
  (HomelandRoomWindow.CheckOccupiedFurnitureStatus)()
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

HomelandRoomWindow.RefreshDecorateSort = function(data, type, oldBelongTo, newBelongTo, coordinate, ...)
  -- function num : 0_94 , upvalues : _ENV, HomelandRoomWindow
  if type ~= HomelandFurnitureType.Decorate then
    return 
  end
  ;
  (HomelandRoomWindow.RemoveDecorateSort)(type, oldBelongTo, data.Uid)
  if not coordinate then
    (HomelandRoomWindow.AddDecorateSort)(data.Uid, data.Coordinate)
    if not newBelongTo then
      (HomelandRoomWindow.SetDecorateSort)(data.BelongTo, data.Uid, data.Furniture)
    end
  end
end

HomelandRoomWindow.SetDecorateSort = function(belongTo, uid, furniture, ...)
  -- function num : 0_95 , upvalues : _ENV, uis, _rightWallHolder, _leftSideDecorateSortListIndex, _floorHolder, _rightSideDecorateSortListIndex
  local index, baseIndex = nil, nil
  if belongTo == HomelandRoomGridType.LeftWall then
    baseIndex = ((uis.Currency).root):GetChildIndex(_rightWallHolder)
    index = baseIndex + _leftSideDecorateSortListIndex[uid]
  else
    baseIndex = ((uis.Currency).root):GetChildIndex(_floorHolder)
    index = baseIndex + _rightSideDecorateSortListIndex[uid]
  end
  local originIndex = ((uis.Currency).root):GetChildIndex(furniture)
  if originIndex < index - 1 then
    index = index - 1
  end
  ;
  ((uis.Currency).root):SetChildIndex(furniture, index)
end

HomelandRoomWindow.InitEditData = function(init, data, ...)
  -- function num : 0_96 , upvalues : _editGridUsage, _ENV, _editCarpetGridUsage, _editFurnitureInfo, _furnitureInfo, _initStyleId, _editWall, _editFloor, _occupiedFurniture, HomelandRoomWindow
  if init then
    _editGridUsage = (Util.Copy)((HomelandData.RoomData).GridUsage)
    _editCarpetGridUsage = (Util.Copy)((HomelandData.RoomData).CarpetGridUsage)
    _editFurnitureInfo = (Util.Copy)(_furnitureInfo)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    HomelandData.EditUndeployFurnitures = (Util.Copy)(HomelandData.UndeployFurnitures)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

    HomelandData.EditPileFurnitures = (Util.Copy)(HomelandData.PileFurnitures)
    _initStyleId = (HomelandData.RoomData).StyleId
  end
  if data == nil then
    _editWall = (HomelandData.RoomData).Wall
    _editFloor = (HomelandData.RoomData).Floor
    _occupiedFurniture = {Count = 0}
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

    if not init then
      (HomelandData.RoomData).CardGridCount = 0
      local size = ((HomelandData.GetCurrentRoomSize)())
      -- DECOMPILER ERROR at PC60: Overwrote pending register: R3 in 'AssignReg'

      local config = .end
      for k,v in pairs(_editFurnitureInfo) do
        do
          config = ((TableData.gTable).BaseFamilyFurnitureData)[v.ConfigId]
          -- DECOMPILER ERROR at PC86: Confused about usage of register: R9 in 'UnsetPending'

          if config.type == HomelandFurnitureType.Furniture then
            do
              (HomelandData.RoomData).CardGridCount = (HomelandData.RoomData).CardGridCount + (v.Size).x * (v.Size).y
              -- DECOMPILER ERROR at PC87: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC87: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      -- DECOMPILER ERROR at PC96: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (HomelandData.RoomData).CardGridCount = size * size - (HomelandData.RoomData).CardGridCount
      -- DECOMPILER ERROR at PC107: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (HomelandData.RoomData).CardGridCount = (HomelandData.RoomData).CardGridCount - #(HomelandData.RoomData).Role
    end
  else
    do
      _editWall = data.Wall
      _editFloor = data.Floor
      -- DECOMPILER ERROR at PC116: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (HomelandData.RoomData).CardGridCount = data.AvailableGridCount
      for k,v in pairs(_editFurnitureInfo) do
        local item = v
        -- DECOMPILER ERROR at PC126: Confused about usage of register: R8 in 'UnsetPending'

        if v.Furniture then
          (v.Furniture).touchable = true
          ;
          ((v.Furniture).onClick):Set(function(context, ...)
    -- function num : 0_96_0 , upvalues : _ENV, item, HomelandRoomWindow
    context:StopPropagation()
    local config = ((TableData.gTable).BaseFamilyFurnitureData)[item.ConfigId]
    ;
    (HomelandRoomWindow.InitMoveFurniture)(config, item.Uid)
    ;
    (HomelandRoomWindow.InitMoveComSwipeGesture)()
  end
)
        end
      end
    end
  end
end

HomelandRoomWindow.ClearEditData = function(syncCom, ...)
  -- function num : 0_97 , upvalues : _editInfo, _editGridUsage, _editCarpetGridUsage, _ENV, _furnitureInfo, _editFurnitureInfo, _editWall, _editFloor
  _editInfo = {}
  _editGridUsage = {}
  _editCarpetGridUsage = {}
  if syncCom then
    for k,v in pairs(_furnitureInfo) do
      if _editFurnitureInfo[k] then
        v.Furniture = (_editFurnitureInfo[k]).Furniture
      end
    end
  end
  do
    for k,v in pairs(_editFurnitureInfo) do
      local item = v
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (v.Furniture).touchable = false
      ;
      ((v.Furniture).onClick):Clear()
    end
    _editFurnitureInfo = {}
    _editWall = {Id = 0}
    _editFloor = {Id = 0}
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

    HomelandData.EditUndeployFurnitures = {}
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

    HomelandData.EditCurrentFurnitures = nil
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

    HomelandData.EditPileFurnitures = nil
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

    HomelandData.EditCurrentType = nil
  end
end

HomelandRoomWindow.HideMoveFurniture = function(...)
  -- function num : 0_98 , upvalues : _moveComInfo
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  if _moveComInfo.Com ~= nil then
    (_moveComInfo.Com).visible = false
  end
  _moveComInfo.Uid = nil
end

HomelandRoomWindow.ChangeOccupiedStatus = function(uid, status, ...)
  -- function num : 0_99 , upvalues : _occupiedFurniture
  -- DECOMPILER ERROR at PC5: Unhandled construct in 'MakeBoolean' P1

  if status and _occupiedFurniture[uid] ~= status then
    _occupiedFurniture[uid] = status
    _occupiedFurniture.Count = _occupiedFurniture.Count + 1
  end
  if _occupiedFurniture[uid] ~= status then
    _occupiedFurniture[uid] = status
    _occupiedFurniture.Count = _occupiedFurniture.Count - 1
  end
end

HomelandRoomWindow.RemoveSelectedFurniture = function(context, notAddToUI, ...)
  -- function num : 0_100 , upvalues : HomelandRoomWindow, _moveComInfo
  if context ~= nil then
    context:StopPropagation()
  end
  ;
  (HomelandRoomWindow.RemoveFurniture)(_moveComInfo.New, _moveComInfo.Uid, _moveComInfo.Id, _moveComInfo.Type, notAddToUI)
  ;
  (HomelandRoomWindow.HideMoveFurniture)()
  ;
  (HomelandRoomWindow.CheckOccupiedFurnitureStatus)()
end

HomelandRoomWindow.RemoveFurniture = function(new, uid, id, type, notAddToUI, ...)
  -- function num : 0_101 , upvalues : HomelandRoomWindow, _editFurnitureInfo, _ENV, _editCarpetGridUsage, _editGridUsage
  if not new then
    (HomelandRoomWindow.ChangeOccupiedStatus)(uid)
    if _editFurnitureInfo[uid] ~= nil then
      local data = _editFurnitureInfo[uid]
      if type == HomelandFurnitureType.Furniture then
        (HomelandRoomWindow.RemoveFurnitureRelation)(uid, type)
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (HomelandData.RoomData).CardGridCount = (HomelandData.RoomData).CardGridCount + (data.Size).x * (data.Size).y
      end
      if data.Status ~= FurnitureEditStatus.Remove then
        (HomelandRoomWindow.PushToPool)(data.Furniture)
      end
      if data.Status ~= FurnitureEditStatus.Add then
        data.Status = FurnitureEditStatus.Remove
      else
        _editFurnitureInfo[uid] = nil
      end
      if data.WindowView ~= nil then
        (data.WindowView):Dispose()
        data.WindowView = nil
      end
      data.BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)(data.BelongingGrid)
      if data.GridStatus == HomelandRoomGridStatus.Available then
        if type == HomelandFurnitureType.Carpet then
          (HomelandRoomWindow.RefreshRangeGridUsage)(data.BelongTo, _editCarpetGridUsage, data.Size, data.Coordinate)
        else
          ;
          (HomelandRoomWindow.RefreshRangeGridUsage)(data.BelongTo, _editGridUsage, data.Size, data.Coordinate)
          ;
          (HomelandRoomWindow.RemoveDecorateSort)(type, data.BelongTo, data.Uid)
        end
      end
    end
  end
  do
    if not notAddToUI then
      (HomelandMgr.AddFurnitureToUI)(id, uid)
    end
  end
end

HomelandRoomWindow.RemoveFurnitureRelation = function(uid, type, coverGrid, ...)
  -- function num : 0_102 , upvalues : _ENV, _furnitureRelation, HomelandRoomWindow, uis, _editFurnitureInfo, _furnitureInfo
  if type ~= HomelandFurnitureType.Furniture then
    return 
  end
  if _furnitureRelation[uid] ~= nil then
    local covers = (_furnitureRelation[uid]).Cover
    for k,v in pairs(covers) do
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R9 in 'UnsetPending'

      ((_furnitureRelation[k]).CoverBy)[uid] = nil
    end
    local coverBy = (_furnitureRelation[uid]).CoverBy
    for k,v in pairs(coverBy) do
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R10 in 'UnsetPending'

      ((_furnitureRelation[k]).Cover)[uid] = nil
    end
    _furnitureRelation[uid] = nil
  end
  do
    if coverGrid then
      (HomelandRoomWindow.ClearFloorLayerOwnerData)(coverGrid, uid)
    else
      if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Edit then
        (HomelandRoomWindow.ClearFloorLayerOwnerData)((_editFurnitureInfo[uid]).CoverGrid, uid)
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (_editFurnitureInfo[uid]).CoverGrid = nil
      else
        ;
        (HomelandRoomWindow.ClearFloorLayerOwnerData)((_furnitureInfo[uid]).CoverGrid, uid)
        -- DECOMPILER ERROR at PC58: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (_furnitureInfo[uid]).CoverGrid = nil
      end
    end
  end
end

HomelandRoomWindow.ClearFloorLayerOwnerData = function(coverGrid, uid, ...)
  -- function num : 0_103 , upvalues : _floorLayerOwner, _ENV
  if coverGrid == nil then
    return 
  end
  local count = #coverGrid
  for i = 1, count do
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

    if _floorLayerOwner[(coverGrid[i]).x] ~= nil and (_floorLayerOwner[(coverGrid[i]).x])[(coverGrid[i]).y] ~= nil then
      ((_floorLayerOwner[(coverGrid[i]).x])[(coverGrid[i]).y])[uid] = nil
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R7 in 'UnsetPending'

      if (_G.next)((_floorLayerOwner[(coverGrid[i]).x])[(coverGrid[i]).y]) == nil then
        (_floorLayerOwner[(coverGrid[i]).x])[(coverGrid[i]).y] = nil
        if (_G.next)(_floorLayerOwner[(coverGrid[i]).x]) == nil then
          _floorLayerOwner[(coverGrid[i]).x] = nil
        end
      end
    end
  end
end

HomelandRoomWindow.CheckOccupiedFurnitureStatus = function(...)
  -- function num : 0_104 , upvalues : _ENV, _occupiedFurniture, _editFurnitureInfo, HomelandRoomWindow, _editCarpetGridUsage, _editGridUsage, SELECTED_ALPHA
  local data, config, gridStatus, gridDetail = nil, nil, nil, nil
  for k,v in pairs(_occupiedFurniture) do
    data = _editFurnitureInfo[k]
    if data ~= nil then
      config = ((TableData.gTable).BaseFamilyFurnitureData)[data.ConfigId]
      if config.type == HomelandFurnitureType.Carpet then
        gridStatus = (HomelandRoomWindow.CheckGridUsage)(data.Coordinate, data.Size, data.BelongTo, data.BelongingGrid, _editCarpetGridUsage)
      else
        -- DECOMPILER ERROR at PC35: Overwrote pending register: R3 in 'AssignReg'

        gridStatus = (HomelandRoomWindow.CheckGridUsage)(data.Coordinate, data.Size, data.BelongTo, data.BelongingGrid, _editGridUsage)
      end
      if gridStatus ~= data.GridStatus then
        if gridStatus == HomelandRoomGridStatus.Available then
          data.BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)(data.BelongingGrid)
          ;
          ((data.Furniture):GetChild("FurnitureItemLoader")).alpha = 1
          -- DECOMPILER ERROR at PC69: Confused about usage of register: R9 in 'UnsetPending'

          if config.type == HomelandFurnitureType.Furniture then
            (HomelandData.RoomData).CardGridCount = (HomelandData.RoomData).CardGridCount - (data.Size).x * (data.Size).y
          end
          data.GridDetail = nil
          if config.type == HomelandFurnitureType.Carpet then
            (HomelandRoomWindow.RefreshRangeGridUsage)(data.BelongTo, _editCarpetGridUsage, data.Size, data.Coordinate, true)
          else
            ;
            (HomelandRoomWindow.RefreshRangeGridUsage)(data.BelongTo, _editGridUsage, data.Size, data.Coordinate, true)
          end
          data.PlaceAnim = (HomelandRoomWindow.PlayFurniutreAnim)(data.Furniture, data.Coordinate)
          if config.type == HomelandFurnitureType.Decorate then
            (HomelandRoomWindow.AddDecorateSort)(data.Uid, data.Coordinate)
            ;
            (HomelandRoomWindow.SetDecorateSort)(data.BelongTo, data.Uid, data.Furniture)
          else
            data.CoverGrid = (HomelandRoomWindow.SetFurnitureLayerIndex)(data.Furniture, data.Uid, data.Coordinate, data.Size)
          end
          ;
          (HomelandRoomWindow.ChangeOccupiedStatus)(k)
        else
          ;
          ((data.Furniture):GetChild("FurnitureItemLoader")).alpha = SELECTED_ALPHA
          data.GridDetail = gridDetail
        end
        data.GridStatus = gridStatus
      end
    end
  end
end

HomelandRoomWindow.PlaceNewFurniture = function(...)
  -- function num : 0_105 , upvalues : _moveComInfo, _ENV, HomelandRoomWindow, _editFurnitureInfo, _currentEditGridUsage
  if (_moveComInfo.Com).visible and _moveComInfo.Furniture ~= nil and _moveComInfo.New then
    local config = ((TableData.gTable).BaseFamilyFurnitureData)[_moveComInfo.Id]
    do
      local turn = _moveComInfo.Turn
      local uid = _moveComInfo.Uid
      if config.type == HomelandFurnitureType.Decorate and _moveComInfo.GridStatus == HomelandRoomGridStatus.Available then
        (HomelandRoomWindow.AddDecorateSort)(uid, _moveComInfo.Coordinate)
      end
      local furniture, coverGrid, loader, view, rect = (HomelandRoomWindow.PlaceSingleFurniture)(config, turn, (_moveComInfo.Com).xy, (_moveComInfo.Furniture).xy, uid, true, _moveComInfo.Coordinate, _moveComInfo.Size, _moveComInfo.GridStatus)
      local info = {}
      if _editFurnitureInfo[uid] == nil then
        info.Status = FurnitureEditStatus.Add
      else
        info = _editFurnitureInfo[uid]
        if info.Status == FurnitureEditStatus.Remove then
          if info.OriginCoordinate ~= _moveComInfo.Coordinate or info.OriginTurn ~= turn or info.OriginBelongTo ~= _moveComInfo.BelongTo then
            info.Status = FurnitureEditStatus.MoveOrRotate
          else
            info.Status = nil
          end
        end
      end
      if _moveComInfo.GridStatus == HomelandRoomGridStatus.Available then
        loader.alpha = 1
        ;
        (HomelandRoomWindow.RefreshRangeGridUsage)(_moveComInfo.BelongTo, _currentEditGridUsage, _moveComInfo.Size, _moveComInfo.Coordinate, true)
        info.PlaceAnim = (HomelandRoomWindow.PlayFurniutreAnim)(furniture, _moveComInfo.Coordinate)
        -- DECOMPILER ERROR at PC108: Confused about usage of register: R9 in 'UnsetPending'

        if config.type == HomelandFurnitureType.Furniture then
          (HomelandData.RoomData).CardGridCount = (HomelandData.RoomData).CardGridCount - (_moveComInfo.Size).x * (_moveComInfo.Size).y
        end
      else
        loader.alpha = HomelandData.UnavailableAlpha
        info.GridDetail = _moveComInfo.GridDetail
        info.BelongingGrid = (HomelandRoomWindow.InitBelongingGrid)(turn, config.id, furniture, _moveComInfo.BelongTo, furniture.size, _moveComInfo.Size)
        ;
        (HomelandRoomWindow.SetGridUsage)(info.BelongingGrid, info.GridDetail)
        ;
        (HomelandRoomWindow.ChangeOccupiedStatus)(uid, true)
      end
      info.Uid = uid
      info.ConfigId = config.id
      info.GridStatus = _moveComInfo.GridStatus
      info.Size = _moveComInfo.Size
      info.Furniture = furniture
      info.Loader = loader
      info.CoverGrid = coverGrid
      info.Coordinate = (Util.CopyVec)(_moveComInfo.Coordinate)
      info.Turn = turn
      info.BelongTo = _moveComInfo.BelongTo
      info.ComPosition = (_moveComInfo.Com).xy
      info.SelectedBelongTo = _moveComInfo.BelongTo
      info.WindowView = view
      info.WindowViewRect = rect
      -- DECOMPILER ERROR at PC158: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (info.Furniture).touchable = true
      if config.time ~= -1 then
        info.Timer = (SimpleTimer.setTimeout)((HomelandData.GetFurnitureTime)(uid) + config.time - (LuaTime.GetTimeStamp)() + 1, function(...)
    -- function num : 0_105_0 , upvalues : HomelandRoomWindow, uid, _moveComInfo, config
    (HomelandRoomWindow.FurnitureTimeUp)(uid, _moveComInfo.Type, config.name)
  end
)
      end
      _editFurnitureInfo[uid] = info
    end
  end
end

HomelandRoomWindow.PlaceFurniture = function(uid, configId, turn, x, y, z, gridStatus, comPosition, belongTo, originCoordinate, originBelongTo, originTurn, gridDetail, status, ...)
  -- function num : 0_106 , upvalues : _ENV, HomelandRoomWindow
  local config = ((TableData.gTable).BaseFamilyFurnitureData)[configId]
  if config.type == HomelandFurnitureType.Wall or config.type == HomelandFurnitureType.Floor then
    return nil
  end
  local furniture, coverGrid, size, gridType, comPos, loader, view, rect = nil, nil, nil, nil, nil, nil, nil, nil
  local removed = status == FurnitureEditStatus.Remove
  if not removed then
    if gridStatus == HomelandRoomGridStatus.Available then
      local coordinate = Vector3(x, y, z)
      if config.type == HomelandFurnitureType.Decorate then
        (HomelandRoomWindow.AddDecorateSort)(uid, coordinate)
      end
      furniture = (HomelandRoomWindow.PlaceSingleFurniture)(config, turn, coordinate, nil, uid, false, nil, nil, gridStatus)
    else
      -- DECOMPILER ERROR at PC73: Overwrote pending register: R22 in 'AssignReg'

      -- DECOMPILER ERROR at PC74: Overwrote pending register: R21 in 'AssignReg'

      -- DECOMPILER ERROR at PC75: Overwrote pending register: R20 in 'AssignReg'

      -- DECOMPILER ERROR at PC76: Overwrote pending register: R19 in 'AssignReg'

      -- DECOMPILER ERROR at PC77: Overwrote pending register: R18 in 'AssignReg'

      -- DECOMPILER ERROR at PC78: Overwrote pending register: R17 in 'AssignReg'

      -- DECOMPILER ERROR at PC79: Overwrote pending register: R16 in 'AssignReg'

      furniture = (HomelandRoomWindow.PlaceSingleFurniture)(config, turn, comPosition, nil, uid, false, nil, nil, gridStatus, belongTo)
    end
  else
    local sizeStr = split(config.size, ":")
    -- DECOMPILER ERROR at PC106: Overwrote pending register: R17 in 'AssignReg'

  end
  if not turn or not Vector2(tonumber(sizeStr[2]), tonumber(sizeStr[1])) then
    local info = {}
    info.Uid = uid
    info.ConfigId = configId
    info.Size = size
    info.Furniture = furniture
    if originCoordinate then
      info.OriginCoordinate = originCoordinate
    else
      info.OriginCoordinate = Vector3(x, y, z)
    end
    if originBelongTo then
      info.OriginBelongTo = originBelongTo
    else
      info.OriginBelongTo = gridType
    end
    if originTurn then
      info.OriginTurn = originTurn
    else
      info.OriginTurn = turn
    end
    info.Coordinate = Vector3(x, y, z)
    info.Turn = turn
    info.BelongTo = gridType
    info.ComPosition = comPos
    info.SelectedBelongTo = gridType
    info.Loader = loader
    info.GridStatus = gridStatus
    info.CoverGrid = coverGrid
    info.Status = status
    info.WindowView = view
    info.WindowViewRect = rect
    if config.time ~= -1 and not removed then
      info.Timer = (SimpleTimer.setTimeout)((HomelandData.GetFurnitureTime)(uid) + config.time - (LuaTime.GetTimeStamp)() + 1, function(...)
    -- function num : 0_106_0 , upvalues : HomelandRoomWindow, uid, config
    (HomelandRoomWindow.FurnitureTimeUp)(uid, config.type, config.name)
  end
)
    end
    local furnitures, normalGridUsage, carpetGridUsage = (HomelandRoomWindow.GetCurrentFurnitureInfo)()
    furnitures[uid] = info
    local gridUsage = nil
    if config.type == HomelandFurnitureType.Carpet then
      gridUsage = carpetGridUsage
    else
      gridUsage = normalGridUsage
    end
    if not removed then
      if gridStatus == HomelandRoomGridStatus.Available then
        loader.alpha = 1
        ;
        (HomelandRoomWindow.RefreshRangeGridUsage)(gridType, gridUsage, info.Size, info.Coordinate, true)
        info.PlaceAnim = (HomelandRoomWindow.PlayFurniutreAnim)(furniture, info.Coordinate)
      else
        loader.alpha = HomelandData.UnavailableAlpha
        info.GridDetail = gridDetail
        info.BelongingGrid = (HomelandRoomWindow.InitBelongingGrid)(turn, configId, furniture, gridType, furniture.size, size)
        ;
        (HomelandRoomWindow.SetGridUsage)(info.BelongingGrid, gridDetail)
      end
    end
    do return furniture end
    -- DECOMPILER ERROR: 17 unprocessed JMP targets
  end
end

HomelandRoomWindow.FurnitureTimeUp = function(uid, type, name, ...)
  -- function num : 0_107 , upvalues : uis, _ENV, _editFurnitureInfo, _editCarpetGridUsage, _editGridUsage, _furnitureInfo, HomelandRoomWindow
  local data, gridUsage = nil, nil
  if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Edit then
    data = _editFurnitureInfo[uid]
    _editFurnitureInfo[uid] = nil
    if type == HomelandFurnitureType.Carpet then
      gridUsage = _editCarpetGridUsage
    else
      gridUsage = _editGridUsage
    end
  else
    data = _furnitureInfo[uid]
    _furnitureInfo[uid] = nil
    if type == HomelandFurnitureType.Carpet then
      gridUsage = (HomelandData.RoomData).CarpetGridUsage
    else
      gridUsage = (HomelandData.RoomData).GridUsage
    end
  end
  if data then
    if type == HomelandFurnitureType.Furniture then
      (HomelandRoomWindow.RemoveFurnitureRelation)(data.Uid, type, data.CoverGrid)
    end
    ;
    (HomelandRoomWindow.PushToPool)(data.Furniture)
    ;
    (HomelandRoomWindow.RemoveDecorateSort)(type, data.BelongTo, data.Uid)
    data.BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)(data.BelongingGrid)
    ;
    (HomelandRoomWindow.ChangeOccupiedStatus)(data.Uid)
    ;
    (HomelandRoomWindow.RefreshRangeGridUsage)(data.BelongTo, gridUsage, data.Size, data.Coordinate)
  end
  ;
  (HomelandMgr.FurnitureTimeUp)(uid, name)
end

HomelandRoomWindow.GetFurniturePositionByCoordinate = function(config, turn, coordinate, furnitureSize, ...)
  -- function num : 0_108 , upvalues : _ENV, HomelandRoomWindow
  local sizeInfo = split(config.size, ":")
  local sizeX = tonumber(sizeInfo[1])
  local sizeY = (tonumber(sizeInfo[2]))
  local gridType, belongingGridOriginPoint = nil, nil
  if coordinate.x == 0 then
    belongingGridOriginPoint = (HomelandRoomWindow.GetLeftWallBelongingGridOriginPoint)(config, sizeX, sizeY)
    gridType = HomelandRoomGridType.LeftWall
  else
    if coordinate.y == 0 then
      belongingGridOriginPoint = (HomelandRoomWindow.GetRightWallBelongingGridOriginPoint)(config, sizeX, sizeY)
      gridType = HomelandRoomGridType.RightWall
    else
      if coordinate.z == 0 then
        if turn then
          sizeX = sizeX + sizeY
          sizeY = sizeX - sizeY
          sizeX = sizeX - (sizeY)
        end
        belongingGridOriginPoint = (HomelandRoomWindow.GetFloorBelongingGridOriginPoint)(config, sizeX, sizeY, furnitureSize)
        gridType = HomelandRoomGridType.Floor
      end
    end
  end
  local position = (HomelandRoomWindow.GetPositionByCoordinate)(coordinate)
  position.x = position.x - belongingGridOriginPoint.x
  position.y = position.y - belongingGridOriginPoint.y
  return position, Vector2(sizeX, sizeY), gridType
end

HomelandRoomWindow.GetPositionByCoordinate = function(coordinate, ...)
  -- function num : 0_109 , upvalues : _ENV
  local position = Vector2.zero
  local setter = function(coord, axis, ...)
    -- function num : 0_109_0 , upvalues : _ENV
    if coord == 0 then
      return Vector2.zero
    else
      return (coord - 1) * axis
    end
  end

  local vec1 = setter(coordinate.x, HomelandRoomConstant.XAxis)
  local vec2 = setter(coordinate.y, HomelandRoomConstant.YAxis)
  local vec3 = setter(coordinate.z, HomelandRoomConstant.ZAxis)
  position.x = (HomelandRoomConstant.OriginalPoint).x + vec1.x + vec2.x + vec3.x
  position.y = (HomelandRoomConstant.OriginalPoint).y + vec1.y + vec2.y + vec3.y
  return position
end

HomelandRoomWindow.PlaceSingleFurniture = function(config, turn, position, offset, uid, new, newCord, size, gridStatus, specifyGridType, view, rect, ...)
  -- function num : 0_110 , upvalues : HomelandRoomWindow, _ENV, uis, _rightWallHolder, _leftSideDecorateSortListIndex, _floorHolder, _rightSideDecorateSortListIndex, _moveComInfo
  local furniture = (HomelandRoomWindow.PullFromPool)(HomelandRoomResources.FurnitureCom, (uis.Currency).root, true)
  local loader = furniture:GetChild("FurnitureItemLoader")
  loader.url = (Util.GetItemUrl)(config.resource)
  loader.size = (loader.image).size
  furniture.name = HomelandRoomResources.FurnitureCom
  furniture.gameObjectName = uid
  furniture.size = loader.size
  local coverGrid = nil
  local coor = new and newCord or position
  if config.type == HomelandFurnitureType.Decorate then
    -- DECOMPILER ERROR at PC73: Unhandled construct in 'MakeBoolean' P3

    if specifyGridType or ((config.direction == HomelandRoomDecorateDirection.Left and coor.x == 0) or ((config.direction == HomelandRoomDecorateDirection.Left and specifyGridType == HomelandRoomGridType.LeftWall) or config.direction ~= HomelandRoomDecorateDirection.Right or specifyGridType == HomelandRoomGridType.RightWall)) then
      turn = true
    else
      turn = false
    end
  end
  if gridStatus == HomelandRoomGridStatus.Available then
    if config.type == HomelandFurnitureType.Decorate then
      local index, baseIndex = nil, nil
      if coor.x == 0 then
        baseIndex = ((uis.Currency).root):GetChildIndex(_rightWallHolder)
        index = baseIndex + _leftSideDecorateSortListIndex[uid]
      else
        baseIndex = ((uis.Currency).root):GetChildIndex(_floorHolder)
        index = baseIndex + _rightSideDecorateSortListIndex[uid]
      end
      ;
      ((uis.Currency).root):SetChildIndexBefore(furniture, index)
    else
      do
        if config.type == HomelandFurnitureType.Furniture then
          if new then
            coverGrid = (HomelandRoomWindow.SetFurnitureLayerIndex)(furniture, uid, newCord, size)
          else
            local sizeStr = split(config.size, ":")
            if not turn or not Vector2(tonumber(sizeStr[2]), tonumber(sizeStr[1])) then
              local size = Vector2(tonumber(sizeStr[1]), tonumber(sizeStr[2]))
            end
            coverGrid = (HomelandRoomWindow.SetFurnitureLayerIndex)(furniture, uid, position, size)
          end
        else
          do
            if config.type == HomelandFurnitureType.Carpet then
              ((uis.Currency).root):SetChildIndexBefore(furniture, ((uis.Currency).root):GetChildIndex(((uis.Currency).Extend).root) + 1)
            end
            if (_moveComInfo.Com).visible then
              ((uis.Currency).root):SetChildIndex(furniture, ((uis.Currency).root).numChildren - 2)
            else
              ;
              ((uis.Currency).root):SetChildIndex(furniture, ((uis.Currency).root).numChildren - 1)
            end
            local view, rect = nil, nil
            local setPos = function(pos, ...)
    -- function num : 0_110_0 , upvalues : turn, loader, offset, _ENV, config, view, rect, HomelandRoomWindow, furniture, uis, _rightWallHolder
    if turn then
      loader.scaleX = -1
      loader.x = (loader.size).x + offset.x
      loader.y = offset.y
    else
      loader.scaleX = 1
      loader.x = offset.x
      loader.y = offset.y
    end
    if not (Util.StringIsNullOrEmpty)(config.perspectivity) then
      view = (HomelandRoomWindow.SetWindowView)(config, furniture.x + loader.x, furniture.y + loader.y, view, rect, (uis.Currency).root, ((uis.Currency).root):GetChildIndex(_rightWallHolder))
      view.x = pos.x + loader.x
      view.y = pos.y + loader.y + rect.y
      if turn then
        view.x = view.x - furniture.width + rect.x
      else
        view.x = view.x + rect.x
      end
    end
  end

            if new then
              furniture.xy = position
              ;
              (furniture.onClick):Set(function(context, ...)
    -- function num : 0_110_1 , upvalues : HomelandRoomWindow, config, uid
    context:StopPropagation()
    ;
    (HomelandRoomWindow.InitMoveFurniture)(config, uid)
  end
)
              setPos(position)
              return furniture, coverGrid, loader, view, rect
            else
              local comPos, size, gridType = nil, nil, nil
              if gridStatus == HomelandRoomGridStatus.Available then
                comPos = (HomelandRoomWindow.GetFurniturePositionByCoordinate)(config, turn, position, furniture.size)
              else
                comPos = position
                local sizeStr = split(config.size, ":")
                -- DECOMPILER ERROR at PC261: Overwrote pending register: R20 in 'AssignReg'

                -- DECOMPILER ERROR at PC262: Overwrote pending register: R21 in 'AssignReg'

              end
              do
                if not turn or not Vector2(tonumber(sizeStr[2]), tonumber(sizeStr[1])) then
                  furniture.xy = comPos
                  offset = (HomelandRoomWindow.GetFunritureOffset)(config, gridType, size, furniture.width, furniture.height, turn)
                  setPos(comPos)
                  do return furniture, coverGrid, size, gridType, comPos, loader, view, rect end
                end
              end
            end
          end
        end
      end
    end
  end
end

HomelandRoomWindow.SetFurnitureLayerIndex = function(furniture, uid, coordinate, gridSize, ...)
  -- function num : 0_111 , upvalues : _ENV, HomelandRoomWindow, _floorLayerOwner, _furnitureRelation, uis
  local size = furniture.size
  local coverY = size.y - (gridSize.x + gridSize.y) * (HomelandRoomConstant.GridProject).sin
  local coverSize = ((math.ceil)(coverY / (2 * (HomelandRoomConstant.GridProject).sin)))
  local x, y, other = nil, nil, nil
  local relation = {}
  relation[uid] = {
Cover = {}
, 
CoverBy = {}
}
  local furnitureInfo = (HomelandRoomWindow.GetCurrentFurnitureInfo)()
  local coverGrid = {}
  local weight = nil
  for i = 1, gridSize.x do
    for j = 1, gridSize.y do
      x = coordinate.x + i - 1
      y = coordinate.y + j - 1
      if _floorLayerOwner[x] == nil then
        _floorLayerOwner[x] = {}
      end
      -- DECOMPILER ERROR at PC55: Confused about usage of register: R22 in 'UnsetPending'

      if (_floorLayerOwner[x])[y] == nil then
        (_floorLayerOwner[x])[y] = {}
      end
      for k,v in pairs((_floorLayerOwner[x])[y]) do
        if v == 1 then
          (HomelandRoomWindow.AddFurnitureRelation)(uid, k, false, relation)
        end
      end
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R22 in 'UnsetPending'

      ;
      ((_floorLayerOwner[x])[y])[uid] = 1
      ;
      (table.insert)(coverGrid, Vector2(x, y))
    end
  end
  local setter = function(x, y, half, compareFunc, ...)
    -- function num : 0_111_0 , upvalues : _ENV, _floorLayerOwner, uid, coverGrid
    local size = (HomelandData.GetCurrentRoomSize)()
    local weight = half and 0.5 or 1
    if _floorLayerOwner[x] == nil then
      _floorLayerOwner[x] = {}
    end
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    if (_floorLayerOwner[x])[y] == nil then
      (_floorLayerOwner[x])[y] = {}
    else
      compareFunc(weight)
    end
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((_floorLayerOwner[x])[y])[uid] = weight
    ;
    (table.insert)(coverGrid, Vector2(x, y))
  end

  for i = 1, coverSize do
    for j = 1, gridSize.x do
      x = coordinate.x - i + 1 + j - 1
      y = coordinate.y - i
      setter(x, y, j == gridSize.x, function(weight, ...)
    -- function num : 0_111_1 , upvalues : _ENV, _floorLayerOwner, x, y, other, furnitureInfo, coordinate, HomelandRoomWindow, uid, relation, gridSize
    for k,v in pairs((_floorLayerOwner[x])[y]) do
      if v + weight > 1 then
        other = furnitureInfo[k]
        if other == nil then
          loge("@@@@@@@@@@@@@@@@@@@@@@:" .. tostring(k))
        else
          if coordinate.x <= (other.Coordinate).x and coordinate.y <= (other.Coordinate).y then
            (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, false, relation)
          else
            if (other.Coordinate).x <= coordinate.x and (other.Coordinate).y <= coordinate.y then
              (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, true, relation)
            else
              if (other.Coordinate).x < coordinate.x then
                (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, false, relation)
              else
                if (other.Coordinate).x <= coordinate.x + gridSize.x - 1 then
                  (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, true, relation)
                else
                  ;
                  (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, false, relation)
                end
              end
            end
          end
        end
      end
    end
  end
)
    end
  end
  for i = 1, coverSize do
    for j = 1, gridSize.y do
      x = coordinate.x - i
      y = coordinate.y - i + 1 + j - 1
      setter(x, y, j == gridSize.y, function(weight, ...)
    -- function num : 0_111_2 , upvalues : _ENV, _floorLayerOwner, x, y, other, furnitureInfo, coordinate, HomelandRoomWindow, uid, relation, gridSize
    for k,v in pairs((_floorLayerOwner[x])[y]) do
      if v + weight > 1 then
        other = furnitureInfo[k]
        if other == nil then
          loge("@@@@@@@@@@@@@@@@@@@@@@:" .. tostring(k))
        else
          if coordinate.x <= (other.Coordinate).x and coordinate.y <= (other.Coordinate).y then
            (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, false, relation)
          else
            if (other.Coordinate).x <= coordinate.x and (other.Coordinate).y <= coordinate.y then
              (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, true, relation)
            else
              if coordinate.x < (other.Coordinate).x then
                (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, false, relation)
              else
                if (other.Coordinate).y <= coordinate.y + gridSize.y - 1 then
                  (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, true, relation)
                else
                  ;
                  (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, false, relation)
                end
              end
            end
          end
        end
      end
    end
  end
)
    end
  end
  for i = 1, coverSize do
    x = coordinate.x - i
    y = coordinate.y - i
    setter(x, y, false, function(...)
    -- function num : 0_111_3 , upvalues : _ENV, _floorLayerOwner, x, y, other, furnitureInfo, coordinate, HomelandRoomWindow, uid, relation
    for k,v in pairs((_floorLayerOwner[x])[y]) do
      other = furnitureInfo[k]
      if other == nil then
        loge("@@@@@@@@@@@@@@@@@@@@@@:" .. tostring(k))
      else
        if coordinate.x < (other.Coordinate).x or coordinate.y < (other.Coordinate).y then
          (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, false, relation)
        else
          ;
          (HomelandRoomWindow.AddFurnitureRelation)(uid, other.Uid, true, relation)
        end
      end
    end
  end
)
  end
  ;
  (HomelandRoomWindow.UpdateRelation)(relation, _furnitureRelation, uid)
  local coverLayer = (HomelandRoomWindow.GetCoverLayer)((relation[uid]).Cover, furnitureInfo)
  local coverByLayer = ((HomelandRoomWindow.GetCoverByLayer)((relation[uid]).CoverBy, furnitureInfo))
  local layer = nil
  if coverLayer == nil or coverLayer < coverByLayer then
    ((uis.Currency).root):SetChildIndexBefore(furniture, coverByLayer)
  elseif coverLayer == coverByLayer then
    ((uis.Currency).root):SetChildIndex(furniture, coverByLayer)
  else
    for k,v in pairs((relation[uid]).Cover) do
      layer = ((uis.Currency).root):GetChildIndex((furnitureInfo[k]).Furniture)
      if coverByLayer <= layer then
        (HomelandRoomWindow.UpdateFurnitureCoverLayer)(furnitureInfo, k, coverByLayer)
        coverByLayer = (HomelandRoomWindow.GetCoverByLayer)((relation[uid]).CoverBy, furnitureInfo)
      end
    end
    ;
    ((uis.Currency).root):SetChildIndexBefore(furniture, coverByLayer)
  end
  do return coverGrid end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

HomelandRoomWindow.UpdateFurnitureCoverLayer = function(furnitureInfo, uid, layer, ...)
  -- function num : 0_112 , upvalues : uis, _furnitureRelation, _ENV, HomelandRoomWindow
  local minLayer = ((uis.Currency).root):GetChildIndex(((uis.Currency).Hemming).root)
  if layer <= minLayer then
    layer = minLayer + 1
  end
  ;
  ((uis.Currency).root):SetChildIndexBefore((furnitureInfo[uid]).Furniture, layer)
  if _furnitureRelation[uid] ~= nil then
    for k,v in pairs((_furnitureRelation[uid]).Cover) do
      if furnitureInfo[k] then
        local coverLayer = ((uis.Currency).root):GetChildIndex((furnitureInfo[k]).Furniture)
        if layer < coverLayer then
          (HomelandRoomWindow.UpdateFurnitureCoverLayer)(furnitureInfo, k, layer - 1)
        end
      end
    end
  end
end

HomelandRoomWindow.UpdateRoleCoverLayer = function(furnitureInfo, id, layer, ...)
  -- function num : 0_113 , upvalues : uis, _roles, HomelandRoomWindow, _ENV
  ((uis.Currency).root):SetChildIndexBefore((_roles[id]).Loader, layer)
  local coverGrid = (HomelandRoomWindow.GetRoleCoverGrid)((_roles[id]).Coordinate)
  local cover, coverBy = (HomelandRoomWindow.GetRoleRelation)(id, furnitureInfo, coverGrid, (_roles[id]).Coordinate)
  for k,v in pairs(cover) do
    if furnitureInfo[k] then
      local coverLayer = ((uis.Currency).root):GetChildIndex((furnitureInfo[k]).Furniture)
      if layer < coverLayer then
        (HomelandRoomWindow.UpdateFurnitureCoverLayer)(furnitureInfo, k, layer - 1)
      end
    else
      do
        do
          if _roles[k] then
            local coverLayer = ((uis.Currency).root):GetChildIndex((_roles[k]).Loader)
            if layer < coverLayer then
              (HomelandRoomWindow.UpdateRoleCoverLayer)(furnitureInfo, k, layer - 1)
            end
          end
          -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

HomelandRoomWindow.AddFurnitureRelation = function(src, des, cover, relation, ...)
  -- function num : 0_114
  if relation[src] == nil then
    relation[src] = {
Cover = {}
, 
CoverBy = {}
}
  end
  if relation[des] == nil then
    relation[des] = {
Cover = {}
, 
CoverBy = {}
}
  end
  if cover then
    if ((relation[des]).Cover)[src] then
      return 
    end
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((relation[src]).Cover)[des] = true
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((relation[des]).CoverBy)[src] = true
  else
    if ((relation[src]).Cover)[des] then
      return 
    end
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((relation[des]).Cover)[src] = true
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((relation[src]).CoverBy)[des] = true
  end
end

HomelandRoomWindow.UpdateRelation = function(srcRelation, dstRelation, uid, ...)
  -- function num : 0_115 , upvalues : _ENV
  local count, found = nil, nil
  if dstRelation[uid] ~= nil then
    for k,v in pairs((dstRelation[uid]).Cover) do
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R10 in 'UnsetPending'

      if not ((srcRelation[uid]).Cover)[k] then
        ((dstRelation[k]).CoverBy)[uid] = nil
      end
    end
    for k,v in pairs((dstRelation[uid]).CoverBy) do
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

      if not ((srcRelation[uid]).CoverBy)[k] then
        ((dstRelation[k]).Cover)[uid] = nil
      end
    end
  end
  do
    dstRelation[uid] = srcRelation[uid]
    for k,v in pairs((srcRelation[uid]).Cover) do
      if dstRelation[k] == nil then
        dstRelation[k] = {
Cover = {}
, 
CoverBy = {}
}
      end
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((dstRelation[k]).CoverBy)[uid] = true
    end
    for k,v in pairs((srcRelation[uid]).CoverBy) do
      if dstRelation[k] == nil then
        dstRelation[k] = {
Cover = {}
, 
CoverBy = {}
}
      end
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((dstRelation[k]).Cover)[uid] = true
    end
  end
end

HomelandRoomWindow.InitMoveComSwipeGesture = function(...)
  -- function num : 0_116 , upvalues : _moveComInfo, HomelandRoomWindow, _furnitureMoving, _ENV
  if _moveComInfo.SwipGes == nil then
    _moveComInfo.SwipGes = (HomelandRoomWindow.GetSwipeGesture)(_moveComInfo.Com)
  end
  ;
  ((_moveComInfo.SwipGes).onBegin):Set(function(...)
    -- function num : 0_116_0 , upvalues : _furnitureMoving, HomelandRoomWindow
    _furnitureMoving = true
    ;
    (HomelandRoomWindow.BeforeMoveFurniture)()
  end
)
  ;
  ((_moveComInfo.SwipGes).onMove):Set(function(...)
    -- function num : 0_116_1 , upvalues : _ENV, HomelandRoomWindow
    if Input.touchCount > 1 then
      return 
    end
    ;
    (HomelandRoomWindow.MovingFurniture)()
  end
)
  ;
  ((_moveComInfo.SwipGes).onEnd):Set(function(context, ...)
    -- function num : 0_116_2 , upvalues : _furnitureMoving, HomelandRoomWindow
    _furnitureMoving = false
    ;
    (HomelandRoomWindow.AfterPlaceCom)(context)
  end
)
end

HomelandRoomWindow.RefreshRangeGridUsage = function(gridType, gridUsageInfo, size, coordinate, status, ...)
  -- function num : 0_117 , upvalues : _ENV
  local checker = function(i, j, ...)
    -- function num : 0_117_0 , upvalues : gridUsageInfo
    if gridUsageInfo[i] == nil then
      gridUsageInfo[i] = {}
    end
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    if (gridUsageInfo[i])[j] == nil then
      (gridUsageInfo[i])[j] = {}
    end
  end

  if gridType == HomelandRoomGridType.LeftWall then
    local yCount = coordinate.y + size.x - 1
    local zCount = coordinate.z + size.y - 1
    for i = coordinate.y, yCount do
      for j = coordinate.z, zCount do
        checker(0, i)
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R16 in 'UnsetPending'

        ;
        ((gridUsageInfo[0])[i])[j] = status
      end
    end
  else
    do
      if gridType == HomelandRoomGridType.RightWall then
        local xCount = coordinate.x + size.x - 1
        local zCount = coordinate.z + size.y - 1
        for i = coordinate.x, xCount do
          for j = coordinate.z, zCount do
            checker(i, 0)
            -- DECOMPILER ERROR at PC57: Confused about usage of register: R16 in 'UnsetPending'

            ;
            ((gridUsageInfo[i])[0])[j] = status
          end
        end
      else
        do
          if gridType == HomelandRoomGridType.Floor then
            local xCount = coordinate.x + size.x - 1
            local yCount = coordinate.y + size.y - 1
            for i = coordinate.x, xCount do
              for j = coordinate.y, yCount do
                checker(i, j)
                -- DECOMPILER ERROR at PC87: Confused about usage of register: R16 in 'UnsetPending'

                ;
                ((gridUsageInfo[i])[j])[0] = status
              end
            end
          end
        end
      end
    end
  end
end

HomelandRoomWindow.MovingFurniture = function(...)
  -- function num : 0_118 , upvalues : HomelandRoomWindow, _moveComInfo, uis
  (HomelandRoomWindow.UpdateFurniturePos)(_moveComInfo.Type)
  if _moveComInfo.WindowViewRect ~= nil then
    (HomelandRoomWindow.SetWindowView)(nil, (_moveComInfo.Furniture).x + (_moveComInfo.Com).x, (_moveComInfo.Furniture).y + (_moveComInfo.Com).y, _moveComInfo.WindowView, _moveComInfo.WindowViewRect)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (_moveComInfo.WindowView).x = (_moveComInfo.Furniture).x + (_moveComInfo.WindowViewRect).x
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (_moveComInfo.WindowView).y = (_moveComInfo.Furniture).y + (_moveComInfo.WindowViewRect).y
  end
  ;
  (HomelandRoomWindow.UpdateBelongingGridUsage)()
  ;
  (_moveComInfo.Com):InvalidateBatchingState()
  ;
  ((uis.Currency).root):InvalidateBatchingState()
end

HomelandRoomWindow.GetTouchPosition = function(...)
  -- function num : 0_119 , upvalues : _ENV, uis
  local posX = (((FairyGUI.Stage).inst).touchPosition).x * (ResolutionHandler.ScreenScale).X
  local posY = (((FairyGUI.Stage).inst).touchPosition).y * (ResolutionHandler.ScreenScale).Y
  posX = posX - ((uis.CurrencyWindow).root).x - ((uis.Currency).root).x
  posY = posY - ((uis.CurrencyWindow).root).y - ((uis.Currency).root).y
  return Vector3((posX) / ((uis.Currency).root).scaleX, (posY) / ((uis.Currency).root).scaleY)
end

HomelandRoomWindow.UpdateFurniturePos = function(type, ...)
  -- function num : 0_120 , upvalues : HomelandRoomWindow, _moveComInfo
  local point, coordinate, belongTo = (HomelandRoomWindow.GetTouchPositionAndCoordinate)(type, true)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (_moveComInfo.Com).xy = point
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  if coordinate ~= nil then
    (_moveComInfo.Coordinate).x = coordinate.x
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (_moveComInfo.Coordinate).y = coordinate.y
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (_moveComInfo.Coordinate).z = coordinate.z
  end
end

HomelandRoomWindow.CheckDecorateFlip = function(direction, belongTo, furniture, ...)
  -- function num : 0_121 , upvalues : _ENV
  if (direction == HomelandRoomDecorateDirection.Left and belongTo == HomelandRoomGridType.LeftWall) or direction == HomelandRoomDecorateDirection.Right and belongTo == HomelandRoomGridType.RightWall then
    furniture.flip = (FairyGUI.FlipType).Horizontal
  else
    furniture.flip = (FairyGUI.FlipType).None
  end
end

HomelandRoomWindow.GetTouchPositionAndCoordinate = function(type, updateMoveComInfo, offsetPos, ...)
  -- function num : 0_122 , upvalues : HomelandRoomWindow, _moveComInfo, _ENV, _rightWallHolder, _sin2, _tan, _sin, _cos
  local point = (HomelandRoomWindow.GetTouchPosition)()
  if offsetPos == nil and _moveComInfo.BelongingGrid then
    offsetPos = (((_moveComInfo.BelongingGrid)[1])[1]).GreenGrid
  end
  if type == HomelandFurnitureType.Wall or type == HomelandFurnitureType.Floor then
    return Vector2(point.x, point.y)
  else
    if type == HomelandFurnitureType.Decorate then
      if _rightWallHolder.x > point.x or not HomelandRoomGridType.RightWall then
        local belongTo = HomelandRoomGridType.LeftWall
      end
      -- DECOMPILER ERROR at PC44: Unhandled construct in 'MakeBoolean' P1

      if updateMoveComInfo and belongTo ~= _moveComInfo.BelongTo then
        _moveComInfo.BelongTo = belongTo
        ;
        (HomelandRoomWindow.CheckDecorateFlip)(_moveComInfo.Direction, belongTo, _moveComInfo.Furniture)
        ;
        (HomelandRoomWindow.InitSelectedBelongGrid)(_moveComInfo.Id)
        local config = ((TableData.gTable).BaseFamilyFurnitureData)[_moveComInfo.Id]
        -- DECOMPILER ERROR at PC69: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (_moveComInfo.Furniture).xy = (HomelandRoomWindow.GetFunritureOffset)(config, _moveComInfo.BelongTo, _moveComInfo.Size, (_moveComInfo.Furniture).width, (_moveComInfo.Furniture).height, _moveComInfo.Turn)
        -- DECOMPILER ERROR at PC85: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (_moveComInfo.AdjustCom).xy = Vector2((_moveComInfo.Furniture).x + (_moveComInfo.Com).width * 0.5, (_moveComInfo.Furniture).y + (_moveComInfo.Com).height * 0.5)
      end
      do
        do
          if belongTo ~= _moveComInfo.BelongTo then
            local config = ((TableData.gTable).BaseFamilyFurnitureData)[_moveComInfo.Id]
            if belongTo == HomelandRoomGridType.LeftWall then
              offsetPos = (HomelandRoomWindow.GetLeftWallBelongingGridOriginPoint)(config, (_moveComInfo.Size).x, (_moveComInfo.Size).y)
            else
              offsetPos = (HomelandRoomWindow.GetRightWallBelongingGridOriginPoint)(config, (_moveComInfo.Size).x, (_moveComInfo.Size).y)
            end
          end
          point.x = point.x - (HomelandRoomConstant.OriginalPoint).x
          point.y = point.y - (HomelandRoomConstant.OriginalPoint).y
          local x, y, vec1, vec2, coordinate = nil, nil, nil, nil, nil
          if belongTo == HomelandRoomGridType.LeftWall then
            local cross = (Util.Cross)(point, HomelandRoomConstant.YAxis)
            local projectInY = -point.x
            local projectInZ = 0
            local cos = (Util.Dot)(point.normalized, HomelandRoomConstant.NormalizeYAxis)
            local mag = point.magnitude
            local angle = (math.deg)((math.acos)(cos))
            if cross.z <= 0 then
              if cos < 0 then
                angle = 180 - angle
              end
              local distanceToYAxis = (math.sin)((math.rad)(angle)) * mag
              projectInZ = distanceToYAxis / _sin2
            else
              do
                do
                  do
                    local distanceToYAxis = (math.sin)((math.rad)(angle)) * mag
                    projectInZ = -distanceToYAxis / _sin2
                    x = (math.modf)(projectInY / (HomelandRoomConstant.GridProject).cos)
                    y = (math.modf)(projectInZ / HomelandRoomConstant.GridLength)
                    vec1 = HomelandRoomConstant.YAxis * x
                    vec2 = HomelandRoomConstant.ZAxis * y
                    coordinate = Vector3(0, x + 1, y + 1)
                    local cross = (Util.Cross)(point, HomelandRoomConstant.XAxis)
                    local projectInY = point.x
                    local projectInZ = 0
                    local cos = (Util.Dot)(point.normalized, HomelandRoomConstant.NormalizeXAxis)
                    local mag = point.magnitude
                    local angle = (math.deg)((math.acos)(cos))
                    if cross.z > 0 then
                      if cos < 0 then
                        angle = 180 - angle
                      end
                      local distanceToYAxis = (math.sin)((math.rad)(angle)) * mag
                      projectInZ = distanceToYAxis / _sin2
                    else
                      do
                        do
                          do
                            do
                              local distanceToYAxis = (math.sin)((math.rad)(angle)) * mag
                              projectInZ = -distanceToYAxis / _sin2
                              x = (math.modf)(projectInY / (HomelandRoomConstant.GridProject).cos)
                              y = (math.modf)(projectInZ / HomelandRoomConstant.GridLength)
                              vec1 = HomelandRoomConstant.XAxis * x
                              vec2 = HomelandRoomConstant.ZAxis * y
                              coordinate = Vector3(x + 1, 0, y + 1)
                              point.x = (HomelandRoomConstant.OriginalPoint).x + vec1.x + vec2.x - offsetPos.x
                              point.y = (HomelandRoomConstant.OriginalPoint).y + vec1.y + vec2.y - offsetPos.y
                              do return Vector2(point.x, point.y), coordinate, belongTo end
                              point.x = point.x - (HomelandRoomConstant.OriginalPoint).x
                              point.y = point.y - (HomelandRoomConstant.OriginalPoint).y
                              local crossY = (Util.Cross)(point, HomelandRoomConstant.YAxis)
                              local crossX = (Util.Cross)(point, HomelandRoomConstant.XAxis)
                              local projectInX = 0
                              local projectInY = 0
                              local cos = (Util.Dot)(point.normalized, HomelandRoomConstant.NormalizeYAxis)
                              local mag = point.magnitude
                              local angle = (math.deg)((math.acos)(cos))
                              if crossY.z * crossX.z <= 0 then
                                if cos >= 0 then
                                  local distanceToYAxis = (math.sin)((math.rad)(angle)) * mag
                                  if crossY.z < 0 then
                                    distanceToYAxis = -distanceToYAxis
                                  end
                                  local ypart1 = mag * cos
                                  local ypart2 = distanceToYAxis / _tan
                                  projectInY = ypart1 + ypart2
                                  projectInX = distanceToYAxis / _sin
                                else
                                  do
                                    local angle = 180 - angle
                                    local distanceToYAxis = (math.sin)((math.rad)(angle)) * mag
                                    if crossY.z < 0 then
                                      distanceToYAxis = -distanceToYAxis
                                    end
                                    do
                                      local ypart1 = (math.cos)((math.rad)(angle)) * mag
                                      projectInX = distanceToYAxis / _sin
                                      projectInY = distanceToYAxis / _tan - ypart1
                                      local distanceToYAxis = (math.sin)((math.rad)(angle)) * mag
                                      if crossY.z < 0 then
                                        distanceToYAxis = -distanceToYAxis
                                      end
                                      projectInX = distanceToYAxis / _sin
                                      do
                                        local ypart1 = (math.abs)(projectInX) * _cos
                                        if crossY.z < 0 then
                                          projectInY = mag * cos - ypart1
                                        else
                                          projectInY = mag * cos + ypart1
                                        end
                                        local y = (math.modf)((projectInY) / HomelandRoomConstant.GridLength)
                                        local x = (math.modf)(projectInX / HomelandRoomConstant.GridLength)
                                        local vecInY = HomelandRoomConstant.YAxis * y
                                        local vecInX = HomelandRoomConstant.XAxis * x
                                        local coordinate = Vector3(x + 1, y + 1, 0)
                                        point.x = (HomelandRoomConstant.OriginalPoint).x + vecInY.x + vecInX.x - offsetPos.x
                                        point.y = (HomelandRoomConstant.OriginalPoint).y + vecInY.y + vecInX.y - offsetPos.y
                                        do return Vector2(point.x, point.y), coordinate end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

HomelandRoomWindow.UpdateBelongingGridUsage = function(updateOccupied, ...)
  -- function num : 0_123 , upvalues : _moveComInfo, HomelandRoomWindow, _currentEditGridUsage, _editFurnitureInfo, _ENV
  if not (_moveComInfo.AdjustCom).visible then
    return 
  end
  _moveComInfo.GridStatus = (HomelandRoomWindow.CheckGridUsage)(_moveComInfo.Coordinate, _moveComInfo.Size, _moveComInfo.BelongTo, _moveComInfo.BelongingGrid, _currentEditGridUsage)
  if updateOccupied and _editFurnitureInfo[_moveComInfo.Uid] then
    if _moveComInfo.GridStatus == HomelandRoomGridStatus.Available then
      (HomelandRoomWindow.ChangeOccupiedStatus)(_moveComInfo.Uid)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((_editFurnitureInfo[_moveComInfo.Uid]).Loader).alpha = 1
    else
      ;
      (HomelandRoomWindow.ChangeOccupiedStatus)(_moveComInfo.Uid, true)
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((_editFurnitureInfo[_moveComInfo.Uid]).Loader).alpha = HomelandData.UnavailableAlpha
    end
  end
end

HomelandRoomWindow.SetGridUsage = function(belongGrid, gridDetail, status, ...)
  -- function num : 0_124 , upvalues : _ENV, HomelandRoomWindow
  if status ~= nil then
    for k,v in pairs(belongGrid) do
      for subK,subV in pairs(v) do
        (HomelandRoomWindow.ChangeBelongingGridStatus)(subV, status)
      end
    end
  else
    do
      for k,v in pairs(gridDetail) do
        for subK,subV in pairs(v) do
          (HomelandRoomWindow.ChangeBelongingGridStatus)((belongGrid[k])[subK], subV)
        end
      end
    end
  end
end

HomelandRoomWindow.CheckGridUsage = function(coordinate, size, belongTo, belongingGrid, gridUsage, ...)
  -- function num : 0_125 , upvalues : _ENV, HomelandRoomWindow
  local status = HomelandRoomGridStatus.Unknown
  local gridsDetail = {}
  local changer = function(i, j, begin1, begin2, status, ...)
    -- function num : 0_125_0 , upvalues : gridsDetail, belongingGrid, HomelandRoomWindow
    i = i - begin1 + 1
    j = j - begin2 + 1
    if gridsDetail[i] == nil then
      gridsDetail[i] = {}
    end
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (gridsDetail[i])[j] = status
    if belongingGrid then
      local gridInfo = (belongingGrid[i])[j]
      ;
      (HomelandRoomWindow.ChangeBelongingGridStatus)(gridInfo, status)
    end
  end

  local setter = function(begin1, begin2, limit1, limit2, checker, ...)
    -- function num : 0_125_1 , upvalues : size, status, _ENV, changer
    local lengthl = begin1 + size.x - 1
    local length2 = begin2 + size.y - 1
    for i = begin1, lengthl do
      for j = begin2, length2 do
        if i <= 0 or limit1 < i or j <= 0 or limit2 < j then
          if status == HomelandRoomGridStatus.Unknown then
            status = HomelandRoomGridStatus.OutOfRoom
          else
            if status == HomelandRoomGridStatus.Available then
              status = HomelandRoomGridStatus.Occupied
            end
          end
          changer(i, j, begin1, begin2, false)
        else
          if not checker(i, j, begin1, begin2) then
            if status == HomelandRoomGridStatus.Unknown then
              status = HomelandRoomGridStatus.Available
            else
              if status == HomelandRoomGridStatus.OutOfRoom then
                status = HomelandRoomGridStatus.Occupied
              end
            end
          end
        end
      end
    end
  end

  if belongTo == HomelandRoomGridType.LeftWall then
    setter(coordinate.y, coordinate.z, (HomelandData.GetCurrentRoomSize)(), HomelandRoomConstant.WallVGridAmount, function(i, j, begin1, begin2, ...)
    -- function num : 0_125_2 , upvalues : gridUsage, status, _ENV, changer
    if gridUsage[0] ~= nil and (gridUsage[0])[i] ~= nil and ((gridUsage[0])[i])[j] then
      status = HomelandRoomGridStatus.Occupied
      changer(i, j, begin1, begin2, false)
      return true
    end
    changer(i, j, begin1, begin2, true)
    return false
  end
)
  else
    if belongTo == HomelandRoomGridType.RightWall then
      setter(coordinate.x, coordinate.z, (HomelandData.GetCurrentRoomSize)(), HomelandRoomConstant.WallVGridAmount, function(i, j, begin1, begin2, ...)
    -- function num : 0_125_3 , upvalues : gridUsage, status, _ENV, changer
    if gridUsage[i] ~= nil and (gridUsage[i])[0] ~= nil and ((gridUsage[i])[0])[j] then
      status = HomelandRoomGridStatus.Occupied
      changer(i, j, begin1, begin2, false)
      return true
    end
    changer(i, j, begin1, begin2, true)
    return false
  end
)
    else
      setter(coordinate.x, coordinate.y, (HomelandData.GetCurrentRoomSize)(), (HomelandData.GetCurrentRoomSize)(), function(i, j, begin1, begin2, ...)
    -- function num : 0_125_4 , upvalues : gridUsage, status, _ENV, changer
    if gridUsage[i] ~= nil and (gridUsage[i])[j] ~= nil and ((gridUsage[i])[j])[0] then
      status = HomelandRoomGridStatus.Occupied
      changer(i, j, begin1, begin2, false)
      return true
    end
    changer(i, j, begin1, begin2, true)
    return false
  end
)
    end
  end
  return status, gridsDetail
end

HomelandRoomWindow.ChangeBelongingGridStatus = function(info, available, ...)
  -- function num : 0_126 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (info.GreenGrid).visible = available
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (info.RedGrid).visible = not available
  for k,v in pairs(info.GreenLines) do
    v.visible = available
  end
  for k,v in pairs(info.RedLines) do
    v.visible = not available
  end
end

HomelandRoomWindow.ModifiedCheck = function(...)
  -- function num : 0_127 , upvalues : _ENV, _editFurnitureInfo, _editInfo
  for k,v in pairs(_editFurnitureInfo) do
    if v.Status then
      return true
    end
  end
  for k,v in pairs(_editInfo) do
    for subK,subV in pairs(v.FurnitureInfo) do
      if subV.Status then
        return true
      end
    end
  end
  return false
end

HomelandRoomWindow.ClearInEditMode = function(...)
  -- function num : 0_128 , upvalues : _ENV, _editFurnitureInfo, HomelandRoomWindow
  for k,v in pairs(_editFurnitureInfo) do
    if v.Status ~= FurnitureEditStatus.Remove then
      (HomelandRoomWindow.RemoveSelectedFurniture)()
    end
  end
end

HomelandRoomWindow.EditClearRoom = function(...)
  -- function num : 0_129 , upvalues : _moveComInfo, _ENV, _editFurnitureInfo, HomelandRoomWindow, _editWall, _editFloor
  local config = nil
  if _moveComInfo.Com and (_moveComInfo.Com).visible and _moveComInfo.New then
    (HomelandMgr.AddFurnitureToUI)(_moveComInfo.Id, _moveComInfo.Uid)
  end
  for k,v in pairs(_editFurnitureInfo) do
    if v.Status ~= FurnitureEditStatus.Remove then
      config = ((TableData.gTable).BaseFamilyFurnitureData)[v.ConfigId]
      ;
      (HomelandRoomWindow.RemoveFurniture)(false, k, v.ConfigId, config.type, false)
    end
  end
  if _editWall.Id ~= 0 then
    (HomelandMgr.AddFurnitureToUI)(_editWall.Id, _editWall.Uid)
  end
  if _editFloor.Id ~= 0 then
    (HomelandMgr.AddFurnitureToUI)(_editFloor.Id, _editFloor.Uid)
  end
  _editWall = {Id = 0}
  _editFloor = {Id = 0}
  ;
  (HomelandRoomWindow.RefreshWall)(0)
  ;
  (HomelandRoomWindow.RefreshFloor)(0)
end

HomelandRoomWindow.AbortEdit = function(...)
  -- function num : 0_130 , upvalues : _occupiedFurniture, _moveComInfo, _editFurnitureInfo, _ENV, HomelandRoomWindow, _editInfo, _editCarpetGridUsage, _editGridUsage, WhiteColor, _furnitureType, _initStyleId, _furnitureInfo
  _occupiedFurniture = {Count = 0}
  if _moveComInfo.Com ~= nil and (_moveComInfo.Com).visible and not _moveComInfo.New and (_editFurnitureInfo[_moveComInfo.Uid]).Status ~= FurnitureEditStatus.Add then
    (HomelandRoomWindow.ChangePlacedFurnitureStatus)(_editFurnitureInfo[_moveComInfo.Uid], true, true)
  end
  for k,v in pairs(_editInfo) do
    _editInfo[k] = nil
  end
  local config, gridUsage, curSize = nil, nil, nil
  do
    do
      for k,v in pairs(_editFurnitureInfo) do
        do
          if v.Status ~= nil then
            config = ((TableData.gTable).BaseFamilyFurnitureData)[v.ConfigId]
            if config.type == HomelandFurnitureType.Carpet then
              gridUsage = _editCarpetGridUsage
            else
              gridUsage = _editGridUsage
            end
            v.BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)(v.BelongingGrid)
            if v.Status == FurnitureEditStatus.Add then
              local config = ((TableData.gTable).BaseFamilyFurnitureData)[v.ConfigId]
              if config.type == HomelandFurnitureType.Furniture then
                (HomelandRoomWindow.RemoveFurnitureRelation)(v.Uid, config.type)
              end
              ;
              (HomelandRoomWindow.RefreshRangeGridUsage)(v.BelongTo, gridUsage, v.Size, v.Coordinate)
              ;
              (HomelandRoomWindow.PushToPool)(v.Furniture)
              ;
              (HomelandRoomWindow.RemoveDecorateSort)(config.type, v.BelongTo, v.Uid)
              _editFurnitureInfo[k] = nil
            else
              do
                local config = ((TableData.gTable).BaseFamilyFurnitureData)[v.ConfigId]
                v.SelectedBelongTo = v.OriginBelongTo
                curSize = (Util.CopyVec)(v.Size)
                local resetLoaderPos = function(loader, ...)
    -- function num : 0_130_0 , upvalues : HomelandRoomWindow, config, v, _ENV
    local offset = (HomelandRoomWindow.GetFunritureOffset)(config, v.OriginBelongTo, v.Size, (v.Furniture).width, (v.Furniture).height, v.OriginTurn)
    if config.type == HomelandFurnitureType.Decorate then
      if (config.direction == HomelandRoomDecorateDirection.Left and v.OriginBelongTo == HomelandRoomGridType.LeftWall) or config.direction == HomelandRoomDecorateDirection.Right and v.OriginBelongTo == HomelandRoomGridType.RightWall then
        loader.scaleX = -1
        loader.x = (loader.size).x + offset.x
      else
        loader.scaleX = 1
        loader.x = offset.x
      end
    else
      if v.OriginTurn then
        loader.scaleX = -1
        loader.x = (loader.size).x + offset.x
      else
        loader.scaleX = 1
        loader.x = offset.x
      end
    end
    loader.y = offset.y
  end

                local loader = nil
                if v.Status == FurnitureEditStatus.Remove then
                  if config.type == HomelandFurnitureType.Decorate then
                    (HomelandRoomWindow.AddDecorateSort)(v.Uid, v.OriginCoordinate)
                  end
                  local furniture, coverGrid, size, gridType, comPos, view, rect = nil, nil, nil, nil, nil, nil, nil
                  furniture = (HomelandRoomWindow.PlaceSingleFurniture)(config, v.OriginTurn, v.OriginCoordinate, nil, v.Uid, false, nil, nil, HomelandRoomGridStatus.Available, nil, v.WindowView, v.WindowViewRect)
                  loader.alpha = 1
                  v.Furniture = furniture
                  -- DECOMPILER ERROR at PC150: Overwrote pending register: R10 in 'AssignReg'

                  v.CoverGrid = coverGrid
                  v.WindowView = view
                  v.WindowViewRect = rect
                  local uid = k
                  -- DECOMPILER ERROR at PC156: Confused about usage of register: R19 in 'UnsetPending'

                  ;
                  (v.Furniture).touchable = true
                  ;
                  ((v.Furniture).onClick):Set(function(context, ...)
    -- function num : 0_130_1 , upvalues : HomelandRoomWindow, config, uid
    context:StopPropagation()
    ;
    (HomelandRoomWindow.InitMoveFurniture)(config, uid)
    ;
    (HomelandRoomWindow.InitMoveComSwipeGesture)()
  end
)
                else
                  do
                    -- DECOMPILER ERROR at PC165: Overwrote pending register: R12 in 'AssignReg'

                    -- DECOMPILER ERROR at PC166: Overwrote pending register: R13 in 'AssignReg'

                    -- DECOMPILER ERROR at PC167: Overwrote pending register: R14 in 'AssignReg'

                    -- DECOMPILER ERROR at PC168: Overwrote pending register: R15 in 'AssignReg'

                    v.ComPosition = (HomelandRoomWindow.GetFurniturePositionByCoordinate)(coverGrid, size, gridType, comPos.size)
                    -- DECOMPILER ERROR at PC176: Overwrote pending register: R10 in 'AssignReg'

                    -- DECOMPILER ERROR at PC179: Confused about usage of register: R11 in 'UnsetPending'

                    ;
                    (v.Furniture).xy = v.ComPosition
                    loader.color = WhiteColor
                    loader.alpha = 1
                    if config.type == HomelandFurnitureType.Furniture then
                      (HomelandRoomWindow.RemoveFurnitureRelation)(v.Uid, config.type, v.CoverGrid)
                      -- DECOMPILER ERROR at PC202: Overwrote pending register: R16 in 'AssignReg'

                      if v.OriginTurn ~= v.Turn then
                        v.CoverGrid = (HomelandRoomWindow.SetFurnitureLayerIndex)(v.Furniture, v.Uid, v.OriginCoordinate, {x = view.y, y = (v.Size).x})
                      else
                        v.CoverGrid = (HomelandRoomWindow.SetFurnitureLayerIndex)(v.Furniture, v.Uid, v.OriginCoordinate, v.Size)
                      end
                    else
                      if config.type == HomelandFurnitureType.Decorate then
                        (HomelandRoomWindow.RefreshDecorateSort)(v, config.type, v.BelongTo, v.OriginBelongTo, v.OriginCoordinate)
                      end
                    end
                    resetLoaderPos(loader)
                    if v.OriginTurn ~= v.Turn then
                      local sizeInfo = split(config.size, ":")
                      local sizeX = tonumber(sizeInfo[1])
                      local sizeY = tonumber(sizeInfo[2])
                      if v.OriginTurn then
                        loader.scaleX = -1
                        loader.x = (loader.size).x
                        -- DECOMPILER ERROR at PC256: Confused about usage of register: R14 in 'UnsetPending'

                        ;
                        (v.Size).x = sizeY
                        -- DECOMPILER ERROR at PC258: Confused about usage of register: R14 in 'UnsetPending'

                        ;
                        (v.Size).y = sizeX
                      else
                        loader.scaleX = 1
                        loader.x = 0
                        -- DECOMPILER ERROR at PC263: Confused about usage of register: R14 in 'UnsetPending'

                        ;
                        (v.Size).x = sizeX
                        -- DECOMPILER ERROR at PC265: Confused about usage of register: R14 in 'UnsetPending'

                        ;
                        (v.Size).y = sizeY
                      end
                      v.Turn = v.OriginTurn
                    end
                    do
                      do
                        do
                          ;
                          (HomelandRoomWindow.RefreshRangeGridUsage)(v.BelongTo, gridUsage, curSize, v.Coordinate)
                          ;
                          (HomelandRoomWindow.RefreshRangeGridUsage)(v.OriginBelongTo, gridUsage, v.Size, v.OriginCoordinate, true)
                          v.Coordinate = (Util.CopyVec)(v.OriginCoordinate)
                          v.Status = nil
                        end
                        -- DECOMPILER ERROR at PC289: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC289: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC289: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC289: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC289: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC289: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC289: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC289: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC289: LeaveBlock: unexpected jumping out IF_STMT

                        -- DECOMPILER ERROR at PC289: LeaveBlock: unexpected jumping out DO_STMT

                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    ;
    (HomelandRoomWindow.RefreshWall)(((HomelandData.RoomData).Wall).Id)
    ;
    (HomelandRoomWindow.RefreshFloor)(((HomelandData.RoomData).Floor).Id)
    ;
    (HomelandRoomWindow.RefreshFurnitureIcon)(_furnitureType)
    if _initStyleId ~= (HomelandData.RoomData).StyleId then
      _furnitureInfo = _editFurnitureInfo
      -- DECOMPILER ERROR at PC317: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (HomelandData.RoomData).GridUsage = _editGridUsage
      -- DECOMPILER ERROR at PC321: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (HomelandData.RoomData).CarpetGridUsage = _editCarpetGridUsage
    end
  end
end

HomelandRoomWindow.SaveEdit = function(...)
  -- function num : 0_131 , upvalues : _moveComInfo, HomelandRoomWindow, _editFurnitureInfo, _ENV, _editInfo
  if _moveComInfo.Com ~= nil and (_moveComInfo.Com).visible then
    if _moveComInfo.New then
      (HomelandRoomWindow.PlaceNewFurniture)()
    else
      ;
      (HomelandRoomWindow.ChangePlacedFurnitureStatus)(_editFurnitureInfo[_moveComInfo.Uid], true)
    end
    ;
    (HomelandRoomWindow.HideMoveFurniture)()
  end
  ;
  (HomelandRoomWindow.SaveCurrentStyleEditInfo)()
  for k,v in pairs(_editInfo) do
    if (v.OccupiedFurniture).Count > 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000543))
      return false
    end
  end
  ;
  (HomelandMgr.ReqChangeRoomLayout)(_editInfo)
end

HomelandRoomWindow.SyncEditedFurnitureInfo = function(...)
  -- function num : 0_132 , upvalues : _ENV, _editWall, _editFloor, _editFurnitureInfo, _furnitureInfo, _editGridUsage, _editCarpetGridUsage
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (HomelandData.RoomData).Wall = _editWall
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (HomelandData.RoomData).Floor = _editFloor
  for k,v in pairs(_editFurnitureInfo) do
    if v.Status == FurnitureEditStatus.Remove then
      _editFurnitureInfo[k] = nil
    else
      v.Status = nil
      v.OriginCoordinate = (Util.CopyVec)(v.Coordinate)
      v.OriginTurn = v.Turn
      v.OriginBelongTo = v.BelongTo
    end
  end
  _furnitureInfo = _editFurnitureInfo
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (HomelandData.RoomData).GridUsage = _editGridUsage
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (HomelandData.RoomData).CarpetGridUsage = _editCarpetGridUsage
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.UndeployFurnitures = HomelandData.EditUndeployFurnitures
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R0 in 'UnsetPending'

  HomelandData.PileFurnitures = HomelandData.EditPileFurnitures
end

HomelandRoomWindow.RefreshFurnitureIcon = function(type, notRefreshPile, ...)
  -- function num : 0_133 , upvalues : _furnitureType, _ENV, HomelandRoomWindow
  _furnitureType = type
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  HomelandData.EditCurrentFurnitures = (HomelandData.GetFurnituresByType)(type)
  ;
  (HomelandRoomWindow.SortFurnitureIcon)()
  ;
  (HomelandRoomWindow.RefreshFurnitureList)()
end

HomelandRoomWindow.SortFurnitureIcon = function(...)
  -- function num : 0_134 , upvalues : _sort, _ENV
  if _sort then
    (table.sort)(HomelandData.EditCurrentFurnitures, function(x, y, ...)
    -- function num : 0_134_0 , upvalues : _ENV
    local xConfig = ((TableData.gTable).BaseFamilyFurnitureData)[x]
    local yConfig = ((TableData.gTable).BaseFamilyFurnitureData)[y]
    if xConfig.sort == yConfig.sort then
      return false
    else
      return xConfig.sort < yConfig.sort
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  else
    ;
    (table.sort)(HomelandData.EditCurrentFurnitures, function(x, y, ...)
    -- function num : 0_134_1 , upvalues : _ENV
    local xConfig = ((TableData.gTable).BaseFamilyFurnitureData)[x]
    local yConfig = ((TableData.gTable).BaseFamilyFurnitureData)[y]
    if xConfig.sort == yConfig.sort then
      return false
    else
      return yConfig.sort < xConfig.sort
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  end
end

HomelandRoomWindow.CheckRoomSwipeArea = function(...)
  -- function num : 0_135 , upvalues : HomelandRoomWindow, uis
  (HomelandRoomWindow.RefreshRoomSwipeArea)()
  ;
  (HomelandRoomWindow.SetRoomXY)(((uis.Currency).root).x, ((uis.Currency).root).y)
end

HomelandRoomWindow.ZoomRoom = function(delta, ...)
  -- function num : 0_136 , upvalues : _zoomSize, _ENV, HomelandRoomWindow
  local zoomSize = _zoomSize + delta
  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P3

  if ((zoomSize < HomelandRoomConstant.MinZoom and HomelandRoomConstant.MinZoom) or HomelandRoomConstant.MaxZoom < zoomSize) then
    (HomelandRoomWindow.SetRoomZoom)(zoomSize)
  end
end

HomelandRoomWindow.ZoomInRoom = function(...)
  -- function num : 0_137 , upvalues : _zoomSize, _ENV, HomelandRoomWindow
  local zoomSize = _zoomSize - 0.05
  if zoomSize >= HomelandRoomConstant.MinZoom or not HomelandRoomConstant.MinZoom then
    (HomelandRoomWindow.SetRoomZoom)(zoomSize)
  end
end

HomelandRoomWindow.ZoomOutRoom = function(...)
  -- function num : 0_138 , upvalues : _zoomSize, _ENV, HomelandRoomWindow
  local zoomSize = _zoomSize + 0.05
  if HomelandRoomConstant.MaxZoom >= zoomSize or not HomelandRoomConstant.MaxZoom then
    (HomelandRoomWindow.SetRoomZoom)(zoomSize)
  end
end

HomelandRoomWindow.SetRoomZoom = function(size, force, ...)
  -- function num : 0_139 , upvalues : _zoomSize, uis, _roomAdjustScale, _ENV, _bgImg, _bgImgOriginScale, HomelandRoomWindow
  if size ~= nil and size == _zoomSize and not force then
    return 
  end
  local diff = nil
  if _zoomSize and size then
    diff = size - _zoomSize
    diff = ((uis.Currency).root).size * (diff) * _roomAdjustScale
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.Currency).root).x = ((uis.Currency).root).x - diff.x * 0.5
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.Currency).root).y = ((uis.Currency).root).y - diff.y * 0.5
  end
  if size ~= nil then
    _zoomSize = size
  end
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.Currency).root).scale = Vector2.one * _zoomSize * _roomAdjustScale
  _bgImg.scale = Vector2.one * _zoomSize * _bgImgOriginScale
  ;
  (HomelandRoomWindow.CheckRoomSwipeArea)()
end

HomelandRoomWindow.SetWindowView = function(config, x, y, img, rect, base, index, ...)
  -- function num : 0_140 , upvalues : _ENV, Rect, HomelandRoomWindow, _bgImg
  do
    if rect == nil then
      local rectStr = split(config.perspectivity, ":")
      rect = Rect(tonumber(rectStr[1]), tonumber(rectStr[2]), tonumber(rectStr[3]), tonumber(rectStr[4]))
    end
    local bgRect = (HomelandRoomWindow.GetWindowViewRect)(Rect(x + rect.x, y + rect.y, rect.width, rect.height))
    if img == nil then
      img = ((FairyGUI.UIObjectFactory).NewObject)((FairyGUI.ObjectType).Image)
      base:AddChild(img)
      base:SetChildIndex(img, index)
      img.size = Vector2(rect.width, rect.height)
    else
      ;
      (img.texture):Unload()
    end
    img.texture = (FairyGUI.NTexture)((_bgImg.texture).nativeTexture, nil, 1, 1)
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (img.texture).uvRect = Rect(bgRect.x / ((_bgImg.texture).nativeTexture).width, 1 - bgRect.yMax / ((_bgImg.texture).nativeTexture).height, bgRect.width / ((_bgImg.texture).nativeTexture).width, bgRect.height / ((_bgImg.texture).nativeTexture).height)
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (img.texture).destroyMethod = (FairyGUI.DestroyMethod).None
    return img, rect
  end
end

HomelandRoomWindow.GetWindowViewRect = function(rect, ...)
  -- function num : 0_141 , upvalues : _ENV, uis, _bgImg, Rect, _bgImgUVRect
  local posInBg = Vector2((rect.x * ((uis.Currency).root).scaleX + ((uis.Currency).root).x - _bgImg.x) / _bgImg.scaleX, (rect.y * ((uis.Currency).root).scaleY + ((uis.Currency).root).y - _bgImg.y) / _bgImg.scaleY)
  return Rect(_bgImgUVRect.xMin * ((_bgImg.texture).nativeTexture).width + posInBg.x, (1 - _bgImgUVRect.yMin - _bgImgUVRect.height) * ((_bgImg.texture).nativeTexture).height + posInBg.y, rect.width * ((uis.Currency).root).scaleX / _bgImg.scaleX, rect.height * ((uis.Currency).root).scaleY / _bgImg.scaleY)
end

HomelandRoomWindow.PullFromPool = function(res, base, ignoreScale, ...)
  -- function num : 0_142 , upvalues : _reusePool, _ENV
  if _reusePool[res] ~= nil and #_reusePool[res] > 0 then
    local com = (table.remove)(_reusePool[res], 1)
    if base ~= nil then
      base:AddChild(com)
    end
    com.visible = true
    return com
  else
    do
      local com = ((FairyGUI.UIPackage).CreateObject)((WinResConfig.HomelandRoomWindow).package, res)
      if base ~= nil then
        base:AddChild(com)
      end
      com.gameObjectName = res
      if not ignoreScale then
        com.scale = Vector2.one * HomelandRoomConstant.GridLength / com.height
      end
      do return com end
    end
  end
end

HomelandRoomWindow.PushToPool = function(com, ...)
  -- function num : 0_143 , upvalues : _reusePool, uis, _ENV
  if com == nil then
    return 
  end
  if _reusePool[com.name] == nil then
    _reusePool[com.name] = {}
  end
  local count = #_reusePool[com.name]
  for i = 1, count do
    if ((_reusePool[com.name])[i]).uid == com.uid then
      return 
    end
  end
  ;
  ((uis.CurrencyWindow).root):AddChild(com)
  ;
  (com.onClick):Clear()
  com.visible = false
  ;
  (table.insert)(_reusePool[com.name], com)
end

HomelandRoomWindow.PlayFurniutreAnim = function(furniture, coordinate, ...)
  -- function num : 0_144 , upvalues : uis, _ENV
  local loader = furniture:GetChild("FurnitureItemLoader")
  loader.pivotY = 1
  local tweens = {}
  local initPos = furniture.xy
  local startPos, func1, func2, func3 = nil, nil, nil, nil
  startPos = initPos.y - furniture.height * 0.5
  furniture.y = startPos
  furniture.visible = true
  func1 = function(value, ...)
    -- function num : 0_144_0 , upvalues : loader
    loader.scaleY = value
  end

  func2 = function(value, ...)
    -- function num : 0_144_1 , upvalues : furniture, uis
    if furniture then
      furniture.y = value
      ;
      ((uis.Currency).root):InvalidateBatchingState()
    end
  end

  local phase1Duration = 0.1
  local eachDuration = 0.1
  local tween = ((LeanTween.value)(1, 1.3, phase1Duration)):setOnUpdate(func1)
  ;
  (table.insert)(tweens, tween)
  tween = (((LeanTween.value)(1.3, 0.8, eachDuration)):setOnUpdate(func1)):setDelay(phase1Duration)
  ;
  (table.insert)(tweens, tween)
  tween = (((LeanTween.value)(0.8, 1.1, eachDuration)):setOnUpdate(func1)):setDelay(phase1Duration + eachDuration)
  ;
  (table.insert)(tweens, tween)
  tween = (((LeanTween.value)(1.1, 1, eachDuration)):setOnUpdate(func1)):setDelay(phase1Duration + eachDuration * 2)
  ;
  (table.insert)(tweens, tween)
  ;
  (((LeanTween.value)(startPos, initPos.y, phase1Duration)):setEaseOutCubic()):setOnUpdate(func2)
  return tweens
end

HomelandRoomWindow.ActiveEditMode = function(...)
  -- function num : 0_145 , upvalues : HomelandRoomWindow, uis, _ENV
  (HomelandRoomWindow.StopBubble)()
  ;
  (HomelandRoomWindow.HideCards)()
  ;
  (HomelandRoomWindow.InitEditData)(true)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = HomelandRoomStatus.Edit
  ;
  (HomelandRoomWindow.RefreshFurnitureIcon)(HomelandFurnitureType.All)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Warehouse).BtnList).numItems = HomelandFurnitureType.Carpet
  ;
  (HomelandRoomWindow.CheckRoomSwipeArea)()
end

HomelandRoomWindow.DeactiveEditMode = function(syncCom, ...)
  -- function num : 0_146 , upvalues : HomelandRoomWindow, uis, _ENV
  (HomelandRoomWindow.RefreshCards)()
  ;
  (HomelandRoomWindow.ClearEditData)(syncCom)
  ;
  (HomelandRoomWindow.HideMoveFurniture)()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = HomelandRoomStatus.Normal
  ;
  (HomelandRoomWindow.CheckRoomSwipeArea)()
  ;
  (HomelandRoomWindow.HideEditGrids)()
end

HomelandRoomWindow.ClearRoom = function(operate, ...)
  -- function num : 0_147 , upvalues : HomelandRoomWindow, _ENV
  if operate.Wall then
    (HomelandRoomWindow.RefreshWall)()
    ;
    (HomelandData.AddFurniture)(operate.Wall)
  end
  if operate.Floor then
    (HomelandRoomWindow.RefreshFloor)()
    ;
    (HomelandData.AddFurniture)(operate.Floor)
  end
  ;
  (HomelandRoomWindow.RecycleAllFurniture)(false, true)
end

HomelandRoomWindow.RecycleAllFurniture = function(destroy, addToUI, ...)
  -- function num : 0_148 , upvalues : HomelandRoomWindow, _ENV
  local furnitures = (HomelandRoomWindow.GetCurrentFurnitureInfo)()
  for k,v in pairs(furnitures) do
    if addToUI then
      (HomelandData.AddFurniture)(v.Uid)
    end
    if v.Timer ~= nil then
      (v.Timer):stop()
    end
    if v.PlaceAnim ~= nil then
      for subK,subV in pairs(v.PlaceAnim) do
        (LeanTween.cancel)(subV.uniqueId)
      end
    end
    do
      do
        if v.Status ~= FurnitureEditStatus.Remove then
          if not destroy then
            (HomelandRoomWindow.PushToPool)(v.Furniture)
            v.BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)(v.BelongingGrid)
          else
            ;
            (v.Furniture):Dispose()
            v.BelongingGrid = (HomelandRoomWindow.RecycleBelongingGrid)(v.BelongingGrid, true)
          end
          if v.WindowView ~= nil then
            (v.WindowView):Dispose()
          end
          v.BelongingGrid = nil
        end
        -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  (HomelandRoomWindow.ClearData)(destroy)
end

HomelandRoomWindow.ClickStyleBtn = function(styleId, ...)
  -- function num : 0_149 , upvalues : _asyncTimer, HomelandRoomWindow, uis, _ENV, _moveComInfo
  if _asyncTimer ~= nil then
    _asyncTimer:stop()
  end
  ;
  (HomelandRoomWindow.StopBubble)()
  if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Edit then
    if _moveComInfo.Com ~= nil and (_moveComInfo.Com).visible and _moveComInfo.New then
      (HomelandRoomWindow.PlaceNewFurniture)()
      ;
      (HomelandMgr.RemoveFurnitureFromUI)(_moveComInfo.Id, _moveComInfo.Uid)
    end
    ;
    (HomelandRoomWindow.SaveCurrentStyleEditInfo)()
    ;
    (HomelandRoomWindow.HideMoveFurniture)()
  end
  ;
  (HomelandMgr.ChangeStyle)(styleId)
end

HomelandRoomWindow.SaveCurrentStyleEditInfo = function(...)
  -- function num : 0_150 , upvalues : _editGridUsage, _editCarpetGridUsage, _editWall, _editFloor, _editFurnitureInfo, _occupiedFurniture, _ENV, _editInfo
  local data = {}
  data.GridUsage = _editGridUsage
  data.CarpetGridUsage = _editCarpetGridUsage
  data.Wall = _editWall
  data.Floor = _editFloor
  data.FurnitureInfo = _editFurnitureInfo
  data.OccupiedFurniture = _occupiedFurniture
  data.AvailableGridCount = (HomelandData.RoomData).CardGridCount
  _editInfo[(HomelandData.RoomData).StyleId] = data
end

HomelandRoomWindow.ClickBlankBtn = function(...)
  -- function num : 0_151 , upvalues : uis, _ENV, _moveComInfo, HomelandRoomWindow, _editFurnitureInfo, _ui, _uiAnim, _topUIAnim
  if ((uis.AssetStripGrp).root).visible then
    if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Edit and (_moveComInfo.Com == nil or not (_moveComInfo.Com).visible) then
      (HomelandRoomWindow.AbortEdit)()
      ;
      (HomelandRoomWindow.DeactiveEditMode)(true)
    else
      if _moveComInfo.Com ~= nil and (_moveComInfo.Com).visible then
        if _moveComInfo.New then
          (HomelandRoomWindow.PlaceNewFurniture)()
        else
          ;
          (HomelandRoomWindow.ChangePlacedFurnitureStatus)(_editFurnitureInfo[_moveComInfo.Uid], true)
        end
        ;
        (HomelandRoomWindow.HideMoveFurniture)()
      end
    end
  else
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.AssetStripGrp).root).visible = true
    _ui.visible = true
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.PlayerInfo).root).visible = true
    _uiAnim:Play()
    _topUIAnim:Play()
  end
end

HomelandRoomWindow.ClickClearBtn = function(...)
  -- function num : 0_152 , upvalues : uis, _ENV, HomelandRoomWindow
  if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Edit then
    (HomelandRoomWindow.EditClearRoom)()
    ;
    (HomelandRoomWindow.HideMoveFurniture)()
  else
    ;
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000551), function(...)
    -- function num : 0_152_0 , upvalues : _ENV
    (HomelandMgr.ReqClearRoom)()
  end
)
  end
end

HomelandRoomWindow.ClickSaveBtn = function(...)
  -- function num : 0_153 , upvalues : HomelandRoomWindow
  (HomelandRoomWindow.SaveEdit)()
end

HomelandRoomWindow.ClickStorageBtn = function(...)
  -- function num : 0_154 , upvalues : HomelandRoomWindow
  (HomelandRoomWindow.ActiveEditMode)()
end

HomelandRoomWindow.ClickHideBtn = function(...)
  -- function num : 0_155 , upvalues : _moveComInfo, HomelandRoomWindow, _editFurnitureInfo, uis, _uiAnim, _ui, _topUIAnim
  if _moveComInfo.Com ~= nil and (_moveComInfo.Com).visible then
    if not _moveComInfo.New then
      (HomelandRoomWindow.ChangePlacedFurnitureStatus)(_editFurnitureInfo[_moveComInfo.Uid], true)
    else
      ;
      (HomelandRoomWindow.PlaceNewFurniture)()
    end
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (_moveComInfo.Com).visible = false
  end
  if ((uis.AssetStripGrp).root).visible then
    _uiAnim:PlayReverse(function(...)
    -- function num : 0_155_0 , upvalues : uis, _ui
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.AssetStripGrp).root).visible = false
    _ui.visible = false
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.PlayerInfo).root).visible = false
  end
)
    _topUIAnim:PlayReverse()
  end
end

HomelandRoomWindow.ClickRandomVisitBtn = function(...)
  -- function num : 0_156 , upvalues : _ENV
  (HomelandMgr.ReqRandomPlayerInfo)()
end

HomelandRoomWindow.ClickVisitBtn = function(...)
  -- function num : 0_157 , upvalues : _ENV
  (HomelandMgr.OpenVisitUI)()
end

HomelandRoomWindow.ClickDeployBtn = function(...)
  -- function num : 0_158 , upvalues : _ENV
  OpenWindow((WinResConfig.HomelandDeployCardWindow).name, UILayer.HUD, (HomelandData.RoomData).CardGridCount)
end

HomelandRoomWindow.ClickShopBtn = function(...)
  -- function num : 0_159 , upvalues : _ENV
  ld("Shop")
  ;
  (HomelandService.ReqFarmShopTypeData)(ShopType.Family_NormalShop)
end

HomelandRoomWindow.ClickExtendBtn = function(...)
  -- function num : 0_160 , upvalues : HomelandRoomWindow, _ENV
  (HomelandRoomWindow.HideEditGrids)()
  ;
  (HomelandMgr.ReqRoomLevelUp)((HomelandData.RoomData).Id, (HomelandData.RoomData).StyleId)
end

HomelandRoomWindow.ClickSortBtn = function(...)
  -- function num : 0_161 , upvalues : _sort, HomelandRoomWindow, uis
  _sort = not _sort
  ;
  (HomelandRoomWindow.SortFurnitureIcon)()
  ;
  ((uis.Warehouse).CardHeadList):RefreshVirtualList()
end

HomelandRoomWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_162 , upvalues : _ENV, HomelandRoomWindow, uis, _furnitureType
  if msgId == (WindowMsgEnum.Family).E_MSG_CHANGE_ROOM_LAYOUT_SUCCESS then
    (HomelandRoomWindow.SyncEditedFurnitureInfo)()
    ;
    (HomelandRoomWindow.DeactiveEditMode)()
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(60000544))
  else
    if msgId == (WindowMsgEnum.Family).E_MSG_CLEAR_ROOM then
      (HomelandRoomWindow.ClearRoom)(para)
      if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Edit then
        (HomelandRoomWindow.DeactiveEditMode)()
      end
    else
      if msgId == (WindowMsgEnum.Family).E_MSG_UPGRADE_ROOM then
        (HomelandRoomWindow.RefreshWall)()
        ;
        (HomelandRoomWindow.RefreshFloor)()
        ;
        (HomelandRoomWindow.RefreshExtendArea)()
        ;
        (HomelandRoomWindow.RefreshRoomSwipeArea)()
        ;
        (HomelandRoomWindow.SetRoomZoom)()
        ;
        (HomelandRoomWindow.SetRoomXY)(((uis.Currency).root).x, ((uis.Currency).root).y)
      else
        if msgId == (WindowMsgEnum.Family).E_MSG_REFRESH_HOUSE then
          (HomelandRoomWindow.RefreshHouse)()
        else
          if msgId == (WindowMsgEnum.Family).E_MSG_REFRESH_ROOM then
            if (uis.c1Ctr).selectedIndex == HomelandRoomStatus.Normal then
              (HomelandRoomWindow.RefreshRoom)()
            else
              ;
              (HomelandRoomWindow.RefreshEditRoom)()
            end
          else
            if msgId == (WindowMsgEnum.Family).E_MSG_REFRESH_ROOM_ROLES then
              (HomelandRoomWindow.RefreshCards)()
            else
              if msgId == (WindowMsgEnum.Family).E_MSG_REFRESH_FURNITURE_LIST then
                (HomelandRoomWindow.RefreshFurnitureIcon)(_furnitureType)
              else
                if msgId == (WindowMsgEnum.Family).E_MSG_REFRESH_FURNITURE_VIRTUAL_LIST then
                  (HomelandRoomWindow.RefreshFurnitureList)()
                else
                  if msgId == (WindowMsgEnum.Family).E_MSG_REFRESH_GULID_VISIT then
                    (HomelandRoomWindow.RefreshOtherRelation)()
                  else
                    if msgId == (WindowMsgEnum.Family).E_MSG_CONTINUE_PATROL then
                      para.PatrolTween = (HomelandRoomWindow.StartPatrol)(para)
                    else
                      if msgId == (WindowMsgEnum.Family).E_MSG_STOP_ROLE_VOICE then
                        (HomelandRoomWindow.StopBubble)(para)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

return HomelandRoomWindow

