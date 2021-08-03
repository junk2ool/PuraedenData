-- params : ...
-- function num : 0 , upvalues : _ENV
TowerMgr = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.TryOpenTowerUI = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (TowerService.ReqTowerData)(true)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.RecvTowerData = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  TowerData.FormationInfo = msg.cardInfo
  ;
  (TowerData.InitTowerData)(msg.tower)
  loge("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~RecvTowerData:" .. tostring(msg.triggerEncounter))
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  TowerData.HaveBounsLevel = msg.encounter
  if MessageMgr.StartBattleMatching == true then
    return 
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  TowerData.ExpandOpen = msg.firstOpen
  ;
  (TowerMgr.OpenTowerUI)()
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.OpenTowerUI = function(...)
  -- function num : 0_2 , upvalues : _ENV
  (GuideMgr.InGuideOpenWindow)((WinResConfig.TowerWindow).name)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.OpenBounsLevel = function(...)
  -- function num : 0_3 , upvalues : _ENV
  if TowerData.BounsLevelData == nil then
    (TowerService.ReqEncounterBattleEmba)()
  else
    OpenWindow((WinResConfig.TowerBounsLevelWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.CheckTowerAvailable = function(layerId, stageId, ...)
  -- function num : 0_4 , upvalues : _ENV
  if (TowerData.BaseInfo)[layerId] == nil then
    (TowerMgr.CheckTowerLayerLockReasonById)(layerId)
    return false
  end
  if (TowerData.UnlockStage)[layerId] < ((TowerData.TowerStageNumber)[layerId])[stageId] then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000091))
    return false
  end
  return true
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.CheckTowerLayerLockReason = function(layer, ...)
  -- function num : 0_5 , upvalues : _ENV
  (TowerMgr.CheckTowerLayerLockReasonById)((TowerData.TowerLayerData)[layer])
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.CheckTowerLayerLockReasonById = function(layerId, ...)
  -- function num : 0_6 , upvalues : _ENV
  local config = ((TableData.gTable).BaseTowerData)[layerId]
  local conditions = (split(config.open_condition, ","))
  -- DECOMPILER ERROR at PC8: Overwrote pending register: R3 in 'AssignReg'

  local condition = .end
  local count = #conditions
  for i = 1, count do
    condition = split(conditions[i], ":")
    if tonumber(condition[1]) == ConditionType.PLAYER_LEVEL then
      if tonumber(condition[3]) <= (ActorData.GetLevel)() then
        (MessageMgr.SendCenterTips)((PUtil.get)(60000091))
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(60000090, tonumber(condition[3])))
      end
    end
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.HaveNextLayer = function(...)
  -- function num : 0_7 , upvalues : _ENV
  local layerNumber = (TowerData.TowerLayerNumber)[TowerData.CurrentLayer] + 1
  if TowerData.UnlockLayer < layerNumber then
    (TowerMgr.CheckTowerLayerLockReason)(layerNumber)
    return false
  else
    return true
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.TryEnterTower = function(layerId, stageId, smash, skipSetFormation, rewards, ...)
  -- function num : 0_8 , upvalues : _ENV
  local isExpand = TowerData.IsExpand
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R6 in 'UnsetPending'

  if (((TableData.gTable).BaseTowerData)[layerId]).type == 2 then
    TowerData.IsExpand = true
    if (TowerTopStageMgr.CheckExpandAvailable)(layerId, stageId) == false then
      return 
    end
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

    TowerData.IsExpand = false
    if (TowerMgr.CheckTowerAvailable)(layerId, stageId) == false then
      return 
    end
  end
  ;
  (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Tower, function(...)
    -- function num : 0_8_0 , upvalues : smash, _ENV, stageId, skipSetFormation, isExpand
    if smash then
      if not (Util.CheckCostResources)((((TableData.gTable).BaseTowerStageData)[stageId]).sweep_cost) then
        return 
      end
      ;
      (TowerMgr.ReqEnterTower)(stageId, TowerData.FormationInfo, smash)
    else
      local config = ((TableData.gTable).BaseTowerStageData)[stageId]
      if not (Util.CheckCostResources)(config.cost) then
        return 
      end
      if skipSetFormation then
        (TowerMgr.ReqEnterTower)(stageId, TowerData.FormationInfo, smash)
      else
        local formationData = {}
        local btnData = {}
        btnData.btnTxt = (PUtil.get)(20000021)
        btnData.fun = function(formation, ...)
      -- function num : 0_8_0_0 , upvalues : _ENV, stageId
      (TowerMgr.ReqEnterTower)(stageId, (Util.CovertLoaclFormationToRemote)(formation), false)
    end

        local monsterGroups = split(config.monster_group_list, ":")
        formationData.enemyList = (Util.CovertMonsterFormationToLocal)(tonumber(monsterGroups[#monsterGroups]))
        formationData.BtnData = btnData
        if isExpand == true then
          formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).TOWER_EXPAND
          formationData.formationType = FormationType.TowerExpand
          formationData.DetailBtn = nil
          formationData.myselfList = (Util.CovertRemoteFormationToLocal)(TowerTopStageData.FormationInfo)
          formationData.closeFun = function(formation, ...)
      -- function num : 0_8_0_1 , upvalues : _ENV
      (TowerTopStageMgr.BeforeCloseFormation)(formation, function(...)
        -- function num : 0_8_0_1_0 , upvalues : _ENV
        UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
      end
)
    end

          formationData.backFun = function(formation, ...)
      -- function num : 0_8_0_2 , upvalues : _ENV
      (TowerTopStageMgr.BeforeCloseFormation)(formation, function(...)
        -- function num : 0_8_0_2_0 , upvalues : _ENV
        UIMgr:CloseWindow((WinResConfig.FormationWindow).name)
      end
)
    end

        else
          formationData.formationType = FormationType.Tower
          formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).TOWER
          formationData.DetailBtn = TowerMgr.OpenTowerMonsterDetailWindow
          formationData.myselfList = (Util.CovertRemoteFormationToLocal)(TowerData.FormationInfo)
          formationData.closeFun = function(formation, ...)
      -- function num : 0_8_0_3 , upvalues : _ENV
      (TowerMgr.BeforeCloseFormation)(formation, function(...)
        -- function num : 0_8_0_3_0 , upvalues : _ENV
        UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
      end
)
    end

          formationData.backFun = function(formation, ...)
      -- function num : 0_8_0_4 , upvalues : _ENV
      (TowerMgr.BeforeCloseFormation)(formation, function(...)
        -- function num : 0_8_0_4_0 , upvalues : _ENV
        UIMgr:CloseWindow((WinResConfig.FormationWindow).name)
      end
)
    end

        end
        formationData.stageId = stageId
        formationData.ExternalData = {}
        -- DECOMPILER ERROR at PC123: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (formationData.ExternalData).buff = (((TableData.gTable).BaseBuffPreBattleData)[tonumber(config.buff_id)]).id
        formationData.isSelfClose = true
        ;
        (MessageMgr.OpenFormationWindow)(formationData)
      end
    end
  end
, rewards)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.ReqEnterTower = function(stageId, formation, smash, ...)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if TowerData.IsExpand == false then
    TowerData.LastReqStageId = stageId
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    TowerData.CurrentLucky = (CardData.GetFormationLucky)(formation)
  else
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    TowerTopStageData.LastReqStageId = stageId
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

    TowerTopStageData.CurrentLucky = (CardData.GetFormationLucky)(formation)
  end
  ;
  (TowerService.ReqEnterTower)(stageId, formation, smash)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.BeforeCloseFormation = function(formation, cb, ...)
  -- function num : 0_10 , upvalues : _ENV
  (Util.BeforeCloseFormation)(formation, cb, function(...)
    -- function num : 0_10_0 , upvalues : _ENV
    return (Util.CovertRemoteFormationToLocal)(TowerData.FormationInfo), 60000062
  end
, function(newFormation, ...)
    -- function num : 0_10_1 , upvalues : _ENV
    (TowerService.ReqTowerCardGroups)(newFormation)
  end
)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.BeforCloseBounsFormation = function(formation, cb, ...)
  -- function num : 0_11 , upvalues : _ENV
  (Util.BeforeCloseFormation)(formation, cb, function(...)
    -- function num : 0_11_0 , upvalues : _ENV
    return (Util.CovertRemoteFormationToLocal)((TowerData.BounsLevelData).myCards), 60000062
  end
, function(newFormation, ...)
    -- function num : 0_11_1 , upvalues : _ENV
    (TowerService.ReqBounsCardGroups)(newFormation)
  end
)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.HandleReward = function(data, stageId, type, ...)
  -- function num : 0_12 , upvalues : _ENV
  local basicReward, extraReward, firstReward = (TowerData.GetActualReward)(data)
  local m = {}
  if type == 1 then
    m.BattleType = (ProtoEnum.E_BATTLE_TYPE).TOWER
  else
    m.BattleType = (ProtoEnum.E_BATTLE_TYPE).TOWER_EXPAND
  end
  local StageData = ((TableData.gTable).BaseTowerStageData)[stageId]
  m.CardAddIntimacy = StageData.card_intimacy
  if TowerData.IsExpand == false then
    m.LuckNum = TowerData.CurrentLucky
    m.cardInfo = TowerData.FormationInfo
  else
    m.LuckNum = TowerTopStageData.CurrentLucky
    m.cardInfo = TowerTopStageData.FormationInfo
  end
  m.FirstGoods = (Util.GoodsToItemDataModel)(firstReward)
  m.BasicGoods = (Util.GoodsToItemDataModel)(basicReward)
  m.LuckGoods = (Util.GoodsToItemDataModel)(extraReward)
  local btn2 = {}
  btn2.btnTxt = (PUtil.get)(20000024)
  btn2.fun = function(...)
    -- function num : 0_12_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.TowerBounsLevelWindow).name, true, true)
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_12_0_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.BattleWinConvergeWindow).name)
    end
  end

  m.btn2 = btn2
  ;
  (CommonWinMgr.OpenBattleSettleConvergeWindow)(m)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.OpenTowerMonsterDetailWindow = function(...)
  -- function num : 0_13 , upvalues : _ENV
  local defaultStage = ((TowerData.TowerStageData)[TowerData.CurrentLayer])[(TowerData.UnlockStage)[TowerData.CurrentLayer]]
  local setStageItem = function(index, item, ...)
    -- function num : 0_13_0 , upvalues : _ENV
    local config = ((TableData.gTable).BaseTowerStageData)[((TowerData.TowerStageData)[TowerData.CurrentLayer])[index]]
    local layerCutGrp = item:GetChild("LayerCutGrp")
    local name = (config.name):match("(.-) ")
    ;
    (item:GetChild("NameTxt")).text = name
    ;
    (item:GetChild("NumberTxt")).text = (config.name):gsub(name .. " ", "")
    return config.id
  end

  local stageLockChecker = function(index, ...)
    -- function num : 0_13_1 , upvalues : _ENV
    do return index <= (TowerData.UnlockStage)[TowerData.CurrentLayer] end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  local getStageTip = function(stageId, ...)
    -- function num : 0_13_2 , upvalues : _ENV
    return (((TableData.gTable).BaseTowerStageData)[stageId]).remark
  end

  local getMonsterGroups = function(stageId, ...)
    -- function num : 0_13_3 , upvalues : _ENV
    return (((TableData.gTable).BaseTowerStageData)[stageId]).monster_group_list
  end

  local lockAction = function(index, ...)
    -- function num : 0_13_4 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(60000451))
  end

  ;
  (MessageMgr.OpenMonsterDetailWindow)(defaultStage, TowerData.FormationInfo, TowerData.EACH_LAYER_STAGES, setStageItem, stageLockChecker, getStageTip, getMonsterGroups, lockAction)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

TowerMgr.JudgeExpandOpen = function(...)
  -- function num : 0_14 , upvalues : _ENV
  if TowerData.ExpandOpen ~= 0 and TowerData.ExpandOpen ~= 1 then
    if (TowerData.TowerLayerNumber)[51310000] == nil then
      (table.insert)(TowerData.TowerLayerData, 51310000)
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (TowerData.TowerLayerNumber)[51310000] = #TowerData.TowerLayerData
    end
    ;
    (TowerService.ReqTowerExpandAcitvityInfo)()
  end
end


