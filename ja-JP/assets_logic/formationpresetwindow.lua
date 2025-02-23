-- params : ...
-- function num : 0 , upvalues : _ENV
require("Formation_TeamProgrammeByName")
local PresetStatus = {Normal = 0, Add = 1}
local FormationPresetWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
FormationPresetWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, FormationPresetWindow
  bridgeObj:SetView((WinResConfig.FormationPresetWindow).package, (WinResConfig.FormationPresetWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetFormation_TeamProgrammeUis(contentPane)
  ;
  (FormationPresetWindow.InitTopMenu)()
  ;
  (FormationPresetWindow.InitList)()
end

FormationPresetWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.FormationPresetWindow).name
  m.Tip = (PUtil.get)(60000598)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.moneyTypes = {}
  m.BackBtnFun = function(...)
    -- function num : 0_1_0
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.FormationPresetWindow).name)
  end

  ;
  (CommonWinMgr.RegisterAssets)(m)
end

FormationPresetWindow.InitList = function(...)
  -- function num : 0_2 , upvalues : uis, FormationPresetWindow
  (uis.BattleInformationList):SetVirtual()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleInformationList).itemRenderer = FormationPresetWindow.RefreshPresetItem
end

FormationPresetWindow.OnShown = function(...)
  -- function num : 0_3 , upvalues : FormationPresetWindow
  (FormationPresetWindow.Init)()
end

FormationPresetWindow.OnHide = function(...)
  -- function num : 0_4
end

FormationPresetWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

FormationPresetWindow.Init = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  if (FormationPresetData.Constant).MaxPresetAmount <= #FormationPresetData.PresetData then
    (uis.BattleInformationList).numItems = (FormationPresetData.Constant).MaxPresetAmount
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.BattleInformationList).numItems = #FormationPresetData.PresetData + 1
  end
end

FormationPresetWindow.RefreshPresetItem = function(index, item, ...)
  -- function num : 0_7 , upvalues : _ENV, PresetStatus, uis
  index = index + 1
  item = item:GetChild("TeamTipsBtn")
  if #FormationPresetData.PresetData < index then
    (item:GetController("c1")).selectedIndex = PresetStatus.Add
    ;
    ((item.parent).onClick):Set(function(...)
    -- function num : 0_7_0 , upvalues : _ENV
    (MessageMgr.OpenFormationPresetEditWindow)({}, (WinResConfig.FormationPresetWindow).name)
  end
)
  else
    ;
    (item:GetController("c1")).selectedIndex = PresetStatus.Normal
    ;
    ((item.parent).onClick):Clear()
    local data = (FormationPresetData.PresetData)[index]
    do
      (item:GetChild("NameTxt")).text = data.name
      ;
      (item:GetChild("BattleWordTxt")).text = (PUtil.get)(60000235)
      ;
      (item:GetChild("BattleNumberTxt")).text = (FormationPresetData.PresetFC)[data.id]
      local list = item:GetChild("HeadList")
      list:RemoveChildrenToPool()
      local count = #data.deckSchemes
      local subItem, status = nil, nil
      local unUsed = 0
      local disable = {}
      local lowLevel = {}
      local partialAvailable = {}
      local btnStatus = FormationPresetCardsStatus.Normal
      for i = 1, count do
        if ((data.deckSchemes)[i]).id ~= 0 then
          local card = (CardData.GetCardData)(((data.deckSchemes)[i]).id)
          subItem = list:AddItemFromPool()
          if FormationPresetData.ExternalData then
            status = ((FormationPresetData.ExternalData).GetCardStatus)(card.id)
            if (FormationPresetData.ExternalData).Type == FormationType.Expedition and status == (ExpeditionMgr.CardState).NoFight then
              unUsed = unUsed + 1
            end
          end
          ;
          (Util.SetHeadFrame)(subItem, card)
          if status and status == 0 then
            (subItem:GetController("c3")).selectedIndex = 1
            ;
            (table.insert)(lowLevel, card.id)
          else
            if status and (ExpeditionMgr.CardState).Normal < status then
              (subItem:GetController("c3")).selectedIndex = status
              ;
              (table.insert)(disable, card.id)
            else
              ;
              (subItem:GetController("c3")).selectedIndex = 1
              ;
              (table.insert)(partialAvailable, (data.deckSchemes)[i])
            end
          end
        end
      end
      if #disable + #lowLevel == count then
        btnStatus = FormationPresetCardsStatus.NotAvailable
      else
        if (#disable > 0 and #disable < count) or #lowLevel > 0 and #lowLevel < count then
          btnStatus = FormationPresetCardsStatus.PartialAvailable
        end
        if FormationPresetData.ExternalData and (FormationPresetData.ExternalData).Type == FormationType.Expedition and ((FormationPresetData.ExternalData).GetAvailableCount)() < unUsed then
          btnStatus = FormationPresetCardsStatus.ExpeditionOutOfLimit
        end
      end
      local btn = item:GetChild("EditBtn")
      btn.text = (PUtil.get)(60000600)
      ;
      (btn.onClick):Set(function(...)
    -- function num : 0_7_1 , upvalues : _ENV, data
    (MessageMgr.OpenFormationPresetEditWindow)(data, (WinResConfig.FormationPresetWindow).name)
  end
)
      btn = item:GetChild("UseBtn")
      if FormationPresetData.ChosedPreset and data.id == (FormationPresetData.ChosedPreset).id then
        btn.text = (PUtil.get)(68)
        ;
        (btn.onClick):Set(function(...)
    -- function num : 0_7_2 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(117))
  end
)
      else
        btn.text = (PUtil.get)(20000032)
        ;
        (btn.onClick):Set(function(...)
    -- function num : 0_7_3 , upvalues : btnStatus, _ENV, partialAvailable, data, uis
    if btnStatus == FormationPresetCardsStatus.NotAvailable then
      if (FormationPresetData.ExternalData).Type == FormationType.Expedition then
        (MessageMgr.SendCenterTips)((PUtil.get)(60000609))
      else
        if (FormationPresetData.ExternalData).Type == FormationType.Relic then
          (MessageMgr.SendCenterTips)((PUtil.get)(60000614))
        end
      end
      return 
    else
      if btnStatus == FormationPresetCardsStatus.ExpeditionOutOfLimit then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000181))
        return 
      else
        if btnStatus == FormationPresetCardsStatus.PartialAvailable then
          if (FormationPresetData.ExternalData).Type == FormationType.Expedition then
            (MessageMgr.SendCenterTips)((PUtil.get)(60000610))
          else
            if (FormationPresetData.ExternalData).Type == FormationType.Relic then
              (MessageMgr.SendCenterTips)((PUtil.get)(60000613))
            end
          end
          -- DECOMPILER ERROR at PC90: Confused about usage of register: R0 in 'UnsetPending'

          ;
          (MessageMgr.formationData).myselfList = (Util.CovertRemoteFormationToLocal)(partialAvailable)
        else
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(60000606))
          -- DECOMPILER ERROR at PC105: Confused about usage of register: R0 in 'UnsetPending'

          ;
          (MessageMgr.formationData).myselfList = (Util.CovertRemoteFormationToLocal)(data.deckSchemes)
        end
      end
    end
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R0 in 'UnsetPending'

    FormationPresetData.ChosedPreset = (Util.Copy)(data)
    -- DECOMPILER ERROR at PC117: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (FormationPresetData.ChosedPreset).RealFormation = (MessageMgr.formationData).myselfList
    ;
    (table.sort)(FormationPresetData.PresetData, FormationPresetData.Sort)
    ;
    (uis.BattleInformationList):RefreshVirtualList()
    -- DECOMPILER ERROR at PC129: Confused about usage of register: R0 in 'UnsetPending'

    FormationPresetData.FormationData = nil
    UIMgr:SendWindowMessage((WinResConfig.FormationWindow).name, (WindowMsgEnum.FormationPreset).E_MSG_REFRESH)
    UIMgr:CloseWindow((WinResConfig.FormationPresetWindow).name)
  end
)
      end
    end
  end
end

FormationPresetWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8 , upvalues : _ENV, uis, FormationPresetWindow
  if msgId == (WindowMsgEnum.FormationPreset).E_MSG_REFRESH_PRESET then
    if para then
      (uis.BattleInformationList):RefreshVirtualList()
    else
      ;
      (FormationPresetWindow.Init)()
    end
  end
end

return FormationPresetWindow

