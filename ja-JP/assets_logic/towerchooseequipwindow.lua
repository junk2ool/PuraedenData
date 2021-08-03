-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Tower_ChoiceEquiptByName")
require("TowerTopStageMgr")
require("Tower_ReturnEquiptTipsByName")
local TowerChooseEquipWindow = {}
local uis, contentPane, bridge, argTable, map, expandConfig = nil, nil, nil, nil, nil, nil
local Asset = require("AssetStripWindow")
TowerChooseEquipWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, expandConfig, uis, TowerChooseEquipWindow
  bridgeObj:SetView((WinResConfig.TowerChooseEquipWindow).package, (WinResConfig.TowerChooseEquipWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  expandConfig = argTable[1]
  contentPane:Center()
  uis = GetTower_ChoiceEquiptUis(contentPane)
  ;
  (TowerChooseEquipWindow.InitAssetStrip)()
  ;
  (TowerChooseEquipWindow.LoadChooseEquip)()
end

TowerChooseEquipWindow.LoadChooseEquip = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, TowerChooseEquipWindow, expandConfig
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TipsTxt).text = (PUtil.get)(40002083)
  ;
  (TowerChooseEquipWindow.LoadEquipList)(expandConfig, uis.TipsList)
end

TowerChooseEquipWindow.LoadEquipList = function(expandConfig, list, ...)
  -- function num : 0_2 , upvalues : _ENV
  local towerList = split(expandConfig.towerId, ":")
  local towerCount = #towerList
  list:RemoveChildrenToPool()
  local ChoiceEquiptTipsUrl = UIMgr:GetItemUrl("Tower", "ChoiceEquiptTips")
  for i = 1, towerCount do
    local towerConfig = ((TableData.gTable).BaseTowerData)[tonumber(towerList[i])]
    do
      local desc = towerConfig.equip_buffs
      local item = list:AddItemFromPool(ChoiceEquiptTipsUrl)
      local returnEquipTips = item:GetChild("ReturnEquiptTips")
      local uis = GetTower_ReturnEquiptTipsUis(returnEquipTips)
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (uis.EquiptLoader).url = (Util.GetResUrl)(towerConfig.tower_icon)
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (uis.EquiptNameTxt).text = towerConfig.name
      ;
      (TowerTopStageMgr.SetEquipDesc)(uis.AttributeList, nil, desc)
      ;
      ((item:GetChild("SureBtn")):GetChild("title")).text = (PUtil.get)(40002084)
      ;
      ((item:GetChild("SureBtn")).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV, expandConfig, towerConfig
    local towerCount = #TowerTopStageData.TowerList
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    if towerCount < 2 then
      TowerTopStageData.ExpandConfig = expandConfig
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

      TowerTopStageData.CurrentLayer = tonumber(towerConfig.id)
      ;
      (TowerTopStageService.ReqTowerExpandChooseEquip)(towerConfig.id)
    else
      OpenWindow((WinResConfig.TowerExpandBattleWindow).name, UILayer.HUD, towerConfig)
    end
  end
)
    end
  end
end

TowerChooseEquipWindow.InitAssetStrip = function(...)
  -- function num : 0_3 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.TowerChooseEquipWindow).name
  m.Tip = (PUtil.get)(40002082)
  m.model = uis.AssetStripGrp
  m.closeWindow = (WinResConfig.TowerTopStageWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.SPIRIT}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

TowerChooseEquipWindow.InitBtn = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV, Asset
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(40002082)
  ;
  (((uis.AssetStripGrp).BackBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.TowerChooseEquipWindow).name)
  end
)
  ;
  (((uis.AssetStripGrp).ExplainBtn).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : Asset, _ENV
    local wordId = (Asset.GetFunctionRuleIdByName)("TowerChooseEquipWindow")
    local ruleDes = (PUtil.get)(tonumber(wordId))
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, tostring(ruleDes))
  end
)
end

TowerChooseEquipWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

TowerChooseEquipWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, contentPane, bridge, argTable, _ENV
  uis = nil
  contentPane = nil
  bridge = nil
  argTable = nil
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.TowerChooseEquipWindow).name)
end

return TowerChooseEquipWindow

