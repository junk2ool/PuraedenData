-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_BattlePreviewWindowByName")
local RelicBattlePreviewWindow = {}
local uis, contentPane, bridge, argTable, stageId = nil, nil, nil, nil, nil
local TempleType = {Normal = 1, Elite = 2, Hero = 3}
local templeType = nil
local LEVELLIMIT = (((TableData.gTable).BaseFixedData)[Const.RELIC_LVL_LIMIT]).int_value
RelicBattlePreviewWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, uis, stageId, templeType, RelicBattlePreviewWindow
  bridgeObj:SetView((WinResConfig.RelicBattlePreviewWindow).package, (WinResConfig.RelicBattlePreviewWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetRelic_BattlePreviewWindowUis(contentPane)
  stageId = argTable[1] or nil
  ;
  (RelicData.GetRelicClickStageId)(stageId)
  local templeData = (RelicMgr.GetTempleData)(stageId)
  templeType = templeData.type
  ;
  (RelicData.GetCurClickedStageType)(templeType)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.BattlePreview).c1Ctr).selectedIndex = templeType - 1
  ;
  (RelicBattlePreviewWindow.RefreshWindow)()
end

RelicBattlePreviewWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV, stageId, uis, templeType, TempleType, RelicBattlePreviewWindow
  local stageData = ((TableData.gTable).BaseStageData)[stageId]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.BattlePreview).TitleTxt).text = (PUtil.get)(20000336)
  ;
  (((uis.BattlePreview).CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.RelicBattlePreviewWindow).name)
  end
)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.BattlePreview).BNWordTxt).visible = templeType ~= TempleType.Hero
  ;
  (((uis.BattlePreview).root):GetChild("n15")).visible = templeType ~= TempleType.Hero
  local weakenData = nil
  local weakNum = (RelicData.GetEliteEnemySubNum)()
  for key,value in pairs((TableData.gTable).BaseTempleWeakenData) do
    if value.time_min <= weakNum and weakNum <= value.time_max then
      weakenData = value
    end
  end
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R3 in 'UnsetPending'

  if templeType == TempleType.Normal then
    ((uis.BattlePreview).NumberTxt).text = (PUtil.get)(287)
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R3 in 'UnsetPending'

    if not weakenData.now_des then
      ((uis.BattlePreview).BNWordTxt).text = (PUtil.get)(299) .. "%"
      -- DECOMPILER ERROR at PC96: Confused about usage of register: R3 in 'UnsetPending'

      if templeType == TempleType.Elite then
        ((uis.BattlePreview).NumberTxt).text = (PUtil.get)(288, tostring(stageId - 52610100))
        -- DECOMPILER ERROR at PC114: Confused about usage of register: R3 in 'UnsetPending'

        if not weakenData.change_des then
          ((uis.BattlePreview).BNWordTxt).text = (PUtil.get)(293, tostring(100 - (RelicData.GetEliteEnemySubNum)())) .. "%"
          do
            local percent, curBlood, totalBlood = (RelicData.GetCurEliteBloodPercent)(stageId)
            ;
            (((uis.BattlePreview).root):GetChild("MosterPreviewHpBar")).value = (math.ceil)(percent * 100)
            -- DECOMPILER ERROR at PC144: Confused about usage of register: R6 in 'UnsetPending'

            ;
            ((uis.BattlePreview).HpNumberTxt).text = tostring(curBlood) .. "(" .. tostring((math.ceil)(percent * 100)) .. "%" .. ")"
            -- DECOMPILER ERROR at PC153: Confused about usage of register: R3 in 'UnsetPending'

            if templeType == TempleType.Hero then
              ((uis.BattlePreview).NumberTxt).text = stageData.name
              -- DECOMPILER ERROR at PC157: Confused about usage of register: R3 in 'UnsetPending'

              ;
              (((uis.BattlePreview).BattleSpend).root).visible = false
              -- DECOMPILER ERROR at PC165: Confused about usage of register: R3 in 'UnsetPending'

              ;
              (((uis.BattlePreview).BattleSpend).vitalityTxt).text = (PUtil.get)(289)
              -- DECOMPILER ERROR at PC174: Confused about usage of register: R3 in 'UnsetPending'

              ;
              (((uis.BattlePreview).BattleSpend).vitalitynumberTxt).text = (ActorData.GetAssetCount)(AssetType.TEMPLE_HERO_COIN)
              -- DECOMPILER ERROR at PC184: Confused about usage of register: R3 in 'UnsetPending'

              ;
              (((uis.BattlePreview).BattleSpend).vitalitynumber_01_Txt).text = (ActorData.GetAssetCount)(AssetType.TEMPLE_HERO_COIN) - 1
              -- DECOMPILER ERROR at PC202: Confused about usage of register: R3 in 'UnsetPending'

              if not weakenData.change_des then
                ((uis.BattlePreview).BNWordTxt).text = (PUtil.get)(293, tostring(100 - (RelicData.GetEliteEnemySubNum)())) .. "%"
                do
                  local percent, curBlood, totalBlood = (RelicData.GetCurEliteBloodPercent)(stageId)
                  ;
                  (((uis.BattlePreview).root):GetChild("MosterPreviewHpBar")).value = (math.ceil)(percent * 100)
                  -- DECOMPILER ERROR at PC232: Confused about usage of register: R6 in 'UnsetPending'

                  ;
                  ((uis.BattlePreview).HpNumberTxt).text = tostring(curBlood) .. "(" .. tostring((math.ceil)(percent * 100)) .. "%" .. ")"
                  -- DECOMPILER ERROR at PC239: Confused about usage of register: R3 in 'UnsetPending'

                  ;
                  ((uis.BattlePreview).ImageLoader).url = (Util.GetItemUrl)(stageData.battle_banner_show)
                  -- DECOMPILER ERROR at PC246: Confused about usage of register: R3 in 'UnsetPending'

                  ;
                  ((uis.BattlePreview).RewardTxt).text = (PUtil.get)(20000001)
                  ;
                  ((uis.BattlePreview).RewardList):RemoveChildrenToPool()
                  local drop_show = stageData.first_drop_show
                  local configs = (Util.ParseConfigStr)(drop_show)
                  print("drop_show", drop_show, stageId, stageData)
                  PrintTable(configs, "configs")
                  for _,v in pairs(configs) do
                    if v[2] then
                      local Frame = (Util.CreateFrame)(v[2])
                      ;
                      ((uis.BattlePreview).RewardList):AddChild(Frame)
                    end
                  end
                  ;
                  (((uis.BattlePreview).SureBtn):GetChild("title")).text = (PUtil.get)(20000003)
                  ;
                  (((uis.BattlePreview).SureBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : templeType, TempleType, _ENV, stageId, RelicBattlePreviewWindow
    if templeType == TempleType.Normal then
      (RelicService.ReqRandomMonsterGroupList)(stageId)
    else
      ;
      (RelicBattlePreviewWindow.SetFormationData)()
    end
  end
)
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

RelicBattlePreviewWindow.SetFormationData = function(monster_group, ...)
  -- function num : 0_2 , upvalues : _ENV, stageId, templeType, TempleType, LEVELLIMIT
  local enemyList = {}
  local stageData = ((TableData.gTable).BaseStageData)[stageId]
  if not monster_group then
    local groupList = split(stageData.monster_group_list, ":")
    local Battle = ((TableData.gTable).BaseMonsterGroupData)[tonumber(groupList[#groupList])]
    local monsters = split(Battle.monster_list, ":")
    for i = 1, 6 do
      if tonumber(monsters[i]) == 0 then
        enemyList[i] = nil
      else
        if (RelicData.GetEnemyState)(stageId, tonumber(monsters[i])) == 1 then
          enemyList[i] = monsters[i]
        end
      end
    end
    local btnData = {}
    btnData.btnTxt = (PUtil.get)(20000021)
    btnData.fun = function(cards, ...)
    -- function num : 0_2_0 , upvalues : _ENV, stageId
    (RelicService.ReqStartChallenge)(stageId, cards)
    ;
    (RelicData.LastBattleStageId)(stageId)
    ;
    (RelicData.IsBattleWin)(false)
  end

    local formationData = {}
    formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).TEMPLE
    formationData.BtnData = btnData
    formationData.enemyList = enemyList
    formationData.stageId = stageId
    formationData.myselfList = (RelicData.GetCardSelfState)(templeType)
    do
      if stageData.activity_fc then
        local battleNum = 0
        if (RelicData.GetRelicPlayerFc)() < stageData.fc then
          battleNum = stageData.fc
        else
          battleNum = (RelicData.GetRelicPlayerFc)()
        end
        formationData.tureEnemyFC = (math.floor)(battleNum * stageData.activity_fc * 0.0001)
      end
      if templeType == TempleType.Normal then
        formationData.formationType = FormationType.Basic
      else
        formationData.formationType = FormationType.Relic
        local temp = {}
        local cards = (CardData.GetObtainedCardList)()
        temp.cantFight = {}
        for index,value in ipairs(cards) do
          if value.level < LEVELLIMIT then
            (table.insert)(temp.cantFight, value.id)
          end
        end
        temp.cardState = (RelicData.GetYetCardSate)(templeType)
        temp.splitString = (PUtil.get)(20000020)
        temp.titleString = (PUtil.get)(294)
        formationData.RelicData = temp
      end
      do
        ;
        (MessageMgr.OpenFormationWindow)(formationData)
      end
    end
  end
end

RelicBattlePreviewWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_3 , upvalues : _ENV, stageId, RelicBattlePreviewWindow
  if msgId == (WindowMsgEnum.Relic).E_MSG_RANDOM_MONSTER then
    local monster_group = (split(((RelicMgr.GetTempleData)(stageId)).monster_group_list, ","))[para.randomMosterGroup + 1]
    print("para.randomMosterGroup", para.randomMosterGroup, ((RelicMgr.GetTempleData)(stageId)).monster_group_list, monster_group)
    ;
    (RelicBattlePreviewWindow.SetFormationData)(monster_group)
  end
end

RelicBattlePreviewWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : uis, contentPane, bridge, argTable
  uis = nil
  contentPane = nil
  bridge = nil
  argTable = nil
end

return RelicBattlePreviewWindow

