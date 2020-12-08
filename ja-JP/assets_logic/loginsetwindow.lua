-- params : ...
-- function num : 0 , upvalues : _ENV
require("Land_SetWindowByName")
local LoginSetWindow = {}
local uis, contentPane = nil, nil
local LoginMgr = LoginMgr
local _videoLoader, _clickTime, _blackBG, _lastBGMId = nil, nil, nil, nil
LoginSetWindow.ReInitData = function(...)
  -- function num : 0_0
end

LoginSetWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_1 , upvalues : _ENV, contentPane, uis, LoginSetWindow
  bridgeObj:SetView((WinResConfig.LoginSetWindow).package, (WinResConfig.LoginSetWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetLand_SetWindowUis(contentPane)
  ;
  (LoginSetWindow.InitBtn)()
end

LoginSetWindow.InitBtn = function(...)
  -- function num : 0_2 , upvalues : uis, LoginSetWindow, _ENV, _clickTime, _blackBG, _lastBGMId
  local setUis = uis.Set
  ;
  ((setUis.CloseBtn).onClick):Set(LoginSetWindow.onClickClose)
  ;
  ((setUis.SureBtn).onClick):Set(LoginSetWindow.onClickClose)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (setUis.NameTxt).text = (PUtil.get)(40002050)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (setUis.NoticeBtn).text = (PUtil.get)(40002051)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (setUis.SDKBtn).text = (PUtil.get)(40002052)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (setUis.AgreementBtn).text = (PUtil.get)(40002053)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (setUis.SureBtn).text = (PUtil.get)(60000004)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (setUis.MoveBtn).text = (PUtil.get)(20000502)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (setUis.RepairBtn).text = (PUtil.get)(40002069)
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (setUis.PlayBtn).text = (PUtil.get)(60000556)
  ;
  ((setUis.NoticeBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV
    ld("RedDot")
    ld("Activity")
    ld("Announcement", function(...)
      -- function num : 0_2_0_0 , upvalues : _ENV
      (AnnouncementMgr.OpenAnnouncement)(true)
    end
)
  end
)
  ;
  ((setUis.MoveBtn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : _ENV
    if Game.useSDK == true then
      (SuperSDKUtil.OpenCustomServer)()
    end
  end
)
  ;
  ((setUis.SDKBtn).onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : _ENV
    if Game.useSDK == true then
      UIMgr:CloseWindow((WinResConfig.LoginSetWindow).name)
      ;
      (SuperSDKUtil.Logout)()
    end
  end
)
  ;
  ((setUis.AgreementBtn).onClick):Set(function(...)
    -- function num : 0_2_3 , upvalues : _ENV
    OpenWindow((WinResConfig.PactWindow).name, UILayer.HUD)
  end
)
  ;
  ((setUis.RepairBtn).onClick):Set(function(...)
    -- function num : 0_2_4 , upvalues : _ENV
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(40002067), function(...)
      -- function num : 0_2_4_0 , upvalues : _ENV
      local ioTools = CS.IOTools
      if ioTools then
        (ioTools.DeleteAllFiles)((ioTools.GetUpdateBasePath)(), true)
        ;
        (Application.Quit)()
      end
    end
, function(...)
      -- function num : 0_2_4_1
    end
, nil, (PUtil.get)(40002068), (PUtil.get)(60000005), true, UILayer.HUD1)
  end
)
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (setUis.VideoLoader).visible = false
  ;
  ((setUis.VideoLoader).onClick):Set(function(...)
    -- function num : 0_2_5 , upvalues : _clickTime, _ENV, setUis
    if _clickTime ~= nil and (os.time)() - _clickTime < 1 then
      ((CS.VideoManager).Instance):StopVideo(setUis.VideoLoader, true)
    end
    _clickTime = (os.time)()
  end
)
  ;
  ((setUis.PlayBtn).onClick):Set(function(...)
    -- function num : 0_2_6 , upvalues : setUis, _blackBG, _ENV, _lastBGMId
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (setUis.VideoLoader).visible = true
    if _blackBG == nil then
      _blackBG = ((FairyGUI.UIObjectFactory).NewObject)((FairyGUI.ObjectType).Graph)
      ;
      (setUis.root):AddChildAt(_blackBG, (setUis.root):GetChildIndex(setUis.VideoLoader))
      _blackBG:DrawRect(ResolutionHandler.Width + 100, ResolutionHandler.Height + 100, 1, ((CS.UnityEngine).Color).white, ((CS.UnityEngine).Color).black)
      _blackBG.x = -(ResolutionHandler.AdaptOffset).X - 50
      _blackBG.y = -50
    end
    _blackBG.visible = true
    _lastBGMId = (LuaSound.GetBGMId)()
    ;
    (LuaSound.StopBGM)()
    ;
    ((CS.VideoManager).Instance):PlayVideo(setUis.VideoLoader, "pv_001", function(...)
      -- function num : 0_2_6_0 , upvalues : setUis, _blackBG, _lastBGMId, _ENV
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

      (setUis.VideoLoader).visible = false
      _blackBG.visible = false
      if _lastBGMId then
        (LuaSound.LoadAndPlayBGM)(_lastBGMId)
        _lastBGMId = nil
      end
    end
)
  end
)
  -- DECOMPILER ERROR at PC105: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (setUis.PlayBtn).visible = not (Util.IsNil)((ResHelper.LoadVideo)("pv_001"))
end

LoginSetWindow.onClickClose = function(...)
  -- function num : 0_3 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.LoginSetWindow).name)
end

LoginSetWindow.OnShown = function(...)
  -- function num : 0_4
end

LoginSetWindow.OnHide = function(...)
  -- function num : 0_5
end

LoginSetWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : _videoLoader, _blackBG, uis, contentPane
  if _videoLoader ~= nil then
    _videoLoader:Dispose()
    _videoLoader = nil
  end
  if _blackBG ~= nil then
    _blackBG:Dispose()
    _blackBG = nil
  end
  uis = nil
  contentPane = nil
end

LoginSetWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7
  if msgId ~= 1 or msgId == 2 then
  end
end

return LoginSetWindow

