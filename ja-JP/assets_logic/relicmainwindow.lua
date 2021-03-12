-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_RelicByName")
local RelicMainWindow = {}
local uis, contentPane, bridge, argTable = nil, nil, nil, nil
local normalStage = {}
local eliteStage = {}
local heroStage = {}
local ButtonType = {Elite = 1, Hero = 2}
local btnType = ButtonType.Elite
local CONSTELITETOWER = 52610100
local ladderOriY = 0
local frontEffect, backEffect, dayBattleEffect = nil, nil, nil
local towerEffects = {}
local configTable = {}
RelicMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, uis, configTable, RelicMainWindow, btnType, ButtonType, frontEffect, backEffect
  bridgeObj:SetView((WinResConfig.RelicMainWindow).package, (WinResConfig.RelicMainWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetRelic_RelicUis(contentPane)
  for key,value in pairs((TableData.gTable).BaseStageData) do
    if value.chapter_type == 20 then
      (table.insert)(configTable, value)
    end
  end
  local m = {}
  m.windowName = (WinResConfig.RelicMainWindow).name
  m.Tip = (PUtil.get)(283)
  m.model = uis.AssetStrip
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.BackBtnFun = function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    (RelicData.SetCurSelectedType)()
    UIMgr:CloseWindow((WinResConfig.RelicMainWindow).name)
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    (RelicData.SetCurSelectedType)()
    UIMgr:CloseWindow((WinResConfig.RelicMainWindow).name)
  end

  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  ;
  (RelicMainWindow.InitStageTable)()
  ;
  (((uis.BattleContent).TypeABtn):GetChild("NameTxt")).text = (PUtil.get)(284)
  ;
  (((uis.BattleContent).TypeABtn).onClick):Set(function(...)
    -- function num : 0_0_2 , upvalues : btnType, ButtonType, _ENV, RelicMainWindow, uis
    if btnType == ButtonType.Elite then
      return 
    else
      btnType = ButtonType.Elite
      ;
      (RelicData.SetCurSelectedType)(btnType)
    end
    ;
    (RelicMainWindow.RefreshEliteStage)()
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.BaseMap).c1Ctr).selectedIndex = 0
  end
)
  -- DECOMPILER ERROR at PC102: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.BattleContent).TimeTxt).text = (PUtil.get)(291, (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M", (RelicData.GetTempleEndTime)()))
  ;
  (((uis.BattleContent).TypeBBtn):GetChild("NameTxt")).text = (PUtil.get)(285)
  ;
  (((uis.BattleContent).TypeBBtn).onClick):Set(function(...)
    -- function num : 0_0_3 , upvalues : btnType, ButtonType, _ENV, RelicMainWindow, uis
    if btnType == ButtonType.Hero then
      return 
    else
      btnType = ButtonType.Hero
      ;
      (RelicData.SetCurSelectedType)(btnType)
    end
    ;
    (RelicMainWindow.RefreshHeroStage)()
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.BaseMap).c1Ctr).selectedIndex = 1
  end
)
  -- DECOMPILER ERROR at PC120: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.RelicShopBtn).visible = false
  ;
  ((uis.RelicShopBtn).onClick):Set(function(...)
    -- function num : 0_0_4 , upvalues : _ENV
    ld("Shop", function(...)
      -- function num : 0_0_4_0 , upvalues : _ENV
      (ShopService.OnReqShopGridData)(ShopType.RelicShop)
    end
)
  end
)
  btnType = (RelicData.GetCurSelectedType)()
  if btnType == nil then
    (RelicMainWindow.RefreshEliteStage)()
    btnType = ButtonType.Elite
  else
    if btnType == ButtonType.Elite then
      (RelicMainWindow.RefreshEliteStage)(true)
    else
      if btnType == ButtonType.Hero then
        (RelicMainWindow.RefreshHeroStage)(true)
      end
    end
  end
  -- DECOMPILER ERROR at PC157: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.BaseMap).c1Ctr).selectedIndex = btnType - 1
  -- DECOMPILER ERROR at PC162: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.BattleContent).c1Ctr).selectedIndex = btnType - 1
  frontEffect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_RELIC_FRONT_EFFECT, false, (uis.BattleContent).root, Vector2(((uis.BattleContent).root).width / 2, ((uis.BattleContent).root).height / 2))
  backEffect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_RELIC_BACK_EFFECT, false, (uis.BaseMap).root, Vector2(((uis.BattleContent).root).width / 2, ((uis.BattleContent).root).height / 2))
  ;
  ((uis.BaseMap).root):SetChildIndex(backEffect, ((uis.BaseMap).root):GetChildIndex((uis.BaseMap).BaseMapLoader) + 1)
  local relicActivityData = (ActivityMgr.InitRelicData)()
  ;
  (ActivityService.OnReqTaskGroup)((relicActivityData.baseActivityInfo).actId, (relicActivityData.templeActInfo).curGroup)
end

RelicMainWindow.InitTask = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  (RedDotMgr.BindingUI)((WinResConfig.RelicMainWindow).name, RedDotComID.Relic_Reward, (uis.BattleContent).RewardBtn)
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.RelicMainWindow).name)
  local rewardIsShow = false
  local taskList = (ActivityMgr.InitRelicTaskData)()
  for index,value in ipairs(taskList) do
    rewardIsShow = rewardIsShow or value.status < (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS
  end
  if rewardIsShow then
    (((uis.BattleContent).RewardBtn):GetController("c1")).selectedIndex = 0
  else
    (((uis.BattleContent).RewardBtn):GetController("c1")).selectedIndex = 1
  end
  ;
  (((uis.BattleContent).RewardBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, taskList, uis
    local relicActivityData = (ActivityMgr.InitRelicData)()
    local templeActInfo = relicActivityData.templeActInfo
    local curTask = nil
    for index,value in ipairs(taskList) do
      if value.status < (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
        curTask = value
        break
      end
    end
    do
      if (((uis.BattleContent).RewardBtn):GetController("c1")).selectedIndex == 1 then
        (MessageMgr.SendCenterTips)((PUtil.get)(314))
      end
      if curTask == nil then
        return 
      end
      local canGet = curTask.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN
      if canGet then
        print("活动ID 任务组 任务ID", (relicActivityData.baseActivityInfo).actId, templeActInfo.curGroup, curTask.id)
        ;
        (ActivityService.OnReqTaskReward)((relicActivityData.baseActivityInfo).actId, templeActInfo.curGroup, curTask.id)
      else
        local taskData = ((TableData.gTable).BaseActivityTaskData)[curTask.id]
        local rewards = taskData.reward
        local btnData = {}
        btnData.btnTxt = (PUtil.get)(30)
        btnData.fun = function(...)
      -- function num : 0_1_0_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.RewardDisplayWindow).name)
    end

        ;
        (MessageMgr.OpenRewardWindow)(rewards, btnData, curTask.id, nil, taskData.remark .. "(" .. curTask.comp .. "/" .. curTask.need .. ")")
      end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

RelicMainWindow.InitStageTable = function(...)
  -- function num : 0_2 , upvalues : _ENV, normalStage, eliteStage, heroStage, RelicMainWindow
  for index,value in pairs((TableData.gTable).BaseTempleData) do
    if value.type == 1 then
      (table.insert)(normalStage, value.stage_id)
    else
      if value.type == 2 then
        (table.insert)(eliteStage, value.stage_id)
      else
        if value.type == 3 then
          (table.insert)(heroStage, value.stage_id)
        end
      end
    end
  end
  ;
  (RelicMainWindow.SortData)(eliteStage)
  ;
  (RelicMainWindow.SortData)(heroStage)
end

RelicMainWindow.SortData = function(tb, ...)
  -- function num : 0_3 , upvalues : _ENV
  (table.sort)(tb, function(a, b, ...)
    -- function num : 0_3_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

RelicMainWindow.RefreshEliteStage = function(needAni, ...)
  -- function num : 0_4 , upvalues : _ENV, towerEffects, CONSTELITETOWER, uis, eliteStage, ladderOriY, dayBattleEffect, normalStage
  for index,value in ipairs(towerEffects) do
    if value ~= nil then
      (LuaEffect.DestroyEffect)(value)
    end
  end
  towerEffects = {}
  local curElietId = (RelicData.GetCurEliteTowerId)()
  local eliteIndex = curElietId - CONSTELITETOWER
  if eliteIndex == nil or eliteIndex <= 0 then
    eliteIndex = 1
  end
  print("==============RelicData.GetCurEliteTowerId()", (RelicData.GetCurEliteTowerId)(), eliteIndex)
  local lastBattleStage = (RelicData.LastBattleStageId)()
  ;
  ((uis.BattleContent).BuildMapList):RemoveChildrenToPool()
  local tbLength = #eliteStage
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.BattleContent).WordTxt).text = (PUtil.get)(308, eliteIndex)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R5 in 'UnsetPending'

  if (RelicData.GetIsGeted)(curElietId) then
    ((uis.BattleContent).WordTxt).text = (PUtil.get)(309)
  end
  do
    for index,value in ipairs(eliteStage) do
      local layerBuildMap = ((uis.BattleContent).BuildMapList):AddItemFromPool()
      local templeCfg = ((TableData.gTable).BaseTempleData)[value + RelicSub.Elite]
      local ladderItem = nil
      local t = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_RELIC_TOWER, false, layerBuildMap, Vector2(layerBuildMap.width / 2, layerBuildMap.height))
      ;
      (table.insert)(towerEffects, t)
      do
        if templeCfg.ladder then
          local monsterModel = (layerBuildMap:GetChild("LineLoader")).Model
          if monsterModel then
            (ResHelper.DestroyGameObject)(((layerBuildMap:GetChild("LineLoader")).Model).gameObject, false)
          end
          ladderItem = (Util.ShowUIModel)(templeCfg.ladder, layerBuildMap:GetChild("LineLoader"))
          -- DECOMPILER ERROR at PC126: Confused about usage of register: R15 in 'UnsetPending'

          ;
          (ladderItem.transform).localScale = Vector3(100, 100, 100)
          if ladderOriY == 0 then
            ladderOriY = (layerBuildMap:GetChild("LineLoader")).y
          end
          ;
          (layerBuildMap:GetChild("LineLoader")).y = ladderOriY + 64
        end
        local towerItem = nil
        do
          if templeCfg.icon then
            local monsterModel = (layerBuildMap:GetChild("LayerLoader")).Model
            if monsterModel then
              (ResHelper.DestroyGameObject)(((layerBuildMap:GetChild("LayerLoader")).Model).gameObject, false)
            end
            towerItem = (Util.ShowUIModel)(templeCfg.icon, layerBuildMap:GetChild("LayerLoader"))
            -- DECOMPILER ERROR at PC174: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (towerItem.transform).localScale = Vector3(100, 100, 100)
          end
          ;
          (layerBuildMap:GetChild("NumberTxt")).text = (PUtil.get)(308, index)
          if index == eliteIndex then
            local isGeted = (RelicData.GetIsGeted)(curElietId)
            if isGeted then
              (layerBuildMap:GetController("c1")).selectedIndex = 2
              ;
              (SkeletonAnimationUtil.SetAnimation)(towerItem, 0, "idle_03", false)
            else
              ;
              (layerBuildMap:GetController("c1")).selectedIndex = 1
              ;
              (SkeletonAnimationUtil.SetAnimation)(ladderItem, 0, "idle_02", true)
              ;
              (SkeletonAnimationUtil.SetAnimation)(towerItem, 0, "idle_02", false)
              local per = (math.ceil)(100 * (RelicData.GetCurEliteBloodPercent)(curElietId))
              ;
              (layerBuildMap:GetChild("LayerHpBar")).value = per
              ;
              ((layerBuildMap:GetChild("LayerHpBar")):GetChild("PercentageTxt")).text = tostring(per) .. "%"
            end
          else
            do
              if eliteIndex < index then
                (layerBuildMap:GetController("c1")).selectedIndex = 0
                ;
                (SkeletonAnimationUtil.SetAnimation)(towerItem, 0, "idle_01", false)
                ;
                (SkeletonAnimationUtil.SetAnimation)(ladderItem, 0, "idle_01", true)
              else
                if index < eliteIndex then
                  (layerBuildMap:GetController("c1")).selectedIndex = 2
                  ;
                  (SkeletonAnimationUtil.SetAnimation)(towerItem, 0, "idle_03", false)
                  ;
                  (SkeletonAnimationUtil.SetAnimation)(ladderItem, 0, "idle_03", true)
                end
              end
              ;
              (layerBuildMap.onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : layerBuildMap, _ENV, curElietId
    if (layerBuildMap:GetController("c1")).selectedIndex == 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(300))
    else
      if (layerBuildMap:GetController("c1")).selectedIndex == 1 then
        if (RelicData.GetEliteTowerNum)() > 0 then
          (RelicMgr.OpenBattlePreview)(curElietId)
        else
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(295))
        end
      else
        if (layerBuildMap:GetController("c1")).selectedIndex == 2 then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000471))
        end
      end
    end
  end
)
              if index == tbLength then
                (layerBuildMap:GetController("c2")).selectedIndex = 1
              else
                ;
                (layerBuildMap:GetController("c2")).selectedIndex = 0
              end
              do
                local isWin = (RelicData.IsBattleWin)()
                if isWin and needAni then
                  if value == lastBattleStage then
                    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_RELICK_SMOKE, true, layerBuildMap, Vector2(layerBuildMap.width / 2, layerBuildMap.height / 2))
                    ;
                    (SkeletonAnimationUtil.SetAnimation)(towerItem, 0, "break", false, function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    (RelicData.IsBattleWin)(false)
  end
)
                    ;
                    (SkeletonAnimationUtil.SetAnimation)(ladderItem, 0, "unlock", false, function(...)
    -- function num : 0_4_2 , upvalues : _ENV, ladderItem
    (SkeletonAnimationUtil.SetAnimation)(ladderItem, 0, "idle_03", true)
  end
)
                  else
                    if value == lastBattleStage + 1 then
                      (SkeletonAnimationUtil.SetAnimation)(towerItem, 0, "unlock", false)
                      ;
                      (SkeletonAnimationUtil.SetAnimation)(ladderItem, 0, "idle_02", true)
                    end
                  end
                end
                -- DECOMPILER ERROR at PC360: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC360: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC360: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC360: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC360: LeaveBlock: unexpected jumping out DO_STMT

              end
            end
          end
        end
      end
    end
  end
  local MinX = 4
  local MaxX = #eliteStage - 2
  local distance = 240
  if MaxX < eliteIndex then
    eliteIndex = MaxX
  end
  do
    if eliteIndex <= MaxX and MinX <= eliteIndex then
      local moveNum = eliteIndex - (MinX - 1)
      -- DECOMPILER ERROR at PC380: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((uis.BattleContent).BuildMapList).scrollPane).posX = moveNum * distance
    end
    local normalNum = (RelicData.GetNormalStageNum)()
    if normalNum > 0 then
      (((uis.BattleContent).DayBattleBtn):GetController("c1")).selectedIndex = 0
      dayBattleEffect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_RELIC_DAYBATTLE, false, (uis.BattleContent).DayBattleBtn, Vector2(((uis.BattleContent).DayBattleBtn).width / 2.1, ((uis.BattleContent).DayBattleBtn).height / 3.5))
    else
      if dayBattleEffect ~= nil then
        (LuaEffect.DestroyEffect)(dayBattleEffect)
      end
      ;
      (((uis.BattleContent).DayBattleBtn):GetController("c1")).selectedIndex = 1
    end
    ;
    ((((uis.BattleContent).DayBattleBtn):GetChild("DayBattleNumber")):GetChild("ProgressTxt")).text = (PUtil.get)(286, normalNum)
    ;
    (((uis.BattleContent).DayBattleBtn).onClick):Set(function(...)
    -- function num : 0_4_3 , upvalues : normalNum, _ENV, normalStage
    if normalNum > 0 then
      (RelicMgr.OpenBattlePreview)(normalStage[1])
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(298))
    end
  end
)
  end
end

RelicMainWindow.RefreshHeroStage = function(needAni, ...)
  -- function num : 0_5 , upvalues : uis, _ENV, heroStage, configTable
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.BattleContent).WordTxt).text = (PUtil.get)(285)
  for index,value in ipairs(heroStage) do
    do
      local stageData = ((TableData.gTable).BaseStageData)[value]
      local templeCfg = ((TableData.gTable).BaseTempleData)[value + RelicSub.Hero]
      local heroItem = (((uis.BattleContent).BossMap).root):GetChild("Boss" .. tostring(index))
      local monsterModel = (heroItem:GetChild("CardQLoader")).Model
      if monsterModel then
        (ResHelper.DestroyGameObject)(((heroItem:GetChild("CardQLoader")).Model).gameObject, false)
      end
      local curBossId = (RelicData.GetCurBossId)()
      ;
      (Util.CreateMiniModelByPath)(heroItem:GetChild("CardQLoader"), stageData.monster_icon, function(model, ...)
    -- function num : 0_5_0 , upvalues : value, curBossId, heroItem, _ENV
    if curBossId < value then
      (heroItem:GetController("c1")).selectedIndex = 0
      ;
      (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle_01_1", false, nil, true)
    else
      if value == curBossId then
        local isGeted = (RelicData.GetIsGeted)(curBossId)
        if isGeted then
          (heroItem:GetController("c1")).selectedIndex = 2
          ;
          (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle_03_1", false, nil, true)
        else
          ;
          (heroItem:GetController("c1")).selectedIndex = 1
          ;
          (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle_02_1", true, nil, true)
        end
      else
        do
          if value < curBossId then
            (heroItem:GetController("c1")).selectedIndex = 2
            ;
            (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle_03_1", false, nil, true)
          end
        end
      end
    end
  end
, true, nil, false)
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((((heroItem:GetChild("CardQLoader")).Model).gameObject).transform).localScale = Vector3(-100, 100, 100)
      ;
      (heroItem.onClick):Set(function(...)
    -- function num : 0_5_1 , upvalues : heroItem, _ENV, configTable, value
    if (heroItem:GetController("c1")).selectedIndex == 0 then
      for j,k in ipairs(configTable) do
        local next = split(k.next, ",")
        for n,m in ipairs(next) do
          if tonumber(m) == value and k.id < 52620100 and (RelicData.GetIsGeted)(k.id) == false then
            (MessageMgr.SendCenterTips)((PUtil.get)(307, k.id - 52610100))
            return 
          end
        end
      end
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(301))
    else
      if (heroItem:GetController("c1")).selectedIndex == 1 then
        (RelicMgr.OpenBattlePreview)(value)
      else
        if (heroItem:GetController("c1")).selectedIndex == 2 then
          (MessageMgr.SendCenterTips)((PUtil.get)(297))
        end
      end
    end
  end
)
    end
  end
end

RelicMainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6 , upvalues : _ENV, RelicMainWindow
  local windowMsgEnum = WindowMsgEnum.Relic
  if msgId == windowMsgEnum.E_MSG_INIT_TASK then
    (RelicMainWindow.InitTask)()
  else
    if msgId == windowMsgEnum.E_MSG_GET_TASKREWARD then
      (RelicMainWindow.InitTask)()
    end
  end
end

RelicMainWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : _ENV, frontEffect, backEffect, dayBattleEffect, towerEffects, uis, contentPane, bridge, argTable, normalStage, eliteStage, heroStage, configTable
  (LuaEffect.DestroyEffect)(frontEffect)
  frontEffect = nil
  ;
  (LuaEffect.DestroyEffect)(backEffect)
  backEffect = nil
  ;
  (LuaEffect.DestroyEffect)(dayBattleEffect)
  dayBattleEffect = nil
  for index,value in ipairs(towerEffects) do
    if value ~= nil then
      (LuaEffect.DestroyEffect)(value)
    end
  end
  towerEffects = {}
  uis = nil
  contentPane = nil
  bridge = nil
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.RelicMainWindow).name)
  argTable = nil
  normalStage = {}
  eliteStage = {}
  heroStage = {}
  configTable = {}
end

return RelicMainWindow

