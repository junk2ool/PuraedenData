-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_HelpListWindowByName")
local NewActivityDungeonGuildAssistWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _guildData = nil
NewActivityDungeonGuildAssistWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, NewActivityDungeonGuildAssistWindow
  bridgeObj:SetView((WinResConfig.NewActivityDungeonGuildAssistWindow).package, (WinResConfig.NewActivityDungeonGuildAssistWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivityDungeonTwo_HelpListWindowUis(contentPane)
  ;
  (NewActivityDungeonGuildAssistWindow.InitText)()
  ;
  (NewActivityDungeonGuildAssistWindow.InitButtonEvent)()
  ;
  (NewActivityDungeonGuildAssistWindow.InitList)()
end

NewActivityDungeonGuildAssistWindow.InitText = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.SystemSetGrp).TitleTxt).text = (PUtil.get)(60000629)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.SystemSetGrp).SureBtn).text = (PUtil.get)(60000004)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.SystemSetGrp).Tips).TipsTxt).autoSize = (FairyGUI.AutoSizeType).Both
end

NewActivityDungeonGuildAssistWindow.InitButtonEvent = function(...)
  -- function num : 0_2 , upvalues : uis, NewActivityDungeonGuildAssistWindow
  (((uis.SystemSetGrp).SureBtn).onClick):Set(NewActivityDungeonGuildAssistWindow.ClickCloseBtn)
  ;
  (((uis.SystemSetGrp).CloseBtn).onClick):Set(NewActivityDungeonGuildAssistWindow.ClickCloseBtn)
end

NewActivityDungeonGuildAssistWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : uis, NewActivityDungeonGuildAssistWindow
  ((uis.SystemSetGrp).PlayerList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.SystemSetGrp).PlayerList).itemRenderer = NewActivityDungeonGuildAssistWindow.RefreshGuildMemberItem
end

NewActivityDungeonGuildAssistWindow.OnShown = function(...)
  -- function num : 0_4 , upvalues : NewActivityDungeonGuildAssistWindow
  (NewActivityDungeonGuildAssistWindow.Init)()
end

NewActivityDungeonGuildAssistWindow.OnHide = function(...)
  -- function num : 0_5
end

NewActivityDungeonGuildAssistWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

NewActivityDungeonGuildAssistWindow.Init = function(...)
  -- function num : 0_7 , upvalues : NewActivityDungeonGuildAssistWindow
  (NewActivityDungeonGuildAssistWindow.RefreshTips)()
  ;
  (NewActivityDungeonGuildAssistWindow.RefreshTimes)()
  ;
  (NewActivityDungeonGuildAssistWindow.RefreshList)()
end

NewActivityDungeonGuildAssistWindow.RefreshTips = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  if NewActivityDungeonData.AssistData == nil then
    (((uis.SystemSetGrp).Tips).TipsTxt).text = ""
  else
    local config = ((TableData.gTable).BaseActivityAidData)[(NewActivityDungeonData.AssistData).id]
    local rewardStrs = split(config.assist_reward, ",")
    local count = #rewardStrs
    local str = ""
    for i = 1, count do
      str = str .. (MessageMgr.GetCostImgHtmlByStr)(rewardStrs[i], nil, 25)
    end
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((uis.SystemSetGrp).Tips).TipsTxt).text = (PUtil.get)(60000634, str, (math.floor)(config.assist_hp * 0.01))
  end
end

NewActivityDungeonGuildAssistWindow.RefreshList = function(...)
  -- function num : 0_9 , upvalues : _guildData, _ENV, uis
  _guildData = {}
  if GuildData ~= nil then
    local count = #GuildData.MemberList
    for i = 1, count do
      if ((GuildData.MemberList)[i]).objectindex ~= (ActorData.baseInfo).playerIndex then
        (table.insert)(_guildData, i)
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.SystemSetGrp).PlayerList).numItems = #_guildData
  end
end

NewActivityDungeonGuildAssistWindow.RefreshGuildMemberItem = function(index, item, ...)
  -- function num : 0_10 , upvalues : _ENV, _guildData
  local data = (GuildData.MemberList)[_guildData[index + 1]]
  local playerHead = item:GetChild("PlayerHead")
  if data.onlineTime == 0 then
    (item:GetChild("PlayerNameTxt")).text = data.name .. "[color=" .. Const.GreenColor .. "](" .. (PUtil.get)(60000233) .. ")[/color]"
  else
    ;
    (item:GetChild("PlayerNameTxt")).text = data.name .. "[color=" .. Const.GreenColor .. "]" .. "(" .. (LuaTime.GetLeftTimeStr)(data.onlineTime / 1000) .. ")" .. "[/color]"
  end
  ;
  (playerHead:GetChild("LevelTxt")).text = "Lv." .. data.level
  local fashionConfig = ((TableData.gTable).BasePlayerHeadIconData)[data.fashionId]
  ;
  (playerHead:GetChild("ActorHeadLoader")).url = (Util.GetResUrl)(fashionConfig.icon_path)
  if data.titleId == 0 then
    ((item:GetChild("TitlePic")):GetChild("PicLoader")).url = nil
  else
    ;
    ((item:GetChild("TitlePic")):GetChild("PicLoader")).url = (Util.GetItemUrl)((((TableData.gTable).BasePlayerTitleData)[data.titleId]).icon)
  end
  local config = ((TableData.gTable).BaseActivityAidData)[(NewActivityDungeonData.AssistData).id]
  local leftTimes = config.assisted_num - data.byAssistTime
  local battleInfo = item:GetChild("BattleInfo")
  ;
  (battleInfo:GetChild("NameTxt")).text = (PUtil.get)(60000635)
  ;
  (battleInfo:GetChild("WordTxt")).autoSize = (FairyGUI.AutoSizeType).Both
  local hp = (math.ceil)(data.remainHp * 0.01)
  if hp == 0 then
    (item:GetController("c1")).selectedIndex = 1
    ;
    (battleInfo:GetChild("WordTxt")).text = (PUtil.get)(60000642, "[color=" .. Const.RedColor .. "]0", "0[/color]")
  else
    if leftTimes == 0 then
      (item:GetController("c1")).selectedIndex = 1
      ;
      (battleInfo:GetChild("WordTxt")).text = (PUtil.get)(60000642, "[color=" .. Const.RedColor .. "]" .. leftTimes .. "[/color][color=" .. Const.GreenColor .. "]", config.assisted_num .. "[/color]")
    else
      ;
      (item:GetController("c1")).selectedIndex = 0
      ;
      (battleInfo:GetChild("WordTxt")).text = "[color=" .. Const.GreenColor .. "]" .. (PUtil.get)(20000092, leftTimes, config.assisted_num) .. "[/color]"
      local battleBtn = item:GetChild("BattleBtn")
      ;
      (battleBtn.onClick):Set(function(...)
    -- function num : 0_10_0 , upvalues : _ENV, data
    (NewActivityDungeonMgr.TryAssistGuildMember)(data)
    ;
    (Util.SetOnClickDelay)(0.5)
  end
)
    end
  end
  do
    local bar = item:GetChild("PlayerHpProgressBar")
    bar.value = hp
    ;
    (bar:GetChild("NumberTxt")).text = hp .. "/100"
  end
end

NewActivityDungeonGuildAssistWindow.RefreshTimes = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis
  local config = ((TableData.gTable).BaseActivityAidData)[(NewActivityDungeonData.AssistData).id]
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  if NewActivityDungeonData.AssistData == nil or config.assist_num <= (NewActivityDungeonData.AssistData).assistedTime then
    ((uis.SystemSetGrp).TouchNumberTxt).text = (PUtil.get)(60000630, "[color=" .. Const.RedColor .. "]" .. "0[/color][color=" .. Const.GreenColor .. "]", config.assist_num .. "[/color]")
    ;
    (RedDotMgr.EliminateRedDot)((WinResConfig.NewActivityDungeonMainWindow).name, RedDotComID.NAD_GuildHlep)
    ;
    (RedDotMgr.RefreshTreeUI)((WinResConfig.NewActivityDungeonMainWindow).name)
  else
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.SystemSetGrp).TouchNumberTxt).text = (PUtil.get)(60000630, "[color=" .. Const.GreenColor .. "]" .. tostring(config.assist_num - (NewActivityDungeonData.AssistData).assistedTime), config.assist_num .. "[/color]")
  end
end

NewActivityDungeonGuildAssistWindow.ClickCloseBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.NewActivityDungeonGuildAssistWindow).name)
end

NewActivityDungeonGuildAssistWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : _ENV, NewActivityDungeonGuildAssistWindow, uis
  if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_ASSIST_LIST then
    (NewActivityDungeonGuildAssistWindow.RefreshList)()
  else
    if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_ASSIST_LIST_INFO then
      ((uis.SystemSetGrp).PlayerList):RefreshVirtualList()
      ;
      (NewActivityDungeonGuildAssistWindow.RefreshTimes)()
    else
      if msgId == (WindowMsgEnum.NewActivityDungeon).E_MSG_REFRESH_GUILD_ASSIST then
        (NewActivityDungeonGuildAssistWindow.RefreshTips)()
        ;
        (NewActivityDungeonGuildAssistWindow.RefreshTimes)()
      end
    end
  end
end

return NewActivityDungeonGuildAssistWindow

