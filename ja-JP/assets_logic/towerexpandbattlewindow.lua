-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Tower_TopStageByName")
require("TowerTopStageMgr")
local TowerExpandBattleWindow = {}
local uis, contentPane, bridge, argTable, towerConfig, enterType = nil, nil, nil, nil, nil, nil
local Asset = require("AssetStripWindow")
TowerExpandBattleWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, towerConfig, enterType, uis, TowerExpandBattleWindow
  bridgeObj:SetView((WinResConfig.TowerExpandBattleWindow).package, (WinResConfig.TowerExpandBattleWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  towerConfig = argTable[1]
  enterType = argTable[2]
  contentPane:Center()
  uis = GetTower_TopStageUis(contentPane)
  ;
  (TowerExpandBattleWindow.InitAssetStrip)()
  ;
  (TowerExpandBattleWindow.LoadTopStage)()
end

TowerExpandBattleWindow.InitAssetStrip = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.TowerExpandBattleWindow).name
  m.Tip = (PUtil.get)(40002077)
  m.model = uis.AssetStripGrp
  m.closeWindow = (WinResConfig.TowerTopStageWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.SPIRIT}
  m.BackBtnFun = function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.TowerChooseEquipWindow).name)
  end

  ;
  (CommonWinMgr.RegisterAssets)(m)
end

TowerExpandBattleWindow.LoadTopStage = function(...)
  -- function num : 0_2 , upvalues : TowerExpandBattleWindow, towerConfig, uis
  (TowerExpandBattleWindow.LoadEquip)(towerConfig, (uis.EquiptTips).AttributeList)
  ;
  (TowerExpandBattleWindow.LoadStageList)(towerConfig, uis.TipsList)
end

TowerExpandBattleWindow.LoadEquip = function(config, list, ...)
  -- function num : 0_3 , upvalues : uis, _ENV, towerConfig, enterType
  local desc = config.equip_buffs
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.EquiptTips).NameTxt).text = config.name
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.EquiptTips).EquiptLoader).url = (Util.GetResUrl)(towerConfig.tower_icon)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  if enterType == 1 then
    ((uis.EquiptTips).NameTxt).text = (PUtil.get)(40002078)
  else
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.EquiptTips).NameTxt).text = (PUtil.get)(40002079)
  end
  ;
  (TowerTopStageMgr.SetEquipDesc)(list, nil, desc)
end

TowerExpandBattleWindow.LoadStageList = function(config, list, ...)
  -- function num : 0_4 , upvalues : _ENV
  list:RemoveChildrenToPool()
  local stageIdList = split(config.stages, ":")
  local stageCount = #stageIdList
  local battleTipsBtnUrl = UIMgr:GetItemUrl("Tower", "BattleTipsBtn")
  for i = 1, stageCount do
    local item = list:AddItemFromPool(battleTipsBtnUrl)
    do
      local stageId = tonumber(stageIdList[i])
      local stageConfig = ((TableData.gTable).BaseTowerStageData)[stageId]
      local data = ((TowerTopStageData.BaseInfo)[stageConfig.tower_id])[stageConfig.id]
      local battleTips = item:GetChild("BattleTips")
      ;
      (battleTips:GetChild("NameTxt")).text = stageConfig.name
      ;
      (battleTips:GetChild("PicLoader")).url = (Util.GetItemUrl)(stageConfig.exstage_icon)
      PlayUITrans(item, "up", nil, i * 0.05)
      if data ~= nil and i <= (TowerTopStageData.UnlockStage)[stageConfig.tower_id] then
        if data.isPass then
          if data.challengeRound < 0 then
            (battleTips:GetController("c1")).selectedIndex = 0
            ;
            (battleTips.onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV, stageConfig
    (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
    ;
    (TowerTopStageMgr.CurStageId)(stageConfig.id)
    OpenWindow((WinResConfig.TowerChallengeWindow).name, UILayer.HUD, stageConfig.id, nil, 2)
  end
)
          else
            if data.challengeRound > 0 then
              (battleTips:GetController("c1")).selectedIndex = 2
              ;
              (battleTips.onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(40002086))
  end
)
            else
              ;
              (battleTips.onClick):Set(function(...)
    -- function num : 0_4_2 , upvalues : _ENV, stageConfig
    (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
    ;
    (TowerTopStageMgr.CurStageId)(stageConfig.id)
    OpenWindow((WinResConfig.TowerChallengeWindow).name, UILayer.HUD, stageConfig.id, nil, 2)
  end
)
            end
          end
        else
          ;
          (battleTips:GetController("c1")).selectedIndex = 0
          ;
          (battleTips.onClick):Set(function(...)
    -- function num : 0_4_3 , upvalues : _ENV, stageConfig
    (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
    ;
    (TowerTopStageMgr.CurStageId)(stageConfig.id)
    OpenWindow((WinResConfig.TowerChallengeWindow).name, UILayer.HUD, stageConfig.id, nil, 2)
  end
)
        end
      else
        ;
        (battleTips:GetController("c1")).selectedIndex = 1
        ;
        (battleTips.onClick):Set(function(...)
    -- function num : 0_4_4 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(60000091))
  end
)
      end
    end
  end
end

TowerExpandBattleWindow.InitBtn = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV, Asset
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(40002077)
  ;
  (((uis.AssetStripGrp).BackBtn).onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.TowerExpandBattleWindow).name)
  end
)
  ;
  (((uis.AssetStripGrp).ExplainBtn).onClick):Set(function(...)
    -- function num : 0_5_1 , upvalues : Asset, _ENV
    local wordId = (Asset.GetFunctionRuleIdByName)("TowerExpandBattleWindow")
    local ruleDes = (PUtil.get)(tonumber(wordId))
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, tostring(ruleDes))
  end
)
end

TowerExpandBattleWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

TowerExpandBattleWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, bridge, argTable, _ENV
  uis = nil
  contentPane = nil
  bridge = nil
  argTable = nil
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.TowerExpandBattleWindow).name)
end

return TowerExpandBattleWindow

