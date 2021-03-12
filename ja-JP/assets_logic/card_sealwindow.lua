-- params : ...
-- function num : 0 , upvalues : _ENV
Card_SealWindow = {}
local currentID, uis, selectSkillConfig, attrPanel = nil, nil, nil, nil
local isAlreadyClick = true
-- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.Init = function(uiRoot, ...)
  -- function num : 0_0 , upvalues : uis, _ENV, currentID, selectSkillConfig, isAlreadyClick
  uis = GetCard_StarGrpUis(uiRoot)
  currentID = (CardData.ReturnCardID)()
  local lv = (CardData.GetCardSealLv)(currentID)
  loge(currentID .. "           印纹等级:          " .. lv)
  ;
  (Card_SealWindow.RevertSfxParent)()
  selectSkillConfig = nil
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  if lv < 0 then
    (uis.c1Ctr).selectedIndex = 2
    ;
    (Card_SealWindow.SetCanOpenInfo)()
  else
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 3
    ;
    (Card_SealWindow.RefreshSealUp)()
  end
  ;
  (Card_SealWindow.SetInvariable)()
  ;
  (Card_SealWindow.SetCurrentChooseSkill)(-1)
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.c2Ctr).selectedIndex = 0
  UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SEAL_SKILL_SHOW, false)
  PlayUITrans(((uis.Imprint).ImprintMap).root, "up")
  ;
  (Card_SealWindow.ProcessOpenSfx)(lv)
  isAlreadyClick = (Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_ATTACK, "0") == "1"
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC9: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.ProcessOpenSfx = function(lv, ...)
  -- function num : 0_1 , upvalues : uis, _ENV
  local effect = uis.ImprintEffect
  local mSfx = (effect.root):GetChild("SealOpenButtonSfx")
  do
    -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

    if lv < 0 and mSfx == nil then
      local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_SEAL_OPEN_BUTTON, true, false)
      holder.name = "SealOpenButtonSfx"
      holder.xy = Vector2(-196, -150)
      ;
      (effect.root):AddChildAt(holder, 1)
    end
    if mSfx then
      (effect.root):RemoveChild(mSfx)
      ;
      (LuaEffect.DestroyEffect)(mSfx)
    end
  end
end

-- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.SetInvariable = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, currentID, attrPanel
  (((uis.ImprintEffect).ImprintBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV, currentID, uis
    (CardService.ReqSealOpen)(currentID)
    local sealPanel = uis.root
    local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_SEAL_OPEN, true, false)
    holder.xy = Vector2(-30, sealPanel.height / 2 + 30)
    sealPanel:AddChild(holder)
    PlayUITrans(((uis.Imprint).ImprintMap).root, "up")
  end
)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000641)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Imprint).ImprintUpBtn).text = (PUtil.get)(20000642)
  ;
  ((uis.TipsBtn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : _ENV, currentID, attrPanel
    local mlv = (CardData.GetCardSealLv)(currentID)
    if mlv < 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000657))
      return 
    end
    if attrPanel == nil then
      attrPanel = UIMgr:CreateObject("Card", "ImprintAttributeTips")
      ;
      (GRoot.inst):AddChild(attrPanel)
      attrPanel.xy = Vector2(300, 150)
    end
    ;
    (Card_SealWindow.SetAttrInfo)()
    attrPanel.visible = true
    ;
    (GRoot.inst):AddCustomPopups(attrPanel, function(...)
      -- function num : 0_2_1_0 , upvalues : attrPanel
      attrPanel.visible = false
    end
)
  end
)
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.SetAttrInfo = function(...)
  -- function num : 0_3 , upvalues : _ENV, currentID, attrPanel
  local mlv = (CardData.GetCardSealLv)(currentID)
  ;
  (attrPanel:GetChild("Word_01_Txt")).text = (PUtil.get)(20000647)
  local mList = attrPanel:GetChild("Attribute_01_List")
  mList:RemoveChildrenToPool()
  local currentAttr = (CardData.GetCardSealAttr)(currentID, mlv)
  local baseData = ((TableData.gTable).BaseCardData)[currentID]
  local config = ((CardData.GetSealConfig)(baseData.seal_grow_type, mlv))
  local nextAttr = nil
  if config.next_id == 0 then
    nextAttr = "-1"
  else
    nextAttr = (CardData.GetCardSealAttr)(currentID, mlv + 1)
  end
  local attrTable = (Card_SealWindow.IntegrationAttr)(currentAttr, nextAttr)
  for _,v in ipairs(attrTable) do
    local item = mList:AddItemFromPool()
    local attrTable = ((TableData.gTable).BaseAttributeData)[tonumber(v.id)]
    ;
    (item:GetChild("n1")).text = attrTable.display_name
    ;
    (item:GetChild("n2")).text = v.start
    ;
    (item:GetChild("n4")).text = v.endValue
  end
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.IntegrationAttr = function(current, next, ...)
  -- function num : 0_4 , upvalues : _ENV
  local currentTable = (Util.ParseConfigStr)(current)
  local nextTable = (Util.ParseConfigStr)(next)
  local attrTable = {}
  local recordAttr = {}
  for _,v in ipairs(currentTable) do
    if v[1] == "1" then
      local attrID = v[2]
      local attrValueStart = v[3]
      local attrValueEnd = nil
      if next == "-1" then
        attrValueEnd = ""
      else
        for _,v2 in ipairs(nextTable) do
          if v2[2] == attrID then
            attrValueEnd = v2[3]
            recordAttr[attrID] = 1
          end
        end
      end
      do
        do
          local compare = {id = attrID, start = attrValueStart, endValue = attrValueEnd}
          ;
          (table.insert)(attrTable, compare)
          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for _,v in ipairs(nextTable) do
    local attrID = v[2]
    if recordAttr[attrID] == nil then
      local compare = {id = attrID, start = 0, endValue = v[3]}
      ;
      (table.insert)(attrTable, compare)
    end
  end
  return attrTable
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.SetCanOpenInfo = function(...)
  -- function num : 0_5 , upvalues : _ENV, currentID, uis
  local baseData = ((TableData.gTable).BaseCardData)[currentID]
  local cardData = (CardData.GetCardData)(currentID)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.HeadFrameGrp).LevelTxt).text = ""
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.HeadFrameGrp).StageTxt).text = ""
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.HeadFrameGrp).QualityCtrlCtr).selectedIndex = baseData.intelligence + 1
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.HeadFrameGrp).IconLoader).url = (CardMgr.GetHeadIconSquareUrl)(cardData)
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.SetCurrentChooseSkill = function(ChooseIndex, ...)
  -- function num : 0_6 , upvalues : _ENV, currentID, uis
  local baseData = ((TableData.gTable).BaseCardData)[currentID]
  local sealList = split(baseData.seal_list, ":")
  for i,v in ipairs(sealList) do
    local button = (((uis.Imprint).ImprintMap).root):GetChild("ImprintSkill_" .. i .. "_Btn")
    button.selected = i == ChooseIndex
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.CheckSkillCanLevelUp = function(type, ...)
  -- function num : 0_7 , upvalues : _ENV, currentID
  local lv = (CardData.GetSealSkillLv)(currentID, type) or 0
  local nextConfig = (CardData.GetSealSkillConfig)(type, lv + 1)
  if nextConfig == nil then
    return false
  end
  local isSatisfy = (CardData.SealSkillCanLevelUp)(currentID, nextConfig)
  local currentConfig = (CardData.GetSealSkillConfig)(type, lv)
  local currentCost = currentConfig.next_cost
  local constSat = (Util.CheckCostResources)(currentCost, nil, nil, true)
  return not isSatisfy or constSat
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.RevertSfxParent = function(...)
  -- function num : 0_8 , upvalues : _ENV, currentID, uis
  local baseData = ((TableData.gTable).BaseCardData)[currentID]
  local sealList = split(baseData.seal_list, ":")
  for i,v in ipairs(sealList) do
    local button = (((uis.Imprint).ImprintMap).root):GetChild("ImprintSkill_" .. i .. "_Btn")
    local sfx = button:GetChild("LoopSfx")
    if sfx then
      button:RemoveChild(sfx)
      ;
      (LuaEffect.DestroyEffect)(sfx)
    end
  end
  local sealPanel = (uis.Imprint).root
  local sfx = sealPanel:GetChild("SealLoopMaxSfx")
  if sfx then
    sealPanel:RemoveChild(sfx)
    ;
    (LuaEffect.DestroyEffect)(sfx)
  end
  local skillPanel = (uis.ImprintSkillUp).root
  local sfx = skillPanel:GetChild("LoopMaxSfx")
  if sfx then
    skillPanel:RemoveChild(sfx)
    ;
    (LuaEffect.DestroyEffect)(sfx)
  end
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.RefreshSealUp = function(...)
  -- function num : 0_9 , upvalues : _ENV, currentID, uis, isAlreadyClick, selectSkillConfig
  local baseData = ((TableData.gTable).BaseCardData)[currentID]
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.Imprint).ImprintMap).c1Ctr).selectedIndex = baseData.seal_icon
  local sealList = split(baseData.seal_list, ":")
  for i,v in ipairs(sealList) do
    do
      local button = (((uis.Imprint).ImprintMap).root):GetChild("ImprintSkill_" .. i .. "_Btn")
      ;
      (button:GetChild("ClickTips")).visible = not isAlreadyClick and i == 1
      ChangeUIController(button, "c2", i - 1)
      local line = (((uis.Imprint).ImprintMap).root):GetChild("Line" .. i - 1)
      local lv = (CardData.GetSealSkillLv)(currentID, v)
      local config = (CardData.GetSealSkillConfig)(v, lv or 0)
      ;
      (button:GetChild("ImprintSkillLoader")).url = (Util.GetItemUrl)(config.icon_path)
      if (Card_SealWindow.CheckSkillCanLevelUp)(v) then
        local sfx = button:GetChild("LoopSfx")
        if sfx == nil then
          local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_SEAL_LOOP, true, true)
          holder.name = "LoopSfx"
          holder.xy = Vector2(button.width / 2, button.height / 2)
          button:AddChild(holder)
        end
      else
        local sfx = button:GetChild("LoopSfx")
        if sfx then
          button:RemoveChild(sfx)
          ;
          (LuaEffect.DestroyEffect)(sfx)
        end
      end
      if line ~= nil then
        if lv == nil then
          ChangeUIController(line, "c1", 0)
        else
          ChangeUIController(line, "c1", 1)
        end
      end
      if lv == nil then
        ChangeUIController(button, "c1", 0)
      elseif config.next_id == 0 then
        ChangeUIController(button, "c1", 2)
      else
        ChangeUIController(button, "c1", 1)
      end
      ;
      (button.onClick):Set(function(...)
    -- function num : 0_9_0 , upvalues : selectSkillConfig, config, uis, _ENV, i, isAlreadyClick, button
    if selectSkillConfig == config then
      selectSkillConfig = nil
      -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.c2Ctr).selectedIndex = 0
      ;
      (Card_SealWindow.SetCurrentChooseSkill)(-1)
      UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SEAL_SKILL_SHOW, false)
    else
      selectSkillConfig = config
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.c2Ctr).selectedIndex = 1
      ;
      (Card_SealWindow.SetSealSkillInfo)(false)
      ;
      (Card_SealWindow.SetCurrentChooseSkill)(i)
    end
    if not isAlreadyClick then
      (Util.SetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_ATTACK, "1")
      ;
      (button:GetChild("ClickTips")).visible = false
    end
    isAlreadyClick = true
  end
)
    end
  end
  ;
  (Card_SealWindow.SetSealConsume)()
  ;
  (Card_SealWindow.RefreshSealTimesShow)()
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.GetCurrentSealIndex = function(...)
  -- function num : 0_10 , upvalues : _ENV, currentID
  local baseData = ((TableData.gTable).BaseCardData)[currentID]
  local seal_list = split(baseData.seal_level_list, ":")
  local mlv = (CardData.GetCardSealLv)(currentID)
  for i = 1, #seal_list do
    if mlv < tonumber(seal_list[i]) then
      return i
    end
  end
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.GetSelectSealSkillIndex = function(...)
  -- function num : 0_11 , upvalues : _ENV, currentID, selectSkillConfig
  local baseData = ((TableData.gTable).BaseCardData)[currentID]
  local seal_list = split(baseData.seal_list, ":")
  for i = 1, #seal_list do
    if tonumber(seal_list[i]) == selectSkillConfig.type then
      return i
    end
  end
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.RefreshSealTimesShow = function(...)
  -- function num : 0_12 , upvalues : _ENV, currentID, uis
  local baseData = ((TableData.gTable).BaseCardData)[currentID]
  local seal_list = split(baseData.seal_level_list, ":")
  local mlv = (CardData.GetCardSealLv)(currentID)
  local index = 0
  for i = 1, #seal_list do
    if mlv < tonumber(seal_list[i]) then
      index = i
      break
    end
  end
  do
    local maxLV = (CardData.GetMaxSealLv)(currentID)
    for i = 1, #seal_list do
      local button = (((uis.Imprint).ImprintMap).root):GetChild("ImprintSkill_" .. i .. "_Btn")
      local numText = button:GetChild("ImprintProgress")
      numText.visible = i == index
      if i == index then
        (numText:GetChild("ProgressTxt")).text = mlv .. "/" .. seal_list[i]
        if maxLV == mlv then
          numText.visible = false
        end
      end
    end
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (uis.TipsBtn).visible = maxLV ~= mlv
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

Card_SealWindow.SetSealConsume = function(...)
  -- function num : 0_13 , upvalues : _ENV, currentID, uis, selectSkillConfig
  local mlv = (CardData.GetCardSealLv)(currentID)
  local maxLV = (CardData.GetMaxSealLv)(currentID)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.Imprint).ImprintMap).c2Ctr).selectedIndex = mlv == maxLV and 1 or 0
  local baseData = ((TableData.gTable).BaseCardData)[currentID]
  local config = (CardData.GetSealConfig)(baseData.seal_grow_type, mlv)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

  if config.next_id == 0 then
    ((uis.Imprint).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.Imprint).c1Ctr).selectedIndex = 0
  end
  local sealPanel = (uis.Imprint).root
  if config.next_id == 0 then
    local sfx = sealPanel:GetChild("SealLoopMaxSfx")
    if sfx == nil then
      local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_SEAL_FULL, true, true)
      holder.name = "SealLoopMaxSfx"
      holder.xy = Vector2(sealPanel.width / 2, sealPanel.height / 2)
      sealPanel:AddChildAt(holder, 1)
    end
  else
    do
      do
        local sfx = sealPanel:GetChild("SealLoopMaxSfx")
        if sfx then
          sealPanel:RemoveChild(sfx)
          ;
          (LuaEffect.DestroyEffect)(sfx)
        end
        local consume = config.next_cost
        local consumeList = split(consume, ",")
        if consume and consume ~= "0" then
          do
            for i = 1, 2 do
              local con = consumeList[i]
              if i == 1 then
                (Util.SetConsumption)(con, ((uis.Imprint).SpendA).ItemLoader, ((uis.Imprint).SpendA).NumberTxt, false, true)
                ;
                ((((uis.Imprint).SpendA).TouchBtn).onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : _ENV, con
    (Util.ShowGetWay)(tonumber((split(con, ":"))[2]))
  end
)
              else
                ;
                (Util.SetConsumption)(con, ((uis.Imprint).SpendB).ItemLoader, ((uis.Imprint).SpendB).NumberTxt, false, true)
                ;
                ((((uis.Imprint).SpendB).TouchBtn).onClick):Set(function(...)
    -- function num : 0_13_1 , upvalues : _ENV, con
    (Util.ShowGetWay)(tonumber((split(con, ":"))[2]))
  end
)
              end
            end
          end
        end
        do
          ;
          (((uis.Imprint).ImprintUpBtn).onClick):Set(function(...)
    -- function num : 0_13_2 , upvalues : _ENV, baseData, mlv, currentID, selectSkillConfig, uis, consume, consumeList
    local nextConfig = (CardData.GetSealConfig)(baseData.seal_grow_type, mlv + 1)
    local needSkill = nextConfig.need_skill_id
    if needSkill > 0 then
      local SealLevelUp = ((TableData.gTable).BaseCardSealSkillUpData)[needSkill]
      local lv = (CardData.GetSealSkillLv)(currentID, SealLevelUp.type) or -1
      if lv < SealLevelUp.level then
        if lv == 0 then
          (MessageMgr.SendCenterTips)((PUtil.get)(20000648, SealLevelUp.name))
        else
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(20000654, SealLevelUp.name, SealLevelUp.level))
        end
        local baseData = ((TableData.gTable).BaseCardData)[currentID]
        local sealList = split(baseData.seal_list, ":")
        for i,v in ipairs(sealList) do
          if SealLevelUp.type == tonumber(v) then
            (Card_SealWindow.SetCurrentChooseSkill)(i)
            lv = (CardData.GetSealSkillLv)(currentID, v)
            local config = (CardData.GetSealSkillConfig)(v, lv or 0)
            selectSkillConfig = config
            -- DECOMPILER ERROR at PC82: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (uis.c2Ctr).selectedIndex = 1
            ;
            (Card_SealWindow.SetSealSkillInfo)()
          end
        end
        return 
      end
    end
    do
      if (Util.CheckCostResources)(consume, nil, nil, true) then
        (CardService.ReqSealUp)(currentID)
        local index = (Card_SealWindow.GetCurrentSealIndex)()
        local button = (((uis.Imprint).ImprintMap).root):GetChild("ImprintSkill_" .. index .. "_Btn")
        ;
        (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_SEAL_UNLOCK, true, button, (Vector2(button.width / 2, button.height / 2)), nil, nil, true)
      else
        do
          for _,v in ipairs(consumeList) do
            if not (Util.CheckCostResources)(v, nil, nil, true) then
              local mConsume = split(v, ":")
              local mID = tonumber(mConsume[2])
              local mNeed = tonumber(mConsume[3])
              local own = (ActorData.GetPropsByID)(mID)
              ;
              (Util.ShowGetWay)(mID, nil, mNeed, mNeed - own)
              return 
            end
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
end

local itemTable = {}
-- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

Card_SealWindow.SetSealSkillInfo = function(RefreshData, delayShow, ...)
  -- function num : 0_14 , upvalues : selectSkillConfig, uis, _ENV, currentID, itemTable
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if selectSkillConfig == nil then
    (uis.c2Ctr).selectedIndex = 0
    return 
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.ImprintSkillUp).ImprintSkillShow).c1Ctr).selectedIndex = (Card_SealWindow.GetSelectSealSkillIndex)() - 1
  UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SEAL_SKILL_SHOW, true)
  local skillType = selectSkillConfig.type
  local lv = (CardData.GetSealSkillLv)(currentID, skillType)
  if not lv then
    selectSkillConfig = (CardData.GetSealSkillConfig)(skillType, not RefreshData and not lv or lv <= 0 or 0)
    ;
    ((((uis.ImprintSkillUp).ImprintSkillShow).root).onClick):Set(function(...)
    -- function num : 0_14_0 , upvalues : _ENV, selectSkillConfig
    OpenWindow((WinResConfig.CardSealSkillTipsWindow).name, UILayer.HUD1, selectSkillConfig.id)
  end
)
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((uis.ImprintSkillUp).ImprintSkillShow).ImprintSkillLoader).url = (Util.GetItemUrl)(selectSkillConfig.icon_path)
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.ImprintSkillUp).NameTxt).text = selectSkillConfig.name
    local mLV = (CardData.GetSealSkillLv)(currentID, selectSkillConfig.type)
    local skillPanel = (uis.ImprintSkillUp).root
    if mLV and selectSkillConfig.next_id == 0 then
      local sfx = skillPanel:GetChild("LoopMaxSfx")
      if sfx == nil then
        local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_SEAL_SKILL_FULL, true, true)
        holder.name = "LoopMaxSfx"
        holder.xy = Vector2(skillPanel.width / 2 - 30, skillPanel.height / 2 - 40)
        skillPanel:AddChildAt(holder, 2)
      end
    else
      do
        do
          local sfx = skillPanel:GetChild("LoopMaxSfx")
          if sfx then
            skillPanel:RemoveChild(sfx)
            ;
            (LuaEffect.DestroyEffect)(sfx)
          end
          local canClick = false
          -- DECOMPILER ERROR at PC119: Confused about usage of register: R7 in 'UnsetPending'

          if mLV == nil then
            ((uis.ImprintSkillUp).c1Ctr).selectedIndex = 0
            -- DECOMPILER ERROR at PC126: Confused about usage of register: R7 in 'UnsetPending'

            ;
            ((uis.ImprintSkillUp).LevelTxt).text = (PUtil.get)(20000645)
            -- DECOMPILER ERROR at PC133: Confused about usage of register: R7 in 'UnsetPending'

            ;
            ((uis.ImprintSkillUp).ImprintTipsTxt).text = (PUtil.get)(20000646)
            -- DECOMPILER ERROR at PC136: Confused about usage of register: R7 in 'UnsetPending'

            ;
            ((uis.ImprintSkillUp).ImprintTipsTxt).visible = true
          else
            -- DECOMPILER ERROR at PC145: Confused about usage of register: R7 in 'UnsetPending'

            if mLV > 0 then
              ((uis.ImprintSkillUp).LevelTxt).text = "Lv." .. mLV
              -- DECOMPILER ERROR at PC150: Confused about usage of register: R7 in 'UnsetPending'

              ;
              ((uis.ImprintSkillUp).LevelTxt).color = Const.WhiteColorRGB
            else
              -- DECOMPILER ERROR at PC158: Confused about usage of register: R7 in 'UnsetPending'

              ;
              ((uis.ImprintSkillUp).LevelTxt).text = (PUtil.get)(20000655)
              -- DECOMPILER ERROR at PC163: Confused about usage of register: R7 in 'UnsetPending'

              ;
              ((uis.ImprintSkillUp).LevelTxt).color = Const.LackColorRGB
            end
            local delayTime = delayShow and 0.5 or 0
            ;
            (SimpleTimer.setTimeout)(delayTime, function(...)
    -- function num : 0_14_1 , upvalues : canClick, selectSkillConfig, uis, _ENV, mLV, currentID, itemTable
    canClick = true
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    if selectSkillConfig.next_id == 0 then
      ((uis.ImprintSkillUp).c1Ctr).selectedIndex = 2
    else
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.ImprintSkillUp).c1Ctr).selectedIndex = 1
      local const = selectSkillConfig.next_cost
      do
        (Card_SealWindow.SetSkillUpConsumeShow)(const)
        -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

        if mLV == 0 then
          ((uis.ImprintSkillUp).UpSureBtn).text = (PUtil.get)(20000643)
        else
          -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

          ;
          ((uis.ImprintSkillUp).UpSureBtn).text = (PUtil.get)(20000644)
        end
        ;
        (((uis.ImprintSkillUp).UpSureBtn).onClick):Set(function(...)
      -- function num : 0_14_1_0 , upvalues : canClick, _ENV, selectSkillConfig, currentID, const, mLV, itemTable, uis
      if not canClick then
        return 
      end
      local nextConfig = (CardData.GetSealSkillConfig)(selectSkillConfig.type, selectSkillConfig.level + 1)
      local isSatisfy = (CardData.SealSkillCanLevelUp)(currentID, nextConfig)
      if not isSatisfy then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000649))
        return 
      end
      if (Util.CheckCostResources)(const, nil, nil, false, false, true) then
        if mLV == 0 then
          (CardService.ReqSealSkillAc)(currentID, selectSkillConfig.type)
        else
          ;
          (CardService.ReqSealSkillUp)(currentID, selectSkillConfig.type)
        end
        do
          for _,v in ipairs(itemTable) do
            if v.visible == true then
              (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_SEAL_SKILL_ITEM_UNLOCK, true, v, (Vector2(v.width / 2, v.height / 2)), nil, nil, true)
            end
          end
        end
        local skillObj = ((uis.ImprintSkillUp).ImprintSkillShow).root
        ;
        (SimpleTimer.setTimeout)(0.3, function(...)
        -- function num : 0_14_1_0_0 , upvalues : _ENV, skillObj
        (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_SEAL_SKILL_UNLOCK, true, skillObj, (Vector2(skillObj.width / 2, skillObj.height / 2)), nil, nil, true)
      end
)
      end
    end
)
      end
    end
  end
)
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

Card_SealWindow.SetSkillUpConsumeShow = function(const, ...)
  -- function num : 0_15 , upvalues : itemTable, _ENV, uis
  itemTable = {}
  ;
  (table.insert)(itemTable, ((uis.ImprintSkillUp).ItemOneGrp).root)
  ;
  (table.insert)(itemTable, ((uis.ImprintSkillUp).ItemTwoGrp).root)
  ;
  (table.insert)(itemTable, ((uis.ImprintSkillUp).ItemThreeGrp).root)
  ;
  (table.insert)(itemTable, ((uis.ImprintSkillUp).ItemSixGrp).root)
  ;
  (table.insert)(itemTable, ((uis.ImprintSkillUp).ItemFiveGrp).root)
  ;
  (table.insert)(itemTable, ((uis.ImprintSkillUp).ItemFourGrp).root)
  local constTable = (Util.ParseConfigStr)(const)
  local assetId = 0
  local assetNum = 0
  local itemList = {}
  for i,v in ipairs(constTable) do
    if i == #constTable then
      assetId = tonumber(v[2])
      assetNum = tonumber(v[3])
    else
      ;
      (table.insert)(itemList, v)
    end
  end
  ;
  (Util.SetConsumptionByID)(assetId, assetNum, ((uis.ImprintSkillUp).Spend).ItemLoader, ((uis.ImprintSkillUp).Spend).NumberTxt, true, true)
  ;
  ((((uis.ImprintSkillUp).Spend).TouchBtn).onClick):Set(function(...)
    -- function num : 0_15_0 , upvalues : _ENV, assetId
    (Util.ShowGetWay)(tonumber(assetId))
  end
)
  -- DECOMPILER ERROR at PC97: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((uis.ImprintSkillUp).Spend).ItemLoader).alpha = 1
  local count = #itemList
  local mPosList = (Util.ParseConfigStr)(CardStageUpMatPosition[count], ";", ",")
  for i = 1, #itemTable do
    local item = itemTable[i]
    if i <= count then
      item.visible = true
      item.xy = Vector2(tonumber((mPosList[i])[1]), tonumber((mPosList[i])[2]))
      ;
      (Card_SealWindow.SetSingleItemShow)(item, (itemList[i])[2], (itemList[i])[3])
    else
      item.visible = false
    end
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R6 in 'UnsetPending'

Card_SealWindow.SetSingleItemShow = function(item, id, number, ...)
  -- function num : 0_16 , upvalues : _ENV
  number = tonumber(number)
  local possess = (ActorData.GetPropsByID)(id)
  local numberTxt = item:GetChild("StageTxt")
  if number <= possess then
    ChangeUIController(item, "c1", 0)
    numberTxt.text = (PUtil.get)(20000063, possess, number)
  else
    ChangeUIController(item, "c1", 1)
    numberTxt.text = (PUtil.get)(20000064, possess, number)
  end
  local config = (Util.GetConfigDataByID)(id)
  ChangeUIController(item, "c2", config.quality - 1)
  ;
  (item:GetChild("IconLoader")).url = (Util.GetItemUrl)(config.icon)
  ;
  (item:GetChild("IconLoader")).alpha = 1
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_16_0 , upvalues : possess, number, _ENV, id
    if possess < number then
      (tonumber(id))
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (Util.ShowGetWay)(tonumber, nil, number, number - possess)
    end
  end
)
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

Card_SealWindow.Message = function(data, ...)
  -- function num : 0_17 , upvalues : uis, _ENV, selectSkillConfig
  if uis == nil then
    return 
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if data.type == 1 then
    (uis.c1Ctr).selectedIndex = 3
    ;
    (Card_SealWindow.RefreshSealUp)()
  else
    if data.type == 2 then
      (Card_SealWindow.RefreshSealUp)()
      ;
      (Card_SealWindow.SetSealSkillInfo)(true, false)
    else
      if data.type == 3 then
        (Card_SealWindow.SetSealSkillInfo)(true, true)
        ;
        (Card_SealWindow.RefreshSealUp)()
      else
        -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

        if data.type == 4 then
          (uis.c2Ctr).selectedIndex = 0
          UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SEAL_SKILL_SHOW, false)
        else
          if data.type == 5 then
            (Card_SealWindow.SetSealSkillInfo)(false, false)
          else
            if data.type == 6 then
              selectSkillConfig = nil
              -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

              ;
              (uis.c2Ctr).selectedIndex = 0
              ;
              (Card_SealWindow.SetCurrentChooseSkill)(-1)
              UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SEAL_SKILL_SHOW, false)
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

Card_SealWindow.OnClose = function(...)
  -- function num : 0_18 , upvalues : attrPanel, itemTable, uis, selectSkillConfig, _ENV
  if attrPanel ~= nil then
    attrPanel:Dispose()
    attrPanel = nil
  end
  itemTable = {}
  uis = nil
  selectSkillConfig = nil
  ;
  (GRoot.inst):ClearCustomPopups()
  UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SEAL_SKILL_SHOW, false)
end


