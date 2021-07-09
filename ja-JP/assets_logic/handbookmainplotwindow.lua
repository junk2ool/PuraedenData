-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_MainPlotByName")
local HandbookMainPlotWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local HBChapterConfigs = (TableData.gTable).BaseHandbookAdventureChapterData
HandbookMainPlotWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HandbookMainPlotWindow
  bridgeObj:SetView((WinResConfig.HandbookMainPlotWindow).package, (WinResConfig.HandbookMainPlotWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetHandBook_MainPlotUis(contentPane)
  ;
  (HandbookMainPlotWindow.InitTopMenu)()
  ;
  (HandbookMainPlotWindow.InitList)()
end

HandbookMainPlotWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.HandbookMainPlotWindow).name
  m.Tip = (PUtil.get)(20000128)
  m.model = uis.AssetStripGrp
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandbookMainPlotWindow.InitList = function(...)
  -- function num : 0_2 , upvalues : uis, HandbookMainPlotWindow
  (uis.MainPlotList):SetVirtual()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.MainPlotList).itemRenderer = HandbookMainPlotWindow.RefreshPlotItem
  ;
  (uis.MainPlotList):SetBeginAnim()
end

HandbookMainPlotWindow.OnShown = function(...)
  -- function num : 0_3 , upvalues : HandbookMainPlotWindow
  (HandbookMainPlotWindow.Init)()
end

HandbookMainPlotWindow.OnHide = function(...)
  -- function num : 0_4
end

HandbookMainPlotWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

HandbookMainPlotWindow.Init = function(...)
  -- function num : 0_6 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  (uis.MainPlotList).numItems = #HandBookData.StoryChapter
end

HandbookMainPlotWindow.RefreshPlotItem = function(index, item, ...)
  -- function num : 0_7 , upvalues : _ENV, HBChapterConfigs
  item = item:GetChild("MainPlotTips")
  index = index + 1
  local id = (HandBookData.StoryChapter)[index]
  local config = HBChapterConfigs[id]
  local wordTxt = item:GetChild("WordTxt")
  local length = ((Util.StrUnicodeLength)(config.name))
  local str = nil
  local actualLength = length * ((wordTxt.textFormat).size + (wordTxt.textFormat).letterSpacing) - (wordTxt.textFormat).letterSpacing
  if item.width < actualLength then
    str = (Util.StrUnicodeSub)(config.name, 1, (math.floor)(item.width / ((wordTxt.textFormat).size + (wordTxt.textFormat).letterSpacing)) - 1) .. "..."
  else
    str = config.name
  end
  ;
  (item:GetChild("ChapterTxt")).text = config.remark
  wordTxt.text = str
  ;
  (item:GetChild("IconImage")).url = (Util.GetItemUrl)(config.icon)
  ;
  (item.onClick):Clear()
  if config.unlockPoints > 0 then
    local data = (HandBookData.ScoreChapterStatus)[id]
    do
      if data == nil then
        (item:GetController("c3")).selectedIndex = 1
        ;
        (item:GetController("c1")).selectedIndex = 1
      else
        if config.unlockPoints <= data.point then
          if data.click then
            (item:GetController("c3")).selectedIndex = 1
          else
            ;
            (item:GetController("c3")).selectedIndex = 0
          end
          ;
          (item:GetController("c1")).selectedIndex = 0
          ;
          (item:GetChild("NumberTxt")).text = ""
          ;
          (item.onClick):Set(function(...)
    -- function num : 0_7_0 , upvalues : data, _ENV, id, index
    data.click = true
    ;
    (HandBookService.ReqClickPointPlot)(id)
    OpenWindow((WinResConfig.HandBookStoryPlotWindow).name, UILayer.HUD, (HandBookMgr.AdventureStoryType).MainStory, HandBookData.StoryChapter, index)
  end
)
        else
          ;
          (item:GetController("c3")).selectedIndex = 1
          ;
          (item:GetController("c1")).selectedIndex = 1
          ;
          (item:GetChild("NumberTxt")).text = (PUtil.get)(60000646, data.point, config.unlockPoints)
          ;
          (item.onClick):Set(function(...)
    -- function num : 0_7_1 , upvalues : _ENV, config, data
    (MessageMgr.SendCenterTips)((PUtil.get)(60000647, config.unlockPoints - data.point))
  end
)
        end
      end
    end
  else
    do
      ;
      (item:GetController("c1")).selectedIndex = 0
      ;
      (item:GetController("c3")).selectedIndex = 1
      if id == HandBookData.QueryingId and HandBookData.UnlockState ~= (HandBookData.PlotLockState).FullUnlock then
        (item:GetChild("NumberTxt")).text = (PUtil.get)(60000645)
        if HandBookData.UnlockState == (HandBookData.PlotLockState).PartUnlock then
          (item.onClick):Set(function(...)
    -- function num : 0_7_2 , upvalues : _ENV, index
    OpenWindow((WinResConfig.HandBookStoryPlotWindow).name, UILayer.HUD, (HandBookMgr.AdventureStoryType).MainStory, HandBookData.StoryChapter, index)
  end
)
        else
          ;
          (item:GetController("c1")).selectedIndex = 1
          ;
          (item.onClick):Set(function(...)
    -- function num : 0_7_3 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(60000645))
  end
)
        end
      else
        ;
        (item:GetChild("NumberTxt")).text = ""
        ;
        (item.onClick):Set(function(...)
    -- function num : 0_7_4 , upvalues : _ENV, index
    OpenWindow((WinResConfig.HandBookStoryPlotWindow).name, UILayer.HUD, (HandBookMgr.AdventureStoryType).MainStory, HandBookData.StoryChapter, index)
  end
)
      end
    end
  end
end

HandbookMainPlotWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8 , upvalues : _ENV, uis
  if msgId == (WindowMsgEnum.HandBook).E_MSG_REFRESH then
    (uis.MainPlotList):RefreshVirtualList()
  end
end

return HandbookMainPlotWindow

