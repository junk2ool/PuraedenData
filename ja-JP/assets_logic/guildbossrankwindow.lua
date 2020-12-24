-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_GuildBossRankWindowByName")
local GuildBossRankWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local isPersonType = nil
local dataList = {}
local currentPage = 1
local playerIndex = (ActorData.GetPlayerIndex)()
local guildIndex = ((ActorData.GetGuildID)())
local GuildLevelConfig = nil
GuildBossRankWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, currentPage, uis, GuildBossRankWindow
  bridgeObj:SetView((WinResConfig.GuildBossRankWindow).package, (WinResConfig.GuildBossRankWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  currentPage = 1
  uis = GetGuildBoss_GuildBossRankWindowUis(contentPane)
  uis = uis.GuildBossRank
  ;
  (GuildBossRankWindow.InitGuildLV)()
  ;
  (GuildBossRankWindow.InitInvariable)()
  ;
  (GuildBossRankWindow.SetLeftInfo)()
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.GuildBossRankChoice).infoList).itemRenderer = GuildBossRankWindow.ItemListRenderer
  ;
  ((uis.GuildBossRankChoice).infoList):SetVirtual()
  ;
  (GuildBossRankWindow.RefreshList)()
end

GuildBossRankWindow.InitGuildLV = function(...)
  -- function num : 0_1 , upvalues : GuildLevelConfig, _ENV
  GuildLevelConfig = {}
  for k,v in pairs((TableData.gTable).BaseGuildLevelUpData) do
    GuildLevelConfig[v.level] = k
  end
end

GuildBossRankWindow.RefreshList = function(...)
  -- function num : 0_2 , upvalues : isPersonType, _ENV, dataList, GuildBossRankWindow, uis
  isPersonType = (GuildBossMgr.IsPersonList)()
  if isPersonType then
    dataList = (GuildBossMgr.GetPersonRankDataList)()
  else
    dataList = (GuildBossMgr.GetGuildRankDataList)()
  end
  ;
  (GuildBossRankWindow.SetSelectIndex)()
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.GuildBossRankChoice).infoList).numItems = #dataList
end

GuildBossRankWindow.ItemListRenderer = function(index, obj, ...)
  -- function num : 0_3 , upvalues : dataList, isPersonType, _ENV, playerIndex, guildIndex, GuildBossRankWindow, GuildLevelConfig
  index = index + 1
  local data = dataList[index]
  if isPersonType then
    ChangeUIController(obj, "c2", 0)
    local personData = data
    if personData.objectindex == playerIndex then
      ChangeUIController(obj, "c3", 1)
    else
      ChangeUIController(obj, "c3", 0)
    end
    ;
    ((obj:GetChild("IntegralNumber")):GetChild("NameTxt")).text = (PUtil.get)(20000533)
    ;
    ((obj:GetChild("TipsBattleNumber")):GetChild("NameTxt")).text = (PUtil.get)(60000235)
    if not (Util.StringIsNullOrEmpty)(personData.name) then
      local fashionConfig = ((TableData.gTable).BasePlayerHeadIconData)[personData.fashionId]
      if fashionConfig then
        ((obj:GetChild("PlayerHead")):GetChild("ActorHeadLoader")).url = (Util.GetResUrl)(fashionConfig.icon_path)
      end
      ;
      ((obj:GetChild("PlayerHead")):GetChild("LevelTxt")).text = "Lv." .. personData.lv
      ;
      (Util.SetTitleShow)(obj:GetChild("TitlePic"), personData.titleId)
      ;
      (obj:GetChild("NameTxt")).text = personData.name
      ;
      ((obj:GetChild("IntegralNumber")):GetChild("WordTxt")).text = personData.integral
      ;
      ((obj:GetChild("TipsBattleNumber")):GetChild("WordTxt")).text = personData.fc
      ChangeUIController(obj, "c4", 0)
    else
      do
        ;
        ((obj:GetChild("PlayerHead")):GetChild("ActorHeadLoader")).url = ""
        ;
        ((obj:GetChild("PlayerHead")):GetChild("LevelTxt")).text = ""
        ;
        (Util.SetTitleShow)(obj:GetChild("TitlePic"), 0)
        ;
        (obj:GetChild("NameTxt")).text = (PUtil.get)(20000563)
        ;
        ((obj:GetChild("IntegralNumber")):GetChild("WordTxt")).text = ""
        ;
        ((obj:GetChild("TipsBattleNumber")):GetChild("WordTxt")).text = ""
        ChangeUIController(obj, "c4", 1)
        local headFrame = (obj:GetChild("PlayerHead")):GetChild("HeadFrameLoader")
        local fashionFrame = headFrame:GetChild("HeadFrameLoader")
        if data.fashionFrame == nil or data.fashionFrame == 0 then
          fashionFrame.url = nil
        else
          local frameConfig = ((TableData.gTable).BasePlayerHeadFrameData)[data.fashionFrame]
          if frameConfig then
            fashionFrame.url = (Util.GetResUrl)(frameConfig.icon_path)
          end
        end
        do
          ChangeUIController(obj, "c2", 1)
          local guildData = data
          if guildData.id == guildIndex then
            ChangeUIController(obj, "c3", 1)
          else
            ChangeUIController(obj, "c3", 0)
          end
          ;
          ((obj:GetChild("IntegralNumber")):GetChild("NameTxt")).text = (PUtil.get)(20000533)
          if not (Util.StringIsNullOrEmpty)(guildData.name) then
            ((obj:GetChild("GuildHead")):GetChild("GuildLoader")).url = (GuildBossRankWindow.GetGuildIcon)(guildData.icon)
            ;
            (obj:GetChild("NameTxt")).text = guildData.name
            ;
            (obj:GetChild("GuildLevelTxt")).text = "Lv." .. guildData.level
            local max = (((TableData.gTable).BaseGuildLevelUpData)[GuildLevelConfig[guildData.level]]).max_member
            ;
            (obj:GetChild("PlayerNumberTxt")).text = (PUtil.get)(20000536, guildData.memberCount, max)
            ;
            ((obj:GetChild("IntegralNumber")):GetChild("WordTxt")).text = guildData.integral
            ChangeUIController(obj, "c4", 0)
          else
            do
              do
                ;
                ((obj:GetChild("GuildHead")):GetChild("GuildLoader")).url = ""
                ;
                (obj:GetChild("NameTxt")).text = (PUtil.get)(20000564)
                ;
                (obj:GetChild("GuildLevelTxt")).text = ""
                ;
                (obj:GetChild("PlayerNumberTxt")).text = ""
                ;
                ((obj:GetChild("IntegralNumber")):GetChild("WordTxt")).text = ""
                ChangeUIController(obj, "c4", 1)
                if index <= 3 then
                  ChangeUIController(obj, "c1", index - 1)
                else
                  ChangeUIController(obj, "c1", 3)
                  ;
                  (obj:GetChild("Ranking_04_Txt")).text = index
                end
              end
            end
          end
        end
      end
    end
  end
end

GuildBossRankWindow.InitInvariable = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV, isPersonType, currentPage, GuildBossRankWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TitleTxt).text = (PUtil.get)(20000530)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(60000004)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossRankWindow).name)
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossRankWindow).name)
  end
)
  ;
  (((uis.GuildBossRankChoice).GuildBtn):GetChild("NameTxt")).text = (PUtil.get)(20000532)
  ;
  (((uis.GuildBossRankChoice).PlayerBtn):GetChild("NameTxt")).text = (PUtil.get)(20000531)
  ;
  (((uis.GuildBossRankChoice).GuildBtn).onClick):Set(function(...)
    -- function num : 0_4_2 , upvalues : _ENV
    local isLast = (GuildBossMgr.IsLastSeasonData)()
    ;
    (GuildBossService.ReqGSeasonRank)(isLast, 1)
  end
)
  ;
  (((uis.GuildBossRankChoice).PlayerBtn).onClick):Set(function(...)
    -- function num : 0_4_3 , upvalues : _ENV
    local isLast = (GuildBossMgr.IsLastSeasonData)()
    ;
    (GuildBossService.ReqMSeasonRank)(isLast)
  end
)
  ;
  (((uis.BossRewardInfo).MonthBtn).onClick):Set(function(...)
    -- function num : 0_4_4 , upvalues : _ENV, uis
    local info = (GuildBossMgr.GuildBossInfo)()
    if info.status == (ProtoEnum.GUILD_WAR_STATUS).READY then
      (MessageMgr.SendCenterTipsByWordID)(20000559)
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.BossRewardInfo).c2Ctr).selectedIndex = 1
      return 
    end
    local isLast = (GuildBossMgr.IsLastSeasonData)()
    local isPerson = (GuildBossMgr.IsPersonList)()
    if isPerson then
      (GuildBossService.ReqMSeasonRank)(not isLast)
    else
      ;
      (GuildBossService.ReqGSeasonRank)(not isLast, 1)
    end
  end
)
  local mList = (uis.GuildBossRankChoice).infoList
  ;
  ((mList.scrollPane).onPullUpRelease):Set(function(...)
    -- function num : 0_4_5 , upvalues : isPersonType, mList, _ENV, currentPage, GuildBossRankWindow
    if isPersonType then
      return 
    end
    local footer = (mList.scrollPane).footer
    ;
    (footer:GetController("c1")).selectedIndex = 1
    PlayUITrans(footer, "Rotate")
    ;
    (mList.scrollPane):LockFooter(footer.sourceHeight)
    currentPage = currentPage + 1
    local last = (GuildBossMgr.IsLastSeasonData)()
    ;
    (GuildBossService.ReqGSeasonRank)(last, currentPage)
    ;
    (SimpleTimer.setTimeout)(1, function(...)
      -- function num : 0_4_5_0 , upvalues : footer, mList, GuildBossRankWindow
      (footer:GetController("c1")).selectedIndex = 0
      ;
      (mList.scrollPane):LockFooter(0)
      ;
      (GuildBossRankWindow.RefreshList)()
    end
)
  end
)
end

GuildBossRankWindow.SetLeftInfo = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV, GuildBossRankWindow, GuildLevelConfig
  local BossRewardInfo = uis.BossRewardInfo
  local isLast = (GuildBossMgr.IsLastSeasonData)()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if isLast then
    (BossRewardInfo.c2Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (BossRewardInfo.c2Ctr).selectedIndex = 0
  end
  local isPerson = (GuildBossMgr.IsPersonList)()
  local maxRank = (GuildBossMgr.GetMaxRank)()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  if isPerson then
    (BossRewardInfo.c1Ctr).selectedIndex = 0
    local personRank, score = (GuildBossMgr.GetPersonRank)()
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((BossRewardInfo.IntegralNumber).NameTxt).text = (PUtil.get)(20000533)
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((BossRewardInfo.TipsBattleNumber).NameTxt).text = (PUtil.get)(60000235)
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((BossRewardInfo.TipsBattleNumber).WordTxt).text = (ActorData.GetFc)()
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

    if personRank == -1 then
      (BossRewardInfo.c3Ctr).selectedIndex = 1
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((BossRewardInfo.IntegralNumber).WordTxt).text = 0
    else
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (BossRewardInfo.c3Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R6 in 'UnsetPending'

      if maxRank < personRank then
        (BossRewardInfo.RankNumberTxt).text = maxRank
        -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (BossRewardInfo.PlusImage).visible = true
      else
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (BossRewardInfo.RankNumberTxt).text = personRank
        -- DECOMPILER ERROR at PC64: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (BossRewardInfo.PlusImage).visible = false
      end
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((BossRewardInfo.IntegralNumber).WordTxt).text = score
    end
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (BossRewardInfo.NameTxt).text = (ActorData.GetNickName)()
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((BossRewardInfo.PlayerHead).LevelTxt).text = "Lv." .. (ActorData.GetLevel)()
    local fashionHead = (ActorData.GetFashionHead)()
    local fashionConfig = ((TableData.gTable).BasePlayerHeadIconData)[fashionHead]
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R8 in 'UnsetPending'

    if fashionConfig then
      ((BossRewardInfo.PlayerHead).ActorHeadLoader).url = (Util.GetResUrl)(fashionConfig.icon_path)
    end
    local frameValue = (ActorData.GetFashionFrame)()
    local fashionFrame = ((BossRewardInfo.PlayerHead).HeadFrameLoader).HeadFrameLoader
    if frameValue == nil or frameValue == 0 then
      fashionFrame.url = nil
    else
      local frameConfig = ((TableData.gTable).BasePlayerHeadFrameData)[frameValue]
      if frameConfig then
        fashionFrame.url = (Util.GetResUrl)(frameConfig.icon_path)
      end
    end
    do
      do
        local titleID = (ActorData.GetWearTitle)()
        ;
        (Util.SetTitleShow)((BossRewardInfo.TitlePic).root, titleID)
        -- DECOMPILER ERROR at PC131: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (BossRewardInfo.c1Ctr).selectedIndex = 1
        local GuildRank = (GuildBossMgr.GuildRankIndex)()
        -- DECOMPILER ERROR at PC140: Confused about usage of register: R5 in 'UnsetPending'

        if GuildRank and GuildRank > 0 then
          (BossRewardInfo.c3Ctr).selectedIndex = 0
          -- DECOMPILER ERROR at PC144: Confused about usage of register: R5 in 'UnsetPending'

          if maxRank < GuildRank then
            (BossRewardInfo.RankNumberTxt).text = maxRank
            -- DECOMPILER ERROR at PC146: Confused about usage of register: R5 in 'UnsetPending'

            ;
            (BossRewardInfo.PlusImage).visible = true
          else
            -- DECOMPILER ERROR at PC149: Confused about usage of register: R5 in 'UnsetPending'

            ;
            (BossRewardInfo.RankNumberTxt).text = GuildRank
            -- DECOMPILER ERROR at PC151: Confused about usage of register: R5 in 'UnsetPending'

            ;
            (BossRewardInfo.PlusImage).visible = false
          end
        else
          -- DECOMPILER ERROR at PC154: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (BossRewardInfo.c3Ctr).selectedIndex = 1
        end
        -- DECOMPILER ERROR at PC161: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((BossRewardInfo.IntegralNumber).NameTxt).text = (PUtil.get)(20000533)
        -- DECOMPILER ERROR at PC168: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((BossRewardInfo.President).NameTxt).text = (PUtil.get)(20000534)
        -- DECOMPILER ERROR at PC175: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((BossRewardInfo.Member).NameTxt).text = (PUtil.get)(20000535)
        local guildInfo = (GuildBossMgr.GuildInfo)()
        -- DECOMPILER ERROR at PC181: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (BossRewardInfo.NameTxt).text = guildInfo.name
        ;
        ((BossRewardInfo.root):GetChild("LevelTxt")).text = "Lv." .. guildInfo.level
        -- DECOMPILER ERROR at PC195: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((BossRewardInfo.GuildHead).GuildLoader).url = (GuildBossRankWindow.GetGuildIcon)(guildInfo.icon)
        -- DECOMPILER ERROR at PC199: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((BossRewardInfo.President).WordTxt).text = guildInfo.leader
        local max = (((TableData.gTable).BaseGuildLevelUpData)[GuildLevelConfig[guildInfo.level]]).max_member
        -- DECOMPILER ERROR at PC214: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((BossRewardInfo.Member).WordTxt).text = "[color=#ffac26]" .. guildInfo.memberCount .. "[/color]/" .. max
        -- DECOMPILER ERROR at PC220: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((BossRewardInfo.IntegralNumber).WordTxt).text = (GuildBossMgr.GuildRankScore)()
      end
    end
  end
end

GuildBossRankWindow.OnShown = function(...)
  -- function num : 0_6
end

GuildBossRankWindow.OnHide = function(...)
  -- function num : 0_7
end

GuildBossRankWindow.SetSelectIndex = function(...)
  -- function num : 0_8 , upvalues : isPersonType, uis
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  if isPersonType then
    ((uis.GuildBossRankChoice).c1Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.GuildBossRankChoice).c1Ctr).selectedIndex = 1
  end
end

GuildBossRankWindow.GetGuildIcon = function(icon, ...)
  -- function num : 0_9 , upvalues : _ENV
  if icon == 0 then
    icon = (((TableData.gTable).BaseFixedData)[GuildData.DEFAULT_BADGE_ID]).int_value
  end
  return (Util.GetItemUrl)((((TableData.gTable).BaseGuildBadgeData)[icon]).icon)
end

GuildBossRankWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildBossRankWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_11 , upvalues : _ENV, GuildBossRankWindow
  if msgId == (WindowMsgEnum.GuildBoss).E_MSG_GUILD_RANK_REFRESH then
    (GuildBossRankWindow.SetLeftInfo)()
    ;
    (GuildBossRankWindow.RefreshList)()
  end
end

return GuildBossRankWindow

