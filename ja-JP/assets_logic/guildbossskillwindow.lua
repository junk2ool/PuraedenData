-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_GuildSkillByName")
local GuildBossSkillWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local INIT_COLOR = GuildBossSkillType.Type4
local SKILL_COLOR = {[GuildBossSkillType.Green] = "Green", [GuildBossSkillType.Red] = "Red", [GuildBossSkillType.Yellow] = "Yellow", [GuildBossSkillType.Blue] = "Blue"}
local _skillGraphic = {}
local _skillGraphicMap = {}
local _chosedSkill, _choesdIcon = nil, nil
GuildBossSkillWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildBossSkillWindow
  bridgeObj:SetView((WinResConfig.GuildBossSkillWindow).package, (WinResConfig.GuildBossSkillWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuildBoss_GuildSkillUis(contentPane)
  ;
  (GuildBossSkillWindow.InitTopMenu)()
  ;
  (GuildBossSkillWindow.InitVariable)()
  ;
  (GuildBossSkillWindow.InitText)()
  ;
  (GuildBossSkillWindow.InitButtonEvent)()
end

GuildBossSkillWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildBossSkillWindow).name
  m.Tip = (PUtil.get)(60000509)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.GUILD_WAR_TALENT}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildBossSkillWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : _ENV, SKILL_COLOR, _skillGraphic, uis
  local icon, line, info, index = nil, nil, nil, nil
  for k,v in pairs(SKILL_COLOR) do
    _skillGraphic[k] = {}
    index = 1
    repeat
      line = (uis.SkillTree)[v .. "Line_" .. index]
      icon = (uis.SkillTree)[v .. "Skill_" .. index]
      info = {Icon = icon, Line = line}
      if (_G.next)(info) ~= nil then
        index = index + 1
        ;
        (table.insert)(_skillGraphic[k], info)
      end
    until false
  end
end

GuildBossSkillWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.SkillUp).TipsTxt).text = (PUtil.get)(60000508)
end

GuildBossSkillWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, GuildBossSkillWindow
  (((uis.SkillNumber).ResetBtn).onClick):Set(GuildBossSkillWindow.ClickResetBtn)
end

GuildBossSkillWindow.OnShown = function(...)
  -- function num : 0_5 , upvalues : GuildBossSkillWindow
  (GuildBossSkillWindow.Init)()
end

GuildBossSkillWindow.OnHide = function(...)
  -- function num : 0_6
end

GuildBossSkillWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : _ENV, _skillGraphic, _skillGraphicMap, _choesdIcon, uis, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildBossSkillWindow).name)
  _skillGraphic = {}
  _skillGraphicMap = {}
  _choesdIcon = nil
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildBossSkillWindow.Init = function(...)
  -- function num : 0_8 , upvalues : GuildBossSkillWindow
  (GuildBossSkillWindow.InitSkillIcon)()
  ;
  (GuildBossSkillWindow.RefreshInvestInfo)()
end

GuildBossSkillWindow.InitSkillIcon = function(...)
  -- function num : 0_9 , upvalues : _skillGraphicMap, _ENV, _skillGraphic, GuildBossSkillWindow
  local index, config, skillId, minIndex, minId, minIcon, maxIndex, maxId, maxIcon = nil, nil, nil, nil, nil, nil, nil, nil, nil
  minIndex = 99999
  maxIndex = 0
  _skillGraphicMap = {}
  for k,v in pairs((GuildBossData.SkillStartId)[GuildBossData.CycleType]) do
    index = 1
    skillId = v
    repeat
      skillId = tonumber(skillId)
      local skillGraphic = (_skillGraphic[k])[index]
      do
        _skillGraphicMap[skillId] = skillGraphic
        config = ((TableData.gTable).BaseGuildWarTalentData)[skillId]
        if config.index < minIndex then
          minIndex = config.index
          minId = skillId
          minIcon = skillGraphic.Icon
        end
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R15 in 'UnsetPending'

        ;
        ((skillGraphic.Icon).IconLoader).url = (Util.GetItemUrl)(config.icon)
        if (GuildBossData.ActiveSkillInfo)[config.id] and maxIndex < config.index then
          maxIndex = config.index
          maxId = skillId
          maxIcon = skillGraphic.Icon
        end
        ;
        (GuildBossSkillWindow.InitSingleSkill)(skillId, skillGraphic)
        local id = skillId
        ;
        (((skillGraphic.Icon).root).onClick):Set(function(...)
    -- function num : 0_9_0 , upvalues : GuildBossSkillWindow, id, skillGraphic
    (GuildBossSkillWindow.ChoseSkill)(id, skillGraphic.Icon)
  end
)
        index = index + 1
        if (string.find)(config.next, ":") ~= nil then
          local nextIds = split(config.next, ":")
          local count = #nextIds
          local nextConfig = nil
          for i = 1, count do
            nextConfig = ((TableData.gTable).BaseGuildWarTalentData)[tonumber(nextIds[i])]
            if nextConfig.type == config.type then
              skillId = nextConfig.id
              break
            end
          end
        else
          do
            skillId = config.next
          end
        end
      end
    until (Util.CheckNullString)(skillId)
    -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out TFORLOOP_STMT

    -- DECOMPILER ERROR at PC103: LeaveBlock: cannot find end of DO_STMT , stop at TFORLOOP_STMT

  end
  if maxIndex == 0 then
    (GuildBossSkillWindow.ChoseSkill)(minId, minIcon)
  else
    ;
    (GuildBossSkillWindow.ChoseSkill)(maxId, maxIcon)
  end
end

GuildBossSkillWindow.InitSingleSkill = function(skillId, skillGraphic, ...)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if (GuildBossData.ActiveSkillInfo)[skillId] then
    ((skillGraphic.Icon).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    if skillGraphic.Line ~= nil then
      ((skillGraphic.Line).c1Ctr).selectedIndex = 1
    end
  else
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((skillGraphic.Icon).c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

    if skillGraphic.Line ~= nil then
      if (GuildBossData.CheckUnlockAvailable)(skillId) then
        ((skillGraphic.Line).c1Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((skillGraphic.Line).c1Ctr).selectedIndex = 0
      end
    end
  end
end

GuildBossSkillWindow.InitPotentialSkill = function(id, ...)
  -- function num : 0_11 , upvalues : _ENV, _skillGraphicMap, GuildBossSkillWindow
  local config = ((TableData.gTable).BaseGuildWarTalentData)[id]
  local ids = split(config.next, ":")
  for k,v in pairs(ids) do
    v = tonumber(v)
    if _skillGraphicMap[v] then
      (GuildBossSkillWindow.InitSingleSkill)(v, _skillGraphicMap[v])
    end
  end
end

GuildBossSkillWindow.ChoseSkill = function(skillId, icon, ...)
  -- function num : 0_12 , upvalues : _chosedSkill, _ENV, _choesdIcon, GuildBossSkillWindow
  _chosedSkill = skillId
  loge("Choes:" .. _chosedSkill)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if _choesdIcon ~= nil then
    (_choesdIcon.c2Ctr).selectedIndex = 0
  end
  _choesdIcon = icon
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_choesdIcon.c2Ctr).selectedIndex = 1
  ;
  (GuildBossSkillWindow.InitSkillBasicInfo)(skillId)
  ;
  (GuildBossSkillWindow.InitSkillAdvenceInfo)()
end

GuildBossSkillWindow.InitSkillBasicInfo = function(...)
  -- function num : 0_13 , upvalues : _ENV, _chosedSkill, uis
  local config = ((TableData.gTable).BaseGuildWarTalentData)[_chosedSkill]
  if config == nil then
    return 
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.SkillUp).SkilI).IconLoader).url = (Util.GetItemUrl)(config.icon)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.SkillUp).NameTxt).text = config.name
end

GuildBossSkillWindow.InitSkillAdvenceInfo = function(...)
  -- function num : 0_14 , upvalues : _ENV, _chosedSkill, uis
  local config = ((TableData.gTable).BaseGuildWarTalentData)[_chosedSkill]
  if config == nil then
    return 
  end
  local lvConfigId = nil
  local level = (GuildBossData.ActiveSkillInfo)[_chosedSkill]
  ;
  (((uis.SkillUp).SureBtn).onClick):Clear()
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  if level then
    ((uis.SkillUp).LvTxt).text = (PUtil.get)(60000507) .. " " .. level .. "/" .. config.max_level
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((uis.SkillUp).SkilI).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

    if config.max_level <= level then
      (((uis.SkillUp).SkillWordA).LevelTxt).text = (PUtil.get)(60000512)
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((uis.SkillUp).c1Ctr).selectedIndex = 3
      lvConfigId = ((GuildBossData.SkillLevelData)[config.grow_type])[level]
    else
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (((uis.SkillUp).SkillWordB).LevelTxt).text = (PUtil.get)(60000510)
      local nextConfigId = ((GuildBossData.SkillLevelData)[config.grow_type])[level + 1]
      do
        local nextConfig = ((TableData.gTable).BaseGuildWarTalentUpData)[nextConfigId]
        -- DECOMPILER ERROR at PC78: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (((uis.SkillUp).SkillWordB).WordTxt).text = nextConfig.remark
        -- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (((uis.SkillUp).SkillWordA).LevelTxt).text = (PUtil.get)(60000512)
        -- DECOMPILER ERROR at PC89: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((uis.SkillUp).c1Ctr).selectedIndex = 2
        lvConfigId = ((GuildBossData.SkillLevelData)[config.grow_type])[level]
        local cost = nextConfig.cost
        ;
        (Util.SetCurrencyWithConfig)(cost, ((uis.SkillUp).Spend).IconLoader, ((uis.SkillUp).Spend).NumberTxt)
        -- DECOMPILER ERROR at PC112: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((uis.SkillUp).SureBtn).text = (PUtil.get)(196)
        ;
        (((uis.SkillUp).SureBtn).onClick):Set(function(...)
    -- function num : 0_14_0 , upvalues : _ENV, _chosedSkill, cost
    (GuildBossMgr.TryUpgradeTalent)(_chosedSkill, cost)
  end
)
      end
    end
  else
    do
      -- DECOMPILER ERROR at PC127: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((uis.SkillUp).LvTxt).text = (PUtil.get)(60000085)
      lvConfigId = ((GuildBossData.SkillLevelData)[config.grow_type])[1]
      -- DECOMPILER ERROR at PC141: Confused about usage of register: R3 in 'UnsetPending'

      if (GuildBossData.CheckUnlockAvailable)(_chosedSkill) then
        ((uis.SkillUp).c1Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC145: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((uis.SkillUp).c1Ctr).selectedIndex = 0
      end
      -- DECOMPILER ERROR at PC153: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (((uis.SkillUp).SkillWordA).LevelTxt).text = (PUtil.get)(60000510)
      local condition = (GuildBossData.GetUnlockCondition)(_chosedSkill)
      -- DECOMPILER ERROR at PC161: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (((uis.SkillUp).SkillWordB).WordTxt).text = condition
      -- DECOMPILER ERROR at PC171: Confused about usage of register: R4 in 'UnsetPending'

      if (Util.StringIsNullOrEmpty)(condition) then
        (((uis.SkillUp).SkillWordB).LevelTxt).text = ""
      else
        -- DECOMPILER ERROR at PC180: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (((uis.SkillUp).SkillWordB).LevelTxt).text = (PUtil.get)(60000511)
      end
      -- DECOMPILER ERROR at PC184: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (((uis.SkillUp).SkilI).c1Ctr).selectedIndex = 0
      do
        local cost = (((TableData.gTable).BaseGuildWarTalentUpData)[lvConfigId]).cost
        ;
        (Util.SetCurrencyWithConfig)(cost, ((uis.SkillUp).Spend).IconLoader, ((uis.SkillUp).Spend).NumberTxt)
        -- DECOMPILER ERROR at PC206: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((uis.SkillUp).SureBtn).text = (PUtil.get)(20000328)
        ;
        (((uis.SkillUp).SureBtn).onClick):Set(function(...)
    -- function num : 0_14_1 , upvalues : _ENV, _chosedSkill, cost
    (GuildBossMgr.TryUpgradeTalent)(_chosedSkill, cost)
  end
)
        -- DECOMPILER ERROR at PC222: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (((uis.SkillUp).SkillWordA).WordTxt).text = (((TableData.gTable).BaseGuildWarTalentUpData)[lvConfigId]).remark
      end
    end
  end
end

GuildBossSkillWindow.ClickResetBtn = function(...)
  -- function num : 0_15
end

GuildBossSkillWindow.RefreshInvestInfo = function(...)
  -- function num : 0_16 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.SkillNumber).ResetBtn).visible = GuildBossData.TotalInvestPoint ~= 0
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.SkillNumber).WordTxt).text = (PUtil.get)(60000526, "[color=" .. Const.YellowColor .. "]" .. GuildBossData.TotalInvestPoint .. "[/color]")
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GuildBossSkillWindow.ClickResetBtn = function(...)
  -- function num : 0_17 , upvalues : _ENV
  (GuildBossService.ReqTalentReset)()
end

GuildBossSkillWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_18 , upvalues : _ENV, GuildBossSkillWindow, _skillGraphicMap
  if msgId == (WindowMsgEnum.GuildBoss).E_MSG_REFRESH_TALENT then
    (GuildBossSkillWindow.Init)()
  else
    if msgId == (WindowMsgEnum.GuildBoss).E_MSG_REFRESH_SINGLE_TALENT then
      (GuildBossSkillWindow.RefreshInvestInfo)()
      ;
      (GuildBossSkillWindow.InitSingleSkill)(para, _skillGraphicMap[para])
      ;
      (GuildBossSkillWindow.InitPotentialSkill)(para)
      ;
      (GuildBossSkillWindow.InitSkillAdvenceInfo)()
    end
  end
end

return GuildBossSkillWindow

