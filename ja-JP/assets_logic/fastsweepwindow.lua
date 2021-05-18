-- params : ...
-- function num : 0 , upvalues : _ENV
require("HeroDungeon_SpeedSweepByName")
require("HeroDungeon_SweepCardGrpByName")
require("HeroDungeon_SpeedSweepWindowByName")
local contentPane = nil
local uis = {}
local FastSweepWindow = {}
local DebrisData = {}
local DebrisSort = {}
local ChooseDebris = {}
local Consumption = 12
local mPlotType = 0
local IsSaveBoolStr = ""
local SaveInfoStr = ""
FastSweepWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, mPlotType, IsSaveBoolStr, SaveInfoStr, ChooseDebris, FastSweepWindow, DebrisData, Consumption
  bridge:SetView((WinResConfig.FastSweepWindow).package, (WinResConfig.FastSweepWindow).comName)
  contentPane = bridge.contentPane
  local argTable = bridge.argTable
  uis = GetHeroDungeon_SpeedSweepWindowUis(contentPane)
  uis = uis.SpeedSweep
  mPlotType = argTable[1]
  if mPlotType == DungeonType.ActivityDungeon then
    IsSaveBoolStr = PlayerPrefsKeyName.FAST_SWEEP_SAVE_CARD_2
    SaveInfoStr = PlayerPrefsKeyName.FAST_SWEEP_SAVE_CARD_INFO_2
  else
    IsSaveBoolStr = PlayerPrefsKeyName.FAST_SWEEP_SAVE_CARD
    SaveInfoStr = PlayerPrefsKeyName.FAST_SWEEP_SAVE_CARD_INFO
  end
  local isSave = (Util.GetPlayerSetting)(IsSaveBoolStr, tostring(0))
  if isSave == tostring(1) then
    local str = (Util.GetPlayerSetting)(SaveInfoStr)
    local debris = split(str, ":")
    ChooseDebris = {}
    for _,v in ipairs(debris) do
      if not (Util.StringIsNullOrEmpty)(v) then
        (table.insert)(ChooseDebris, tonumber(v))
      end
    end
  else
    do
      ChooseDebris = {}
      ;
      (FastSweepWindow.InItDebrisData)()
      ;
      (FastSweepWindow.InitDebrisList)()
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.DefaultBtn).selected = (Util.GetPlayerSetting)(IsSaveBoolStr, 0) == tostring(1)
      ;
      ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.FastSweepWindow).name)
  end
)
      ;
      ((uis.DefaultBtn).onChanged):Set(function(...)
    -- function num : 0_0_1 , upvalues : uis, _ENV, IsSaveBoolStr
    if (uis.DefaultBtn).selected then
      (Util.SetPlayerSetting)(IsSaveBoolStr, 1)
    else
      ;
      (Util.SetPlayerSetting)(IsSaveBoolStr, 0)
    end
  end
)
      -- DECOMPILER ERROR at PC114: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.SpeedSweepBtn).text = (PUtil.get)(20000053)
      ;
      ((uis.SpeedSweepBtn).onClick):Set(function(...)
    -- function num : 0_0_2 , upvalues : _ENV, DebrisData, FastSweepWindow, ChooseDebris, Consumption
    local stages = {}
    for k,v in pairs(DebrisData) do
      if (FastSweepWindow.IsChooseDebris)(k) then
        for _,v2 in ipairs(v) do
          (table.insert)(stages, v2)
        end
      end
    end
    if #ChooseDebris > 0 and #stages > 0 then
      if (FastSweepWindow.GetCountTimes)() <= 0 then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000054))
      else
        if (ActorData.GetAssetCount)(AssetType.PHYSICAL) < (FastSweepWindow.GetCountTimes)() * Consumption then
          (MessageMgr.OpenAssetNotEnoughtWindow)(AssetType.PHYSICAL)
        else
          local count = #stages
          local rewards = ""
          for i = 1, count do
            if i == 1 then
              rewards = (((TableData.gTable).BaseStageData)[stages[i]]).sweep_reward
            else
              rewards = rewards .. "," .. (((TableData.gTable).BaseStageData)[stages[i]]).sweep_reward
            end
          end
          ;
          (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Dungeon, function(...)
      -- function num : 0_0_2_0 , upvalues : _ENV, ChooseDebris, stages
      (PlotDungeonMgr.FastSweep)(ChooseDebris, stages)
      UIMgr:CloseWindow((WinResConfig.FastSweepWindow).name)
    end
, rewards)
        end
      end
    else
      do
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000055))
      end
    end
  end
)
      ;
      (FastSweepWindow.RefreshPhysics)()
      -- DECOMPILER ERROR at PC127: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.RewardTxt).text = (PUtil.get)(20000400)
      -- DECOMPILER ERROR at PC133: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.DefaultTxt).text = (PUtil.get)(20000407)
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
  end
end

FastSweepWindow.InItDebrisData = function(...)
  -- function num : 0_1 , upvalues : _ENV, mPlotType, DebrisData, DebrisSort
  local chapterData = (TableData.gTable).BaseChapterData
  for _,v in pairs(chapterData) do
    if (PlotDungeonMgr.ChapterIsOpen)(v.id) and v.type == mPlotType then
      local stages = split(v.stages, ":")
      for _,v2 in ipairs(stages) do
        local stageData = ((TableData.gTable).BaseStageData)[tonumber(v2)]
        local debrisId = stageData.role_drop_show
        if (PlotDungeonMgr.IsPassDungeon)(tonumber(v2)) and debrisId > 0 then
          local stageNum = nil
          if DebrisData[debrisId] then
            stageNum = DebrisData[debrisId]
          else
            stageNum = {}
            ;
            (table.insert)(DebrisSort, {debrisID = debrisId, stageID = stageData.id})
          end
          ;
          (table.insert)(stageNum, stageData.id)
          DebrisData[debrisId] = stageNum
        end
      end
    end
  end
end

FastSweepWindow.InitDebrisList = function(...)
  -- function num : 0_2 , upvalues : FastSweepWindow, uis, _ENV, DebrisSort, DebrisData
  (FastSweepWindow.SortDebrisData)()
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CardList).numItems = 0
  for _,v in ipairs(DebrisSort) do
    local stages = DebrisData[v.debrisID]
    local times = 0
    for _,v2 in pairs(stages) do
      times = (PlotDungeonMgr.GetCanChangeTimesDungeon)(tonumber(v2)) + times
    end
    local obj = (FastSweepWindow.CreateDebrisTemplate)(v.debrisID, times)
    if obj then
      (uis.CardList):AddChild(obj)
    end
  end
end

FastSweepWindow.CreateDebrisTemplate = function(debrisID, times, ...)
  -- function num : 0_3 , upvalues : _ENV, Consumption, FastSweepWindow
  local CardData = ((TableData.gTable).BaseCardData)[debrisID]
  if CardData then
    local debrisId = (split(CardData.recruit_cost, ":"))[2]
    do
      local obj = UIMgr:CreateObject("HeroDungeon", "SweepCardGrp")
      local templateModel = GetHeroDungeon_SweepCardGrpUis(obj)
      ;
      (Util.SetDebrisFrame)((templateModel.HeadDebrisGrp).root, tonumber(debrisId))
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (templateModel.PlayerNameTxt).text = CardData.name
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (templateModel.Number_02_Txt).text = times
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

      if times <= 0 then
        (templateModel.Number_02_Txt).color = Const.LackColorRGB
      end
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (templateModel.Time_02_Txt).text = times * Consumption
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (templateModel.DefaultBtn).selected = (FastSweepWindow.IsChooseDebris)(debrisID)
      ;
      ((templateModel.DefaultBtn).onChanged):Set(function(...)
    -- function num : 0_3_0 , upvalues : FastSweepWindow, debrisID, templateModel
    (FastSweepWindow.onChanged)(debrisID, templateModel.DefaultBtn)
  end
)
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (templateModel.Number_01_Txt).text = (PUtil.get)(20000401)
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (templateModel.Time_01_Txt).text = (PUtil.get)(20000402)
      return obj
    end
  end
end

FastSweepWindow.onChanged = function(debrisID, btn, ...)
  -- function num : 0_4 , upvalues : FastSweepWindow, mPlotType, _ENV, ChooseDebris
  if btn.selected then
    if (FastSweepWindow.NeedTimes)(debrisID) <= 0 then
      if mPlotType == DungeonType.HeroDungeon then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000054))
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(40002075))
      end
      btn.selected = false
    else
      ;
      (table.insert)(ChooseDebris, debrisID)
    end
  else
    local pos = 0
    for i,v in ipairs(ChooseDebris) do
      if v == debrisID then
        pos = i
      end
    end
    ;
    (table.remove)(ChooseDebris, pos)
  end
  do
    ;
    (FastSweepWindow.RefreshPhysics)()
    ;
    (FastSweepWindow.SaveInfoPlayerPrefs)()
  end
end

FastSweepWindow.SaveInfoPlayerPrefs = function(...)
  -- function num : 0_5 , upvalues : _ENV, ChooseDebris, SaveInfoStr
  local str = ""
  for _,v in ipairs(ChooseDebris) do
    if not (Util.StringIsNullOrEmpty)(v) then
      str = v .. ":" .. str
    end
  end
  ;
  (Util.SetPlayerSetting)(SaveInfoStr, str)
end

FastSweepWindow.RefreshPhysics = function(...)
  -- function num : 0_6 , upvalues : FastSweepWindow, Consumption, _ENV, uis
  local needCount = (FastSweepWindow.GetCountTimes)() * Consumption
  local haveCount = (ActorData.GetAssetCount)(AssetType.PHYSICAL)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  if needCount <= haveCount then
    (uis.NumberTxt).text = (PUtil.get)(20000063, needCount, haveCount)
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.NumberTxt).text = (PUtil.get)(20000064, needCount, haveCount)
  end
end

FastSweepWindow.GetCountTimes = function(...)
  -- function num : 0_7 , upvalues : _ENV, ChooseDebris, FastSweepWindow
  local times = 0
  for _,v in ipairs(ChooseDebris) do
    times = (FastSweepWindow.NeedTimes)(v) + times
  end
  return times
end

FastSweepWindow.NeedTimes = function(debrisID, ...)
  -- function num : 0_8 , upvalues : DebrisData, _ENV
  local times = 0
  local stages = DebrisData[tonumber(debrisID)]
  if stages then
    for _,v in pairs(stages) do
      times = (PlotDungeonMgr.GetCanChangeTimesDungeon)(v) + times
    end
  end
  do
    return times
  end
end

FastSweepWindow.SortDebrisData = function(...)
  -- function num : 0_9 , upvalues : _ENV, DebrisSort, FastSweepWindow
  (table.sort)(DebrisSort, function(a, b, ...)
    -- function num : 0_9_0 , upvalues : FastSweepWindow
    local aValue = 0
    local bValue = 0
    if (FastSweepWindow.IsChooseDebris)(a.debrisID) then
      aValue = 1000000000
    end
    if (FastSweepWindow.IsChooseDebris)(b.debrisID) then
      bValue = 1000000000
    end
    do return bValue - b.stageID < aValue - a.stageID end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

FastSweepWindow.IsChooseDebris = function(debrisID, ...)
  -- function num : 0_10 , upvalues : _ENV, ChooseDebris
  for _,v in ipairs(ChooseDebris) do
    if tonumber(v) == tonumber(debrisID) then
      return true
    end
  end
end

FastSweepWindow.OnShown = function(...)
  -- function num : 0_11
end

FastSweepWindow.OnHide = function(...)
  -- function num : 0_12
end

FastSweepWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : DebrisData, DebrisSort, ChooseDebris, uis
  DebrisData = {}
  DebrisSort = {}
  ChooseDebris = {}
  uis = {}
end

FastSweepWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14
  if msgId == 1 then
  end
end

return FastSweepWindow

