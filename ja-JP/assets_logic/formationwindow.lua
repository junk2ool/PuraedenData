-- params : ...
-- function num : 0 , upvalues : _ENV
require("Formation_FormationWindowByName")
require("CommonResource_HeadFrameByName")
require("BattleConfig")
require("CommonResource_ExpeditionHeadByName")
GTween = FairyGUI.GTween
local FormationWindow = {}
local uis = {}
local contentPane, scrollList = nil, nil
local cardListDate = {}
local saveInitCard = {}
local myselfFightDate = {nil, nil, nil, nil, nil, nil}
local supportID = 0
local supportPlayerIndex = 0
local supportCardListDate = {}
local enemyFightDate = {nil, nil, nil, nil, nil, nil}
local selfLoaderList = {}
local enemyLoaderList = {}
local mFormationType = FormationType.Basic
local mFormationData = nil
local speedSort = {}
local DragModel = nil
local isTouching = false
local filterType = 0
local supportData = {}
local enemyIsCustom = false
local selfGrp, appaySfx, putHolder = nil, nil, nil
local sfxOffsetPos = Vector2(63, 55)
local _gestureDic = {}
local _swipeDic = {}
local alreadyCard = {}
local MaxFight = 0
local ExpeditionListData = nil
local MustFightID = 0
local bgModel, battleType, stageID = nil, nil, nil
local dragModelPos = Vector3(0, -0.6, 6)
local dragSize = 1.1
local dragOffset = Vector2(0, 0)
local DragDropManager = FairyGUI.DragDropManager
local expeditionSweep = 0
local ModelScale = 0.22
local GuildBossCantCard = {}
local TowerExpandCantCard = {}
local recordEnemyFc = nil
local grpTalkCom = {}
local relicData, expandData = nil, nil
FormationWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, GuildBossCantCard, ModelScale, FormationWindow
  bridge:SetView((WinResConfig.FormationWindow).package, (WinResConfig.FormationWindow).comName)
  contentPane = bridge.contentPane
  contentPane:Center()
  uis = GetFormation_FormationWindowUis(contentPane)
  GuildBossCantCard = {}
  if Application.platform == RuntimePlatform.Android then
    if (Util.CompareVersion)(Application.version, "1.0.6") or Game.gameVersion == "cn" then
      ModelScale = 0.22
    else
      ModelScale = 0.15
    end
  else
    if Application.platform == RuntimePlatform.IPhonePlayer then
      if (Util.CompareVersion)(Application.version, "1.0.9") or Game.gameVersion == "cn" then
        ModelScale = 0.22
      else
        ModelScale = 0.15
      end
    end
  end
  ;
  (FormationWindow.Refresh)(true)
end

FormationWindow.Refresh = function(init, ...)
  -- function num : 0_1 , upvalues : FormationWindow, _ENV, mFormationData, isTouching, filterType, supportID, supportPlayerIndex, recordEnemyFc, mFormationType, stageID, uis, battleType, enemyFightDate, enemyIsCustom, scrollList, relicData, expeditionSweep, supportData, GuildBossCantCard, cardListDate, saveInitCard, myselfFightDate, MustFightID, MaxFight, DragDropManager, appaySfx, selfGrp, sfxOffsetPos, putHolder
  (FormationWindow.CloseTalkCom)()
  if FormationPresetData and FormationPresetData.FormationData then
    mFormationData = FormationPresetData.FormationData
  else
    mFormationData = (MessageMgr.GetFormationData)()
  end
  isTouching = false
  filterType = 0
  supportID = 0
  supportPlayerIndex = 0
  recordEnemyFc = nil
  mFormationType = mFormationData.formationType
  stageID = mFormationData.stageId
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  if mFormationType == FormationType.Relic then
    (uis.c1Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

    if mFormationType == FormationType.TowerExpand then
      (uis.c1Ctr).selectedIndex = 2
    else
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = mFormationType
    end
  end
  battleType = mFormationData.battleType
  if mFormationType ~= FormationType.Single and mFormationType ~= FormationType.Edit then
    if mFormationData.enemyList then
      enemyFightDate = mFormationData.enemyList
      enemyIsCustom = false
    else
      enemyFightDate = mFormationData.otherPlayerList
      enemyIsCustom = true
    end
  end
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (GRoot.inst).IgnoreItemClick = false
  if mFormationType == FormationType.Relic then
    ld("Expedition")
    scrollList = (uis.HeadListGrp).ExpeditionList
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.HeadListGrp).c1Ctr).selectedIndex = 1
    scrollList.defaultItem = (Util.GetResUrl)("CommonResource:ExpeditionHead")
    relicData = mFormationData.RelicData
  else
    if mFormationType ~= FormationType.Expedition then
      scrollList = (uis.HeadListGrp).CardHeadList
      -- DECOMPILER ERROR at PC109: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.HeadListGrp).c1Ctr).selectedIndex = 0
    else
      scrollList = (uis.HeadListGrp).ExpeditionList
      -- DECOMPILER ERROR at PC116: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.HeadListGrp).c1Ctr).selectedIndex = 1
      scrollList.defaultItem = (Util.GetResUrl)("CommonResource:ExpeditionHead")
      expeditionSweep = (mFormationData.ExternalData).sweepDander
    end
  end
  if mFormationType == FormationType.CG then
    ((uis.root):GetChild("TipsTxt")).text = (PUtil.get)(20000379)
  else
    if mFormationType == FormationType.GuildBattle then
      supportData = (mFormationData.GuildBossExternal).SupportCardList
      GuildBossCantCard = (mFormationData.GuildBossExternal).cantUseCard
      -- DECOMPILER ERROR at PC157: Confused about usage of register: R1 in 'UnsetPending'

      if (mFormationData.GuildBossExternal).isSimulation then
        ((uis.GuildBossTips).root).visible = true
        -- DECOMPILER ERROR at PC164: Confused about usage of register: R1 in 'UnsetPending'

        ;
        ((uis.GuildBossTips).TipsTxt).text = (PUtil.get)(20000537)
      else
        -- DECOMPILER ERROR at PC168: Confused about usage of register: R1 in 'UnsetPending'

        ;
        ((uis.GuildBossTips).root).visible = false
      end
    end
  end
  scrollList.itemRenderer = FormationWindow.CardRenderer
  scrollList:SetVirtual()
  if mFormationData.PrepareList and #mFormationData.PrepareList > 0 then
    local selfData = mFormationData.PrepareList
    for i,v in pairs(selfData) do
      local data, isMonster = (CardData.GetBaseConfig)(tonumber(v))
      if isMonster then
        local oneCard = {}
        local cardData = {}
        cardData.id = tonumber(selfData[i])
        ;
        (CardData.InitCardAttr)(oneCard, cardData)
        ;
        (table.insert)(cardListDate, oneCard)
      else
        do
          do
            local oneCard = (CardData.GetCardData)(v)
            ;
            (table.insert)(cardListDate, oneCard)
            -- DECOMPILER ERROR at PC220: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC220: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC220: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  else
    do
      if mFormationType == FormationType.Edit then
        cardListDate = (CardData.GetPreEditFormationCards)()
      else
        cardListDate = (CardData.GetFormationCards)()
      end
      saveInitCard = cardListDate
      if mFormationType == FormationType.GuildBattle then
        local mList = mFormationData.myselfList
        local selfList = {}
        for i = 1, 6 do
          local card = mList[i]
          if card and not (FormationWindow.IsContainCantUseList)(card) then
            selfList[i] = card
          end
        end
        myselfFightDate = selfList
      else
        do
          if not mFormationData.myselfList then
            myselfFightDate = {}
            ;
            (FormationWindow.InitAsset)(mFormationData)
            if mFormationData.ExternalData and (mFormationData.ExternalData).mustID and tonumber((mFormationData.ExternalData).mustID) > 0 then
              MustFightID = tonumber((mFormationData.ExternalData).mustID)
              local exist = false
              for i = 1, 6 do
                if myselfFightDate[i] and myselfFightDate[i] == MustFightID then
                  exist = true
                  break
                end
              end
              do
                if not exist then
                  for i = 1, 6 do
                    if myselfFightDate[i] == nil then
                      myselfFightDate[i] = tonumber((mFormationData.ExternalData).mustID)
                      break
                    end
                  end
                end
                do
                  for i = 1, 6 do
                    local value = myselfFightDate[i]
                    if value then
                      loge("第" .. i .. "号位id为" .. value)
                    end
                  end
                  if mFormationData.ExternalData and (mFormationData.ExternalData).maxFight and (mFormationData.ExternalData).maxFight > 0 then
                    MaxFight = (mFormationData.ExternalData).maxFight
                  else
                    MaxFight = 0
                  end
                  for i = 1, 20 do
                    for j = 1, 6 do
                      if i ~= j and myselfFightDate[i] and myselfFightDate[j] and myselfFightDate[i] == myselfFightDate[j] then
                        loge("传入的数据错误，第" .. i .. "与" .. j .. "数据重复")
                        myselfFightDate[j] = nil
                      end
                    end
                    if i > 6 and myselfFightDate[i] then
                      loge("传入的数据错误，第" .. i .. "位不应该有数据。")
                      myselfFightDate[i] = nil
                    end
                  end
                  if init then
                    (scrollList.onDrop):Add(FormationWindow.scrollOnDrag)
                    ;
                    (((uis.CardOperationGrp2).root).onDrop):Add(FormationWindow.scrollOnDrag)
                  end
                  ;
                  (FormationWindow.InitExpedition)(mFormationData)
                  ;
                  (FormationWindow.RefreshCard)()
                  ;
                  (FormationWindow.RefreshEnemyFightList)(mFormationData)
                  ;
                  (FormationWindow.RefreshMyselfFightList)({})
                  ;
                  (FormationWindow.InitBuff)(mFormationData)
                  ;
                  (FormationWindow.InitInfoGrpBtn)()
                  ;
                  (FormationWindow.InitGuildBattle)(mFormationData)
                  -- DECOMPILER ERROR at PC429: Confused about usage of register: R1 in 'UnsetPending'

                  ;
                  ((uis.HeadListGrp).BattleStartBtn).text = (mFormationData.BtnData).btnTxt
                  if init then
                    (((uis.HeadListGrp).BattleStartBtn).onClick):Add(function(...)
    -- function num : 0_1_0 , upvalues : FormationWindow, _ENV, myselfFightDate, mFormationType, mFormationData, supportID, supportPlayerIndex, uis, stageID, recordEnemyFc
    if (FormationWindow.JudgeFormationRepetition)() then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000518))
      myselfFightDate = {nil, nil, nil, nil, nil, nil}
      ;
      (FormationWindow.RefreshMyselfFightList)({})
      loge("出战卡片数据重复")
      return 
    end
    local enterFunc = function(...)
      -- function num : 0_1_0_0 , upvalues : mFormationType, _ENV, mFormationData, myselfFightDate, supportID, supportPlayerIndex, uis
      if mFormationType == FormationType.GuildBattle then
        ((mFormationData.BtnData).fun)(myselfFightDate, supportID, supportPlayerIndex)
      else
        if mFormationType == FormationType.Edit then
          ((mFormationData.BtnData).fun)(myselfFightDate, ((uis.TeamName).NameTxt).text)
        else
          ;
          ((mFormationData.BtnData).fun)(myselfFightDate)
        end
      end
    end

    if (PlotDungeonMgr.GetStageChapterType)(stageID) == DungeonType.ActivityDungeon or (PlotDungeonMgr.GetStageChapterType)(stageID) == DungeonType.RelicDungeon or (PlotDungeonMgr.GetStageChapterType)(stageID) == DungeonType.NewActivityDungeon then
      local fcTxt = recordEnemyFc
      if fcTxt then
        (PlotDungeonMgr.ActivityDungeonEnemyFc)(tonumber(fcTxt))
      end
    else
      do
        if (PlotDungeonMgr.GetTowerExpandChapterType)(stageID) == DungeonType.TowerExpand and recordEnemyFc then
          (TowerTopStageMgr.TowerExpandFc)(tonumber(recordEnemyFc))
        end
        if (FormationWindow.JudgeIsFormationFull)() then
          enterFunc()
        else
          if mFormationType ~= FormationType.Single and mFormationType ~= FormationType.Edit then
            (MessageMgr.OpenConfirmWindow)((PUtil.get)(20000274), function(...)
      -- function num : 0_1_0_1 , upvalues : enterFunc
      enterFunc()
    end
, function(...)
      -- function num : 0_1_0_2 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.ConfirmWindow).name)
    end
, (PUtil.get)(20000275), (PUtil.get)(20000276), (PUtil.get)(20000277), false, UILayer.HUD1)
          else
            enterFunc()
          end
        end
      end
    end
  end
)
                  end
                  local detailFun = mFormationData.DetailBtn
                  local detailBtn = (uis.root):GetChild("ExtBtn")
                  detailBtn.visible = detailFun ~= nil
                  ;
                  (detailBtn.onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : detailFun
    detailFun()
  end
)
                  if init then
                    (((DragDropManager.inst).dragAgent).onDragEnd):Add(function(...)
    -- function num : 0_1_2 , upvalues : FormationWindow, appaySfx
    (FormationWindow.SetSelfFightAlphaAndTouch)(1, true)
    appaySfx.visible = false
  end
)
                  end
                  if mFormationType == FormationType.Single or mFormationType == FormationType.Edit then
                    selfGrp = uis.ArenaOneSelfGrp
                  else
                    selfGrp = uis.OneSelfGrp
                  end
                  ;
                  (FormationWindow.InitSortNum)()
                  ;
                  (FormationWindow.InitFunctionControl)()
                  if init then
                    if mFormationData.battleType == nil then
                      local data = (MessageMgr.GetFormationData)()
                      ;
                      (FormationWindow.InitBG)(data.battleType, data.stageId)
                    else
                      (FormationWindow.InitBG)(mFormationData.battleType, mFormationData.stageId)
                    end
                  end
                  -- DECOMPILER ERROR at PC502: Confused about usage of register: R3 in 'UnsetPending'

                  if mFormationType == FormationType.Edit then
                    (uis.TeamName).touchable = false
                    -- DECOMPILER ERROR at PC506: Confused about usage of register: R3 in 'UnsetPending'

                    ;
                    ((uis.TeamName).NameTxt).text = mFormationData.presetName
                    ;
                    (((uis.TeamName).root).onClick):Set(function(...)
    -- function num : 0_1_3 , upvalues : _ENV, mFormationData
    OpenWindow((WinResConfig.FormationPresetNamingWindow).name, UILayer.HUD, mFormationData.presetName)
  end
)
                  end
                  ;
                  (FormationWindow.InitBtn)()
                  appaySfx = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ARRAY_POSITIONEFF)
                  appaySfx.xy = sfxOffsetPos
                  local isShowSfx = false
                  if init then
                    (((DragDropManager.inst).dragAgent).onDragMove):Add(function(eventContext, ...)
    -- function num : 0_1_4 , upvalues : isShowSfx, FormationWindow, _ENV, appaySfx
    isShowSfx = false
    for i = 1, 6 do
      local mLoader = ((FormationWindow.GetModelTemplate)(true, i)):GetChild("MonsterLoader")
      local v2 = mLoader:GlobalToLocal(Vector2((eventContext.inputEvent).x, (eventContext.inputEvent).y))
      if v2.x <= mLoader.width and v2.x >= 0 and v2.y <= mLoader.height and v2.y >= 0 then
        local mSelf = (FormationWindow.GetModelTemplate)(true, i)
        mSelf:AddChild(appaySfx)
        isShowSfx = true
      end
    end
    appaySfx.visible = isShowSfx
  end
)
                  end
                  ;
                  (FormationWindow.InitBottomBoard)()
                  if init then
                    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_ARRAY_EFF, false, (uis.CardOperationGrp2).root, Vector2((GRoot.inst).width / 2, (GRoot.inst).height / 2))
                    putHolder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ARRAY_POSITIONEFFPUT)
                    putHolder.visible = false
                  end
                  ;
                  (FormationWindow.InitTxt)()
                  -- DECOMPILER ERROR: 10 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
end

FormationWindow.InitTxt = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.Battlepower_01_Txt).text = (PUtil.get)(20000352)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleNumber_01_Txt).text = (PUtil.get)(60000235)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.Battlepower_02_Txt).text = (PUtil.get)(20000353)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleNumber_02_Txt).text = (PUtil.get)(60000235)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ArenaNumber_02_Txt).text = (PUtil.get)(60000235)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.Tower_01_Txt).text = (PUtil.get)(55)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.HeadListGrp).NameTxt).text = (PUtil.get)(31)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).BattleNumberTxt).text = (PUtil.get)(60000235)
end

FormationWindow.InitBtn = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, FormationWindow, myselfFightDate
  (((uis.HeadListGrp).ArrayBtn):GetChild("title")).text = (PUtil.get)(20000283)
  ;
  (((uis.HeadListGrp).ArrayBtn).onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, FormationWindow, myselfFightDate
    local GetNum = (math.min)((FormationWindow.GetCardMaxFightNum)(), (FormationWindow.GetFreePosNum)())
    if GetNum <= 0 then
      return 
    end
    local FightTable = (FormationWindow.GetFreeFightOrder)(GetNum)
    if #FightTable < 1 then
      return 
    end
    ;
    (table.sort)(FightTable, function(a, b, ...)
      -- function num : 0_3_0_0 , upvalues : FormationWindow
      local aCardType = (FormationWindow.GetAutoFightTypeOrder)(a.attr_prior)
      local bCardType = (FormationWindow.GetAutoFightTypeOrder)(b.attr_prior)
      do return b.fc + bCardType < a.fc + aCardType end
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
)
    local timer = 1
    local addPos = {}
    local addFashionId = {}
    for i = 4, 6 do
      if myselfFightDate[i] == nil then
        for j,v in ipairs(FightTable) do
          if v.attr_prior == CardTendType.SUP then
            local cardStartPos = (FormationWindow.GetCardListPosByID)(v.id)
            ;
            (FormationWindow.AddFightDate)(true, cardStartPos, i, true)
            ;
            (table.insert)(addPos, i)
            ;
            (table.insert)(addFashionId, v.fashionId)
            ;
            (table.remove)(FightTable, j)
            break
          end
        end
      end
    end
    for i = 1, 6 do
      if myselfFightDate[i] == nil then
        local cardData = FightTable[timer]
        if cardData then
          local cardStartPos = (FormationWindow.GetCardListPosByID)(cardData.id)
          ;
          (FormationWindow.AddFightDate)(true, cardStartPos, i, true)
          timer = timer + 1
          ;
          (table.insert)(addPos, i)
          ;
          (table.insert)(addFashionId, cardData.fashionId)
        end
      end
    end
    ;
    (FormationWindow.RefreshMyselfFightList)(addPos)
    ;
    (FormationWindow.RefreshCardList)()
    ;
    (FormationWindow.SetSelfFightAlphaAndTouch)(1, true)
    ;
    (FormationWindow.CloseTalkCom)()
    local random = (math.random)(1, #addPos)
    for i,v in ipairs(addPos) do
      (FormationWindow.PlayTalkTxt)(addFashionId[i], v)
    end
    ;
    (AudioManager.PlayBubbleAndVoice)(false, true, addFashionId[random], CVAudioType.ArrayUpBubble, nil, nil, nil, nil, nil, nil, function(...)
      -- function num : 0_3_0_1 , upvalues : FormationWindow
      (FormationWindow.CloseTalkCom)()
    end
, true)
  end
)
end

FormationWindow.GetAutoFightTypeOrder = function(type, ...)
  -- function num : 0_4 , upvalues : _ENV
  local cardType = type
  if cardType == CardTendType.DEFENCE then
    return 1e+15
  else
    if cardType == CardTendType.ATTACK then
      return 100000000
    else
      return 0
    end
  end
end

FormationWindow.GetFreeFightOrder = function(rank, ...)
  -- function num : 0_5 , upvalues : _ENV, cardListDate, mFormationType, saveInitCard, MaxFight, ExpeditionListData, FormationWindow, supportID
  if rank <= 0 then
    return 
  end
  local cardList = (Util.clone)(cardListDate)
  if mFormationType == FormationType.GuildBattle then
    cardList = (Util.clone)(saveInitCard)
  end
  ;
  (table.sort)(cardList, function(a, b, ...)
    -- function num : 0_5_0
    local aFight = a.fc or -1
    local bFight = b.fc or -1
    do return bFight < aFight end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local mTable = {}
  local k = 1
  local canNoFightNum = 9999
  if mFormationType == FormationType.Expedition then
    canNoFightNum = MaxFight - #ExpeditionListData
  end
  for i = 1, rank do
    for j = k, #cardList do
      local data = cardList[j]
      if not (FormationWindow.IsFight)(data.id) and (FormationWindow.RelicIsCanFight)(data.id) and data.id ~= nil then
        if mFormationType == FormationType.Expedition or mFormationType == FormationType.Relic then
          local stage = (FormationWindow.GetCardState)(data.id)
          if stage == (ExpeditionMgr.CardState).Normal then
            (table.insert)(mTable, data)
            k = j + 1
            break
          else
            if stage == (ExpeditionMgr.CardState).NoFight and canNoFightNum > 0 then
              (table.insert)(mTable, data)
              k = j + 1
              canNoFightNum = canNoFightNum + 1
              break
            end
          end
        else
          do
            do
              if data.id ~= supportID and not (FormationWindow.IsContainCantUseList)(data.id) then
                (table.insert)(mTable, data)
                k = j + 1
                break
              end
              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  return mTable
end

FormationWindow.GetCardMaxFightNum = function(...)
  -- function num : 0_6 , upvalues : mFormationType, _ENV, MaxFight, FormationWindow
  if mFormationType == FormationType.Expedition then
    return (math.min)(MaxFight - (FormationWindow.GetExpeditionCantFightNum)(), (FormationWindow.GetRemainCanBattleNum)())
  else
    return (FormationWindow.GetRemainCanBattleNum)()
  end
end

FormationWindow.GetExpeditionCantFightNum = function(...)
  -- function num : 0_7 , upvalues : _ENV, ExpeditionListData, FormationWindow
  local num = 0
  for _,v in ipairs(ExpeditionListData) do
    local stage = (FormationWindow.GetCardState)(v.cardId)
    if stage == (ExpeditionMgr.CardState).Dead or stage == (ExpeditionMgr.CardState).Tired or (FormationWindow.IsFight)(v.cardId) then
      num = num + 1
    end
  end
  return num
end

FormationWindow.JudgeFormationRepetition = function(...)
  -- function num : 0_8 , upvalues : myselfFightDate, _ENV
  for i = 1, 6 do
    local value1 = myselfFightDate[i]
    for j = i + 1, 6 do
      local value2 = myselfFightDate[j]
      if value1 and value2 and value1 == value2 then
        ld("Overture")
        ;
        (OvertureMgr.SendRecord)(999)
        return true
      end
    end
  end
  return false
end

FormationWindow.JudgeIsFormationFull = function(...)
  -- function num : 0_9 , upvalues : FormationWindow, mFormationType, _ENV, ExpeditionListData, MaxFight
  local freePos = (FormationWindow.GetFreePosNum)()
  local remainPos = (FormationWindow.GetRemainCanBattleNum)()
  if mFormationType == FormationType.Expedition and MaxFight <= #ExpeditionListData then
    return true
  end
  if freePos == 0 or remainPos == 0 then
    return true
  end
  return false
end

FormationWindow.GetRemainCanBattleNum = function(...)
  -- function num : 0_10 , upvalues : cardListDate, mFormationType, _ENV, saveInitCard, FormationWindow, supportID
  local Count = 0
  local mList = cardListDate
  if mFormationType == FormationType.GuildBattle then
    mList = saveInitCard
  end
  for _,v in ipairs(mList) do
    if v.id ~= nil and not (FormationWindow.IsFight)(v.id) then
      if mFormationType == FormationType.Expedition or mFormationType == FormationType.Relic then
        local state = (FormationWindow.GetCardState)(v.id)
        if state == (ExpeditionMgr.CardState).Normal or state == -1 then
          Count = Count + 1
        end
      else
        do
          do
            if v.id ~= supportID then
              Count = Count + 1
            end
            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  return Count
end

FormationWindow.InitFunctionControl = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis
  local winName = (WinResConfig.FormationWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Formation_Challenge, (uis.HeadListGrp).BattleStartBtn, winName)
  RegisterGuideAndControl(ControlID.Formation_OneKey, (uis.HeadListGrp).ArrayBtn, winName)
end

FormationWindow.InitBG = function(battleType, stageID, ...)
  -- function num : 0_12 , upvalues : _ENV
  (Util.SetCameraActive)(Game.battleCamera, true)
  ;
  (BattleBackground.CreateBackground)(false, stageID, battleType, 1)
end

FormationWindow.InitSortNum = function(...)
  -- function num : 0_13 , upvalues : _ENV, FormationWindow
  (SimpleTimer.setTimeout)(0.2, function(...)
    -- function num : 0_13_0 , upvalues : FormationWindow
    for i = 0, 5 do
      (FormationWindow.SetBelowSortingOrder)(i)
    end
  end
)
end

FormationWindow.SetBelowSortingOrder = function(pos2, ...)
  -- function num : 0_14 , upvalues : uis
  local floor = ((uis.root):GetChild("Enemy_0" .. pos2 .. "_Grp")):GetChild("n29")
  floor.ManuallyModifySd = true
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (floor.displayObject).renderingOrder = 1
end

FormationWindow.InitExpedition = function(formationData, ...)
  -- function num : 0_15 , upvalues : mFormationType, _ENV, alreadyCard
  if mFormationType ~= FormationType.Expedition then
    return 
  end
  alreadyCard = (formationData.ExternalData).cardState
end

FormationWindow.InitGuildBattle = function(formationData, ...)
  -- function num : 0_16 , upvalues : mFormationType, _ENV, FormationWindow, uis
  if mFormationType ~= FormationType.GuildBattle then
    return 
  end
  ;
  (FormationWindow.SetCardFilter)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.HeadListGrp).GuildBossList).itemRenderer = FormationWindow.SupportCardRenderer
  ;
  ((uis.HeadListGrp).GuildBossList):SetVirtual()
end

FormationWindow.SetCardFilter = function(...)
  -- function num : 0_17 , upvalues : uis, _ENV, FormationWindow
  (((uis.GuildBossChoice).ABtn):GetChild("NameTxt")).text = (PUtil.get)(25)
  ;
  (((uis.GuildBossChoice).BBtn):GetChild("NameTxt")).text = (PUtil.get)(6)
  ;
  (((uis.GuildBossChoice).CBtn):GetChild("NameTxt")).text = (PUtil.get)(1)
  ;
  (((uis.GuildBossChoice).DBtn):GetChild("NameTxt")).text = (PUtil.get)(20000226)
  ;
  (((uis.GuildBossChoice).EBtn):GetChild("NameTxt")).text = (PUtil.get)(3)
  ;
  (((uis.GuildBossChoice).ABtn).onClick):Set(function(...)
    -- function num : 0_17_0 , upvalues : FormationWindow
    (FormationWindow.OnClickFilter)(0)
  end
)
  ;
  (((uis.GuildBossChoice).BBtn).onClick):Set(function(...)
    -- function num : 0_17_1 , upvalues : FormationWindow, _ENV
    (FormationWindow.OnClickFilter)(CardTendType.ATTACK)
  end
)
  ;
  (((uis.GuildBossChoice).CBtn).onClick):Set(function(...)
    -- function num : 0_17_2 , upvalues : FormationWindow, _ENV
    (FormationWindow.OnClickFilter)(CardTendType.DEFENCE)
  end
)
  ;
  (((uis.GuildBossChoice).DBtn).onClick):Set(function(...)
    -- function num : 0_17_3 , upvalues : FormationWindow, _ENV
    (FormationWindow.OnClickFilter)(CardTendType.SUP)
  end
)
  ;
  (((uis.GuildBossChoice).EBtn).onClick):Set(function(...)
    -- function num : 0_17_4 , upvalues : uis, FormationWindow
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.HeadListGrp).c1Ctr).selectedIndex = 2
    ;
    (FormationWindow.RefreshSupportCard)()
  end
)
end

FormationWindow.OnClickFilter = function(type, ...)
  -- function num : 0_18 , upvalues : filterType, uis, FormationWindow
  filterType = type
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.HeadListGrp).c1Ctr).selectedIndex = 0
  ;
  (FormationWindow.RefreshCard)()
end

FormationWindow.GetGuildBossFightAndFreeListData = function(cardList, ...)
  -- function num : 0_19 , upvalues : _ENV, FormationWindow
  local fight = {}
  local free = {}
  local used = nil
  for _,v in ipairs(cardList) do
    used = (FormationWindow.IsContainCantUseList)(v.id)
    if used then
      (table.insert)(fight, v)
    else
      ;
      (table.insert)(free, v)
    end
  end
  ;
  (table.sort)(fight, function(a, b, ...)
    -- function num : 0_19_0
    do return b.fc < a.fc end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(free, function(a, b, ...)
    -- function num : 0_19_1 , upvalues : FormationWindow
    local aIsFight = 0
    local bIsFight = 0
    if (FormationWindow.IsFight)(a.id) then
      aIsFight = 100000000000
    end
    if (FormationWindow.IsFight)(b.id) then
      bIsFight = 100000000000
    end
    do return bIsFight + b.fc < aIsFight + a.fc end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return fight, free
end

FormationWindow.GetExpeditionFightListData = function(...)
  -- function num : 0_20 , upvalues : _ENV, alreadyCard, myselfFightDate, FormationWindow
  local data = {}
  for _,v in ipairs(alreadyCard) do
    local oneCard = (CardData.GetCardData)(v.cardId)
    v.oneCard = oneCard
    ;
    (table.insert)(data, v)
  end
  for i,v in pairs(myselfFightDate) do
    if not (FormationWindow.FormationIsContainAlready)(v) then
      local cardData = {}
      local oneCard = (CardData.GetCardData)(v)
      cardData.cardId = oneCard.id
      cardData.cardState = (ExpeditionMgr.CardState).Normal
      cardData.supDander = oneCard.dander
      cardData.supHp = oneCard.max_hp
      cardData.pos = i
      cardData.oneCard = oneCard
      ;
      (table.insert)(data, cardData)
    end
  end
  ;
  (table.sort)(data, function(a, b, ...)
    -- function num : 0_20_0 , upvalues : FormationWindow
    local fa = (FormationWindow.GetExpeditionListSortWeight)(a.cardId)
    local fb = (FormationWindow.GetExpeditionListSortWeight)(b.cardId)
    do return fb < fa end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return data
end

FormationWindow.GetExpeditionFreeListData = function(...)
  -- function num : 0_21 , upvalues : _ENV, cardListDate, FormationWindow
  local data = {}
  for i,v in ipairs(cardListDate) do
    if v.id ~= nil and not (FormationWindow.FormationIsContainAlready)(v.id) and not (FormationWindow.IsFight)(v.id) then
      local cardData = {}
      cardData.cardId = v.id
      cardData.cardState = (ExpeditionMgr.CardState).Normal
      cardData.supDander = v.dander
      cardData.supHp = v.max_hp
      cardData.fc = v.fc
      cardData.oneCard = v
      ;
      (table.insert)(data, cardData)
    end
  end
  ;
  (table.sort)(data, function(a, b, ...)
    -- function num : 0_21_0 , upvalues : FormationWindow
    local aIsFight = 0
    local bIsFight = 0
    if (FormationWindow.IsFight)(a.id) then
      aIsFight = 100000000000
    end
    if (FormationWindow.IsFight)(b.id) then
      bIsFight = 100000000000
    end
    local aStateNum = (FormationWindow.GetExpeditionSortWeight)(a.id)
    local bStateNum = (FormationWindow.GetExpeditionSortWeight)(b.id)
    do return bIsFight + b.fc + bStateNum < aIsFight + a.fc + aStateNum end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return data
end

FormationWindow.FormationIsContainAlready = function(id, ...)
  -- function num : 0_22 , upvalues : _ENV, alreadyCard
  for _,v in ipairs(alreadyCard) do
    if v.cardId == tonumber(id) then
      return true
    end
  end
  return false
end

FormationWindow.SetCardStateSymbol = function(ctr, id, isExpeditionList, ...)
  -- function num : 0_23 , upvalues : FormationWindow, _ENV
  local state = 0
  if isExpeditionList then
    state = (FormationWindow.GetCardState)(id)
    if state == (ExpeditionMgr.CardState).Dead then
      ctr.selectedIndex = 3
    else
      if state == (ExpeditionMgr.CardState).Tired then
        ctr.selectedIndex = 2
      else
        ctr.selectedIndex = 0
      end
    end
  else
    if (FormationWindow.IsFight)(id) then
      ctr.selectedIndex = 4
    else
      state = (FormationWindow.GetCardState)(id)
      if state == (ExpeditionMgr.CardState).Dead then
        ctr.selectedIndex = 3
      else
        if state == (ExpeditionMgr.CardState).Tired then
          ctr.selectedIndex = 2
        else
          if state == (ExpeditionMgr.CardState).Normal then
            ctr.selectedIndex = 1
          else
            ctr.selectedIndex = 0
          end
        end
      end
    end
  end
  return state
end

FormationWindow.GetCardState = function(id, ...)
  -- function num : 0_24 , upvalues : mFormationType, _ENV, alreadyCard, relicData
  local list = nil
  if mFormationType == FormationType.Expedition then
    list = alreadyCard
  else
    if mFormationType == FormationType.Relic then
      list = relicData.cardState
    end
  end
  for _,v in ipairs(list) do
    if v.cardId == id then
      return v.cardState
    end
  end
  return -1
end

FormationWindow.GetAvailableCount = function(...)
  -- function num : 0_25 , upvalues : MaxFight, ExpeditionListData
  return MaxFight - #ExpeditionListData
end

FormationWindow.InitBuff = function(formationData, ...)
  -- function num : 0_26 , upvalues : FormationWindow, _ENV, mFormationType, uis
  if not formationData.ExternalData then
    (FormationWindow.CloseBuffShow)()
    return 
  end
  local buff = ((TableData.gTable).BaseBuffPreBattleData)[tonumber((formationData.ExternalData).buff)]
  if not buff then
    (FormationWindow.CloseBuffShow)()
    return 
  end
  local icon, des = nil, nil
  if mFormationType == FormationType.Tower or mFormationType == FormationType.TowerExpand then
    icon = uis.BuffLoader
    des = uis.BuffNameTxt
  else
    if mFormationType == FormationType.Expedition then
      icon = uis.ExpeditionBuffLoader
      des = uis.ExpeditionBuffNameTxt
    end
  end
  icon.url = (Util.GetItemUrl)(buff.icon)
  icon.fill = (FairyGUI.FillType).ScaleNoBorder
  des.text = (PUtil.get)(20000108, buff.name, buff.remark)
end

FormationWindow.CloseBuffShow = function(...)
  -- function num : 0_27 , upvalues : mFormationType, _ENV, uis
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if mFormationType == FormationType.Tower or mFormationType == FormationType.TowerExpand then
    (uis.BuffLoader).visible = false
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.BuffNameTxt).visible = false
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

    if mFormationType == FormationType.Expedition then
      (uis.ExpeditionBuffLoader).visible = false
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.ExpeditionBuffNameTxt).visible = false
    end
  end
end

FormationWindow.InitBottomBoard = function(...)
  -- function num : 0_28 , upvalues : FormationWindow, _ENV, mFormationType, enemyIsCustom, enemyFightDate
  for i = 1, 6 do
    local mSelf = (FormationWindow.GetModelTemplate)(true, i)
    local selfModel = GetFormation_ModelTemplateUis(mSelf)
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (selfModel.c1Ctr).selectedIndex = 0
    ;
    (mSelf:GetChild("Talk")).touchable = false
  end
  do
    if mFormationType == FormationType.Single or mFormationType == FormationType.Edit then
      return 
    end
    for i = 1, 6 do
      local mEnemy = (FormationWindow.GetModelTemplate)(false, i)
      local enemyModel = GetFormation_ModelTemplateUis(mEnemy)
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (enemyModel.c1Ctr).selectedIndex = 1
      local tips = mEnemy:GetChild("Tips")
      tips.visible = false
      if not enemyIsCustom then
        local id = enemyFightDate[i]
        if id then
          local monsterData = (TableData.GetBaseMonsterData)(tonumber(id))
          if monsterData ~= nil and monsterData.formation_label_show ~= nil then
            (mEnemy:GetChild("TipsTxt")).text = monsterData.formation_label_show
            tips.visible = true
          end
        end
      end
    end
  end
end

FormationWindow.SplitSupportCardUse = function(...)
  -- function num : 0_29 , upvalues : _ENV, supportData, FormationWindow
  local use = {}
  local noUse = {}
  for _,v in ipairs(supportData) do
    if v.used then
      (table.insert)(use, v)
    else
      ;
      (table.insert)(noUse, v)
    end
  end
  ;
  (table.sort)(use, function(a, b, ...)
    -- function num : 0_29_0 , upvalues : FormationWindow
    do return (FormationWindow.CardListSort)(b, true) < (FormationWindow.CardListSort)(a, true) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(noUse, function(a, b, ...)
    -- function num : 0_29_1 , upvalues : FormationWindow
    do return (FormationWindow.CardListSort)(b, true) < (FormationWindow.CardListSort)(a, true) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return use, noUse
end

FormationWindow.CardListSort = function(data, isSupportCard, ...)
  -- function num : 0_30 , upvalues : FormationWindow
  local aIsFight = 0
  if (FormationWindow.IsFight)(data.id, isSupportCard, data.playerIndex) then
    aIsFight = 100000000000
  end
  return aIsFight + data.fc
end

FormationWindow.RefreshSupportCard = function(...)
  -- function num : 0_31 , upvalues : mFormationType, _ENV, supportCardListDate, FormationWindow, uis
  if mFormationType ~= FormationType.GuildBattle then
    return 
  end
  supportCardListDate = {}
  local use, noUse = (FormationWindow.SplitSupportCardUse)()
  for _,v in ipairs(noUse) do
    (table.insert)(supportCardListDate, v)
  end
  local blankNum = #noUse % 3
  if blankNum ~= 0 then
    blankNum = 3 - blankNum
  end
  if blankNum > 0 then
    for i = 1, blankNum do
      (table.insert)(supportCardListDate, "Blank")
    end
  end
  do
    if use and #use > 0 then
      for i = 1, 3 do
        (table.insert)(supportCardListDate, "Line")
      end
      for _,v in ipairs(use) do
        (table.insert)(supportCardListDate, v)
      end
    end
    do
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((uis.HeadListGrp).GuildBossList).itemProvider = function(index, ...)
    -- function num : 0_31_0 , upvalues : supportCardListDate, _ENV
    local data = supportCardListDate[index + 1]
    if data == "Line" then
      return (Util.GetResUrl)("Formation:Division_B")
    else
      return (Util.GetResUrl)("CommonResource:GuildBossHead")
    end
  end

      -- DECOMPILER ERROR at PC72: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((uis.HeadListGrp).GuildBossList).numItems = #supportCardListDate
    end
  end
end

FormationWindow.GetRelicUpList = function(...)
  -- function num : 0_32 , upvalues : _ENV, relicData, FormationWindow
  local mUpList = {}
  local mDownList = {}
  local cardList = (CardData.GetFormationCards)()
  local cantList = {}
  if relicData then
    cantList = relicData.cantFight
  end
  for _,v in ipairs(cardList) do
    local isContain = false
    for _,v2 in ipairs(cantList) do
      if v.id == v2 then
        isContain = true
        break
      end
    end
    do
      do
        if isContain then
          (table.insert)(mDownList, v)
        else
          ;
          (table.insert)(mUpList, v)
        end
        -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  (table.sort)(mUpList, function(a, b, ...)
    -- function num : 0_32_0 , upvalues : FormationWindow
    do return (FormationWindow.GetRelicListSortWeight)(b.id) + b.fc < (FormationWindow.GetRelicListSortWeight)(a.id) + a.fc end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(mDownList, function(a, b, ...)
    -- function num : 0_32_1
    do return b.fc < a.fc end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return mUpList, mDownList
end

FormationWindow.RefreshCard = function(...)
  -- function num : 0_33 , upvalues : mFormationType, _ENV, FormationWindow, cardListDate, scrollList, uis, relicData, ExpeditionListData, MaxFight, filterType, saveInitCard
  if mFormationType == FormationType.Relic then
    local upList, downList = (FormationWindow.GetRelicUpList)()
    cardListDate = {}
    for _,v in ipairs(upList) do
      (table.insert)(cardListDate, v)
    end
    local blankNum = #upList % 3
    if blankNum ~= 0 then
      blankNum = 3 - blankNum
    end
    if blankNum > 0 then
      for i = 1, blankNum do
        (table.insert)(cardListDate, "Blank")
      end
    end
    do
      if #downList > 0 then
        for i = 1, 3 do
          (table.insert)(cardListDate, "Line")
        end
      end
      do
        do
          for _,v in ipairs(downList) do
            (table.insert)(cardListDate, v)
          end
          scrollList.itemProvider = function(index, ...)
    -- function num : 0_33_0 , upvalues : cardListDate, _ENV
    local data = cardListDate[index + 1]
    if data == "Line" then
      return (Util.GetResUrl)("Formation:Division_B")
    else
      return (Util.GetResUrl)("CommonResource:ExpeditionHead")
    end
  end

          -- DECOMPILER ERROR at PC67: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (((uis.HeadListGrp).Division_A).WordTxt).text = relicData.titleString
          if mFormationType == FormationType.Expedition then
            local fightList = (FormationWindow.GetExpeditionFightListData)()
            local freeList = (FormationWindow.GetExpeditionFreeListData)()
            cardListDate = {}
            for _,v in ipairs(fightList) do
              (table.insert)(cardListDate, v.oneCard)
            end
            local blankNum = #fightList % 3
            if blankNum ~= 0 then
              blankNum = 3 - blankNum
            end
            if blankNum > 0 then
              for i = 1, blankNum do
                (table.insert)(cardListDate, "Blank")
              end
            end
            do
              if #freeList > 0 then
                for i = 1, 3 do
                  (table.insert)(cardListDate, "Line")
                end
              end
              do
                for _,v in ipairs(freeList) do
                  (table.insert)(cardListDate, v.oneCard)
                end
                ExpeditionListData = fightList
                scrollList.itemProvider = function(index, ...)
    -- function num : 0_33_1 , upvalues : cardListDate, _ENV
    local data = cardListDate[index + 1]
    if data == "Line" then
      return (Util.GetResUrl)("Formation:Division_B")
    else
      return (Util.GetResUrl)("CommonResource:ExpeditionHead")
    end
  end

                do
                  local fightNum = #ExpeditionListData
                  -- DECOMPILER ERROR at PC148: Confused about usage of register: R4 in 'UnsetPending'

                  if fightNum > 0 then
                    (((uis.HeadListGrp).Division_A).WordTxt).text = (PUtil.get)(20000279, fightNum, MaxFight)
                  else
                    -- DECOMPILER ERROR at PC159: Confused about usage of register: R4 in 'UnsetPending'

                    ;
                    (((uis.HeadListGrp).Division_A).WordTxt).text = (PUtil.get)(20000297, fightNum, MaxFight)
                  end
                  if mFormationType == FormationType.GuildBattle then
                    cardListDate = {}
                    if filterType == 0 then
                      cardListDate = saveInitCard
                    else
                      local mTable = saveInitCard
                      for _,v in ipairs(mTable) do
                        if v.attr_prior == filterType then
                          (table.insert)(cardListDate, v)
                        end
                      end
                    end
                    do
                      local fightList, freeList = (FormationWindow.GetGuildBossFightAndFreeListData)(cardListDate)
                      cardListDate = {}
                      for _,v in ipairs(freeList) do
                        (table.insert)(cardListDate, v)
                      end
                      local blankNum = #freeList % 3
                      if blankNum ~= 0 then
                        blankNum = 3 - blankNum
                      end
                      if blankNum > 0 then
                        for i = 1, blankNum do
                          (table.insert)(cardListDate, "Blank")
                        end
                      end
                      do
                        if #fightList > 0 then
                          for i = 1, 3 do
                            (table.insert)(cardListDate, "Line")
                          end
                        end
                        do
                          do
                            for _,v in ipairs(fightList) do
                              (table.insert)(cardListDate, v)
                            end
                            scrollList.itemProvider = function(index, ...)
    -- function num : 0_33_2 , upvalues : cardListDate, _ENV
    local data = cardListDate[index + 1]
    if data == "Line" then
      return (Util.GetResUrl)("Formation:Division_B")
    else
      return (Util.GetResUrl)("CommonResource:HeadFrame")
    end
  end

                            cardListDate = {}
                            if filterType == 0 then
                              cardListDate = saveInitCard
                            else
                              local mTable = saveInitCard
                              for _,v in ipairs(mTable) do
                                if v.attr_prior == filterType then
                                  (table.insert)(cardListDate, R8_PC271)
                                end
                              end
                            end
                            do
                              ;
                              (table.sort)(cardListDate, function(a, b, ...)
    -- function num : 0_33_3 , upvalues : FormationWindow
    local aIsFight = 0
    local bIsFight = 0
    if (FormationWindow.IsFight)(a.id) then
      aIsFight = 100000000000
    end
    if (FormationWindow.IsFight)(b.id) then
      bIsFight = 100000000000
    end
    do return bIsFight + b.fc < aIsFight + a.fc end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                              scrollList.defaultItem = (Util.GetResUrl)("CommonResource:HeadFrame")
                              scrollList.numItems = #cardListDate
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

FormationWindow.GetExpeditionDataByID = function(id, ...)
  -- function num : 0_34 , upvalues : mFormationType, _ENV, ExpeditionListData, relicData
  local mList = nil
  if mFormationType == FormationType.Expedition then
    mList = ExpeditionListData
  else
    if mFormationType == FormationType.Relic then
      mList = relicData.cardState
    end
  end
  for _,v in ipairs(mList) do
    if v.cardId == id then
      return v
    end
  end
end

FormationWindow.GetRelicListSortWeight = function(id, ...)
  -- function num : 0_35 , upvalues : mFormationType, _ENV, relicData, FormationWindow
  if mFormationType ~= FormationType.Relic then
    return 0
  end
  local State = -1
  for _,v in ipairs(relicData.cardState) do
    if v.cardId == id then
      State = v.cardState
    end
  end
  if (FormationWindow.IsFight)(id) then
    return 100000000000
  end
  if State == (ExpeditionMgr.CardState).Dead then
    return -1e+21
  else
    if State == (ExpeditionMgr.CardState).Tired then
      return -100000000000
    else
      if State == (ExpeditionMgr.CardState).Normal then
        return 0
      end
    end
  end
  return 0
end

FormationWindow.GetExpeditionListSortWeight = function(id, ...)
  -- function num : 0_36 , upvalues : mFormationType, _ENV, FormationWindow
  if mFormationType ~= FormationType.Expedition then
    return 0
  end
  local State = (FormationWindow.GetCardState)(id)
  if (FormationWindow.IsFight)(id) then
    return 100000000000
  end
  if State == (ExpeditionMgr.CardState).Dead then
    return -1e+21
  else
    if State == (ExpeditionMgr.CardState).Tired then
      return -100000000000
    else
      if State == (ExpeditionMgr.CardState).Normal then
        return 0
      end
    end
  end
end

FormationWindow.GetExpeditionSortWeight = function(id, ...)
  -- function num : 0_37 , upvalues : mFormationType, _ENV, FormationWindow
  if mFormationType ~= FormationType.Expedition then
    return 0
  end
  local State = (FormationWindow.GetCardState)(id)
  if State == (ExpeditionMgr.CardState).Dead then
    return -1e+21
  else
    if State == (ExpeditionMgr.CardState).Tired then
      return 1000000
    else
      if State == (ExpeditionMgr.CardState).Normal then
        return 100000000
      else
        return 0
      end
    end
  end
end

FormationWindow.SetSelfFightAlphaAndTouch = function(num, canTouch, ...)
  -- function num : 0_38 , upvalues : _ENV, selfLoaderList
  for _,v in pairs(selfLoaderList) do
    if v.Model then
      v.alpha = num
      v.touchable = canTouch
    end
  end
end

FormationWindow.RelicIsCanFight = function(id, ...)
  -- function num : 0_39 , upvalues : mFormationType, _ENV, relicData
  if mFormationType ~= FormationType.Relic then
    return true
  end
  for _,v in ipairs(relicData.cantFight) do
    if v == id then
      return false
    end
  end
  return true
end

FormationWindow.CardRenderer = function(index, obj, ...)
  -- function num : 0_40 , upvalues : cardListDate, mFormationType, _ENV, relicData, battleType, FormationWindow, expeditionSweep, isTouching
  local cardData = cardListDate[index + 1]
  if cardData == nil or cardData == "Line" then
    if cardData == "Line" then
      if mFormationType == FormationType.GuildBattle then
        (obj:GetChild("WordTxt")).text = (PUtil.get)(20000555)
      else
        if mFormationType == FormationType.Relic then
          (obj:GetChild("WordTxt")).text = relicData.splitString
        else
          ;
          (obj:GetChild("WordTxt")).text = (PUtil.get)(20000403)
        end
      end
    end
    return 
  end
  if cardData == "Blank" then
    obj.visible = false
    return 
  end
  obj.visible = true
  local Card = obj
  local cardConfig, isMonster = (CardData.GetBaseConfig)(cardData.id)
  if mFormationType == FormationType.Expedition or mFormationType == FormationType.Relic then
    Card = obj:GetChild("HeadFrameGrp")
  end
  local CardModel = GetCommonResource_HeadFrameUis(Card)
  if battleType == (ProtoEnum.E_BATTLE_TYPE).CG then
    local cardInfo = {id = cardData.id, level = cardConfig.level, star = cardConfig.star, quality = cardConfig.quality}
    ;
    (Card:GetChild("IconLoader")).url = (CardMgr.GetHeadIconSquareUrl)(cardInfo)
    ;
    (Card:GetChild("LevelTxt")).text = ""
    for i = 1, Const.MaxRoleStar do
      (Card:GetChild("Star_0" .. tostring(i) .. "_smallImage")).visible = false
    end
    ;
    (Card:GetChild("StageTxt")).visible = false
    ;
    (obj:GetController("QualityCtrl")).selectedIndex = cardConfig.intelligence + 1
  else
    do
      ;
      (Util.SetHeadFrameByOneCard)(Card, cardData, isMonster)
      ;
      (Card.onClick):Set(function(...)
    -- function num : 0_40_0 , upvalues : FormationWindow, cardData
    (FormationWindow.onClickCard)(cardData, true)
  end
)
      local isCanDrag = true
      Card.draggable = false
      if mFormationType == FormationType.Expedition or mFormationType == FormationType.Relic then
        (FormationWindow.SetCardStateSymbol)(CardModel.c3Ctr, cardData.id, false)
        local hp = (obj:GetChild("HpBar")).asProgress
        local Dander = (obj:GetChild("DanderBar")).asProgress
        local state = (FormationWindow.GetCardState)(cardData.id)
        local data = (FormationWindow.GetExpeditionDataByID)(cardData.id)
        if state == (ExpeditionMgr.CardState).Dead then
          hp.value = 0
          Dander.value = 0
        else
          if not (FormationWindow.RelicIsCanFight)(cardData.id) then
            hp.value = 100
            Dander.value = 100
            -- DECOMPILER ERROR at PC179: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (CardModel.c3Ctr).selectedIndex = 8
            isCanDrag = false
          else
            if data ~= nil then
              hp.value = data.supHp / cardData.max_hp * 100
              Dander.value = data.supDander / cardData.max_dander * 100
            else
              hp.value = cardData.hp / cardData.max_hp * 100
              local danger = expeditionSweep + cardData.dander
              Dander.value = danger / cardData.max_dander * 100
            end
          end
        end
      else
        do
          -- DECOMPILER ERROR at PC214: Confused about usage of register: R8 in 'UnsetPending'

          if (FormationWindow.IsFight)(cardData.id) then
            (CardModel.c3Ctr).selectedIndex = 4
          else
            -- DECOMPILER ERROR at PC227: Confused about usage of register: R8 in 'UnsetPending'

            if (FormationWindow.IsContainCard)(cardData.id) or (FormationWindow.IsContainCantUseList)(cardData.id) then
              (CardModel.c3Ctr).selectedIndex = 5
              isCanDrag = false
            else
              -- DECOMPILER ERROR at PC231: Confused about usage of register: R8 in 'UnsetPending'

              ;
              (CardModel.c3Ctr).selectedIndex = 0
            end
          end
          local swipeGes = (FormationWindow.GetSwipeGesture)(Card)
          swipeGes.actionDistance = 100
          local isSwipe = true
          local isCreate = false
          ;
          (swipeGes.onBegin):Set(function(...)
    -- function num : 0_40_1 , upvalues : _ENV, swipeGes, isSwipe, isCreate
    local temp = (math.atan)((swipeGes.position).y / (swipeGes.position).x)
    isSwipe = true
    isCreate = false
    if (swipeGes.position).x > 0 or (math.abs)(temp) > 1 then
      isSwipe = false
    end
  end
)
          ;
          (swipeGes.onMove):Set(function(Context, ...)
    -- function num : 0_40_2 , upvalues : _ENV, isSwipe, isCreate, isCanDrag, mFormationType, FormationWindow, cardData, isTouching, Card
    ((FairyGUI.Stage).inst):CancelClick(0)
    if not isSwipe or isCreate or not isCanDrag then
      return 
    end
    do
      if mFormationType == FormationType.Expedition or mFormationType == FormationType.Relic then
        local state = (FormationWindow.GetCardState)(cardData.id)
        if state == (ExpeditionMgr.CardState).Tired then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000326))
          return 
        else
          if state == (ExpeditionMgr.CardState).Dead then
            (MessageMgr.SendCenterTips)((PUtil.get)(20000327))
            return 
          end
        end
      end
      if isTouching then
        return 
      end
      isCreate = true
      Card.draggable = true
      ;
      (FormationWindow.onDragStart)(Context, cardData)
    end
  end
)
          ;
          (swipeGes.onEnd):Set(function(...)
    -- function num : 0_40_3 , upvalues : Card
    Card.draggable = false
  end
)
        end
      end
    end
  end
end

FormationWindow.IsContainCantUseList = function(id, ...)
  -- function num : 0_41 , upvalues : _ENV, GuildBossCantCard
  for _,v in ipairs(GuildBossCantCard) do
    if v == id then
      return true
    end
  end
  return false
end

FormationWindow.ExpandCantUseList = function(id, ...)
  -- function num : 0_42 , upvalues : TowerExpandCantCard, _ENV
  TowerExpandCantCard = (TowerTopStageData.FormationInfo).yetUseCardIdList
  for _,v in ipairs(TowerExpandCantCard) do
    if v == id then
      return true
    end
  end
  return false
end

FormationWindow.SupportCardRenderer = function(index, obj, ...)
  -- function num : 0_43 , upvalues : supportCardListDate, _ENV, supportID, supportPlayerIndex, FormationWindow
  local cardData = supportCardListDate[index + 1]
  if cardData == nil or cardData == "Line" then
    if cardData == "Line" then
      (obj:GetChild("WordTxt")).text = (PUtil.get)(20000547)
    end
    return 
  end
  if cardData == "Blank" then
    obj.visible = false
    return 
  end
  obj.visible = true
  local name = obj:GetChild("NameTxt")
  name.text = cardData.playerName
  local headFrame = obj:GetChild("HeadFrameGrp")
  ;
  (Util.SetHeadFrame)(headFrame, cardData, false)
  local isCanDrag = true
  if cardData.id == supportID and cardData.playerIndex == supportPlayerIndex then
    ChangeUIController(headFrame, "c3", 6)
  else
    if cardData.used or (FormationWindow.IsFight)(cardData.id, false) then
      ChangeUIController(headFrame, "c3", 5)
      isCanDrag = false
    else
      ChangeUIController(headFrame, "c3", 0)
    end
  end
  ;
  (headFrame.onClick):Set(function(...)
    -- function num : 0_43_0 , upvalues : FormationWindow, cardData
    (FormationWindow.onClickCard)(cardData, false)
  end
)
  local swipeGes = (FormationWindow.GetSwipeGesture)(headFrame)
  swipeGes.actionDistance = 100
  local isSwipe = true
  local isCreate = false
  ;
  (swipeGes.onBegin):Set(function(...)
    -- function num : 0_43_1 , upvalues : _ENV, swipeGes, isSwipe, isCreate
    local temp = (math.atan)((swipeGes.position).y / (swipeGes.position).x)
    isSwipe = true
    isCreate = false
    if (swipeGes.position).x > 0 or (math.abs)(temp) > 1 then
      isSwipe = false
    end
  end
)
  ;
  (swipeGes.onMove):Set(function(Context, ...)
    -- function num : 0_43_2 , upvalues : _ENV, isSwipe, isCreate, isCanDrag, headFrame, FormationWindow, cardData
    ((FairyGUI.Stage).inst):CancelClick(0)
    if not isSwipe or isCreate or not isCanDrag then
      return 
    end
    isCreate = true
    headFrame.draggable = true
    ;
    (FormationWindow.onDragStart)(Context, cardData)
  end
)
  ;
  (swipeGes.onEnd):Set(function(...)
    -- function num : 0_43_3 , upvalues : headFrame
    headFrame.draggable = false
  end
)
end

FormationWindow.GetGesture = function(item, ...)
  -- function num : 0_44 , upvalues : _gestureDic, _ENV
  if _gestureDic[item] == nil then
    _gestureDic[item] = (FairyGUI.LongPressGesture)(item)
  end
  return _gestureDic[item]
end

FormationWindow.GetSwipeGesture = function(item, ...)
  -- function num : 0_45 , upvalues : _swipeDic, _ENV
  if _swipeDic[item] == nil then
    _swipeDic[item] = (FairyGUI.SwipeGesture)(item)
  end
  return _swipeDic[item]
end

FormationWindow.IsContainCard = function(id, ...)
  -- function num : 0_46 , upvalues : _ENV, myselfFightDate
  for _,v in pairs(myselfFightDate) do
    if v == id then
      return true
    end
  end
  return false
end

FormationWindow.JudgeSupportIsFight = function(id, playerIndex, ...)
  -- function num : 0_47 , upvalues : mFormationType, _ENV, supportID, supportPlayerIndex
  if mFormationType ~= FormationType.GuildBattle then
    return true
  end
  do return supportID == id and supportPlayerIndex == playerIndex end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FormationWindow.JudgeCardAlreadyBattle = function(id, ...)
  -- function num : 0_48 , upvalues : _ENV
  local already = false
  for _,v in pairs((TowerTopStageData.FormationInfo).yetUseCardIdList) do
    if tostring(v) == id then
      already = true
    end
  end
  return already
end

FormationWindow.IsFight = function(id, isSupportCard, playerIndex, ...)
  -- function num : 0_49 , upvalues : mFormationType, _ENV, FormationWindow, myselfFightDate, supportID
  if isSupportCard and mFormationType == FormationType.GuildBattle then
    return (FormationWindow.JudgeSupportIsFight)(id, playerIndex)
  end
  for _,v in pairs(myselfFightDate) do
    -- DECOMPILER ERROR at PC24: Unhandled construct in 'MakeBoolean' P1

    if mFormationType ~= FormationType.GuildBattle and v == id then
      return true
    end
    if v == id then
      if v == supportID then
        return isSupportCard
      else
        return true
      end
    end
  end
  return false
end

FormationWindow.onClickCard = function(cardData, showBtn, ...)
  -- function num : 0_50 , upvalues : _ENV, uis, FormationWindow
  print(cardData.id)
  local configData, isMonster = (CardData.GetBaseConfig)(cardData.id)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).CardCultivateBtn).visible = (not isMonster and showBtn)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).EquiptCultivateBtn).visible = (not isMonster and showBtn)
  ;
  (((uis.FormationTipsGrp).CardCultivateBtn).onClick):Set(function(...)
    -- function num : 0_50_0 , upvalues : _ENV, cardData
    (CardMgr.ClickCardResultByCardId)(cardData.id)
  end
)
  ;
  (((uis.FormationTipsGrp).EquiptCultivateBtn).onClick):Set(function(...)
    -- function num : 0_50_1 , upvalues : _ENV, cardData
    ld("Equipt", function(...)
      -- function num : 0_50_1_0 , upvalues : _ENV, cardData
      (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.ChangeRoldEquipts, cardData.id)
    end
)
  end
)
  ;
  (FormationWindow.SetInfoGrpHead)(cardData, isMonster)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).EquiptList).numItems = 0
  local equipInfo = cardData.equipInfo
  if equipInfo and #equipInfo > 0 then
    local equipInfoS = (Util.clone)(equipInfo)
    ;
    (table.sort)(equipInfoS, function(a, b, ...)
    -- function num : 0_50_2 , upvalues : _ENV, FormationWindow
    local AEquipData = ((TableData.gTable).BaseEquipData)[a.id]
    local BEquipData = ((TableData.gTable).BaseEquipData)[b.id]
    local ASort = (FormationWindow.GetEquipSort)(AEquipData.type)
    local BSort = (FormationWindow.GetEquipSort)(BEquipData.type)
    do return BSort < ASort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    local equipCount = #equipInfoS
    for i = 1, equipCount do
      local obj = UIMgr:CreateObject("CommonResource", "EquiptIcon")
      ;
      (Util.SetEquipFrame)(obj, equipInfoS[i])
      ;
      ((uis.FormationTipsGrp).EquiptList):AddChild(obj)
    end
  end
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).ContentList).numItems = 0
  local skillHeight = (FormationWindow.SetSkillInfo)(cardData, isMonster)
  local sHeight = 0
  local mHeight = 0
  local isLine = false
  local suitConfig = nil
  local buffList = {}
  if cardData.equipSet ~= nil then
    buffList = cardData.equipSet
  else
    buffList = cardData.equipSetsBuffList
  end
  if buffList ~= nil then
    for _,v in ipairs(buffList) do
      local setsId = (((TableData.gTable).BaseBuffPreBattleData)[v]).setsId
      local buffs = {}
      suitConfig = ((TableData.gTable).BaseEquipSetsData)[setsId]
      local suits = split(suitConfig.effect, ",")
      local count = #suits
      for i = 1, count do
        local buffId = tonumber((split(suits[i], ":"))[2])
        local buffType = tonumber((split(suits[i], ":"))[1])
        if buffType == 1 then
          buffs[i] = buffId
        else
          buffs[i] = 0
        end
      end
      local lowerId = (EquiptMgr.JudgeHaveLowerBuff)(buffs, buffList)
      local lowerIdCount = #lowerId
      for k,v in ipairs(lowerId) do
        (table.insert)(buffList, v)
      end
      if lowerIdCount ~= 0 then
        (table.sort)(buffList, function(a, b, ...)
    -- function num : 0_50_3 , upvalues : _ENV
    local aC = ((TableData.gTable).BaseBuffPreBattleData)[a]
    local bC = ((TableData.gTable).BaseBuffPreBattleData)[b]
    if b >= a then
      do return bC.sortId >= aC.sortId end
      do return a < b end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
      end
    end
    for _,v in ipairs(buffList) do
      do
        do
          if not isLine then
            local line = UIMgr:CreateObject("Formation", "Line")
            ;
            ((uis.FormationTipsGrp).ContentList):AddChild(line)
            isLine = true
          end
          ;
          (FormationWindow.SetSuitBuffInfo)(v, suitConfig.name)
          sHeight = sHeight + 70
          -- DECOMPILER ERROR at PC191: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  if not isMonster then
    for _,v in ipairs(cardData.equipInfo) do
      for _,v2 in ipairs(v.randomBuff) do
        (FormationWindow.SetEquipBuffInfo)(v2)
        mHeight = mHeight + 70
      end
    end
  end
  -- DECOMPILER ERROR at PC213: Confused about usage of register: R11 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).root).visible = true
  ;
  (GRoot.inst):AddCustomPopups((uis.FormationTipsGrp).root, function(...)
    -- function num : 0_50_4 , upvalues : uis
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.FormationTipsGrp).root).visible = false
  end
)
  local last = ((uis.FormationTipsGrp).ContentList).height
  local interval = (((uis.FormationTipsGrp).ContentList).numItems - 1) * ((uis.FormationTipsGrp).ContentList).lineGap
  if isLine then
    interval = interval + ((uis.FormationTipsGrp).ContentList).lineGap + 3
  end
  local current = (math.min)(skillHeight + (mHeight) + (interval) + (sHeight), 363)
  local gt = (GTween.To)(last, current, 0.3)
  gt:OnUpdate(function(...)
    -- function num : 0_50_5 , upvalues : uis, gt
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.FormationTipsGrp).ContentList).height = (gt.value).x
    ;
    ((uis.FormationTipsGrp).root):InvalidateBatchingState()
  end
)
  -- DECOMPILER ERROR: 18 unprocessed JMP targets
end

FormationWindow.GetEquipSort = function(part, ...)
  -- function num : 0_51 , upvalues : _ENV
  if part == EquiptPartsType.Necklace then
    return 4
  else
    if part == EquiptPartsType.Ring then
      return 3
    else
      if part == EquiptPartsType.Weapon then
        return 2
      else
        return 1
      end
    end
  end
end

FormationWindow.SetInfoGrpHead = function(cardData, isMonster, ...)
  -- function num : 0_52 , upvalues : _ENV, uis
  local cardInfo = {}
  cardInfo.id = cardData.id
  cardInfo.quality = cardData.quality
  cardInfo.star = cardData.star
  cardInfo.level = cardData.level
  cardInfo.fashionId = cardData.fashionId
  cardInfo.equipSet = cardData.equipSet
  ;
  (Util.SetHeadFrame)(((uis.FormationTipsGrp).HeadFrameGrp).root, cardInfo, isMonster)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).NameTxt).text = cardData.name
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).NumberTxt).text = cardData.fc
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).BattleNumberTxt).visible = not isMonster
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).NumberTxt).visible = not isMonster
  ;
  ((((uis.FormationTipsGrp).HeadFrameGrp).root):GetChild("LevelTxt")).visible = not isMonster
end

FormationWindow.SetEquipBuffInfo = function(buffID, ...)
  -- function num : 0_53 , upvalues : _ENV, uis
  local buffData = ((TableData.gTable).BaseBuffPreBattleData)[buffID]
  if not buffData then
    return 
  end
  local Buff = UIMgr:CreateObject("Formation", "EquiptSkill")
  ;
  (Buff:GetChild("EquiptWordTxt")).text = buffData.remark
  ;
  ((uis.FormationTipsGrp).ContentList):AddChild(Buff)
end

FormationWindow.SetSuitBuffInfo = function(buffId, title, ...)
  -- function num : 0_54 , upvalues : _ENV, uis
  local suitConfig = ((TableData.gTable).BaseBuffPreBattleData)[buffId]
  if not suitConfig then
    return 
  end
  local suit = UIMgr:CreateObject("Formation", "EquiptSkill")
  ;
  (suit:GetChild("EquiptWordTxt")).UBBEnabled = true
  ;
  (suit:GetChild("EquiptWordTxt")).text = "[color=" .. Const.GreenColor .. "]" .. (PUtil.get)(title) .. " - " .. suitConfig.remark .. "[/color]"
  ;
  ((uis.FormationTipsGrp).ContentList):AddChild(suit)
end

FormationWindow.SetSkillInfo = function(cardData, isMonster, ...)
  -- function num : 0_55 , upvalues : _ENV, FormationWindow
  local skillInfo = cardData.skillInfo
  local unique_skill_id, special_skill_id, ex_skill_id = nil, nil, nil
  local unique_skill_level = 0
  local special_skill_level = 0
  if isMonster then
    unique_skill_level = 1
    special_skill_level = 1
    local cardTable = (TableData.GetBaseMonsterData)(cardData.id)
    unique_skill_id = cardTable.unique_skill_id
    special_skill_id = cardTable.special_skill_id
    ex_skill_id = cardTable.ex_passiveSkillId
  else
    do
      local cardTable = ((TableData.gTable).BaseCardData)[cardData.id]
      unique_skill_id = cardTable.unique_skill_id
      special_skill_id = cardTable.special_skill_id
      ex_skill_id = cardTable.ex_passiveSkillId
      if skillInfo then
        for _,v in pairs(skillInfo) do
          if v.id == unique_skill_id then
            unique_skill_level = v.value
          else
            if v.id == special_skill_id then
              special_skill_level = v.value
            end
          end
        end
      end
      do
        local uniqueSkill, isChange = (CardData.JudgeSealSkillModify)(cardData.sealSkillInfo, unique_skill_id)
        local specialSkill, isChange2 = (CardData.JudgeSealSkillModify)(cardData.sealSkillInfo, special_skill_id)
        local exSkill, isChange3 = (CardData.JudgeSealSkillModify)(cardData.sealSkillInfo, ex_skill_id)
        local height = (FormationWindow.CreateSingleSkill)(uniqueSkill, unique_skill_level, true, cardData, isChange, false)
        local height2 = (FormationWindow.CreateSingleSkill)(specialSkill, special_skill_level, false, cardData, isChange2, false)
        local height3 = (FormationWindow.CreateSingleSkill)(exSkill, special_skill_level, false, cardData, isChange3, true)
        return height + height2 + height3
      end
    end
  end
end

FormationWindow.CreateSingleSkill = function(skillID, level, isUnique, cardData, isSealSkill, isExSkill, ...)
  -- function num : 0_56 , upvalues : _ENV, uis, FormationWindow
  if not skillID or skillID == 0 then
    return 0
  end
  local uniqueSkill = UIMgr:CreateObject("Formation", "CardSkill")
  local skillConfig = (TableData.GetBaseSkillData)(skillID)
  ;
  ((uniqueSkill:GetChild("SkillFrameGrp")):GetChild("SkillLoader")).url = (Util.GetResUrl)(skillConfig.icon_path)
  if isSealSkill then
    local parent = uniqueSkill:GetChild("SkillFrameGrp")
    local holder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_SEAL_TIPS_SHOW, true, parent, Vector2(parent.width / 2, parent.height / 2))
    ;
    (Util.SetSfxClipInList)((holder.displayObject).gameObject, (uis.FormationTipsGrp).ContentList)
  end
  do
    if isUnique then
      ChangeUIController(uniqueSkill:GetChild("SkillFrameGrp"), "c1", 2)
    else
      ChangeUIController(uniqueSkill:GetChild("SkillFrameGrp"), "c1", 1)
    end
    if isExSkill then
      ChangeUIController(uniqueSkill:GetChild("SkillFrameGrp"), "c1", 3)
    end
    ;
    (uniqueSkill:GetChild("CardWordTxt")).text = (FormationWindow.GetSkillRemark)(skillConfig, level, cardData)
    ;
    ((uis.FormationTipsGrp).ContentList):AddChild(uniqueSkill)
    return uniqueSkill.height
  end
end

FormationWindow.GetSkillRemark = function(skillData, level, cardData, ...)
  -- function num : 0_57 , upvalues : _ENV, FormationWindow
  local text = skillData.des_array
  local startIndex, endIndex, skillId = (string.find)(text, "damage_A_(%d+)")
  do
    if startIndex ~= nil then
      local skillData = (TableData.GetBaseSkillData)(tonumber(skillId))
      text = (string.gsub)(text, "damage_A_" .. skillId, (FormationWindow.Damage_A)(skillData))
    end
    startIndex = (string.find)(text, "damage_B_(%d+)")
    do
      if startIndex ~= nil then
        local skillData = (TableData.GetBaseSkillData)(tonumber(skillId))
        text = (string.gsub)(text, "damage_B_" .. skillId, (FormationWindow.Damage_B)(skillData, level))
      end
      if (string.find)(text, "damage_A") ~= nil then
        text = (string.gsub)(text, "damage_A", (FormationWindow.Damage_A)(skillData, skillData))
      end
      if (string.find)(text, "damage_B") ~= nil then
        text = (string.gsub)(text, "damage_B", (FormationWindow.Damage_B)(skillData, level))
      end
      if (string.find)(text, "damage_C1") ~= nil then
        text = (string.gsub)(text, "damage_C1", (FormationWindow.Damage_C)(skillData, 1, level))
      end
      if (string.find)(text, "damage_C2") ~= nil then
        text = (string.gsub)(text, "damage_C2", (FormationWindow.Damage_C)(skillData, 2, level))
      end
      if (string.find)(text, "damage_C3") ~= nil then
        text = (string.gsub)(text, "damage_C3", (FormationWindow.Damage_C)(skillData, 3, level))
      end
      if (string.find)(text, "damage_C4") ~= nil then
        text = (string.gsub)(text, "damage_C4", (FormationWindow.Damage_C)(skillData, 4, level))
      end
      if (string.find)(text, "damage_D") ~= nil then
        local str = (string.match)(text, "damage_D%d+")
        if str then
          str = (string.gsub)(str, "damage_D", "")
          local buffId = tonumber(str)
          text = (string.gsub)(text, "damage_D%d+", (FormationWindow.Damage_D)(buffId, level))
        end
      end
      do
        if (string.find)(text, "damage_E1") ~= nil then
          text = (string.gsub)(text, "damage_E1", (FormationWindow.Damage_E)(skillData, 1, cardData))
        end
        if (string.find)(text, "damage_E2") ~= nil then
          text = (string.gsub)(text, "damage_E2", (FormationWindow.Damage_E)(skillData, 2, cardData))
        end
        return text
      end
    end
  end
end

FormationWindow.Damage_A = function(skillData, ...)
  -- function num : 0_58 , upvalues : _ENV
  local number = 0
  number = ((math.abs)(skillData.damage_rate * 0.0001) + (math.abs)(skillData.damage_rate_up * 0.0001)) * 100
  local str = ""
  if number > 0 then
    str = tostring(number)
  end
  return (string.sub)(str, 1, -3)
end

FormationWindow.Damage_B = function(skillData, skillLevel, ...)
  -- function num : 0_59 , upvalues : _ENV
  local number = 0
  number = (math.abs)(skillData.damage) * (1 + (math.abs)(skillData.damage_up) * 0.0001 * skillLevel)
  local str = ""
  if number > 0 then
    str = "+" .. tostring(number)
  end
  return (string.sub)(str, 1, -3)
end

FormationWindow.Damage_C = function(skillData, cIndex, skillLevel, ...)
  -- function num : 0_60 , upvalues : _ENV
  local number = 0
  local attr = (split((split(skillData.add_attr, ","))[cIndex], ":"))[3]
  number = (math.abs)(attr) * skillLevel
  local str = ""
  if number > 0 then
    str = tostring(number)
  end
  local final = (string.sub)(str, 1, -3)
  return final
end

FormationWindow.Damage_D = function(buffId, skillLevel, ...)
  -- function num : 0_61 , upvalues : _ENV
  local number = 0
  local config = (TableData.GetBaseSkillBuffData)(buffId)
  local value_up = tonumber((split(config.value_up, ":"))[2])
  local ConstValue = tonumber((split(config.value_up, ":"))[3] or 0)
  number = (math.abs)(value_up) * skillLevel + ConstValue
  local str = ""
  if number > 0 then
    str = "+" .. tostring(number)
  end
  return str
end

FormationWindow.Damage_E = function(skillData, index, cardData, ...)
  -- function num : 0_62 , upvalues : _ENV
  local buffId = (split(skillData.star_config_id, ":"))[index]
  local buffData = (TableData.GetBaseSkillBuffData)(tonumber(buffId))
  local starConfig = buffData.star_config
  local starNums = split(starConfig, ":")
  local number = starNums[cardData.star]
  number = number * 0.01
  local str = ""
  if number > 0 then
    str = tostring(number)
  end
  local final = (string.sub)(str, 1, -3)
  return final
end

FormationWindow.InitInfoGrpBtn = function(...)
  -- function num : 0_63 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.FormationTipsGrp).CardCultivateBtn).text = (PUtil.get)(20000214)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.FormationTipsGrp).EquiptCultivateBtn).text = (PUtil.get)(20000215)
end

FormationWindow.onDragStart = function(Context, card, ...)
  -- function num : 0_64 , upvalues : FormationWindow, _ENV, ModelScale, DragDropManager, dragOffset, dragModelPos, dragSize, DragModel
  Context:PreventDefault()
  local data = card
  ;
  (FormationWindow.SetSelfFightAlphaAndTouch)(0.5, false)
  local model = (FormationWindow.CreateModel)(data.id, data.quality)
  ;
  (CSLuaUtil.SetGOScale)(model, ModelScale, ModelScale, ModelScale)
  ;
  (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.CATCH, true)
  ;
  (DragDropManager.inst):StartDrag(nil, model, card, Vector2(250, 250), dragOffset, -1, dragModelPos.x, dragModelPos.y, dragModelPos.z, dragSize)
  DragModel = model
  ;
  (LuaSound.PlaySound)(LuaSound.FORMATION_DRAG_START, SoundBank.OTHER)
end

FormationWindow.CreateModel = function(id, quality, ...)
  -- function num : 0_65 , upvalues : _ENV
  local fashionConfig = (CardData.GetFashionConfig)({id = id, quality = quality})
  local spdName = fashionConfig.spd_bundle
  return (ResHelper.InstantiateModel)(spdName)
end

FormationWindow.scrollOnDrag = function(EventContext, Card, ...)
  -- function num : 0_66 , upvalues : _ENV, FormationWindow, mFormationType, MustFightID, myselfFightDate, supportID
  local data = EventContext.data
  if type(data) == "number" then
    if (FormationWindow.GetFightNum)() <= 1 and mFormationType ~= FormationType.Edit then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000040))
    else
      if MustFightID > 0 and myselfFightDate[data] == MustFightID then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000213))
      else
        local cardID = myselfFightDate[data]
        if cardID == supportID then
          supportID = 0
        end
        myselfFightDate[data] = nil
        ;
        (FormationWindow.RefreshCardList)()
        ;
        (FormationWindow.RefreshMyselfFightList)({data})
        ;
        (LuaSound.PlaySound)(LuaSound.FORMATION_TO_CARDLIST, SoundBank.OTHER)
      end
    end
  end
end

FormationWindow.GetFightNum = function(...)
  -- function num : 0_67 , upvalues : myselfFightDate
  local count = 0
  for i = 1, 6 do
    if myselfFightDate[i] then
      count = count + 1
    end
  end
  return count
end

FormationWindow.GetFreePosNum = function(...)
  -- function num : 0_68 , upvalues : myselfFightDate
  local count = 0
  for i = 1, 6 do
    if myselfFightDate[i] == nil or myselfFightDate[i] == 0 then
      count = count + 1
    end
  end
  return count
end

FormationWindow.GetFightNum = function(...)
  -- function num : 0_69 , upvalues : _ENV, myselfFightDate
  local num = 0
  for _,v in pairs(myselfFightDate) do
    if v and v > 0 then
      num = num + 1
    end
  end
  return num
end

local currentTxt = {}
FormationWindow.AddFightDate = function(IsCard, startPos, endPos, BanVoice, isSupport, playerIndex, oldPos, ...)
  -- function num : 0_70 , upvalues : _ENV, mFormationType, ExpeditionListData, MaxFight, myselfFightDate, FormationWindow, saveInitCard, MustFightID, supportCardListDate, supportID, supportPlayerIndex
  if endPos > 6 or not IsCard and startPos > 6 then
    (MessageMgr.SendCenterTips)("此时应该有问题了")
    return 
  end
  if mFormationType == FormationType.Expedition and MaxFight <= #ExpeditionListData and IsCard and (myselfFightDate[endPos] == nil or (FormationWindow.FormationIsContainAlready)(myselfFightDate[endPos])) and not (FormationWindow.FormationIsContainAlready)((saveInitCard[startPos]).id) then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000181))
    return 
  end
  if IsCard and myselfFightDate[endPos] and MustFightID > 0 and myselfFightDate[endPos] == MustFightID then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000213))
    return 
  else
    if IsCard and MaxFight > 0 and MaxFight <= (FormationWindow.GetFightNum)() and myselfFightDate[endPos] == nil then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000181))
      return 
    end
  end
  local dragData = nil
  if IsCard then
    if isSupport then
      dragData = (Util.clone)((supportCardListDate[startPos]).id)
    else
      dragData = (Util.clone)((saveInitCard[startPos]).id)
    end
  else
    dragData = (Util.clone)(myselfFightDate[startPos])
  end
  if not BanVoice then
    local cardData = nil
    if isSupport then
      cardData = (FormationWindow.GetSupportOneCardData)(dragData, playerIndex)
    else
      cardData = (FormationWindow.GetOneCardDataByID)(dragData)
    end
    local config = (CardData.GetFashionConfig)({id = cardData.id, quality = cardData.quality, fashionId = cardData.fashionId})
    ;
    (AudioManager.DisposeCurAudioAndBubble)()
    ;
    (FormationWindow.CloseTalkCom)()
    ;
    (AudioManager.PlayBubbleAndVoice)(false, true, config.id, CVAudioType.ArrayUpBubble, nil, nil, nil, nil, nil, nil, function(...)
    -- function num : 0_70_0 , upvalues : FormationWindow
    (FormationWindow.CloseTalkCom)()
  end
, true)
    ;
    (FormationWindow.PlayTalkTxt)(config.id, endPos)
  end
  do
    if myselfFightDate[endPos] == nil then
      if not IsCard then
        myselfFightDate[startPos] = nil
      end
      myselfFightDate[endPos] = dragData
    else
      if IsCard then
        if myselfFightDate[endPos] ~= nil and myselfFightDate[endPos] == supportID then
          supportID = 0
        end
        myselfFightDate[endPos] = dragData
      else
        local receiveDate = (Util.clone)(myselfFightDate[endPos])
        myselfFightDate[endPos] = dragData
        myselfFightDate[startPos] = receiveDate
      end
    end
    do
      if isSupport then
        do
          if supportID and supportID > 0 then
            local supPos = (FormationWindow.GetSupportIDPos)()
            if oldPos ~= endPos and oldPos > 0 then
              myselfFightDate[oldPos] = nil
            end
          end
          supportID = dragData
          supportPlayerIndex = playerIndex
        end
      end
    end
  end
end

FormationWindow.GetSupportIDPos = function(...)
  -- function num : 0_71 , upvalues : myselfFightDate, supportID
  for i = 1, 6 do
    if myselfFightDate[i] and myselfFightDate[i] == supportID then
      return i
    end
  end
end

FormationWindow.PlayTalkTxt = function(fashionID, endPos, ...)
  -- function num : 0_72 , upvalues : _ENV, FormationWindow, grpTalkCom, uis, currentTxt
  local excelData = ((TableData.gTable).BaseFashionData)[fashionID]
  if excelData then
    local ids = split(excelData.arrayup_bubble_ids, ":")
    local bubbleId = tonumber(ids[1])
    local bubbleData = ((TableData.gTable).BaseFashionBubbleData)[bubbleId]
    local mSelf = (FormationWindow.GetModelTemplate)(true, endPos)
    local baseTalk = (mSelf:GetChild("Talk"))
    local talk = nil
    if grpTalkCom[mSelf.uid] == nil then
      talk = UIMgr:CreateObject((WinResConfig.FormationWindow).package, "Talk")
      talk.touchable = false
      ;
      (uis.root):AddChildAt(talk, (uis.root):GetChildIndex((uis.FormationTipsGrp).root) - 1)
      grpTalkCom[mSelf.uid] = talk
    end
    talk = grpTalkCom[mSelf.uid]
    if talk ~= nil then
      talk.x = mSelf.x + baseTalk.x
      talk.y = mSelf.y + baseTalk.y
      talk.visible = true
      local mText = talk:GetChild("TalkTxt")
      local bg = talk:GetChild("n3")
      mText.text = bubbleData.bubble_text
      PlayUITrans(talk, "in")
      ;
      (table.insert)(currentTxt, endPos)
    end
  end
end

FormationWindow.GetMaxSortingOrder = function(...)
  -- function num : 0_73 , upvalues : mFormationType, _ENV, uis
  if mFormationType == FormationType.Single or mFormationType == FormationType.Edit then
    return ((uis.ArenaNumber_02_Txt).displayObject).renderingOrder
  else
    if mFormationType == FormationType.CG then
      return (((uis.root):GetChild("TipsTxt")).displayObject).renderingOrder
    else
      return ((uis.Number_02_Txt).displayObject).renderingOrder
    end
  end
end

FormationWindow.CloseTalkCom = function(...)
  -- function num : 0_74 , upvalues : _ENV, currentTxt, FormationWindow, grpTalkCom
  for i,v in ipairs(currentTxt) do
    local mSelf = (FormationWindow.GetModelTemplate)(true, v)
    do
      local talk = grpTalkCom[mSelf.uid]
      PlayUITrans(talk, "out", function(...)
    -- function num : 0_74_0 , upvalues : talk
    (talk:GetChild("TalkTxt")).alpha = 0
  end
)
    end
  end
  currentTxt = {}
end

FormationWindow.RefreshEnemyFightList = function(formationData, ...)
  -- function num : 0_75 , upvalues : mFormationType, _ENV, enemyLoaderList, enemyIsCustom, enemyFightDate, FormationWindow, uis, recordEnemyFc, battleType, stageID
  if mFormationType == FormationType.Single or mFormationType == FormationType.Edit then
    return 
  end
  enemyLoaderList = {}
  local fight = 0
  for i = 1, 6 do
    if enemyIsCustom then
      if enemyFightDate[i] then
        (FormationWindow.CreateFightCard)(false, (enemyFightDate[i]).fashionId, i, true)
      else
        ;
        (FormationWindow.CreateFightCard)(false, nil, i, true)
      end
      if enemyFightDate[i] then
        fight = fight + (enemyFightDate[i]).fc
      end
    else
      ;
      (FormationWindow.CreateFightCard)(false, enemyFightDate[i], i, true)
      if enemyFightDate[i] then
        local monster = (TableData.GetBaseMonsterData)(tonumber(enemyFightDate[i]))
        fight = fight + monster.fc
      end
    end
  end
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

  if formationData.tureEnemyFC then
    (uis.Number_02_Txt).text = formationData.tureEnemyFC
    recordEnemyFc = fight
  else
    local configData = nil
    if battleType == (ProtoEnum.E_BATTLE_TYPE).EXPEDITION then
      configData = ((TableData.gTable).BaseExpeditionStageData)[stageID]
    else
      if battleType == (ProtoEnum.E_BATTLE_TYPE).ADVENTURE then
        configData = ((TableData.gTable).BaseAdventureNodeData)[stageID]
      end
    end
    local percent = 1
    if formationData.FCFactor ~= nil then
      fight = (math.ceil)((fight) * formationData.FCFactor * 0.0001)
    else
      if configData and configData.fc_show then
        percent = configData.fc_show / 10000
      end
    end
    -- DECOMPILER ERROR at PC119: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.Number_02_Txt).text = (math.floor)(fight * (percent))
    recordEnemyFc = (uis.Number_02_Txt).text
  end
end

FormationWindow.RefreshMyselfFightList = function(list, ...)
  -- function num : 0_76 , upvalues : FormationWindow, myselfFightDate, _ENV, mFormationType, uis
  local fight = 0
  local luck = 0
  local isHaveFight = false
  local data = list
  local isInit = false
  if #data <= 0 then
    isInit = true
    for i = 1, 6 do
      (FormationWindow.CreateFightCard)(true, myselfFightDate[i], i, true)
    end
  else
    do
      isInit = false
      for _,v in ipairs(data) do
        (FormationWindow.CreateFightCard)(true, myselfFightDate[tonumber(v)], tonumber(v), false)
      end
      do
        for i = 1, 6 do
          if myselfFightDate[i] and myselfFightDate[i] > 0 then
            local oneCard = (FormationWindow.GetOneCardDataByID)(tonumber(myselfFightDate[i]))
            fight = fight + oneCard.fc
            isHaveFight = true
            if mFormationType == FormationType.Tower or mFormationType == FormationType.TowerExpand then
              luck = luck + oneCard.luck
            end
          end
        end
        do
          do
            if mFormationType == FormationType.Tower or mFormationType == FormationType.TowerExpand then
              local lastLuck = tonumber((uis.Tower_02_Txt).text)
              if isInit or lastLuck == luck then
                (FormationWindow.SetLuckArrow)(false, false)
              else
                if luck < lastLuck then
                  (FormationWindow.SetLuckArrow)(false, true)
                else
                  ;
                  (FormationWindow.SetLuckArrow)(true, false)
                end
              end
              -- DECOMPILER ERROR at PC105: Confused about usage of register: R7 in 'UnsetPending'

              ;
              (uis.Tower_02_Txt).text = luck
            end
            -- DECOMPILER ERROR at PC117: Confused about usage of register: R6 in 'UnsetPending'

            if mFormationType == FormationType.Single or mFormationType == FormationType.Edit then
              (uis.ArenaNumber_01_Txt).text = fight
            else
              -- DECOMPILER ERROR at PC120: Confused about usage of register: R6 in 'UnsetPending'

              ;
              (uis.Number_01_Txt).text = fight
            end
            if mFormationType ~= FormationType.Edit then
              if isHaveFight then
                ChangeUIController((uis.HeadListGrp).BattleStartBtn, "c1", 0)
              else
                ChangeUIController((uis.HeadListGrp).BattleStartBtn, "c1", 1)
              end
              -- DECOMPILER ERROR at PC143: Confused about usage of register: R6 in 'UnsetPending'

              ;
              ((uis.HeadListGrp).BattleStartBtn).touchable = isHaveFight
            else
              ChangeUIController((uis.HeadListGrp).BattleStartBtn, "c1", 0)
              -- DECOMPILER ERROR at PC153: Confused about usage of register: R6 in 'UnsetPending'

              ;
              ((uis.HeadListGrp).BattleStartBtn).touchable = true
            end
            ;
            (FormationWindow.SortSpeList)()
            ;
            (FormationWindow.RefreshSpeedSort)()
          end
        end
      end
    end
  end
end

FormationWindow.GetOneCardDataByID = function(id, ...)
  -- function num : 0_77 , upvalues : mFormationType, _ENV, supportID, cardListDate, saveInitCard, supportCardListDate, supportPlayerIndex
  if mFormationType ~= FormationType.GuildBattle or id ~= supportID then
    local mCardList = cardListDate
    if mFormationType == FormationType.GuildBattle then
      mCardList = saveInitCard
    end
    for _,v in pairs(mCardList) do
      if v.id ~= nil and v.id == id then
        return v
      end
    end
  else
    do
      for _,v in ipairs(supportCardListDate) do
        if v.id == id and v.playerIndex == supportPlayerIndex then
          return v
        end
      end
    end
  end
end

FormationWindow.GetSupportOneCardData = function(id, playerIndex, ...)
  -- function num : 0_78 , upvalues : _ENV, supportCardListDate
  for _,v in ipairs(supportCardListDate) do
    if v.id == id and v.playerIndex == playerIndex then
      return v
    end
  end
end

FormationWindow.SetLuckArrow = function(green, red, ...)
  -- function num : 0_79 , upvalues : uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (uis.RedImage).visible = red
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.GreenImage).visible = green
end

FormationWindow.SortSpeList = function(...)
  -- function num : 0_80 , upvalues : speedSort, _ENV, myselfFightDate, FormationWindow, enemyFightDate, enemyIsCustom
  speedSort = {}
  for i,v in pairs(myselfFightDate) do
    if v then
      local card = (FormationWindow.GetOneCardDataByID)(v)
      if card then
        (table.insert)(speedSort, {spd = card.spd, isSelf = true, Pos = i, id = tonumber(v)})
      end
    end
  end
  for i2,v2 in pairs(enemyFightDate) do
    if v2 then
      if enemyIsCustom then
        local monster = v2
        if monster then
          (table.insert)(speedSort, {spd = monster.spd, isSelf = false, Pos = i2, id = tonumber(monster.fashionId)})
        end
      else
        do
          do
            local monster = (TableData.GetBaseMonsterData)(tonumber(v2))
            if monster then
              (table.insert)(speedSort, {spd = monster.spd, isSelf = false, Pos = i2, id = tonumber(v2)})
            end
            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  ;
  (table.sort)(speedSort, FormationWindow.CustomSort)
end

FormationWindow.GetSpeedSort = function(cardId, isSelf, ...)
  -- function num : 0_81 , upvalues : _ENV, speedSort
  if type(cardId) == "number" or type(cardId) == "string" then
    for i,v in ipairs(speedSort) do
      if v.id == tonumber(cardId) and v.isSelf == isSelf then
        return i
      end
    end
  else
    do
      local data = cardId
      for i,v in ipairs(speedSort) do
        if v.isSelf == isSelf and v.spd == data.spd and v.id == data.fashionId then
          return i
        end
      end
    end
  end
end

FormationWindow.CustomSort = function(a, b, ...)
  -- function num : 0_82
  local aSelf = 0
  local bSelf = 0
  if a.isSelf then
    aSelf = 0.1
  end
  if b.isSelf then
    bSelf = 0.1
  end
  do return b.spd + bSelf + (6 - b.Pos) * 0.01 < a.spd + aSelf + (6 - a.Pos) * 0.01 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FormationWindow.RefreshSpeedSort = function(...)
  -- function num : 0_83 , upvalues : FormationWindow, myselfFightDate, enemyFightDate, _ENV, mFormationType, enemyIsCustom
  for i = 1, 6 do
    local selfModel = (FormationWindow.GetModelTemplate)(true, i)
    local enemyModel = (FormationWindow.GetModelTemplate)(false, i)
    local selfId = myselfFightDate[i]
    local enemy = enemyFightDate[i]
    if selfId and tonumber(selfId) > 0 then
      (FormationWindow.SetSpeedSort)(selfModel, true, selfId)
    else
      ;
      (FormationWindow.SetSpeedFrameShow)(GetFormation_ModelTemplateUis(selfModel), false, false)
    end
    if mFormationType ~= FormationType.Single and mFormationType ~= FormationType.Edit then
      if not enemyIsCustom and enemy and tonumber(enemy) > 0 then
        (FormationWindow.SetSpeedSort)(enemyModel, false, enemy)
      else
        if enemyIsCustom and enemy and enemy.fashionId and tonumber(enemy.fashionId) > 0 then
          (FormationWindow.SetSpeedSort)(enemyModel, false, enemy)
        else
          ;
          (FormationWindow.SetSpeedFrameShow)(GetFormation_ModelTemplateUis(enemyModel), false, false)
        end
      end
    end
  end
end

FormationWindow.SetSpeedSort = function(model, isSelf, cardId, ...)
  -- function num : 0_84 , upvalues : _ENV, FormationWindow
  local template = GetFormation_ModelTemplateUis(model)
  if isSelf then
    (FormationWindow.SetSpeedFrameShow)(template, true, false)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (template.OrderMyTxt).text = (FormationWindow.GetSpeedSort)(cardId, isSelf)
  else
    ;
    (FormationWindow.SetSpeedFrameShow)(template, false, true)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (template.OrderEnemyTxt).text = (FormationWindow.GetSpeedSort)(cardId, isSelf)
  end
end

FormationWindow.SetSpeedFrameShow = function(model, Self, enemy, ...)
  -- function num : 0_85
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (model.OrderImage).visible = Self or enemy
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (model.OrderMyTxt).visible = Self
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (model.OrderEnemyTxt).visible = enemy
end

FormationWindow.CreateFightCard = function(isSelf, card, pos, IsInit, ...)
  -- function num : 0_86 , upvalues : _ENV, FormationWindow, mFormationType, supportID, isTouching, grpTalkCom, currentTxt, selfLoaderList, putHolder, sfxOffsetPos, enemyLoaderList, enemyIsCustom
  local cardId = tonumber(card)
  local template = (FormationWindow.GetModelTemplate)(isSelf, pos)
  local fightModel = GetFormation_ModelTemplateUis(template)
  local ModelLoader = (fightModel.MonsterLoader).ModelLoader
  local shadow = ((fightModel.MonsterLoader).root):GetChild("Decorate_01_Image")
  if cardId ~= supportID then
    (template:GetChild("SupportImage")).visible = mFormationType ~= FormationType.GuildBattle
    ModelLoader.draggable = false
    ;
    (ModelLoader.onDragStart):Clear()
    ;
    (((fightModel.MonsterLoader).root).onDrop):Clear()
    if isSelf then
      if cardId ~= nil and cardId > 0 then
        ModelLoader.touchable = true
        ModelLoader.draggable = true
        ;
        (LuaSound.PlaySound)(LuaSound.FORMATION_DRAG_END, SoundBank.OTHER)
      else
        ModelLoader.touchable = false
      end
      ;
      (ModelLoader.onDragStart):Set(function(Context, ...)
    -- function num : 0_86_0 , upvalues : isTouching, FormationWindow, pos
    if isTouching then
      return 
    end
    ;
    (FormationWindow.onDragFightStart)(Context, pos)
  end
)
      ;
      (((fightModel.MonsterLoader).root).onDrop):Set(function(eventContext, ...)
    -- function num : 0_86_1 , upvalues : FormationWindow, pos
    (FormationWindow.onDropFight)(eventContext, pos)
  end
)
    end
    shadow.visible = cardId ~= nil and cardId > 0
    ;
    (FormationWindow.OnDestroyModel)(ModelLoader)
    do
      if cardId == nil or cardId <= 0 then
        local talk = grpTalkCom[template.uid]
        if talk and (talk:GetChild("TalkTxt")).alpha > 0.95 and not IsInit and isSelf then
          PlayUITrans(talk, "out")
          for i,v in ipairs(currentTxt) do
            if v == pos then
              (table.remove)(currentTxt, i)
            end
          end
        end
        return 
      end
      local waitTime = pos * 0.1
      if IsInit ~= true then
        waitTime = 0
      else
        waitTime = 0.2
      end
      ;
      (SimpleTimer.setTimeout)(waitTime, function(...)
    -- function num : 0_86_2 , upvalues : _ENV, isSelf, FormationWindow, cardId, selfLoaderList, pos, ModelLoader, fightModel, IsInit, putHolder, template, sfxOffsetPos, enemyLoaderList, enemyIsCustom
    if UIMgr:IsWindowOpen((WinResConfig.FormationWindow).name) ~= true then
      return 
    end
    if isSelf then
      local cardData = (FormationWindow.GetOneCardDataByID)(cardId)
      selfLoaderList[pos] = ModelLoader
      ;
      (Util.ShowUIModelByFashionId)(cardData.id, cardData.quality, cardData.fashionId, ModelLoader, true, function(model, ...)
      -- function num : 0_86_2_0 , upvalues : FormationWindow, fightModel, _ENV, IsInit, putHolder, template, sfxOffsetPos
      if model == nil then
        return 
      end
      ;
      (FormationWindow.AddSmokeEvent)(model, (fightModel.MonsterLoader).root)
      ;
      (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.LAND, false, function(...)
        -- function num : 0_86_2_0_0 , upvalues : _ENV, model
        (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.IDLE, true)
      end
)
      if IsInit then
        (LuaEffect.PlayEffectByHolder)(putHolder, template, sfxOffsetPos)
        ;
        (CSLuaUtil.SetGOScale)(model, 20, 20, 20)
      end
    end
)
    else
      do
        enemyLoaderList[pos] = ModelLoader
        if enemyIsCustom then
          (Util.CreateMiniModel)(ModelLoader, cardId, function(model, ...)
      -- function num : 0_86_2_1 , upvalues : FormationWindow, fightModel, _ENV, cardId
      (FormationWindow.AddSmokeEvent)(model, (fightModel.MonsterLoader).root)
      ;
      (SkeletonAnimationUtil.SetFlip)(model, true, false)
      ;
      (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.LAND, false, function(...)
        -- function num : 0_86_2_1_0 , upvalues : _ENV, model
        (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.IDLE, true)
      end
)
      local fashionData = ((TableData.gTable).BaseFashionData)[cardId]
      if fashionData.scale then
        local scale = fashionData.scale / 10000 * 20
        ;
        (CSLuaUtil.SetGOScale)(model, scale, scale, scale)
      end
    end
)
        else
          ;
          (Util.ShowUIModelByFashionId)(cardId, 0, nil, ModelLoader, true, function(model, ...)
      -- function num : 0_86_2_2 , upvalues : _ENV, cardId, FormationWindow, fightModel
      local config = (CardData.GetFashionConfig)({id = cardId, quality = 0, fashionId = nil})
      ;
      (FormationWindow.AddSmokeEvent)(model, (fightModel.MonsterLoader).root)
      ;
      (SkeletonAnimationUtil.SetFlip)(model, true, false)
      ;
      (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.LAND, false, function(...)
        -- function num : 0_86_2_2_0 , upvalues : _ENV, model
        (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.IDLE, true)
      end
)
      if config and config.scale then
        local scale = config.scale / 10000 * 20
        ;
        (CSLuaUtil.SetGOScale)(model, scale, scale, scale)
      else
        do
          local scale = 20
          ;
          (CSLuaUtil.SetGOScale)(model, scale, scale, scale)
        end
      end
    end
)
        end
      end
    end
  end
)
      -- DECOMPILER ERROR: 13 unprocessed JMP targets
    end
  end
end

FormationWindow.GetModelTemplate = function(isSelf, pos, ...)
  -- function num : 0_87 , upvalues : mFormationType, _ENV, uis
  local posName = nil
  if mFormationType == FormationType.Single or mFormationType == FormationType.Edit then
    posName = "ArenaSelf_0" .. pos .. "_Grp"
  else
    if isSelf then
      posName = "Self_0" .. pos .. "_Grp"
    else
      pos = pos - 1
      posName = "Enemy_0" .. pos .. "_Grp"
    end
  end
  return (uis.root):GetChild(posName)
end

FormationWindow.AddSmokeEvent = function(model, parent, ...)
  -- function num : 0_88 , upvalues : _ENV
  local callback = nil
  callback = function(trackEntry, event, ...)
    -- function num : 0_88_0 , upvalues : _ENV, parent, model, callback
    if (event.Data).Name == "smoke" then
      (LuaEffect.CreateEffectToObj)(BattleEffectEnum.COMMON_FALLDOWN_SMOKE, true, parent, (Vector2(parent.width / 2, parent.height)), nil, 14)
      ;
      (SkeletonAnimationUtil.RemoveEvent)(model, callback)
    end
  end

  ;
  (SkeletonAnimationUtil.RemoveEvent)(model, callback)
  ;
  (SkeletonAnimationUtil.AddEvent)(model, callback)
end

FormationWindow.OnDestroyModel = function(loader, ...)
  -- function num : 0_89 , upvalues : _ENV
  if loader.Model then
    loader.alpha = 1
    ;
    (Util.RecycleUIModel)(loader)
  end
end

FormationWindow.onDragFightStart = function(Context, pos, ...)
  -- function num : 0_90 , upvalues : myselfFightDate, FormationWindow, _ENV, ModelScale, DragDropManager, dragOffset, dragModelPos, dragSize, DragModel
  Context:PreventDefault()
  local data = myselfFightDate[pos]
  local cardDate = (FormationWindow.GetOneCardDataByID)(data)
  ;
  (FormationWindow.SetSelfFightAlphaAndTouch)(0.5, false)
  local model = (FormationWindow.CreateModel)(cardDate.id, cardDate.quality)
  ;
  (CSLuaUtil.SetGOScale)(model, ModelScale, ModelScale, ModelScale)
  ;
  (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.CATCH, true)
  ;
  (DragDropManager.inst):StartDrag(nil, model, pos, Vector2(250, 250), dragOffset, -1, dragModelPos.x, dragModelPos.y, dragModelPos.z, dragSize)
  DragModel = model
  ;
  (LuaSound.PlaySound)(LuaSound.FORMATION_DRAG_START, SoundBank.OTHER)
end

FormationWindow.onDropFight = function(eventContext, pos, ...)
  -- function num : 0_91 , upvalues : _ENV, FormationWindow, supportID
  local startData = eventContext.data
  if type(startData) ~= "number" then
    local cardData = startData
    local isSupport = (FormationWindow.CardDataIsSupport)(cardData)
    if (FormationWindow.IsFight)(cardData.id, isSupport, cardData.playerIndex) then
      local cardStartPos = (FormationWindow.GetCardPosByID)(cardData.id)
      ;
      (FormationWindow.AddFightDate)(false, cardStartPos, pos)
      ;
      (FormationWindow.RefreshMyselfFightList)({cardStartPos, pos})
    else
      do
        local cardStartPos = nil
        if isSupport then
          cardStartPos = (FormationWindow.GetSupportCardListPosByID)(cardData.id, cardData.playerIndex)
        else
          cardStartPos = (FormationWindow.GetCardListPosByID)(cardData.id)
        end
        do
          local supPos = 0
          if supportID and supportID > 0 and isSupport then
            supPos = (FormationWindow.GetSupportIDPos)()
          end
          ;
          (FormationWindow.AddFightDate)(true, cardStartPos, pos, false, isSupport, cardData.playerIndex, supPos)
          if supPos > 0 then
            (FormationWindow.RefreshMyselfFightList)({pos, supPos})
          else
            ;
            (FormationWindow.RefreshMyselfFightList)({pos})
          end
          ;
          (FormationWindow.AddFightDate)(false, startData, pos)
          if startData == pos then
            (FormationWindow.RefreshMyselfFightList)({startData})
          else
            ;
            (FormationWindow.RefreshMyselfFightList)({startData, pos})
          end
          ;
          (FormationWindow.RefreshCardList)()
        end
      end
    end
  end
end

FormationWindow.RefreshCardList = function(...)
  -- function num : 0_92 , upvalues : mFormationType, _ENV, FormationWindow, uis
  if mFormationType ~= FormationType.GuildBattle then
    (FormationWindow.RefreshCard)()
  else
    local select = ((uis.HeadListGrp).c1Ctr).selectedIndex
    if select == 2 then
      (FormationWindow.RefreshSupportCard)()
    else
      ;
      (FormationWindow.RefreshCard)()
    end
  end
end

FormationWindow.CardDataIsSupport = function(cardData, ...)
  -- function num : 0_93
  do return cardData.used ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FormationWindow.GetCardPosByID = function(id, ...)
  -- function num : 0_94 , upvalues : myselfFightDate, _ENV
  for i = 1, 6 do
    if myselfFightDate[i] == tonumber(id) then
      return i
    end
  end
end

FormationWindow.GetCardListPosByID = function(id, ...)
  -- function num : 0_95 , upvalues : saveInitCard, _ENV
  local mList = saveInitCard
  for i,v in ipairs(mList) do
    if v.id ~= nil and v.id == id then
      return i
    end
  end
end

FormationWindow.GetSupportCardListPosByID = function(id, playerIndex, ...)
  -- function num : 0_96 , upvalues : _ENV, supportCardListDate
  for i,v in ipairs(supportCardListDate) do
    if v.id ~= nil and v.id == id and v.playerIndex == playerIndex then
      return i
    end
  end
end

FormationWindow.OnShown = function(...)
  -- function num : 0_97
end

FormationWindow.OnHide = function(...)
  -- function num : 0_98
end

FormationWindow.OnClose = function(...)
  -- function num : 0_99 , upvalues : _ENV, DragModel, DragDropManager, enemyLoaderList, FormationWindow, selfLoaderList, grpTalkCom, mFormationData, supportID, supportPlayerIndex, myselfFightDate, enemyFightDate, alreadyCard, MaxFight, ExpeditionListData, appaySfx, putHolder, uis, contentPane, scrollList, cardListDate, speedSort, selfGrp, _gestureDic, bgModel, currentTxt, expeditionSweep
  (BattleBackground.ClearBackground)(true)
  DragModel = nil
  local dragAgent = (DragDropManager.inst).dragAgent
  if not (Util.IsNil)(dragAgent) then
    ((CS.RTManager).Singleton):ReleaseModelFromLoader(dragAgent)
  end
  ;
  (DragDropManager.inst):Cancel()
  print("close window")
  for _,v in pairs(enemyLoaderList) do
    (FormationWindow.OnDestroyModel)(v)
  end
  for _,v in pairs(selfLoaderList) do
    (FormationWindow.OnDestroyModel)(v)
  end
  for k,v in pairs(grpTalkCom) do
    if v then
      v:Dispose()
    end
  end
  grpTalkCom = {}
  if mFormationData.formationType == FormationType.GuildBattle then
    if supportID > 0 then
      local card = (FormationWindow.GetSupportOneCardData)(supportID, supportPlayerIndex)
      for k,v in pairs(myselfFightDate) do
        if v == card.id then
          myselfFightDate[k] = nil
          break
        end
      end
    end
    do
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (MessageMgr.formationData).myselfList = myselfFightDate
      ;
      (GuildBossMgr.SaveCardList)(myselfFightDate, supportID, supportPlayerIndex)
      -- DECOMPILER ERROR at PC93: Confused about usage of register: R1 in 'UnsetPending'

      if FormationPresetData then
        FormationPresetData.FormationData = nil
      end
      selfLoaderList = {}
      enemyLoaderList = {}
      myselfFightDate = {nil, nil, nil, nil, nil, nil}
      enemyFightDate = {nil, nil, nil, nil, nil, nil}
      alreadyCard = {}
      MaxFight = 0
      ExpeditionListData = nil
      ;
      (GRoot.inst):ClearCustomPopups()
      ;
      (CommonWinMgr.RemoveAssets)((WinResConfig.FormationWindow).name)
      ;
      (LuaEffect.DestroyEffect)(appaySfx)
      ;
      (LuaEffect.DestroyEffect)(putHolder)
      -- DECOMPILER ERROR at PC132: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (GRoot.inst).IgnoreItemClick = true
      uis = {}
      contentPane = nil
      scrollList = nil
      cardListDate = {}
      speedSort = {}
      selfGrp = nil
      appaySfx = nil
      putHolder = nil
      _gestureDic = {}
      ;
      (ResHelper.DestroyGameObject)(bgModel, false)
      ;
      (Util.SetCameraActive)(Game.battleCamera, false)
      bgModel = nil
      ;
      (GuideData.AbolishControlRefer)((WinResConfig.FormationWindow).name)
      ;
      (AudioManager.DisposeCurAudioAndBubble)()
      currentTxt = {}
      expeditionSweep = 0
    end
  end
end

FormationWindow.InitAsset = function(formationData, ...)
  -- function num : 0_100 , upvalues : _ENV, uis, battleType, myselfFightDate, supportID, supportPlayerIndex, FormationWindow
  local m = {}
  m.windowName = (WinResConfig.FormationWindow).name
  m.Tip = (PUtil.get)(20000035)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {}
  m.isShowConfirm = formationData.isShowConfirmWindow
  m.ConfirmContent = formationData.confirmContent
  m.isSelfClose = formationData.isSelfClose
  if formationData.formationType ~= FormationType.Edit and battleType ~= (ProtoEnum.E_BATTLE_TYPE).CG then
    m.Formation = function(...)
    -- function num : 0_100_0 , upvalues : _ENV, myselfFightDate
    return (Util.CovertLoaclFormationToRemoteTight)(myselfFightDate)
  end

  end
  m.CloseBtnFun = function(...)
    -- function num : 0_100_1 , upvalues : formationData, myselfFightDate, supportID, supportPlayerIndex
    if formationData.closeFun then
      (formationData.closeFun)(myselfFightDate, supportID, supportPlayerIndex)
    end
  end

  m.BackBtnFun = function(...)
    -- function num : 0_100_2 , upvalues : formationData, myselfFightDate, supportID, supportPlayerIndex
    if formationData.backFun then
      (formationData.backFun)(myselfFightDate, supportID, supportPlayerIndex)
    end
  end

  if formationData.formationType == FormationType.Expedition then
    m.ExternalData = {}
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (m.ExternalData).Type = FormationType.Expedition
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (m.ExternalData).GetCardStatus = FormationWindow.GetCardState
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (m.ExternalData).GetAvailableCount = FormationWindow.GetAvailableCount
  else
    if formationData.formationType == FormationType.Relic then
      m.ExternalData = {}
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (m.ExternalData).Type = FormationType.Relic
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (m.ExternalData).GetCardStatus = RelicData.GetRelicCardState
    end
  end
  m.explainFunc = function(...)
    -- function num : 0_100_3 , upvalues : _ENV
    local wordID = nil
    local windowNameData = (TableData.gTable).BaseWindowNameData
    for _,v in pairs(windowNameData) do
      if v.window_name == (WinResConfig.FormationWindow).name then
        if (Util.StringIsNullOrEmpty)(v.rule_des) then
          return 
        end
        local cons = (Util.ParseConfigStr)(v.rule_des)
        for _,v in ipairs(cons) do
          local functionID = tonumber(v[1])
          if functionID == 0 or (FunctionControlMgr.GetFunctionState)(functionID) then
            wordID = tonumber(v[2])
            break
          end
        end
      end
    end
    if wordID and wordID > 0 then
      local ruleDes = (PUtil.get)(tonumber(wordID))
      OpenWindow((WinResConfig.BuffInfoWindow).name, UILayer.HUD1, tostring(ruleDes))
    else
      do
        OpenWindow((WinResConfig.BuffInfoWindow).name, UILayer.HUD1)
      end
    end
  end

  ;
  (CommonWinMgr.RegisterAssets)(m)
end

FormationWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_101 , upvalues : _ENV, myselfFightDate, FormationWindow, uis
  if msgId == (WindowMsgEnum.FormationPreset).E_MSG_REFRESH_FORMATION then
    myselfFightDate = para
    ;
    (FormationWindow.RefreshCard)()
    ;
    (FormationWindow.RefreshMyselfFightList)({})
  else
    if msgId == (WindowMsgEnum.FormationPreset).E_MSG_REFRESH then
      (FormationWindow.CloseTalkCom)()
      ;
      (FormationWindow.Refresh)()
    else
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

      if msgId == (WindowMsgEnum.FormationPreset).E_MSG_REFRESH_PRESET_NAME then
        (FormationPresetData.FormationData).presetName = para
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((uis.TeamName).NameTxt).text = para
      end
    end
  end
end

return FormationWindow

