-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_SkillDescribeGrpByName")
require("Card_SkillLevelUpByName")
Card_SkillUpWindow = {}
local selectSkillIndex = nil
local skillPanel = {}
local cardData = {}
local cardLevel = 0
local skills = {}
local skillsData = {}
local skillList = nil
local growType = 0
local MAXSKILLLEVEL = (((TableData.gTable).BaseFixedData)[Const.MAX_CARDLEVEL]).int_value
local battleNumTxt = nil
local timers = {}
local reqSkillID, starUrl = nil, nil
local enableClick = false
local fakeCanLvUpNum = 0
local fakeTotalCoin = 0
local fakeCastCoin = 0
local fakeLvl = 0
local fakeTotalCost = 0
local effectTimer = nil
local isLongPress = false
local isSingleClick = false
local tips1IsTip = false
local tips2IsTip = false
local tips3IsTip = false
local skillItems = {}
local uniqueTable = {}
local preData = {}
local afterData = {}
local isPlayingNumEffects = {false, false, false, false, false, false, false, false, false}
local autoUpCondition = {}
local isAutoUpClick = false
local playLvlEffect = {}
local itemTweeners = {}
-- DECOMPILER ERROR at PC59: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.Init = function(uis, ...)
  -- function num : 0_0 , upvalues : skillPanel, starUrl, _ENV, skillList, cardData, growType, cardLevel, battleNumTxt
  skillPanel = (uis.PanelGrp).SkillGrp
  if starUrl == nil then
    starUrl = (((skillPanel.StarImage).root):GetChild("0")).resourceURL
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (skillPanel.TitleTxt).text = (PUtil.get)(18)
  skillList = (skillPanel.SkillEffectGrp).SkillList
  cardData = {}
  local cardID = (CardData.ReturnCardID)()
  cardData = (CardData.GetCardData)(cardID)
  growType = cardData.skill_grow_type
  cardLevel = cardData.level
  battleNumTxt = (uis.MessageGrp).BattleTwoTxt
  ;
  (Card_SkillUpWindow.RefreshWindow)(true)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((skillPanel.SkillAllUp).WordTxt).text = (PUtil.get)(226)
  ;
  (((skillPanel.SkillAllUp).AllUpBtn):GetChild("title")).text = (PUtil.get)(227)
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.RefreshWindow = function(isInit, ...)
  -- function num : 0_1 , upvalues : skillsData, autoUpCondition, _ENV, cardData, skills
  skillsData = {}
  autoUpCondition = {}
  if not ((CardData.GetCardData)(cardData.id)).skillInfo then
    skillsData = {}
    skills = {}
    local isHave = {isHave1 = false, isHave2 = false, isHave3 = false, isHave4 = false, isHave5 = false, isHave6 = false, isHave7 = false, isHave8 = false, isHave9 = false}
    local limitConfig = nil
    for i,v in pairs(skillsData) do
      if v.id == cardData.unique_skill_id then
        isHave.isHave1 = true
        skills[1] = {id = cardData.unique_skill_id, value = v.value}
      end
      if v.id == cardData.special_skill_id then
        isHave.isHave2 = true
        skills[2] = {id = cardData.special_skill_id, value = v.value}
      end
      for j = 1, 7 do
        if v.id == cardData["passiveSkillId" .. j] then
          limitConfig = ((TableData.gTable).BaseCardLimitData)[cardData.id]
          if limitConfig == nil or limitConfig.passiveSkill_display ~= 0 and (limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time)) then
            isHave["isHave" .. tostring(2 + j)] = true
            skills[2 + j] = {id = cardData["passiveSkillId" .. j], value = v.value}
          end
        end
      end
    end
    if isHave.isHave1 == false then
      skills[1] = {id = cardData.unique_skill_id, value = 0}
    end
    if isHave.isHave2 == false then
      skills[2] = {id = cardData.special_skill_id, value = 0}
    end
    for j = 1, 7 do
      if isHave["isHave" .. tostring(2 + j)] == false then
        limitConfig = ((TableData.gTable).BaseCardLimitData)[cardData.id]
        if limitConfig == nil or limitConfig.passiveSkill_display ~= 0 and (limitConfig.hide_time == nil or (LuaTime.GetTimeStamp)() < tonumber(limitConfig.hide_time)) then
          skills[2 + j] = {id = cardData["passiveSkillId" .. j], value = 0}
        end
      end
    end
    ;
    (Card_SkillUpWindow.SetScrollView)(isInit)
    ;
    (Card_SkillUpWindow.SetAutoLevelUpButton)()
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.SetScrollView = function(isInit, ...)
  -- function num : 0_2 , upvalues : _ENV, skillList, enableClick, skillItems, skills, cardData
  local url = UIMgr:GetItemUrl("Card", "SkillDescribeGrp")
  skillList:RemoveChildrenToPool()
  ;
  (Card_SkillUpWindow.KillTimersPool)()
  enableClick = false
  skillItems = {}
  for i = 1, #skills do
    enableClick = true
    ;
    (Card_SkillUpWindow.CreateSkillItem)(url, i, skills[i])
    if cardData.ex_passiveSkillId and i == 2 then
      (Card_SkillUpWindow.CreateExSkillItem)(url, cardData.ex_passiveSkillId)
    end
  end
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.SetAutoLevelUpButton = function(...)
  -- function num : 0_3 , upvalues : skills, _ENV, cardData, autoUpCondition, skillPanel, growType, playLvlEffect, isAutoUpClick
  local isAllSkillMax = true
  for i = 1, #skills do
    local skillData = (TableData.GetBaseSkillData)((skills[i]).id)
    isAllSkillMax = not isAllSkillMax or cardData.level <= (skills[i]).value or not autoUpCondition[i] or skillData.no_level_up == 1
  end
  local functionData = ((TableData.gTable).BaseFunctionData)[ControlID.AutoSkillLvlUp]
  local limitLvl = tonumber((split(functionData.open_condition, ":"))[3])
  local isFunctionLock = limitLvl > (ActorData.GetLevel)()
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R4 in 'UnsetPending'

  if isFunctionLock then
    (skillPanel.c1Ctr).selectedIndex = 1
    return 
  else
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R4 in 'UnsetPending'

    (skillPanel.c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((skillPanel.SkillAllUp).SpendBackImage).visible = not isAllSkillMax
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((skillPanel.SkillAllUp).WordTxt).visible = not isAllSkillMax
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((skillPanel.SkillAllUp).SpendLoader).visible = not isAllSkillMax
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((skillPanel.SkillAllUp).SpendTxt).visible = not isAllSkillMax
    if isAllSkillMax then
      (((skillPanel.SkillAllUp).AllUpBtn).onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(52))
  end
)
      return 
    end
  end
  local finalSkillUp = {}
  local fakeSelfGold = (ActorData.GetAssetCount)(AssetType.GOLD)
  local totalCost = 0
  for i = 1, #skills do
    (table.insert)(finalSkillUp, {skillId = (skills[i]).id, detalLvl = 0, finalLvl = (skills[i]).value, isNeedCheck = autoUpCondition[i]})
  end
  for n = 1, cardData.level do
    for index,value in ipairs(finalSkillUp) do
      if value.isNeedCheck then
        local cost = 0
        local cfgData = (TableData.GetBaseSkillData)(value.skillId)
        for j,v in pairs((TableData.gTable).BaseSkillLevelUpData) do
          if v.type == growType and v.level == value.finalLvl + 1 and cfgData.no_level_up == nil then
            if index == 1 then
              cost = tonumber((split(v.unique_skill_cost, ":"))[3])
              break
            end
            if index == 2 then
              cost = tonumber((split(v.special_skill_cost, ":"))[3])
              break
            end
            if index == 3 then
              cost = tonumber((split(v.passive_skill_cost1, ":"))[3])
              break
            end
            if index == 4 then
              cost = tonumber((split(v.passive_skill_cost2, ":"))[3])
              break
            end
            if index == 5 then
              cost = tonumber((split(v.passive_skill_cost3, ":"))[3])
              break
            end
            if index == 6 then
              cost = tonumber((split(v.passive_skill_cost4, ":"))[3])
              break
            end
            if index == 7 then
              cost = tonumber((split(v.passive_skill_cost5, ":"))[3])
              break
            end
            if index == 8 then
              cost = tonumber((split(v.passive_skill_cost6, ":"))[3])
              break
            end
            if index == 9 then
              cost = tonumber((split(v.passive_skill_cost7, ":"))[3])
            end
            break
          end
        end
        if cost <= fakeSelfGold then
          totalCost = totalCost + cost
          fakeSelfGold = fakeSelfGold - cost
          value.finalLvl = value.finalLvl + 1
          value.detalLvl = value.detalLvl + 1
          if cardData.level <= value.finalLvl then
            value.isNeedCheck = false
          end
        else
          value.isNeedCheck = false
        end
      end
    end
    local isNeedGoOn = false
    for index,value in ipairs(finalSkillUp) do
      if not isNeedGoOn then
        isNeedGoOn = value.isNeedCheck
      end
    end
  end
  -- DECOMPILER ERROR at PC284: Confused about usage of register: R7 in 'UnsetPending'

  if isNeedGoOn == false or totalCost == 0 then
    ((skillPanel.SkillAllUp).SpendTxt).text = "[color=#ff5f7b]" .. tostring(fakeSelfGold) .. "[/color]"
  else
    -- DECOMPILER ERROR at PC294: Confused about usage of register: R7 in 'UnsetPending'

    ((skillPanel.SkillAllUp).SpendTxt).text = "[color=#3dffbd]" .. tostring(totalCost) .. "[/color]"
  end
  local skillData = {}
  local tempLvlEffect = {}
  for index,value in ipairs(finalSkillUp) do
    print("skillId", value.skillId, value.finalLvl, value.detalLvl)
    if value.detalLvl > 0 then
      (table.insert)(skillData, {id = value.skillId, value = value.detalLvl})
      ;
      (table.insert)(tempLvlEffect, index)
    end
  end
  ;
  (((skillPanel.SkillAllUp).AllUpBtn).onClick):Set(function(...)
    -- function num : 0_3_1 , upvalues : isFunctionLock, _ENV, functionData, totalCost, playLvlEffect, tempLvlEffect, isAutoUpClick, cardData, skillData
    if isFunctionLock then
      (MessageMgr.SendCenterTips)(functionData.open_des)
      return 
    end
    if totalCost == 0 then
      (MessageMgr.OpenAssetNotEnoughtWindow)(21100003)
      return 
    else
      playLvlEffect = tempLvlEffect
      isAutoUpClick = true
      ;
      (CardService.OnReqSkillUp)(cardData.id, 0, 0, skillData)
    end
  end
)
  -- DECOMPILER ERROR: 22 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.CreateSkillItem = function(url, index, skillItemData, ...)
  -- function num : 0_4 , upvalues : skillList, _ENV, skillItems
  local skillItem = skillList:AddItemFromPool(url)
  ;
  (Card_SkillUpWindow.SetPrefabInfo)(skillItem, skillItemData, index)
  ;
  (table.insert)(skillItems, skillItem)
  return skillItem
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.SetPrefabInfo = function(obj, skill, _index, ...)
  -- function num : 0_5 , upvalues : _ENV, itemTweeners, cardData, starUrl, autoUpCondition, growType, MAXSKILLLEVEL, isLongPress, enableClick, reqSkillID, selectSkillIndex, preData, isSingleClick, effectTimer, fakeLvl, fakeCanLvUpNum, fakeTotalCost, tips1IsTip, tips2IsTip, tips3IsTip, fakeTotalCoin, fakeCastCoin, afterData
  local uis = nil
  local index = _index
  uis = GetCard_SkillDescribeGrpUis(obj)
  if itemTweeners[uis.root] then
    (itemTweeners[uis.root]):Kill(false)
    itemTweeners[uis.root] = nil
  end
  local skillData = (TableData.GetBaseSkillData)(skill.id)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.SkillFrameGrp).SkillLoader).url = (Util.GetResUrl)(skillData.icon_path)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.SkillFrameGrp).SkillLoader).alpha = 1
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.NameTxt).text = skillData.name
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.DescribeTxt).alpha = 1
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.DescribeTxt).text = skillData.remark
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.GoldImage).visible = true
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.SkipBtn).visible = true
  ;
  ((uis.SkipBtn):GetChild("title")).text = (PUtil.get)(79)
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.LevelTxt).text = (PUtil.get)(53) .. skill.value
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.LevelEffectTxt).text = (PUtil.get)(53) .. skill.value
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.LevelEffectTxt).visible = false
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.c3Ctr).selectedIndex = 0
  ;
  (((uis.SkillFrameGrp).SkillLoader).onClick):Clear()
  ;
  (((uis.SkillFrameGrp).SkillLoader).onClick):Add(function(...)
    -- function num : 0_5_0 , upvalues : _ENV, skillData, skill, cardData
    OpenWindow("SkillTipsWindow", UILayer.HUD)
    local data = {}
    data.skillData = skillData
    data.skillLevel = skill.value
    data.cardData = cardData
    UIMgr:SendWindowMessage((WinResConfig.SkillTipsWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SKILLDETAIL, data)
  end
)
  local temp, isChange = (CardData.JudgeSealSkillModify)(cardData.sealSkillInfo, skill.id)
  local parent = (uis.SkillFrameGrp).root
  do
    if isChange then
      local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_SEAL_TIPS_SHOW, true, true)
      holder.name = "SealFrameSfx"
      holder.xy = Vector2(parent.width / 2, parent.height / 2)
      parent:AddChild(holder)
    end
    -- DECOMPILER ERROR at PC118: Confused about usage of register: R9 in 'UnsetPending'

    if skill.value <= 0 or skillData.no_level_up == 1 then
      (uis.LevelTxt).visible = false
    else
      -- DECOMPILER ERROR at PC121: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (uis.LevelTxt).visible = true
    end
    local isQualityLock = false
    local isStarLock = false
    local skillType = skillData.type
    -- DECOMPILER ERROR at PC129: Confused about usage of register: R12 in 'UnsetPending'

    if skillType == 2 then
      ((uis.SkillFrameGrp).c1Ctr).selectedIndex = 2
    else
      -- DECOMPILER ERROR at PC135: Confused about usage of register: R12 in 'UnsetPending'

      if skillType == 3 then
        ((uis.SkillFrameGrp).c1Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC143: Confused about usage of register: R12 in 'UnsetPending'

        if skillType == 5 and index > 2 then
          ((uis.SkillFrameGrp).c1Ctr).selectedIndex = 0
          local curQuality = cardData.quality
          local curStar = cardData.star
          local tableID = nil
          if curQuality > 9 then
            tableID = cardData.id .. curQuality
          else
            tableID = cardData.id .. "0" .. curQuality
          end
          local qualityData = ((TableData.gTable).BaseCardQualityUpData)[tonumber(tableID)]
          local skillLevelNumber = qualityData.skill_level_number
          if index - 2 <= skillLevelNumber then
            isQualityLock = false
          else
            isQualityLock = true
            -- DECOMPILER ERROR at PC172: Confused about usage of register: R17 in 'UnsetPending'

            ;
            (uis.GoldImage).visible = false
            -- DECOMPILER ERROR at PC174: Confused about usage of register: R17 in 'UnsetPending'

            ;
            (uis.SkipBtn).visible = false
            -- DECOMPILER ERROR at PC176: Confused about usage of register: R17 in 'UnsetPending'

            ;
            (uis.c1Ctr).selectedIndex = 1
            for i = tonumber(tableID), tonumber(cardData.id .. 18) do
              local tmpData = ((TableData.gTable).BaseCardQualityUpData)[i]
              if index - 2 <= tmpData.skill_level_number then
                local levelShow = split(tmpData.level_show, ":")
                -- DECOMPILER ERROR at PC203: Confused about usage of register: R23 in 'UnsetPending'

                ;
                (uis.c2Ctr).selectedIndex = tonumber(levelShow[1])
                -- DECOMPILER ERROR at PC206: Confused about usage of register: R23 in 'UnsetPending'

                ;
                (uis.StageNumberTxt).text = tmpData.level
                break
              end
            end
          end
          do
            do
              if skillData.need_star <= curStar then
                isStarLock = false
              else
                isStarLock = true
                -- DECOMPILER ERROR at PC216: Confused about usage of register: R17 in 'UnsetPending'

                ;
                (uis.c1Ctr).selectedIndex = 1
                -- DECOMPILER ERROR at PC218: Confused about usage of register: R17 in 'UnsetPending'

                ;
                (uis.c2Ctr).selectedIndex = 0
                -- DECOMPILER ERROR at PC239: Confused about usage of register: R17 in 'UnsetPending'

                ;
                (uis.StageNumberTxt).text = (PUtil.get)(154) .. skillData.need_star .. "<img src=\'" .. starUrl .. "\' " .. "width=\'" .. tostring(26) .. "\' " .. "height=\'" .. tostring(26) .. "\'>"
                -- DECOMPILER ERROR at PC245: Confused about usage of register: R17 in 'UnsetPending'

                ;
                (uis.WordTxt).text = (PUtil.get)(171)
              end
              -- DECOMPILER ERROR at PC249: Confused about usage of register: R12 in 'UnsetPending'

              ;
              ((uis.SkillFrameGrp).c1Ctr).selectedIndex = 0
              ;
              (table.insert)(autoUpCondition, isQualityLock == false and isStarLock == false and skill.value < cardData.level)
              local isGoldEnough = true
              if isQualityLock == false and isStarLock == false then
                local cost = "0"
                for i,v in pairs((TableData.gTable).BaseSkillLevelUpData) do
                  if v.type == growType and v.level == skill.value + 1 then
                    if index == 1 then
                      cost = (split(v.unique_skill_cost, ":"))[3]
                      break
                    end
                    if index == 2 then
                      cost = (split(v.special_skill_cost, ":"))[3]
                      break
                    end
                    if index == 3 then
                      cost = (split(v.passive_skill_cost1, ":"))[3]
                      break
                    end
                    if index == 4 then
                      cost = (split(v.passive_skill_cost2, ":"))[3]
                      break
                    end
                    if index == 5 then
                      cost = (split(v.passive_skill_cost3, ":"))[3]
                      break
                    end
                    if index == 6 then
                      cost = (split(v.passive_skill_cost4, ":"))[3]
                      break
                    end
                    if index == 7 then
                      cost = (split(v.passive_skill_cost5, ":"))[3]
                      break
                    end
                    if index == 8 then
                      cost = (split(v.passive_skill_cost6, ":"))[3]
                      break
                    end
                    if index == 9 then
                      cost = (split(v.passive_skill_cost7, ":"))[3]
                    end
                    break
                  end
                end
                local selfGold = (ActorData.GetAssetCount)(AssetType.GOLD)
                if tonumber(cost) <= selfGold then
                  isGoldEnough = true
                  -- DECOMPILER ERROR at PC375: Confused about usage of register: R15 in 'UnsetPending'

                  ;
                  (uis.Number_01_Txt).text = "[color=#3dffbd]" .. cost .. "[/color]"
                else
                  isGoldEnough = false
                  -- DECOMPILER ERROR at PC383: Confused about usage of register: R15 in 'UnsetPending'

                  ;
                  (uis.Number_01_Txt).text = "[color=#ff5f7b]" .. cost .. "[/color]"
                end
                -- DECOMPILER ERROR at PC393: Confused about usage of register: R15 in 'UnsetPending'

                if MAXSKILLLEVEL <= skill.value then
                  (uis.Number_01_Txt).text = (PUtil.get)(175)
                  -- DECOMPILER ERROR at PC395: Confused about usage of register: R15 in 'UnsetPending'

                  ;
                  (uis.GoldImage).visible = false
                  -- DECOMPILER ERROR at PC397: Confused about usage of register: R15 in 'UnsetPending'

                  ;
                  (uis.c1Ctr).selectedIndex = 2
                else
                  -- DECOMPILER ERROR at PC400: Confused about usage of register: R15 in 'UnsetPending'

                  (uis.c1Ctr).selectedIndex = 0
                end
                -- DECOMPILER ERROR at PC405: Confused about usage of register: R15 in 'UnsetPending'

                if skillData.no_level_up == 1 then
                  (uis.c1Ctr).selectedIndex = 2
                end
              end
              ;
              ((uis.SkipBtn).onTouchBegin):Clear()
              ;
              ((uis.SkipBtn).onClick):Set(function(...)
    -- function num : 0_5_1 , upvalues : isLongPress, enableClick, _ENV, index, skill, cardData, isGoldEnough, reqSkillID, selectSkillIndex, preData, isSingleClick, MAXSKILLLEVEL
    if isLongPress == true or enableClick == false then
      return 
    end
    loge("   这是单点" .. tostring(index) .. "    " .. tostring(isLongPress) .. "   " .. tostring(enableClick))
    if skill.value < cardData.level then
      if isGoldEnough == true then
        reqSkillID = skill.id
        selectSkillIndex = index
        preData = (Card_SkillUpWindow.SetSkillAttrData)(skill.id, skill.value)
        ;
        (CardService.OnReqSkillUp)(cardData.id, skill.id, 1)
        isSingleClick = true
      else
        ;
        (MessageMgr.OpenAssetNotEnoughtWindow)(21100003)
      end
    else
      if cardData.level <= skill.value then
        (MessageMgr.SendCenterTips)((PUtil.get)(52))
      end
      if MAXSKILLLEVEL <= skill.value then
        (MessageMgr.SendCenterTips)((PUtil.get)(51))
      end
    end
  end
)
              local longPress = (FairyGUI.LongPressGesture)(uis.SkipBtn)
              longPress:Enable(true)
              longPress.trigger = 0.3
              longPress.interval = 0.1
              longPress:AddEventListener("onLongPressBegin", function(...)
    -- function num : 0_5_2 , upvalues : effectTimer, fakeLvl, skill, fakeCanLvUpNum, fakeTotalCost, tips1IsTip, tips2IsTip, tips3IsTip, selectSkillIndex, index, fakeTotalCoin, _ENV, fakeCastCoin, preData, isLongPress, cardData, MAXSKILLLEVEL, isGoldEnough, growType, uis
    if effectTimer ~= nil then
      effectTimer:stop()
      effectTimer = nil
    end
    fakeLvl = skill.value
    fakeCanLvUpNum = 0
    fakeTotalCost = 0
    tips1IsTip = false
    tips2IsTip = false
    tips3IsTip = false
    selectSkillIndex = index
    fakeTotalCoin = (ActorData.GetAssetCount)(AssetType.GOLD)
    fakeCastCoin = fakeTotalCoin
    preData = (Card_SkillUpWindow.SetSkillAttrData)(skill.id, skill.value)
    isLongPress = true
    if cardData.level <= skill.value then
      (MessageMgr.SendCenterTips)((PUtil.get)(52))
      return 
    end
    if MAXSKILLLEVEL <= skill.value then
      (MessageMgr.SendCenterTips)((PUtil.get)(51))
      return 
    end
    if isGoldEnough == false then
      (MessageMgr.OpenAssetNotEnoughtWindow)(21100003)
      return 
    end
    for i = fakeLvl, cardData.level do
      local cost = 0
      if cardData.level >= i + 1 then
        for j,v in pairs((TableData.gTable).BaseSkillLevelUpData) do
          if v.type == growType and v.level == i + 1 then
            if index == 1 then
              cost = (split(v.unique_skill_cost, ":"))[3]
              break
            end
            if index == 2 then
              cost = (split(v.special_skill_cost, ":"))[3]
              break
            end
            if index == 3 then
              cost = (split(v.passive_skill_cost1, ":"))[3]
              break
            end
            if index == 4 then
              cost = (split(v.passive_skill_cost2, ":"))[3]
              break
            end
            if index == 5 then
              cost = (split(v.passive_skill_cost3, ":"))[3]
              break
            end
            if index == 6 then
              cost = (split(v.passive_skill_cost4, ":"))[3]
              break
            end
            if index == 7 then
              cost = (split(v.passive_skill_cost5, ":"))[3]
              break
            end
            if index == 8 then
              cost = (split(v.passive_skill_cost6, ":"))[3]
              break
            end
            if index == 9 then
              cost = (split(v.passive_skill_cost7, ":"))[3]
            end
            break
          end
        end
        do
          fakeTotalCoin = fakeTotalCoin - cost
          if fakeTotalCoin >= 0 or fakeLvl + fakeCanLvUpNum >= cardData.level then
            do
              fakeTotalCost = fakeTotalCost + cost
              fakeCanLvUpNum = fakeCanLvUpNum + 1
              -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC194: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    effectTimer = (SimpleTimer.new)(0.18, -1, function(...)
      -- function num : 0_5_2_0 , upvalues : _ENV, uis
      (Card_SkillUpWindow.PlayEffects)(uis)
    end
)
    effectTimer:start()
    print("最终可以升多少级：", fakeCanLvUpNum, "总消耗:", fakeTotalCost, "剩余：", fakeTotalCoin)
    fakeTotalCost = 0
  end
)
              longPress:AddEventListener("onLongPressAction", function(...)
    -- function num : 0_5_3 , upvalues : skill, cardData, MAXSKILLLEVEL, isGoldEnough, fakeCanLvUpNum, _ENV, growType, fakeLvl, index, fakeTotalCoin, tips1IsTip, uis, tips2IsTip, tips3IsTip, effectTimer, afterData, preData, skillData, fakeTotalCost, fakeCastCoin
    if cardData.level <= skill.value then
      return 
    end
    if MAXSKILLLEVEL <= skill.value then
      return 
    end
    if isGoldEnough == false then
      return 
    end
    fakeCanLvUpNum = fakeCanLvUpNum - 1
    local cost = "0"
    for i,v in pairs((TableData.gTable).BaseSkillLevelUpData) do
      if v.type == growType and v.level == fakeLvl + 1 then
        if index == 1 then
          cost = (split(v.unique_skill_cost, ":"))[3]
          break
        end
        if index == 2 then
          cost = (split(v.special_skill_cost, ":"))[3]
          break
        end
        if index == 3 then
          cost = (split(v.passive_skill_cost1, ":"))[3]
          break
        end
        if index == 4 then
          cost = (split(v.passive_skill_cost2, ":"))[3]
          break
        end
        if index == 5 then
          cost = (split(v.passive_skill_cost3, ":"))[3]
          break
        end
        if index == 6 then
          cost = (split(v.passive_skill_cost4, ":"))[3]
          break
        end
        if index == 7 then
          cost = (split(v.passive_skill_cost5, ":"))[3]
          break
        end
        if index == 8 then
          cost = (split(v.passive_skill_cost6, ":"))[3]
          break
        end
        if index == 9 then
          cost = (split(v.passive_skill_cost7, ":"))[3]
        end
        break
      end
    end
    do
      if fakeCanLvUpNum < 0 then
        -- DECOMPILER ERROR at PC128: Unhandled construct in 'MakeBoolean' P1

        if fakeTotalCoin <= 0 and tips1IsTip == false then
          (MessageMgr.OpenAssetNotEnoughtWindow)(21100003)
          -- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

          ;
          (uis.Number_01_Txt).text = "[color=#ff5f7b]" .. cost .. "[/color]"
          tips1IsTip = true
        end
        -- DECOMPILER ERROR at PC143: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (uis.Number_01_Txt).text = "[color=#3dffbd]" .. cost .. "[/color]"
        if cardData.level <= fakeLvl and tips2IsTip == false then
          (MessageMgr.SendCenterTips)((PUtil.get)(52))
          tips2IsTip = true
        end
        if MAXSKILLLEVEL <= fakeLvl and tips3IsTip == false then
          (MessageMgr.SendCenterTips)((PUtil.get)(51))
          -- DECOMPILER ERROR at PC175: Confused about usage of register: R1 in 'UnsetPending'

          ;
          (uis.c1Ctr).selectedIndex = 2
          tips3IsTip = true
        end
        if effectTimer ~= nil then
          effectTimer:stop()
          effectTimer = nil
        end
        return 
      end
      fakeLvl = fakeLvl + 1
      afterData = (Card_SkillUpWindow.SetSkillAttrData)(skill.id, fakeLvl)
      ;
      (Card_SkillUpWindow.PlayNumEffects)(uis, afterData, preData)
      preData = afterData
      -- DECOMPILER ERROR at PC211: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.LevelTxt).text = (PUtil.get)(53) .. fakeLvl
      -- DECOMPILER ERROR at PC219: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.LevelEffectTxt).text = (PUtil.get)(53) .. fakeLvl
      -- DECOMPILER ERROR at PC228: Confused about usage of register: R1 in 'UnsetPending'

      if (uis.LevelTxt).visible == false and skillData.no_level_up == nil then
        (uis.LevelTxt).visible = true
      end
      -- DECOMPILER ERROR at PC234: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.Number_01_Txt).text = "[color=#3dffbd]" .. cost .. "[/color]"
      fakeTotalCost = fakeTotalCost + tonumber(cost)
      fakeCastCoin = fakeCastCoin - tonumber(cost)
      local fakeNum = GetFormatedCount(fakeCastCoin)
      ;
      (CommonWinMgr.ModifyAssetsAmount)((WinResConfig.CardWindow).comName, AssetType.GOLD, fakeNum)
    end
  end
)
              longPress:AddEventListener("onLongPressEnd", function(...)
    -- function num : 0_5_4 , upvalues : effectTimer, _ENV, isLongPress, fakeLvl, skill, cardData
    if effectTimer ~= nil then
      effectTimer:stop()
      effectTimer = nil
    end
    ;
    (SimpleTimer.setTimeout)(0.01, function(...)
      -- function num : 0_5_4_0 , upvalues : isLongPress
      isLongPress = false
    end
)
    if fakeLvl - skill.value <= 0 then
      return 
    end
    ;
    (CardService.OnReqSkillUp)(cardData.id, skill.id, fakeLvl - skill.value)
  end
)
              -- DECOMPILER ERROR: 16 unprocessed JMP targets
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.CreateExSkillItem = function(url, skillId, ...)
  -- function num : 0_6 , upvalues : skillList, _ENV, cardData
  local exSkillItem = (skillList:AddItemFromPool(url))
  -- DECOMPILER ERROR at PC4: Overwrote pending register: R3 in 'AssignReg'

  local uis = .end
  uis = GetCard_SkillDescribeGrpUis(exSkillItem)
  local skillData = (TableData.GetBaseSkillData)(skillId)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.SkillFrameGrp).SkillLoader).url = (Util.GetResUrl)(skillData.icon_path)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.SkillFrameGrp).SkillLoader).alpha = 1
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.NameTxt).text = skillData.name
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.DescribeTxt).alpha = 1
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.DescribeTxt).text = skillData.remark
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = 3
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.c3Ctr).selectedIndex = 0
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.SkillFrameGrp).c1Ctr).selectedIndex = 3
  ;
  (((uis.SkillFrameGrp).SkillLoader).onClick):Clear()
  ;
  (((uis.SkillFrameGrp).SkillLoader).onClick):Add(function(...)
    -- function num : 0_6_0 , upvalues : _ENV, skillData, cardData
    OpenWindow("SkillTipsWindow", UILayer.HUD)
    local data = {}
    data.skillData = skillData
    data.skillLevel = 0
    data.cardData = cardData
    UIMgr:SendWindowMessage((WinResConfig.SkillTipsWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SKILLDETAIL, data)
  end
)
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : skillList, _ENV, skillPanel, skills, playLvlEffect, battleNumTxt, reqSkillID, skillItems, autoUpCondition, enableClick, itemTweeners
  skillList:RemoveChildrenToPool()
  ;
  (Card_SkillUpWindow.KillTimersPool)()
  ;
  (Card_SkillUpWindow.CancelAllLeanTween)()
  skillPanel = {}
  skills = {}
  playLvlEffect = {}
  skillList = nil
  battleNumTxt = nil
  reqSkillID = nil
  skillItems = {}
  autoUpCondition = {}
  enableClick = false
  for k,v in pairs(itemTweeners) do
    v:Kill(false)
  end
  itemTweeners = {}
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.KillTimersPool = function(...)
  -- function num : 0_8 , upvalues : _ENV, timers
  for k,v in pairs(timers) do
    if v ~= nil then
      v:stop()
      v = nil
    end
  end
  timers = {}
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.ResStageInfo = function(msg, ...)
  -- function num : 0_9 , upvalues : _ENV, cardData, battleNumTxt, isSingleClick, skillList, afterData, preData, isAutoUpClick, playLvlEffect
  local fakeData = (CardData.GetCardData)(cardData.id)
  local emptyData = {}
  ;
  (CardData.InitCardAttr)(emptyData, fakeData)
  battleNumTxt.text = emptyData.fc
  ;
  (CardData.SetCardDataFc)(msg.id, emptyData.fc)
  if isSingleClick == true then
    local skillId = ((msg.skill)[1]).id
    local index = (Card_SkillUpWindow.GetSkillItemIndex)(skillId)
    local itemIndex = index
    if cardData.ex_passiveSkillId and index > 2 then
      itemIndex = itemIndex + 1
    end
    local hand = skillList:GetChildAt(skillList:ItemIndexToChildIndex(itemIndex - 1))
    if hand then
      (Card_SkillUpWindow.SetPrefabInfo)(hand, {id = skillId, value = (CardData.GetSkillLevel)(msg.id, skillId)}, index)
      local uis = GetCard_SkillDescribeGrpUis(hand)
      ;
      (Card_SkillUpWindow.PlayEffects)(uis)
      afterData = (Card_SkillUpWindow.SetSkillAttrData)(skillId, (CardData.GetSkillLevel)(msg.id, skillId))
      ;
      (Card_SkillUpWindow.PlayNumEffects)(uis, afterData, preData)
    end
    do
      do
        isSingleClick = false
        ;
        (Card_SkillUpWindow.RefreshWindow)(false)
        if isAutoUpClick then
          for index,value in ipairs(playLvlEffect) do
            if value > 2 and cardData.ex_passiveSkillId ~= nil then
              value = value + 1
            end
            local hand = skillList:GetChildAt(skillList:ItemIndexToChildIndex(value - 1))
            local uis = GetCard_SkillDescribeGrpUis(hand)
            ;
            (Card_SkillUpWindow.PlayEffects)(uis)
          end
          isAutoUpClick = false
        end
        playLvlEffect = {}
      end
    end
  end
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.GetSkillItemIndex = function(skillId, ...)
  -- function num : 0_10 , upvalues : _ENV, skills
  for index,skill in pairs(skills) do
    if skill.id == skillId then
      return index
    end
  end
  return -1
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.PlayEffects = function(uis, ...)
  -- function num : 0_11 , upvalues : _ENV
  local uiMap = uis.SkillFrameGrp
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_SKILL, true, true)
  holder:SetXY((uiMap.root).width / 2, (uiMap.root).height / 2)
  ;
  (uiMap.root):AddChild(holder)
  ;
  (LuaSound.PlaySound)(LuaSound.CARD_UP_FLASH, SoundBank.OTHER)
  DisposeTrans(uis.root, "skillstart")
  PlayUITrans(uis.root, "skillstart")
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.PlayNumEffects = function(uis, afterData, preData, ...)
  -- function num : 0_12 , upvalues : selectSkillIndex, isPlayingNumEffects, _ENV
  local index = selectSkillIndex
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  if isPlayingNumEffects[index] == true then
    (uis.c3Ctr).selectedIndex = 1
    ;
    (Card_SkillUpWindow.NumberUpdate)(uis, index, afterData, preData)
  else
    ;
    (Card_SkillUpWindow.PropertyNumberEffects)(uis, index, afterData, preData)
  end
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.PropertyNumberEffects = function(_uis, index, afterData, preData, ...)
  -- function num : 0_13 , upvalues : itemTweeners, _ENV, isPlayingNumEffects
  local tweenr = (_uis.DescribeTxt):TweenFade(0, 0.25)
  if itemTweeners[_uis.root] then
    (itemTweeners[_uis.root]):Kill(false)
    itemTweeners[_uis.root] = nil
  end
  itemTweeners[_uis.root] = tweenr
  tweenr:OnComplete(function(...)
    -- function num : 0_13_0 , upvalues : _uis, itemTweeners
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (_uis.c3Ctr).selectedIndex = 1
    itemTweeners[_uis.root] = nil
  end
)
  local uis = GetCard_SkillLevelUpUis(_uis.SkillDescribeGrp)
  local attrselectedIndex = -1
  for i,v in ipairs(afterData) do
    if v.value > 0 then
      attrselectedIndex = attrselectedIndex + 1
    end
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = attrselectedIndex
  for i,v in ipairs(preData) do
    local t = i
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (uis["Number_0" .. t .. "_Txt"]).text = (preData[t]).value
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (uis["Name_0" .. t .. "_Txt"]).text = (preData[t]).name
  end
  PlayUITrans(uis.root, "in")
  isPlayingNumEffects[index] = true
  ;
  (Card_SkillUpWindow.NumberUpdate)(_uis, index, afterData, preData)
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.NumberUpdate = function(_uis, index, afterData, preData, ...)
  -- function num : 0_14 , upvalues : _ENV, uniqueTable, isPlayingNumEffects
  local uis = GetCard_SkillLevelUpUis(_uis.SkillDescribeGrp)
  if uniqueTable[index] then
    for i,v in ipairs(uniqueTable[index]) do
      (LeanTween.cancel)(v)
    end
  end
  do
    uniqueTable[index] = {}
    do
      for i,v in ipairs(afterData) do
        local t = i
        local startNum = 0
        if preData[t] ~= nil then
          startNum = (preData[t]).value
        end
        local endNum = (afterData[t]).value
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (uis["Name_0" .. t .. "_Txt"]).text = (afterData[t]).name
        local leanTween = (((LeanTween.value)(startNum, endNum, 0.75)):setOnUpdate(function(value, ...)
    -- function num : 0_14_0 , upvalues : uis, t, _ENV
    if uis["Number_0" .. t .. "_Txt"] then
      local num = (math.ceil)(value)
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis["Number_0" .. t .. "_Txt"]).text = num
    end
  end
)):setOnComplete(function(...)
    -- function num : 0_14_1 , upvalues : _ENV, _uis, isPlayingNumEffects, index, uniqueTable
    (SimpleTimer.setTimeout)(0.3, function(...)
      -- function num : 0_14_1_0 , upvalues : _uis, isPlayingNumEffects, index, uniqueTable
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

      (_uis.c3Ctr).selectedIndex = 0
      isPlayingNumEffects[index] = false
      ;
      (_uis.DescribeTxt):TweenFade(1, 0.25)
      uniqueTable[index] = {}
    end
)
  end
)
        ;
        (table.insert)(uniqueTable[index], leanTween.uniqueId)
      end
    end
  end
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.SetSkillAttrData = function(skillID, skillLvl, ...)
  -- function num : 0_15 , upvalues : _ENV
  local t = {}
  local skillData = (TableData.GetBaseSkillData)(skillID)
  local desLvlUp = split(skillData.des_level_up, ",")
  if skillData.type == 2 or skillData.type == 3 then
    skillLvl = skillLvl + 1
  end
  for i,v in ipairs(desLvlUp) do
    local des = split(v, ":")
    local name = (((TableData.gTable).BaseAttributeData)[tonumber(des[1])]).display_name
    local skillAttrData = ((CardData.GetBaseSkillAttrData)(skillData.add_attr_type, skillLvl))
    local attrNum, value = nil, nil
    if skillAttrData then
      attrNum = split(skillAttrData.add_attr, ":")
      value = tonumber(des[2]) * (skillLvl) + tonumber(attrNum[3])
    else
      value = tonumber(des[2]) * (skillLvl)
    end
    ;
    (table.insert)(t, {name = name, value = value})
  end
  return t
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R34 in 'UnsetPending'

Card_SkillUpWindow.CancelAllLeanTween = function(...)
  -- function num : 0_16 , upvalues : _ENV, uniqueTable
  for i,v in pairs(uniqueTable) do
    for n,m in pairs(v) do
      (LeanTween.cancel)(m)
    end
  end
  uniqueTable = {}
end


