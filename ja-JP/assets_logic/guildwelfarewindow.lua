-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_WelfareByName")
local GUILD_TIDY_SLOTS_AMOUNT = 6
local CLEAN_UP_DURATION = 3
local GuildWelfareWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local clearItems = {}
GuildWelfareWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildWelfareWindow
  bridgeObj:SetView((WinResConfig.GuildWelfareWindow).package, (WinResConfig.GuildWelfareWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_WelfareUis(contentPane)
  ;
  (GuildWelfareWindow.InitTopMenu)()
  ;
  (GuildWelfareWindow.InitVariable)()
  ;
  (GuildWelfareWindow.InitText)()
  ;
  (GuildWelfareWindow.InitButtonEvent)()
end

GuildWelfareWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildWelfareWindow).name
  m.Tip = (PUtil.get)(60000256)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildWelfareWindow.InitVariable = function(...)
  -- function num : 0_2
end

GuildWelfareWindow.InitText = function(...)
  -- function num : 0_3
end

GuildWelfareWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, GuildWelfareWindow
  ((uis.RankingBtn).onClick):Add(GuildWelfareWindow.ClickRankingBtn)
end

GuildWelfareWindow.InitEvent = function(...)
  -- function num : 0_5
end

GuildWelfareWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

GuildWelfareWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : GuildWelfareWindow
  (GuildWelfareWindow.InitEvent)()
  ;
  (GuildWelfareWindow.Init)()
end

GuildWelfareWindow.OnHide = function(...)
  -- function num : 0_8
end

GuildWelfareWindow.Init = function(...)
  -- function num : 0_9 , upvalues : GUILD_TIDY_SLOTS_AMOUNT, GuildWelfareWindow
  for i = 1, GUILD_TIDY_SLOTS_AMOUNT do
    (GuildWelfareWindow.InitClearItem)(i)
  end
end

GuildWelfareWindow.InitClearItem = function(index, ...)
  -- function num : 0_10 , upvalues : uis, _ENV, clearItems, CLEAN_UP_DURATION
  local content = (uis.WelfareContent)["Content_0" .. tostring(index)]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  if (GuildData.RewardStatus)[index] ~= nil and not ((GuildData.RewardStatus)[index]).isDraw then
    (content.root).visible = true
    ;
    (table.insert)(clearItems, content)
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (content.root).visible = false
  end
  local longPress = (FairyGUI.LongPressGesture)((uis.WelfareContent).root)
  longPress:Enable(true)
  longPress.trigger = 0
  longPress.interval = 0.1
  local sound, pressPanel = nil, nil
  local ctrls = {}
  local tweens = {}
  local pos = {}
  longPress:AddEventListener("onLongPressBegin", function(...)
    -- function num : 0_10_0 , upvalues : clearItems, sound, _ENV, pressPanel, ctrls, CLEAN_UP_DURATION, pos, tweens
    if #clearItems < 1 then
      return 
    end
    sound = (LuaSound.PlaySound)(LuaSound.GUILD_WELFARE_TOUCH, SoundBank.OTHER)
    for i = 1, #clearItems do
      do
        local _content = clearItems[i]
        local ctrl, bar, tweener = nil, nil, nil
        pressPanel = (_content.root):GetChildAt((_content.root).numChildren - 2)
        ctrl = pressPanel:GetController("c1")
        ;
        (table.insert)(ctrls, ctrl)
        ctrl.selectedIndex = 1
        bar = pressPanel:GetChild("ClearBar")
        bar.value = 0
        tweener = ((bar:TweenValue(100, CLEAN_UP_DURATION)):SetEase((FairyGUI.EaseType).Linear)):OnComplete(function(...)
      -- function num : 0_10_0_0 , upvalues : _content, _ENV, pos, i, clearItems
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

      (_content.root).visible = false
      local index = (string.gsub)((_content.root).gameObjectName, "Content_0", "")
      index = tonumber(index)
      ;
      (table.insert)(pos, index)
      if i == #clearItems then
        clearItems = {}
        ;
        (GuildService.ReqGuildGiftGet)(pos)
      end
    end
)
        ;
        (table.insert)(tweens, tweener)
      end
    end
  end
)
  longPress:AddEventListener("onLongPressEnd", function(...)
    -- function num : 0_10_1 , upvalues : _ENV, sound, clearItems, tweens, ctrls, pos
    (LuaSound.StopSound)(sound)
    for i = 1, #clearItems do
      if tweens[i] then
        (tweens[i]):Kill(false)
      end
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

      if ctrls[i] then
        (ctrls[i]).selectedIndex = 0
      end
    end
    tweens = {}
    ctrls = {}
    pos = {}
  end
)
end

GuildWelfareWindow.ClickRankingBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  (GuildService.ReqGuildGiftRank)()
end

GuildWelfareWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : _ENV, GuildWelfareWindow, uis, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildWelfareWindow).name)
  ;
  (GuildWelfareWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildWelfareWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : _ENV, GuildWelfareWindow
  if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_WELFARE_STATUS then
    (GuildWelfareWindow.Init)()
  end
end

return GuildWelfareWindow

