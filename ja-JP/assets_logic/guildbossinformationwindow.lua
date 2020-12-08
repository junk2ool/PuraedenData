-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_AllBossBattleWindowByName")
local GuildBossInformationWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local tableList = {}
GuildBossInformationWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildBossInformationWindow
  bridgeObj:SetView((WinResConfig.GuildBossInformationWindow).package, (WinResConfig.GuildBossInformationWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuildBoss_AllBossBattleWindowUis(contentPane)
  uis = uis.AllBossBattle
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.AllBossTipsList).itemRenderer = GuildBossInformationWindow.ItemRenderer
  ;
  (uis.AllBossTipsList):SetVirtual()
  ;
  (GuildBossInformationWindow.InitListData)()
  ;
  (GuildBossInformationWindow.InitVariable)()
end

GuildBossInformationWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossInformationWindow).name)
  end
)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000016)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossInformationWindow).name)
  end
)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000526)
end

GuildBossInformationWindow.ItemRenderer = function(index, object, ...)
  -- function num : 0_2 , upvalues : tableList, _ENV
  index = index + 1
  local data = (tableList[index]).mData
  local round = (tableList[index]).round
  ;
  (table.sort)(data, function(a, b, ...)
    -- function num : 0_2_0
    do return a.monster_pos < b.monster_pos end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local title = object:GetChild("NumberTxt")
  title.text = (PUtil.get)(20000523, round)
  local mList = object:GetChild("AllBossList")
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (mList.scrollPane).touchEffect = false
  mList.numItems = 0
  for _,v in ipairs(data) do
    do
      local single = UIMgr:CreateObject("GuildBoss", "AllBossBtn")
      local name = single:GetChild("BossNameTxt")
      local time = single:GetChild("Word_01_Txt")
      local time2 = single:GetChild("Word_02_Txt")
      local loader = single:GetChild("BossLoader")
      time.text = (PUtil.get)(20000524)
      name.text = (PUtil.get)(20000627, v.name, round)
      local fashionData = ((TableData.gTable).BaseFashionData)[v.monster_show]
      loader.url = (Util.GetItemUrl)(fashionData.head_icon_square)
      local bossInfo = (GuildBossMgr.GetBossInfo)(v.id)
      if bossInfo then
        time2.visible = true
        if v.id == ((GuildBossMgr.GuildBossCurStage)()).id and round == (GuildBossMgr.GetCurrentRound)(true) then
          time2.text = (PUtil.get)(20000525)
        else
          time2.text = (LuaTime.GetFormatTimeStr)("%m-%d %H:%M", bossInfo.deathTime)
        end
      else
        time2.visible = false
      end
      ;
      (single.onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : bossInfo, _ENV, v, round
    if bossInfo then
      (GuildBossService.ReqHurtReport)(v.id, round)
    else
      ;
      (MessageMgr.SendCenterTipsByWordID)(20000527)
    end
  end
)
      mList:AddChild(single)
    end
  end
  mList.height = (math.ceil)(mList.numItems / 2) * 122
end

GuildBossInformationWindow.InitListData = function(...)
  -- function num : 0_3 , upvalues : tableList, _ENV, uis
  tableList = {}
  local battleList = (GuildBossMgr.BossInfoData)()
  local roundList = {}
  for _,v in pairs(battleList) do
    local stageData = ((TableData.gTable).BaseGuildWarStageData)[v.id]
    local round = v.round
    if roundList[round] == nil then
      roundList[round] = {}
    end
    ;
    (table.insert)(roundList[round], stageData)
  end
  for i,v in pairs(roundList) do
    local data = {}
    data.round = i
    data.mData = v
    ;
    (table.insert)(tableList, data)
  end
  ;
  (table.sort)(tableList, function(a, b, ...)
    -- function num : 0_3_0
    do return b.round < a.round end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.AllBossTipsList).numItems = #tableList
end

GuildBossInformationWindow.OnShown = function(...)
  -- function num : 0_4
end

GuildBossInformationWindow.OnHide = function(...)
  -- function num : 0_5
end

GuildBossInformationWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildBossInformationWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7
end

return GuildBossInformationWindow

