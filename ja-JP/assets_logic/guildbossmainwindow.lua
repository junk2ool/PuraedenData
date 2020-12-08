-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_GuildBossMainByName")
local GuildBossMainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local GTween = FairyGUI.GTween
local runSpeed = 20
local runRange = Vector2(30, 60)
local idlePercent = 0.3
local idleTime = Vector2(1.1, 2.1)
local straightPercent = 0.6
local backPercent = 0.1
local Behaviour = {IDLE = 1, STRAIGHT = 2, BACK = 3}
local BossMovePosName = {
{"SpotA_1", "SpotA_2"}
, 
{"SpotB_1", "SpotB_3"}
, 
{"SpotC_1", "SpotC_2"}
, 
{"SpotD_1", "SpotD_2"}
, 
{"SpotE_1", "SpotE_2"}
}
local gtTable = {}
local challengeIndex = -1
local tipsObj = nil
local recordBattleData = {}
local RefreshTimer = nil
local RefreshTime = 30
local isClose = false
local waitTimerList = {}
GuildBossMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, isClose, challengeIndex, uis, GuildBossMainWindow
  bridgeObj:SetView((WinResConfig.GuildBossMainWindow).package, (WinResConfig.GuildBossMainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  isClose = false
  challengeIndex = -1
  uis = GetGuildBoss_GuildBossMainUis(contentPane)
  ;
  (GuildBossMainWindow.InitAssetStrip)()
  ;
  (GuildBossMainWindow.SetBossContentShow)()
  ;
  (GuildBossMainWindow.SetLeftTopInformation)()
  ;
  (GuildBossMainWindow.InitBtnEvent)()
  ;
  (GuildBossMainWindow.SetActivityInfo)()
  ;
  (GuildBossMainWindow.InitBattleRecordList)()
  ;
  (GuildBossMainWindow.BindingUI)()
  ;
  (GuildBossMainWindow.RefreshBattleRecordData)()
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_GUILD_BATTLE_ATMOSPHERE, false, uis.root, Vector2((GRoot.inst).width / 2, (GRoot.inst).height / 2))
end

GuildBossMainWindow.InitBtnEvent = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  ((uis.InformationBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    local info = (GuildBossMgr.GuildBossInfo)()
    if info.status == (ProtoEnum.GUILD_WAR_STATUS).READY then
      (MessageMgr.SendCenterTipsByWordID)(20000529)
    else
      ;
      (GuildBossService.ReqGuildBossAdvisory)()
    end
  end
)
  ;
  ((uis.TalentBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    if ((GuildBossMgr.GuildBossInfo)()).status == (ProtoEnum.GUILD_WAR_STATUS).SETTLE then
      (MessageMgr.SendCenterTipsByWordID)(60000539)
    else
      ;
      (GuildBossMgr.OpenTalentUI)()
    end
  end
)
  ;
  ((uis.RewardBtn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : _ENV
    (GuildBossService.ReqSeasonReward)()
  end
)
  ;
  ((uis.HelpBtn).onClick):Set(function(...)
    -- function num : 0_1_3 , upvalues : _ENV
    (GuildBossService.ReqSupportInfo)()
  end
)
  ;
  (((uis.StateTips).BossRankBtn).onClick):Set(function(...)
    -- function num : 0_1_4 , upvalues : _ENV
    local info = (GuildBossMgr.GuildBossInfo)()
    if info.status == (ProtoEnum.GUILD_WAR_STATUS).READY then
      (GuildBossService.ReqGSeasonRank)(true, 1)
    else
      ;
      (GuildBossService.ReqGSeasonRank)(false, 1)
    end
  end
)
end

GuildBossMainWindow.GetNextBehaviour = function(...)
  -- function num : 0_2 , upvalues : idlePercent, _ENV, Behaviour, straightPercent, backPercent
  local mTable = {}
  for i = 1, idlePercent * 100 do
    (table.insert)(mTable, Behaviour.IDLE)
  end
  for i = 1, straightPercent * 100 do
    (table.insert)(mTable, Behaviour.STRAIGHT)
  end
  for i = 1, backPercent * 100 do
    (table.insert)(mTable, Behaviour.BACK)
  end
  local rangeNum = (math.random)(1, #mTable)
  return mTable[rangeNum]
end

GuildBossMainWindow.SetBossMove = function(pos1, pos2, boss, direction, index, ...)
  -- function num : 0_3 , upvalues : GuildBossMainWindow, _ENV, isClose, challengeIndex, Behaviour, idleTime, waitTimerList, runRange, GTween, runSpeed, gtTable
  local mBehaviour = (GuildBossMainWindow.GetNextBehaviour)()
  local loader = boss:GetChild("BossLoader")
  if (Util.IsNil)(loader.Model) or isClose or index < challengeIndex then
    return 
  end
  local Model = (loader.Model).gameObject
  if mBehaviour == Behaviour.IDLE then
    (SkeletonAnimationUtil.SetAnimation)(Model, 0, BattleCardState.IDLE, true)
    local waitTime = (math.random)((math.ceil)(idleTime.x * 100), (math.ceil)(idleTime.y * 100)) / 100
    do
      local timer = (SimpleTimer.setTimeout)(waitTime, function(...)
    -- function num : 0_3_0 , upvalues : GuildBossMainWindow, pos1, pos2, boss, direction, index
    (GuildBossMainWindow.SetBossMove)(pos1, pos2, boss, direction, index)
  end
)
      ;
      (table.insert)(waitTimerList, timer)
    end
  else
    do
      local nextDirection = direction
      if mBehaviour == Behaviour.BACK then
        nextDirection = not direction
      end
      ;
      (SkeletonAnimationUtil.SetFlip)(Model, not nextDirection, false)
      ;
      (SkeletonAnimationUtil.SetAnimation)(Model, 0, BattleCardState.RUN, true, nil, false, nil, 0.7)
      local rangeMin = (math.min)(pos1.x, pos2.x)
      local rangeMax = (math.max)(pos1.x, pos2.x)
      local currentPos = boss.x
      local distance = (math.random)(runRange.x, runRange.y) / 100 * (math.abs)(pos1.x - pos2.x)
      local endX = 0
      local remain = 0
      if nextDirection then
        local toPos = currentPos + distance
        if rangeMax < toPos then
          endX = rangeMax
          remain = rangeMax - toPos + rangeMax
        else
          endX = toPos
        end
      else
        do
          do
            local toPos = currentPos - distance
            if toPos < rangeMin then
              endX = rangeMin
              remain = distance - (currentPos - rangeMin) + rangeMin
            else
              endX = toPos
            end
            local startPos = currentPos
            local gt = (GTween.To)(startPos, endX, (math.abs)(startPos - endX) / runSpeed)
            gt:SetEase((FairyGUI.EaseType).Linear)
            gt:OnUpdate(function(...)
    -- function num : 0_3_1 , upvalues : isClose, index, challengeIndex, gt, GuildBossMainWindow, pos1, pos2, boss, _ENV
    if isClose or index < challengeIndex then
      return 
    end
    local mX = (gt.value).x
    local mY = (GuildBossMainWindow.SetLineFunction)(pos1, pos2, mX)
    boss.xy = Vector2(mX, mY)
  end
)
            gt:OnComplete(function(...)
    -- function num : 0_3_2 , upvalues : isClose, index, challengeIndex, remain, boss, GTween, _ENV, runSpeed, Model, GuildBossMainWindow, pos1, pos2, gtTable, nextDirection
    if isClose or index < challengeIndex then
      return 
    end
    if remain > 0 then
      local Restart = boss.x
      do
        local gt2 = (GTween.To)(Restart, remain, (math.abs)(Restart - remain) / runSpeed)
        local currentDir = Restart < remain
        ;
        (SkeletonAnimationUtil.SetFlip)(Model, not currentDir, false)
        gt2:SetEase((FairyGUI.EaseType).Linear)
        gt2:OnUpdate(function(...)
      -- function num : 0_3_2_0 , upvalues : isClose, index, challengeIndex, gt2, GuildBossMainWindow, pos1, pos2, boss, _ENV
      if isClose or index < challengeIndex then
        return 
      end
      local mX = (gt2.value).x
      local mY = (GuildBossMainWindow.SetLineFunction)(pos1, pos2, mX)
      boss.xy = Vector2(mX, mY)
    end
)
        gt2:OnComplete(function(...)
      -- function num : 0_3_2_1 , upvalues : GuildBossMainWindow, pos1, pos2, boss, currentDir, index
      (GuildBossMainWindow.SetBossMove)(pos1, pos2, boss, currentDir, index)
    end
)
        ;
        (table.insert)(gtTable, gt2)
      end
    else
      (GuildBossMainWindow.SetBossMove)(pos1, pos2, boss, nextDirection, index)
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
)
            ;
            (table.insert)(gtTable, gt)
          end
        end
      end
    end
  end
end

GuildBossMainWindow.InitBossRandomPos = function(pos1, pos2, boss, index, randomPos, ...)
  -- function num : 0_4 , upvalues : _ENV, GuildBossMainWindow
  local max = (math.max)(pos1.x, pos2.x)
  local min = (math.min)(pos1.x, pos2.x)
  local pos = (math.random)((math.ceil)(min), (math.ceil)(max))
  if randomPos then
    boss.xy = Vector2(pos, (GuildBossMainWindow.SetLineFunction)(pos1, pos2, pos))
  end
  ;
  (GuildBossMainWindow.SetBossMove)(pos1, pos2, boss, false, index)
end

GuildBossMainWindow.OnClickShowTips = function(pos, content, ...)
  -- function num : 0_5 , upvalues : tipsObj, _ENV, uis
  if tipsObj == nil then
    tipsObj = UIMgr:CreateObject("GuildBoss", "InfoTips")
    ;
    (uis.root):AddChild(tipsObj)
  else
    tipsObj.visible = true
  end
  ;
  (GRoot.inst):AddCustomPopups(tipsObj, function(...)
    -- function num : 0_5_0 , upvalues : tipsObj
    tipsObj.visible = false
  end
)
  ;
  (tipsObj:GetChild("ItemWordTxt")).text = content
  tipsObj.xy = pos - Vector2(tipsObj.width / 2, tipsObj.height)
end

GuildBossMainWindow.InitBossRun = function(randomPos, ...)
  -- function num : 0_6 , upvalues : challengeIndex, uis, BossMovePosName, GuildBossMainWindow
  for i = 1, 5 do
    if challengeIndex <= i then
      local startPos = (((uis.Map).root):GetChild((BossMovePosName[i])[1])).xy
      local endPos = (((uis.Map).root):GetChild((BossMovePosName[i])[2])).xy
      local boos = ((uis.Map).root):GetChild("Boss_" .. i)
      ;
      (GuildBossMainWindow.InitBossRandomPos)(startPos, endPos, boos, i, randomPos)
    end
  end
end

GuildBossMainWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : GuildBossMainWindow, _ENV, RefreshTimer, RefreshTime
  (GuildBossMainWindow.InitBossRun)(true)
  local info = (GuildBossMgr.GuildBossInfo)()
  local state = info.status
  if state == (ProtoEnum.GUILD_WAR_STATUS).CHALLENGE then
    RefreshTimer = (SimpleTimer.setInterval)(RefreshTime, 9999, function(...)
    -- function num : 0_7_0 , upvalues : _ENV
    (GuildBossService.ReqGuildBattleInfo)(true)
  end
)
  end
end

GuildBossMainWindow.OnHide = function(...)
  -- function num : 0_8
end

GuildBossMainWindow.SetBossContentShow = function(...)
  -- function num : 0_9 , upvalues : _ENV, challengeIndex, uis
  local round = (GuildBossMgr.GetCurrentRound)(false)
  local StageData = (TableData.gTable).BaseGuildWarStageData
  local stageList = {}
  local cycle = (GuildBossMgr.GetCurrentSeasonCycle)()
  for _,v in pairs(StageData) do
    if v.round == round and v.cycle_type == cycle then
      (table.insert)(stageList, v)
    end
  end
  ;
  (table.sort)(stageList, function(a, b, ...)
    -- function num : 0_9_0
    do return a.monster_pos < b.monster_pos end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local currentBoss = (GuildBossMgr.GuildBossCurStage)()
  do
    if currentBoss.id == 0 or (GuildBossMgr.GuildBattleAllPass)() then
      challengeIndex = 999
    else
      for i = 1, 5 do
        local data = stageList[i]
        if data.id == currentBoss.id then
          challengeIndex = i
        end
      end
    end
    do
      local info = (GuildBossMgr.GuildBossInfo)()
      for i = 1, 5 do
        local bossObj = ((uis.root):GetChild("Map")):GetChild("Boss_" .. i)
        local data = stageList[i]
        local bossLoader = bossObj:GetChild("BossLoader")
        ;
        (bossObj:GetChild("OrderTxt")).text = i
        local func = function(model, ...)
    -- function num : 0_9_1 , upvalues : i, challengeIndex, _ENV
    if i < challengeIndex then
      (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.DIE, false, nil, true)
      local time = (SkeletonAnimationUtil.GetAnimationTime)(model, BattleCardState.DIE)
      ;
      (SkeletonAnimationUtil.JumpToTime)(model, 0, time, false, true)
    end
  end

        if bossLoader.Model == nil then
          (Util.CreateMiniModel)(bossLoader, data.monster_show, function(model, ...)
    -- function num : 0_9_2 , upvalues : func
    func(model)
  end
, false, true)
        else
          func((bossLoader.Model).gameObject)
        end
        if i < challengeIndex then
          ChangeUIController(bossObj, "c1", 2)
        else
          if i == challengeIndex and info.status == (ProtoEnum.GUILD_WAR_STATUS).CHALLENGE then
            ChangeUIController(bossObj, "c1", 0)
            local hp = (GuildBossMgr.GuildBossHP)()
            ;
            (bossObj:GetChild("BossHpProgressBar")).value = hp
            ;
            (bossObj:GetChild("HpNumberTxt")).text = hp .. "%"
          else
            do
              do
                ChangeUIController(bossObj, "c1", 1)
                ;
                (bossObj.onClick):Set(function(...)
    -- function num : 0_9_3 , upvalues : info, _ENV, i, challengeIndex, data
    if info.status == (ProtoEnum.GUILD_WAR_STATUS).SETTLE then
      (MessageMgr.SendCenterTipsByWordID)(20000560)
      return 
    end
    if i < challengeIndex then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000471))
    else
      if i == challengeIndex then
        (GuildBossMgr.GuildDetailStageID)(data.id)
        OpenWindow((WinResConfig.GuildBossDetailWindow).name, UILayer.HUD1)
      else
        ;
        (GuildBossMgr.GuildDetailStageID)(data.id)
        OpenWindow((WinResConfig.GuildBossDetailWindow).name, UILayer.HUD1, true)
      end
    end
  end
)
                -- DECOMPILER ERROR at PC148: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC148: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC148: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC148: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC148: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
end

GuildBossMainWindow.SetLineFunction = function(pos1, pos2, mX, ...)
  -- function num : 0_10
  local tan = (pos2.y - pos1.y) / (pos2.x - pos1.x)
  return tan * mX + pos1.y - tan * pos1.x
end

GuildBossMainWindow.SetLeftTopInformation = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis, GuildBossMainWindow
  local info = (GuildBossMgr.GuildBossInfo)()
  local state = info.status
  local rank = info.rank
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  if state == (ProtoEnum.GUILD_WAR_STATUS).READY then
    ((uis.StateTips).c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.BattleNumber).c1Ctr).selectedIndex = 0
    local FixedData = ((TableData.gTable).BaseFixedData)[Const.GuildBossTalentMax]
    local max = tonumber(FixedData.int_value)
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((uis.BattleNumber).TalentTxt).text = (PUtil.get)(20000477, info.obtTalent, max)
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((uis.BattleNumber).root).visible = false
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((uis.StateTips).TimeTxt).text = (LuaTime.GetFormatTimeStr)("%m/%d %H:%M", info.beginTime) .. " - " .. (LuaTime.GetFormatTimeStr)("%m/%d %H:%M", info.endTime)
  else
    do
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R3 in 'UnsetPending'

      if state == (ProtoEnum.GUILD_WAR_STATUS).CHALLENGE then
        ((uis.BattleNumber).c1Ctr).selectedIndex = 1
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((uis.BattleNumber).RoundTxt).text = (PUtil.get)(20000478, (GuildBossMgr.GetCurrentRound)(true))
        local remain = (GuildBossMgr.GuildRemCount)()
        -- DECOMPILER ERROR at PC84: Confused about usage of register: R4 in 'UnsetPending'

        if remain > 0 then
          ((uis.BattleNumber).BattleNumberTxt).text = (PUtil.get)(20000479, remain)
        else
          -- DECOMPILER ERROR at PC93: Confused about usage of register: R4 in 'UnsetPending'

          ;
          ((uis.BattleNumber).BattleNumberTxt).text = (PUtil.get)(20000558, remain)
        end
        -- DECOMPILER ERROR at PC108: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((uis.StateTips).TimeTxt).text = (LuaTime.GetFormatTimeStr)("%m/%d %H:%M", info.beginTime) .. " - " .. (LuaTime.GetFormatTimeStr)("%m/%d %H:%M", info.endTime)
      else
        do
          -- DECOMPILER ERROR at PC117: Confused about usage of register: R3 in 'UnsetPending'

          if state == (ProtoEnum.GUILD_WAR_STATUS).SETTLE then
            ((uis.BattleNumber).c1Ctr).selectedIndex = 1
            -- DECOMPILER ERROR at PC128: Confused about usage of register: R3 in 'UnsetPending'

            ;
            ((uis.BattleNumber).RoundTxt).text = (PUtil.get)(20000478, (GuildBossMgr.GetCurrentRound)(true))
            -- DECOMPILER ERROR at PC135: Confused about usage of register: R3 in 'UnsetPending'

            ;
            ((uis.BattleNumber).BattleNumberTxt).text = (PUtil.get)(20000549)
            -- DECOMPILER ERROR at PC142: Confused about usage of register: R3 in 'UnsetPending'

            ;
            ((uis.StateTips).TimeTxt).text = (PUtil.get)(20000560)
          end
          do
            if state ~= (ProtoEnum.GUILD_WAR_STATUS).READY then
              local maxRank = (GuildBossMgr.GetMaxRank)()
              -- DECOMPILER ERROR at PC157: Confused about usage of register: R4 in 'UnsetPending'

              if rank and rank > 0 then
                ((uis.StateTips).c1Ctr).selectedIndex = 2
                -- DECOMPILER ERROR at PC162: Confused about usage of register: R4 in 'UnsetPending'

                if maxRank < rank then
                  ((uis.StateTips).RankNumberTxt).text = maxRank
                  -- DECOMPILER ERROR at PC165: Confused about usage of register: R4 in 'UnsetPending'

                  ;
                  ((uis.StateTips).PlusImage).visible = true
                else
                  -- DECOMPILER ERROR at PC169: Confused about usage of register: R4 in 'UnsetPending'

                  ;
                  ((uis.StateTips).RankNumberTxt).text = rank
                  -- DECOMPILER ERROR at PC172: Confused about usage of register: R4 in 'UnsetPending'

                  ;
                  ((uis.StateTips).PlusImage).visible = false
                end
              else
                -- DECOMPILER ERROR at PC176: Confused about usage of register: R4 in 'UnsetPending'

                ;
                ((uis.StateTips).c1Ctr).selectedIndex = 1
              end
            end
            ;
            (((uis.BattleNumber).TipsBtn).onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : uis, _ENV, GuildBossMainWindow
    local pos = ((uis.BattleNumber).TipsBtn):TransformPoint(Vector2(0, 0), uis.root)
    ;
    (GuildBossMainWindow.OnClickShowTips)(pos, (PUtil.get)(20000545))
  end
)
          end
        end
      end
    end
  end
end

GuildBossMainWindow.InitBattleRecordList = function(...)
  -- function num : 0_12 , upvalues : uis, GuildBossMainWindow
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.IntegralShow).PlayerIntegralList).itemRenderer = GuildBossMainWindow.RecordListRenderer
  ;
  ((uis.IntegralShow).PlayerIntegralList):SetVirtual()
end

GuildBossMainWindow.RecordListRenderer = function(index, obj, ...)
  -- function num : 0_13 , upvalues : recordBattleData, GuildBossMainWindow
  local data = recordBattleData[index + 1]
  ;
  (GuildBossMainWindow.SetSingleBattle)(obj, data)
end

GuildBossMainWindow.RefreshBattleRecordData = function(...)
  -- function num : 0_14 , upvalues : _ENV, uis, recordBattleData, GuildBossMainWindow
  local info = (GuildBossMgr.GuildBossInfo)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if info.status == (ProtoEnum.GUILD_WAR_STATUS).READY then
    ((uis.IntegralShow).root).visible = false
    return 
  end
  recordBattleData = {}
  local data = (GuildBossMgr.GuildBattleRecord)()
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  if #data <= 0 then
    ((uis.IntegralShow).root).visible = false
    return 
  else
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.IntegralShow).root).visible = true
  end
  for _,v in ipairs(data) do
    (table.insert)(recordBattleData, v)
  end
  ;
  (table.sort)(recordBattleData, function(a, b, ...)
    -- function num : 0_14_0
    do return b.settleTime < a.settleTime end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.IntegralShow).TalentTxt).text = (PUtil.get)(20000551)
  local length = #recordBattleData
  ;
  (GuildBossMainWindow.SetSingleBattle)(((uis.IntegralShow).PlayerIntegral).root, recordBattleData[1])
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.IntegralShow).PlayerIntegralList).numItems = length
end

GuildBossMainWindow.SetSingleBattle = function(obj, data, ...)
  -- function num : 0_15 , upvalues : _ENV
  if data == nil then
    obj.visible = false
    return 
  end
  obj.visible = true
  ;
  (obj:GetChild("NameTxt")).text = data.playerName
  ;
  (obj:GetChild("IntegralNumberTxt")).text = (PUtil.get)(20000550, data.integral)
  ;
  (obj:GetChild("TimeTxt")).text = (LuaTime.GetLeftTimeStr)(data.settleTime * 0.001)
  local btn = obj:GetChild("TipsBtn")
  btn.text = (PUtil.get)(20000023)
  ;
  (btn.onClick):Set(function(...)
    -- function num : 0_15_0 , upvalues : _ENV, data
    (CommonWinMgr.OpenBattleDataWindow)((data.battleData).challengeSummarizeData)
  end
)
end

GuildBossMainWindow.BindingUI = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis
  local winName = (WinResConfig.GuildBossMainWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.GuildBoss_Rwd, uis.RewardBtn)
  BindingUI(winName, RedDotComID.GuildBoss_Rup, uis.HelpBtn)
  BindingUI(winName, RedDotComID.GuildBoss_Talent, uis.TalentBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

GuildBossMainWindow.SetActivityInfo = function(...)
  -- function num : 0_17 , upvalues : _ENV, uis, GuildBossMainWindow
  local info = (GuildBossMgr.GuildBossInfo)()
  local state = info.status
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  if state == (ProtoEnum.GUILD_WAR_STATUS).READY or state == (ProtoEnum.GUILD_WAR_STATUS).SETTLE then
    ((uis.Active).root).visible = false
    return 
  end
  local FixedData = ((TableData.gTable).BaseFixedData)[Const.GuildBossActivityMax]
  local max = tonumber((split(FixedData.array_value, ":"))[3])
  local activity = (GuildBossMgr.GuildActivity)()
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.Active).NameTxt).text = (PUtil.get)(20000480, activity, max)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.Active).ActiveProgressBar).value = activity / max * 100
  ;
  (((uis.Active).TipsBtn).onClick):Set(function(...)
    -- function num : 0_17_0 , upvalues : uis, _ENV, GuildBossMainWindow
    local pos = ((uis.Active).TipsBtn):TransformPoint(Vector2(0, 0), uis.root)
    ;
    (GuildBossMainWindow.OnClickShowTips)(pos, (PUtil.get)(20000544))
  end
)
end

GuildBossMainWindow.OnClose = function(...)
  -- function num : 0_18 , upvalues : isClose, gtTable, _ENV, uis, contentPane, argTable, tipsObj, RefreshTimer, waitTimerList
  isClose = true
  gtTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildBossMainWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
  if tipsObj then
    tipsObj:Dispose()
    tipsObj = nil
    ;
    (GRoot.inst):ClearCustomPopups()
  end
  if RefreshTimer then
    RefreshTimer:_destroy()
    RefreshTimer = nil
  end
  waitTimerList = {}
end

GuildBossMainWindow.InitAssetStrip = function(...)
  -- function num : 0_19 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildBossMainWindow).name
  m.Tip = (PUtil.get)(20000457)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildBossMainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_20 , upvalues : _ENV, GuildBossMainWindow, gtTable, waitTimerList
  if msgId == (WindowMsgEnum.GuildBoss).E_MSG_GUILD_MAIN_BOSS then
    (GuildBossMainWindow.SetBossContentShow)()
    if para then
      for _,v in ipairs(gtTable) do
        v:Kill()
      end
      for _,v in ipairs(waitTimerList) do
        v:stop()
      end
      gtTable = {}
      waitTimerList = {}
      ;
      (GuildBossMainWindow.InitBossRun)(false)
    end
    ;
    (GuildBossMainWindow.SetLeftTopInformation)()
    ;
    (GuildBossMainWindow.RefreshBattleRecordData)()
  end
end

return GuildBossMainWindow

