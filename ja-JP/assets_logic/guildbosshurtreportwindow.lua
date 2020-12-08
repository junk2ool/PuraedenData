-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_BattleNewsWindowByName")
require("GuildBoss_NewsTipsByName")
local GuildBossHurtReportWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local listData = {}
local maxHp = 0
GuildBossHurtReportWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildBossHurtReportWindow
  bridgeObj:SetView((WinResConfig.GuildBossHurtReportWindow).package, (WinResConfig.GuildBossHurtReportWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuildBoss_BattleNewsWindowUis(contentPane)
  uis = uis.BattleNews
  ;
  (GuildBossHurtReportWindow.SetBossInfo)()
  ;
  (GuildBossHurtReportWindow.SetInvariable)()
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.OtherGuildList).itemRenderer = GuildBossHurtReportWindow.ListRenderer
  ;
  (uis.OtherGuildList):SetVirtual()
  ;
  (GuildBossHurtReportWindow.RefreshList)()
end

GuildBossHurtReportWindow.RefreshList = function(...)
  -- function num : 0_1 , upvalues : maxHp, listData, _ENV, uis
  maxHp = 0
  listData = {}
  local data = ((GuildBossMgr.BossHurtReport)()).hurtReport
  for _,v in ipairs(data) do
    (table.insert)(listData, v)
    maxHp = (math.max)(v.hurt, maxHp)
  end
  ;
  (table.sort)(listData, function(a, b, ...)
    -- function num : 0_1_0
    do return b.hurt < a.hurt end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.OtherGuildList).numItems = #listData
end

GuildBossHurtReportWindow.ListRenderer = function(index, obj, ...)
  -- function num : 0_2 , upvalues : _ENV, listData, maxHp
  local model = GetGuildBoss_NewsTipsUis(obj)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (model.c1Ctr).selectedIndex = (math.min)(3, index)
  index = index + 1
  local data = listData[index]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  if data.playerIndex == (ActorData.GetPlayerIndex)() then
    (model.c3Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (model.c3Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((model.TipsBattleNumber).NameTxt).text = (PUtil.get)(60000235)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.WordTxt).text = (PUtil.get)(20000410)
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.NumberTxt).text = (Util.NumberTransformKilo)((math.ceil)(data.hurt))
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.NumberProgressBar).value = data.hurt / maxHp * 100
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.Ranking_04_Txt).text = index
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'

  if (Util.StringIsNullOrEmpty)(data.name) then
    ((model.PlayerHead).LevelTxt).text = ""
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((model.TitlePic).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (model.PlayerNameTxt).text = ""
  else
    local fashionConfig = ((TableData.gTable).BasePlayerHeadIconData)[data.fashionHead]
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R5 in 'UnsetPending'

    if fashionConfig then
      ((model.PlayerHead).ActorHeadLoader).url = (Util.GetResUrl)(fashionConfig.icon_path)
    end
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((model.PlayerHead).LevelTxt).text = "Lv." .. data.level
    ;
    (Util.SetTitleShow)((model.TitlePic).root, data.titleId)
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (model.PlayerNameTxt).text = data.name
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((model.TipsBattleNumber).WordTxt).text = data.fc
  end
end

GuildBossHurtReportWindow.SetInvariable = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.SureBtn).text = (PUtil.get)(60000004)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossHurtReportWindow).name)
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_3_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossHurtReportWindow).name)
  end
)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000543)
end

GuildBossHurtReportWindow.SetBossInfo = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis
  local stageID = ((GuildBossMgr.BossHurtReport)()).stageId
  local stageData = ((TableData.gTable).BaseGuildWarStageData)[stageID]
  local round = ((GuildBossMgr.BossHurtReport)()).round
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.NewsShow).NameTxt).text = (PUtil.get)(20000627, stageData.name, round)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.NewsShow).TimeTxt).text = (PUtil.get)(20000523, round)
  local curStage = (GuildBossMgr.GuildBossCurStage)()
  local isChallenge = curStage.id == stageID
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

  if isChallenge then
    (((uis.NewsShow).BossForm).c1Ctr).selectedIndex = 0
    local per = (GuildBossMgr.GuildBossHP)()
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((uis.NewsShow).BossForm).BossHpProgressBar).value = per
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((uis.NewsShow).BossForm).HpNumberTxt).text = per .. "%"
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((uis.NewsShow).BossForm).OrderTxt).text = stageData.monster_pos
  else
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

    (((uis.NewsShow).BossForm).c1Ctr).selectedIndex = 2
  end
  ;
  (Util.CreateMiniModel)(((uis.NewsShow).BossForm).BossLoader, stageData.monster_show)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

GuildBossHurtReportWindow.OnShown = function(...)
  -- function num : 0_5
end

GuildBossHurtReportWindow.OnHide = function(...)
  -- function num : 0_6
end

GuildBossHurtReportWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildBossHurtReportWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8
end

return GuildBossHurtReportWindow

