-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_ThemeMainStageByName")
require("Tower_ThemeMainBtnByName")
require("Tower_ReturnBtnByName")
require("TowerTopStageMgr")
TowerTopStageWindow = {}
local uis, contentPane, bridge, argTable = nil, nil, nil, nil
local Asset = require("AssetStripWindow")
-- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

TowerTopStageWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, uis
  bridgeObj:SetView((WinResConfig.TowerTopStageWindow).package, (WinResConfig.TowerTopStageWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetTower_ThemeMainStageUis(contentPane)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  TowerData.IsExpand = true
  ;
  (TowerTopStageWindow.InitAssetStrip)()
  ;
  (TowerTopStageWindow.UpdatePanelInfo)()
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

TowerTopStageWindow.InitAssetStrip = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.TowerTopStageWindow).name
  m.Tip = (PUtil.get)(40002076)
  m.model = uis.AssetStripGrp
  m.closeWindow = (WinResConfig.TowerWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.SPIRIT}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

TowerTopStageWindow.UpdatePanelInfo = function(...)
  -- function num : 0_2 , upvalues : _ENV
  (TowerTopStageWindow.LoadEntrance)()
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

TowerTopStageWindow.LoadEntrance = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  local entranceList = uis.ThemeMainStageList
  entranceList:RemoveChildrenToPool()
  local entranceData = TowerTopStageData.InterTypeSort
  local type = 1
  for k,v in pairs(entranceData) do
    if v.type == 2 then
      type = 2
      break
    end
  end
  do
    for k,v in pairs(entranceData) do
      if v.type == 1 then
        (TowerTopStageWindow.LoadNewEntrance)(entranceList, k, type)
      end
    end
    for k,v in pairs(entranceData) do
      if v.type == 2 then
        (TowerTopStageWindow.LoadOldEntrance)(entranceList, k)
      end
    end
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

TowerTopStageWindow.LoadOldEntrance = function(list, id, ...)
  -- function num : 0_4 , upvalues : _ENV
  local config = ((TableData.gTable).BaseTowerExpandData)[tonumber(id)]
  local returnItem = list:AddItemFromPool(UIMgr:GetItemUrl("Tower", "ReturnBtn"))
  local itemUis = GetTower_ReturnBtnUis(returnItem)
  local open = (TowerTopStageMgr.CheckEntranceOpen)(config)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

  if open == true then
    (itemUis.NameTxt).text = (PUtil.get)(40002079)
    local beginTime, endTime = (TowerTopStageMgr.GetEntranceTime)(config)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (itemUis.TimeTxt).text = (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M:%S", beginTime) .. " - " .. (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M:%S", endTime)
  else
    do
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (itemUis.NameTxt).text = (PUtil.get)(40002080)
      local openTime = (TowerTopStageMgr.GetEnterNextOpenTime)(config)
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R7 in 'UnsetPending'

      if openTime == 0 then
        (itemUis.TimeTxt).text = (PUtil.get)(40002088)
      else
        local str = (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M:%S", openTime)
        -- DECOMPILER ERROR at PC79: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (itemUis.TimeTxt).text = str .. (PUtil.get)(40002087)
      end
      do
        local loder = (returnItem:GetChild("ReturnPic")):GetChild("PicLoader")
        local texture = (ResHelper.LoadTexture)(config.normal_pic)
        SetLoaderTexture(loder, texture)
        ;
        (returnItem.onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV, config
    if (TowerTopStageMgr.CheckEntranceOpen)(config) then
      local id = (TowerTopStageMgr.GetOldData)()
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

      if id ~= nil then
        TowerTopStageData.CurrentLayer = id
        local towerConfig = ((TableData.gTable).BaseTowerData)[id]
        OpenWindow((WinResConfig.TowerExpandBattleWindow).name, UILayer.HUD, towerConfig, 2)
      else
        do
          do
            OpenWindow((WinResConfig.TowerChooseEquipWindow).name, UILayer.HUD, config)
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(40002085))
          end
        end
      end
    end
  end
)
      end
    end
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

TowerTopStageWindow.LoadNewEntrance = function(list, id, type, ...)
  -- function num : 0_5 , upvalues : _ENV
  local config = ((TableData.gTable).BaseTowerExpandData)[tonumber(id)]
  local mainItem = list:AddItemFromPool(UIMgr:GetItemUrl("Tower", "ThemeMainBtn"))
  local itemUis = GetTower_ThemeMainBtnUis(mainItem)
  local open = (TowerTopStageMgr.CheckEntranceOpen)(config)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

  if type == 2 then
    (itemUis.c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (itemUis.c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R7 in 'UnsetPending'

  if open == true then
    (itemUis.NameTxt).text = (PUtil.get)(40002078)
    local beginTime, endTime = (TowerTopStageMgr.GetEntranceTime)(config)
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (itemUis.TimeTxt).text = (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M:%S", beginTime) .. " - " .. (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M:%S", endTime)
  else
    do
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (itemUis.NameTxt).text = (PUtil.get)(40002080)
      local openTime = (TowerTopStageMgr.GetEnterNextOpenTime)(config)
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R8 in 'UnsetPending'

      if openTime == 0 then
        (itemUis.TimeTxt).text = (PUtil.get)(40002088)
      else
        local str = (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M:%S", openTime)
        -- DECOMPILER ERROR at PC86: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (itemUis.TimeTxt).text = str .. (PUtil.get)(40002087)
      end
      do
        local towerConfig = ((TableData.gTable).BaseTowerData)[tonumber(config.towerId)]
        local loder = (mainItem:GetChild("ThemePic")):GetChild("PicLoader")
        local texture = (ResHelper.LoadTexture)(config.normal_pic)
        SetLoaderTexture(loder, texture)
        ;
        (mainItem.onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : _ENV, config, towerConfig
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    if (TowerTopStageMgr.CheckEntranceOpen)(config) then
      TowerTopStageData.CurrentLayer = tonumber(config.towerId)
      OpenWindow((WinResConfig.TowerExpandBattleWindow).name, UILayer.HUD, towerConfig, 1)
    else
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(40002085))
    end
  end
)
      end
    end
  end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'

TowerTopStageWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

TowerTopStageWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, argTable, bridge, _ENV
  uis = nil
  contentPane = nil
  argTable = {}
  bridge = nil
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  TowerData.IsExpand = false
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.TowerTopStageWindow).name)
end

return TowerTopStageWindow

