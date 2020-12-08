-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_BossPreviewWindowByName")
local GuildBossDetailWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local isSimulation = false
local tipsObj = nil
local currentID = 0
GuildBossDetailWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, isSimulation, currentID, uis, GuildBossDetailWindow
  bridgeObj:SetView((WinResConfig.GuildBossDetailWindow).package, (WinResConfig.GuildBossDetailWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  isSimulation = argTable[1]
  currentID = (GuildBossMgr.GuildDetailStageID)()
  uis = GetGuildBoss_BossPreviewWindowUis(contentPane)
  uis = uis.BossPreview
  ;
  (GuildBossDetailWindow.SetInvariable)()
end

GuildBossDetailWindow.SetInvariable = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, isSimulation, currentID, GuildBossDetailWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TitleTxt).text = (PUtil.get)(20000481)
  local info = (GuildBossMgr.GuildBossInfo)()
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ReportBtn).visible = not isSimulation and info.status ~= (ProtoEnum.GUILD_WAR_STATUS).READY
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ReportBtn).text = (PUtil.get)(20000482)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SimulateBtn).text = (PUtil.get)(20000483)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000484)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.RewardTxt).text = (PUtil.get)(20000001)
  ;
  ((uis.ReportBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    local stageID = ((GuildBossMgr.GuildBossCurStage)()).id
    local round = (GuildBossMgr.GetCurrentRound)(true)
    ;
    (GuildBossService.ReqHurtReport)(stageID, round)
  end
)
  ;
  ((uis.SimulateBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV, currentID
    local info = (GuildBossMgr.GuildBossInfo)()
    if info.status == (ProtoEnum.GUILD_WAR_STATUS).SETTLE then
      (MessageMgr.SendCenterTipsByWordID)(20000548)
      return 
    end
    ;
    (GuildBossService.ReqInGuildStage)(currentID, true)
  end
)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : isSimulation, _ENV, currentID
    if isSimulation then
      (MessageMgr.SendCenterTipsByWordID)(20000472)
      return 
    end
    local info = (GuildBossMgr.GuildBossInfo)()
    if info.status ~= (ProtoEnum.GUILD_WAR_STATUS).CHALLENGE then
      (MessageMgr.SendCenterTipsByWordID)(20000548)
      return 
    end
    if (GuildBossMgr.GuildRemCount)() > 0 then
      (GuildBossService.ReqInGuildStage)(currentID, false)
    else
      ;
      (MessageMgr.SendCenterTipsByWordID)(60000025)
    end
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_3 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossDetailWindow).name)
  end
)
  local tipBtn = (uis.root):GetChild("n32")
  local StageData = ((TableData.gTable).BaseGuildWarStageData)[currentID]
  local remark = StageData.monster_remark
  tipBtn.visible = remark ~= nil
  ;
  (tipBtn.onClick):Set(function(...)
    -- function num : 0_1_4 , upvalues : tipBtn, _ENV, uis, GuildBossDetailWindow, StageData
    local pos = tipBtn:TransformPoint(Vector2(0, 0), uis.root)
    ;
    (GuildBossDetailWindow.OnClickShowTips)(pos, StageData.monster_remark)
  end
)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

GuildBossDetailWindow.OnClickShowTips = function(pos, content, ...)
  -- function num : 0_2 , upvalues : tipsObj, _ENV, uis
  if tipsObj == nil then
    tipsObj = UIMgr:CreateObject("GuildBoss", "InfoTips")
    ;
    (uis.root):AddChild(tipsObj)
  else
    tipsObj.visible = true
  end
  ;
  (GRoot.inst):AddCustomPopups(tipsObj, function(...)
    -- function num : 0_2_0 , upvalues : tipsObj
    tipsObj.visible = false
  end
)
  ;
  (tipsObj:GetChild("ItemWordTxt")).text = content
  tipsObj.xy = pos + Vector2(100, -tipsObj.height / 2)
end

GuildBossDetailWindow.OnShown = function(...)
  -- function num : 0_3 , upvalues : currentID, _ENV, uis
  local stageID = currentID
  local StageData = ((TableData.gTable).BaseGuildWarStageData)[stageID]
  ;
  (Util.CreateMiniModel)(uis.BossLoader, StageData.monster_show, function(model, ...)
    -- function num : 0_3_0 , upvalues : _ENV
    (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle", true)
  end
)
  if stageID == ((GuildBossMgr.GuildBossCurStage)()).id then
    local hp = (GuildBossMgr.GuildBossHP)()
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.BossHpProgressBar).value = hp
    local stageInfo = (GuildBossMgr.GuildBossCurStage)()
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.HpNumberTxt).text = (PUtil.get)(20000561, stageInfo.bossHp, hp)
  else
    do
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.BossHpProgressBar).value = 100
      do
        local maxHp = (GuildBossMgr.GetStageBossMaxHP)(stageID)
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.HpNumberTxt).text = (PUtil.get)(20000561, maxHp, 100)
        local round = (GuildBossMgr.GetCurrentRound)(true)
        -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.NumberTxt).text = (PUtil.get)(20000627, StageData.name, round)
        local info = (GuildBossMgr.GuildBossInfo)()
        if info.status == (ProtoEnum.GUILD_WAR_STATUS).CHALLENGE then
          local countDown = (math.max)(0, (math.floor)((info.endTime - (ActorData.GetServerTime)()) * 0.001))
          local mT = (LuaTime.GetTimeStrVersion2)(countDown, true)
          -- DECOMPILER ERROR at PC93: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (uis.EndTimeTxt).text = (PUtil.get)(20000485, mT)
        else
          do
            -- DECOMPILER ERROR at PC110: Confused about usage of register: R4 in 'UnsetPending'

            if info.status == (ProtoEnum.GUILD_WAR_STATUS).SETTLE then
              (uis.EndTimeTxt).text = (PUtil.get)(20000485, (PUtil.get)(20000221))
            end
            -- DECOMPILER ERROR at PC119: Confused about usage of register: R4 in 'UnsetPending'

            ;
            (uis.SurplusTxt).text = (PUtil.get)(20000486, (GuildBossMgr.GuildRemCount)())
            local rewardList = split(StageData.reward, ",")
            for _,v in ipairs(rewardList) do
              (Util.SetFrameByConfig)(v, uis.RewardList)
            end
            local info = (GuildBossMgr.GuildBossInfo)()
            ;
            ((uis.root):GetChild("EndTime")).visible = info.status ~= (ProtoEnum.GUILD_WAR_STATUS).READY
            ;
            ((uis.root):GetChild("Surplus")).visible = info.status ~= (ProtoEnum.GUILD_WAR_STATUS).READY
            -- DECOMPILER ERROR: 2 unprocessed JMP targets
          end
        end
      end
    end
  end
end

GuildBossDetailWindow.OnHide = function(...)
  -- function num : 0_4
end

GuildBossDetailWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable, tipsObj, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  if tipsObj then
    tipsObj:Dispose()
    tipsObj = nil
    ;
    (GRoot.inst):ClearCustomPopups()
  end
end

GuildBossDetailWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

return GuildBossDetailWindow

