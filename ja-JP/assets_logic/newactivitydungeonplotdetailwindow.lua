-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_PlotDetailWindowByName")
local NewActivityDungeonPlotDetailWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local BOOK = "ui_tushuguan_shu"
local IDLE2_ANIM = "idle2"
local _book = nil
NewActivityDungeonPlotDetailWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, NewActivityDungeonPlotDetailWindow
  bridgeObj:SetView((WinResConfig.NewActivityDungeonPlotDetailWindow).package, (WinResConfig.NewActivityDungeonPlotDetailWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActivityDungeonTwo_PlotDetailWindowUis(contentPane)
  ;
  (NewActivityDungeonPlotDetailWindow.InitTopMenu)()
  ;
  (NewActivityDungeonPlotDetailWindow.InitText)()
  ;
  (NewActivityDungeonPlotDetailWindow.InitButtonEvent)()
end

NewActivityDungeonPlotDetailWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, NewActivityDungeonPlotDetailWindow
  local m = {}
  m.windowName = (WinResConfig.NewActivityDungeonPlotDetailWindow).name
  m.Tip = (PUtil.get)(20000216)
  m.model = (uis.PlotDetail).AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  m.BackBtnFun = NewActivityDungeonPlotDetailWindow.QuitAnim
  m.CloseBtnFun = NewActivityDungeonPlotDetailWindow.QuitAnim
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

NewActivityDungeonPlotDetailWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.PlotDetail).ChallengeBtn).text = (PUtil.get)(20000003)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.PlotDetail).DropDisplayTxt).text = (PUtil.get)(20000001)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.PlotDetail).sweepawayBtn).text = (PUtil.get)(20000004)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.PlotDetail).sweepaway10Btn).text = (PUtil.get)(20000005)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.PlotDetail).vitalityTxt).text = (PUtil.get)(20000006)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.PlotDetail).mycombatTxt).text = (PUtil.get)(20000008)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.PlotDetail).recommendedcombatTxt).text = (PUtil.get)(20000007)
end

NewActivityDungeonPlotDetailWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, NewActivityDungeonPlotDetailWindow
  (((uis.PlotDetail).ChallengeBtn).onClick):Set(NewActivityDungeonPlotDetailWindow.ClickChallengeBtn)
  ;
  (((uis.PlotDetail).sweepawayBtn).onClick):Set(NewActivityDungeonPlotDetailWindow.ClickSmashBtn)
  ;
  (((uis.PlotDetail).sweepaway10Btn).onClick):Set(NewActivityDungeonPlotDetailWindow.ClickMultiplySmashBtn)
end

NewActivityDungeonPlotDetailWindow.OnShown = function(...)
  -- function num : 0_4 , upvalues : NewActivityDungeonPlotDetailWindow
  (NewActivityDungeonPlotDetailWindow.Init)()
end

NewActivityDungeonPlotDetailWindow.OnHide = function(...)
  -- function num : 0_5
end

NewActivityDungeonPlotDetailWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : _book, _ENV, uis, contentPane, argTable
  if _book then
    (ResHelper.DestroyGameObject)(_book, false)
    _book = nil
  end
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.NewActivityDungeonPlotDetailWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
end

NewActivityDungeonPlotDetailWindow.Init = function(...)
  -- function num : 0_7 , upvalues : NewActivityDungeonPlotDetailWindow
  (NewActivityDungeonPlotDetailWindow.InitEffect)()
  ;
  (NewActivityDungeonPlotDetailWindow.RefreshDetail)()
end

NewActivityDungeonPlotDetailWindow.RefreshDetail = function(...)
  -- function num : 0_8 , upvalues : NewActivityDungeonPlotDetailWindow, _ENV, uis
  (NewActivityDungeonPlotDetailWindow.RefreshBtn)()
  local config = ((TableData.gTable).BaseStageData)[NewActivityDungeonData.CurrentDungeon]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.PlotDetail).PlotImageLoader).url = (Util.GetItemUrl)(config.battle_banner_show)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.PlotDetail).vitalitynumberTxt).text = (ActorData.GetAssetCount)(AssetType.PHYSICAL)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.PlotDetail).vitalitynumber_01_Txt).text = (ActorData.GetAssetCount)(AssetType.PHYSICAL) - config.need_vit
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.PlotDetail).mycombatnumberTxt).text = (ActorData.GetFc)()
  if config.activity_fc then
    local battleNum = (math.max)(config.fc, (PlotDungeonMgr.GetActivityDungeonPlayerFc)())
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.PlotDetail).recommendedcombatmumberTxt).text = (math.floor)(battleNum * config.activity_fc * 0.0001)
  else
    do
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.PlotDetail).recommendedcombatmumberTxt).text = config.fc
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R1 in 'UnsetPending'

      if Const.NoShowAmount <= tonumber(config.challenge_num) then
        ((uis.PlotDetail).challengenumberTxt).visible = false
        -- DECOMPILER ERROR at PC75: Confused about usage of register: R1 in 'UnsetPending'

        ;
        ((uis.PlotDetail).BattleImage).visible = false
      else
        -- DECOMPILER ERROR at PC91: Confused about usage of register: R1 in 'UnsetPending'

        if config.challenge_num == -1 and config.type == StageType.FIGHT then
          ((uis.PlotDetail).challengenumberTxt).text = (PUtil.get)(20000086)
        else
          local canChange = (PlotDungeonMgr.GetCanChangeTimesDungeon)(NewActivityDungeonData.CurrentDungeon)
          -- DECOMPILER ERROR at PC107: Confused about usage of register: R2 in 'UnsetPending'

          if canChange > 0 then
            ((uis.PlotDetail).challengenumberTxt).text = (PUtil.get)(20000372, canChange)
          else
            -- DECOMPILER ERROR at PC116: Confused about usage of register: R2 in 'UnsetPending'

            ;
            ((uis.PlotDetail).challengenumberTxt).text = (PUtil.get)(20000373, canChange)
          end
        end
      end
      do
        -- DECOMPILER ERROR at PC120: Confused about usage of register: R1 in 'UnsetPending'

        ;
        ((uis.PlotDetail).NumberTxt).text = config.name
        -- DECOMPILER ERROR at PC124: Confused about usage of register: R1 in 'UnsetPending'

        ;
        ((uis.PlotDetail).WordTxt).text = config.remark
        ;
        ((uis.PlotDetail).Prop1List):RemoveChildrenToPool()
        if not (PlotDungeonMgr.IsPassDungeon)(NewActivityDungeonData.CurrentDungeon) then
          local first_drop_show = config.first_drop_show
          local firstConfigs = (Util.ParseConfigStr)(first_drop_show)
          for _,v in ipairs(firstConfigs) do
            if v[2] then
              (Util.SetFrame)(v[2], v[3], (uis.PlotDetail).Prop1List, false, true)
            end
          end
        end
        do
          local drop_show = config.drop_show
          local configs = (Util.ParseConfigStr)(drop_show)
          for _,v in pairs(configs) do
            if v[2] then
              (Util.SetFrame)(v[2], v[3], (uis.PlotDetail).Prop1List)
            end
          end
        end
      end
    end
  end
end

NewActivityDungeonPlotDetailWindow.InitEffect = function(...)
  -- function num : 0_9 , upvalues : _book, _ENV, BOOK, uis, IDLE2_ANIM
  if _book == nil then
    local holder, model = (Util.AddUIModel)(BOOK, 100)
    do
      (uis.root):AddChildAt(holder, 1)
      holder:SetXY((uis.root).width * 0.5, (uis.root).height * 0.5)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (model.transform).localScale = Vector3.one * 100
      _book = model
      local sa = model:GetComponent(typeof(((CS.Spine).Unity).SkeletonAnimation))
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (sa.skeleton).A = 0
      ;
      (((LeanTween.value)(0, 1, 0.25)):setOnUpdate(function(value, ...)
    -- function num : 0_9_0 , upvalues : sa
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

    (sa.skeleton).A = value
  end
)):setDelay(0.13)
      ;
      (SkeletonAnimationUtil.SetAnimation)(_book, 0, IDLE2_ANIM, true)
    end
  end
end

NewActivityDungeonPlotDetailWindow.QuitAnim = function(...)
  -- function num : 0_10 , upvalues : _ENV, _book
  if not (Util.IsNil)(_book) then
    local sa = _book:GetComponent(typeof(((CS.Spine).Unity).SkeletonAnimation))
    do
      (((LeanTween.value)(1, 0, 0.17)):setOnUpdate(function(value, ...)
    -- function num : 0_10_0 , upvalues : _ENV, sa
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    if not (Util.IsNil)(sa) then
      (sa.skeleton).A = value
    end
  end
)):setOnComplete(function(...)
    -- function num : 0_10_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.NewActivityDungeonPlotDetailWindow).name)
  end
)
    end
  else
    do
      UIMgr:CloseWindow((WinResConfig.NewActivityDungeonPlotDetailWindow).name)
    end
  end
end

NewActivityDungeonPlotDetailWindow.RefreshBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  if not (PlotDungeonMgr.IsPassDungeon)(NewActivityDungeonData.CurrentDungeon) or not (FunctionControlMgr.GetFunctionState)(ControlID.StageDetail_SweepOneBtn, false) then
    ((uis.PlotDetail).c1Ctr).selectedIndex = 0
  else
    local tenSweep = (FunctionControlMgr.GetFunctionState)(ControlID.StageDetail_SweepTenBtn, false)
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

    if tenSweep then
      ((uis.PlotDetail).c1Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.PlotDetail).c1Ctr).selectedIndex = 3
    end
  end
end

NewActivityDungeonPlotDetailWindow.ClickSmashBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  (PlotDungeonMgr.StartSweep)(NewActivityDungeonData.CurrentDungeon, 1, nil)
  ;
  (Util.SetOnClickDelay)(0.5)
end

NewActivityDungeonPlotDetailWindow.ClickMultiplySmashBtn = function(...)
  -- function num : 0_13 , upvalues : _ENV
  (PlotDungeonMgr.StartSweep)(NewActivityDungeonData.CurrentDungeon, 10, nil)
  ;
  (Util.SetOnClickDelay)(0.5)
end

NewActivityDungeonPlotDetailWindow.ClickChallengeBtn = function(...)
  -- function num : 0_14 , upvalues : _ENV
  local config = ((TableData.gTable).BaseStageData)[NewActivityDungeonData.CurrentDungeon]
  if (PlotDungeonMgr.IsPassDungeon)(NewActivityDungeonData.CurrentDungeon) then
    (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Dungeon, function(...)
    -- function num : 0_14_0 , upvalues : _ENV
    (PlotDungeonMgr.OnClickChallengeDungeon)(NewActivityDungeonData.CurrentDungeon)
    ;
    (Util.SetOnClickDelay)(0.5)
  end
, config.drop_show)
  else
    ;
    (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Dungeon, function(...)
    -- function num : 0_14_1 , upvalues : _ENV
    (PlotDungeonMgr.OnClickChallengeDungeon)(NewActivityDungeonData.CurrentDungeon)
    ;
    (Util.SetOnClickDelay)(0.5)
  end
, config.first_reward, config.drop_show)
  end
end

NewActivityDungeonPlotDetailWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15
end

return NewActivityDungeonPlotDetailWindow

