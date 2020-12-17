-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_PlayerCardByName")
local PlayerBusinessCardWindow = {}
local uis, contentPane, bridge, argTable, showModel, holder, holderEffectBack, holderEffectFront, texture = nil, nil, nil, nil, nil, nil, nil, nil, nil
local curClickedCardIndex = 1
local curSelectShowType = 1
local curClickedCardId, curClickedBgId = nil, nil
local bgItems = {}
local guildNameTxt = nil
local visibleAttr = {true, true, true, true, true}
local playerSetWords = ""
local fxMainEffect = nil
local constY = -40
local constScaleY = 0.9
local blackImg = nil
local oriBlackImgHeight = 0
PlayerBusinessCardWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, uis, curClickedCardIndex, curClickedCardId, visibleAttr, blackImg, curClickedBgId, PlayerBusinessCardWindow, oriBlackImgHeight
  bridgeObj:SetView((WinResConfig.PlayerBusinessCardWindow).package, (WinResConfig.PlayerBusinessCardWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetActorInfo_PlayerCardUis(contentPane)
  local cards = (CardData.GetObtainedCardList)()
  local fashionShow = (ActorData.GetFashionShow)()
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionShow]
  local selectedCardId = fashionConfig.card_id
  for index,value in ipairs(cards) do
    if selectedCardId == value.id then
      curClickedCardIndex = index
      curClickedCardId = value.id
    end
  end
  visibleAttr = {true, true, true, true, true}
  blackImg = ((uis.FormShrink).Form).Decorate_02_Image
  curClickedBgId = (ActorData.GetGeneralHomeBg)()
  ;
  (((uis.ListChoice).TypeABtn):GetChild("NameTxt")).text = (PUtil.get)(278)
  ;
  (((uis.ListChoice).TypeABtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : PlayerBusinessCardWindow
    (PlayerBusinessCardWindow.UpdateChooseCardArrow)()
  end
)
  ;
  (((uis.ListChoice).TypeBBtn):GetChild("NameTxt")).text = (PUtil.get)(279)
  ;
  (((uis.ListChoice).TypeBBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : PlayerBusinessCardWindow
    (PlayerBusinessCardWindow.UpdateChooseBgArrow)()
  end
)
  ;
  (((uis.Cothes_A_Btn).Cothes_A_Btn).onClick):Set(function(...)
    -- function num : 0_0_2 , upvalues : PlayerBusinessCardWindow
    (PlayerBusinessCardWindow.ChangeFashion)(1)
  end
)
  ;
  (((uis.Cothes_A_Btn).Cothes_B_Btn).onClick):Set(function(...)
    -- function num : 0_0_3 , upvalues : PlayerBusinessCardWindow
    (PlayerBusinessCardWindow.ChangeFashion)(2)
  end
)
  ;
  (((uis.Cothes_A_Btn).Cothes_C_Btn).onClick):Set(function(...)
    -- function num : 0_0_4 , upvalues : PlayerBusinessCardWindow
    (PlayerBusinessCardWindow.ChangeFashion)(3)
  end
)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_5 , upvalues : uis, blackImg, oriBlackImgHeight
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    if (uis.ScreenShotCtr).selectedIndex == 1 then
      (uis.ScreenShotCtr).selectedIndex = 0
      -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (((uis.FormShrink).Form).ScreenShotCtr).selectedIndex = 0
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.FormShrink).ScreenShotCtr).selectedIndex = 0
      blackImg.height = oriBlackImgHeight
    end
  end
)
  ;
  ((uis.LookBtn).onClick):Set(function(...)
    -- function num : 0_0_6 , upvalues : PlayerBusinessCardWindow
    (PlayerBusinessCardWindow.CreateAttr)()
  end
)
  ;
  ((uis.ScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_7 , upvalues : _ENV, PlayerBusinessCardWindow
    -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P1

    if Application.platform == RuntimePlatform.Android and Application.version >= "1.0.11" then
      (PlayerBusinessCardWindow.CreateAttr)(true)
    end
    if Application.platform == RuntimePlatform.IPhonePlayer and Application.version >= "1.0.12" then
      (PlayerBusinessCardWindow.CreateAttr)(true)
    end
  end
)
  -- DECOMPILER ERROR at PC125: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.ScreenBtn).visible = false
  -- DECOMPILER ERROR at PC129: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.LookBtn).x = (uis.ScreenBtn).x
  ;
  ((uis.OutBtn).onClick):Set(function(...)
    -- function num : 0_0_8 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.PlayerBusinessCardWindow).name)
  end
)
  -- DECOMPILER ERROR at PC144: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((((uis.FormShrink).Form).ContentListA).Word).WordTxt).promptText = (PUtil.get)(282)
  ;
  ((((((uis.FormShrink).Form).ContentListA).Word).WordTxt).onFocusOut):Clear()
  ;
  ((((((uis.FormShrink).Form).ContentListA).Word).WordTxt).onFocusOut):Set(function(...)
    -- function num : 0_0_9 , upvalues : _ENV, uis
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

    if (Util.TextLegalCheck)((((((uis.FormShrink).Form).ContentListA).Word).WordTxt).text) == false then
      (((((uis.FormShrink).Form).ContentListA).Word).WordTxt).text = (PUtil.get)(282)
    else
      ;
      (Util.SetPlayerSetting)(PlayerPrefsKeyName.PLAYER_BUSINESS_INFO, (((((uis.FormShrink).Form).ContentListA).Word).WordTxt).text)
    end
  end
)
  ;
  (PlayerBusinessCardWindow.RefreshWindow)()
  ;
  (PlayerBusinessCardWindow.InitCardList)()
  ;
  (PlayerBusinessCardWindow.InitBgList)()
  ;
  (PlayerBusinessCardWindow.InitIssue)()
end

PlayerBusinessCardWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : PlayerBusinessCardWindow
  (PlayerBusinessCardWindow.InitBackground)()
  ;
  (PlayerBusinessCardWindow.InitPlayerAttr)()
end

PlayerBusinessCardWindow.InitCardList = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis, curClickedCardIndex, curClickedCardId, PlayerBusinessCardWindow
  (CardMgr.SetButtomRoleList)((uis.ListChoice).CardHeadList, function(index, data, ...)
    -- function num : 0_2_0 , upvalues : curClickedCardIndex, curClickedCardId, _ENV, uis, PlayerBusinessCardWindow
    if index ~= curClickedCardIndex then
      curClickedCardIndex = index
      curClickedCardId = data.id
      local fashionIds = (((TableData.gTable).BaseCardData)[data.id]).fashion_ids
      local fashionId = tonumber((split(fashionIds, ":"))[1])
      print("fashionId", fashionId)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((uis.Cothes_A_Btn).c1Ctr).selectedIndex = 0
      ;
      (PlayerBusinessCardWindow.UpdateBg)(fashionId)
    end
  end
, curClickedCardIndex, (uis.ListChoice).LeftBtn, (uis.ListChoice).RightBtn, (WinResConfig.PlayerBusinessCardWindow).name, true)
end

PlayerBusinessCardWindow.ChangeFashion = function(index, ...)
  -- function num : 0_3 , upvalues : _ENV, curClickedCardId, PlayerBusinessCardWindow
  local fashionIds = (((TableData.gTable).BaseCardData)[curClickedCardId]).fashion_ids
  ;
  (PlayerBusinessCardWindow.UpdateBg)(tonumber((split(fashionIds, ":"))[index]))
end

PlayerBusinessCardWindow.UpdateChooseCardArrow = function(...)
  -- function num : 0_4 , upvalues : uis
  local BackGroundChoice = uis.ListChoice
  local leftArrow = BackGroundChoice.LeftBtn
  local rightArrow = BackGroundChoice.RightBtn
  local cardList = BackGroundChoice.CardHeadList
  if leftArrow and rightArrow then
    if (cardList.scrollPane).contentWidth <= cardList.width then
      leftArrow.visible = false
      rightArrow.visible = false
    else
      local posX = (cardList.scrollPane).posX
      if posX <= 0 then
        leftArrow.visible = false
      else
        leftArrow.visible = true
      end
      if (cardList.scrollPane).contentWidth - cardList.width <= posX then
        rightArrow.visible = false
      else
        rightArrow.visible = true
      end
    end
  end
end

PlayerBusinessCardWindow.InitBgList = function(...)
  -- function num : 0_5 , upvalues : uis, PlayerBusinessCardWindow, _ENV, bgItems, curClickedBgId
  local bgList = (uis.ListChoice).BgList
  ;
  ((bgList.scrollPane).onScroll):Set(PlayerBusinessCardWindow.OnBgScrollView)
  bgList:RemoveChildrenToPool()
  local backgroundConfig = (TableData.gTable).BaseHomeBackgroundData
  local configTable = {}
  for _,config in pairs(backgroundConfig) do
    do
      if config.is_open == 1 then
        local serverTime = (LuaTime.GetTimeStamp)()
        local beginTime = config.begin_time
        local endTime = config.end_time
        -- DECOMPILER ERROR at PC37: Unhandled construct in 'MakeBoolean' P1

        if beginTime ~= nil and endTime ~= nil and beginTime <= serverTime and serverTime <= endTime then
          (table.insert)(configTable, config)
        end
      end
      ;
      (table.insert)(configTable, config)
    end
  end
  ;
  (table.sort)(configTable, function(a, b, ...)
    -- function num : 0_5_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local selectIndex = nil
  bgItems = {}
  for i,config in ipairs(configTable) do
    local bgItem = bgList:AddItemFromPool()
    ;
    (bgItem:GetChild("PictureLoader")).url = (Util.GetItemUrl)(config.path_ui)
    ;
    (table.insert)(bgItems, bgItem)
    ChangeUIController(bgItem, "c1", 1)
    ChangeUIController(bgItem, "c2", 1)
    if curClickedBgId == config.id then
      selectIndex = i
      ChangeUIController(bgItem, "c2", 0)
    end
    ;
    (bgItem.onClick):Set(function(...)
    -- function num : 0_5_1 , upvalues : _ENV, bgItems, bgItem, PlayerBusinessCardWindow, config
    for index,value in ipairs(bgItems) do
      ChangeUIController(value, "c2", 1)
    end
    ChangeUIController(bgItem, "c2", 0)
    ;
    (PlayerBusinessCardWindow.UpdateOneBg)(bgItem, config)
  end
)
  end
  if selectIndex then
    bgList:ScrollToView(selectIndex - 1)
  end
end

PlayerBusinessCardWindow.UpdateOneBg = function(hand, config, ...)
  -- function num : 0_6 , upvalues : holderEffectBack, _ENV, holderEffectFront, uis, holder, contentPane, texture
  if holderEffectBack then
    (LuaEffect.DestroyEffect)(holderEffectBack)
    holderEffectBack = nil
  end
  if holderEffectFront then
    (LuaEffect.DestroyEffect)(holderEffectFront)
    holderEffectFront = nil
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.BackgroundLoader).texture = nil
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  if config and config ~= "" then
    (uis.BackgroundLoader).texture = nil
    local path_ab = config.path_ab
    if (string.find)((string.lower)(path_ab), "fx_") ~= nil then
      holder = (LuaEffect.AddNotDeletedUIEffect)(path_ab, Vector3.zero, 1)
      holder:SetXY(contentPane.width / 2, contentPane.height / 2)
      contentPane:AddChildAt(holder, 0)
    else
      if texture then
        (ResHelper.UnloadTexture)(texture)
      end
      texture = (ResHelper.LoadTexture)(path_ab)
      if texture ~= nil then
        SetLoaderTexture(uis.BackgroundLoader, texture)
      end
    end
    if config.effect_back then
      holderEffectBack = (LuaEffect.AddNotDeletedUIEffect)(config.effect_back, Vector3.zero, 1)
      holderEffectBack:SetXY(contentPane.width / 2, contentPane.height / 2)
      contentPane:AddChildAt(holderEffectBack, contentPane:GetChildIndex(uis.ShowLoader))
    end
    if config.effect_front then
      holderEffectFront = (LuaEffect.AddNotDeletedUIEffect)(config.effect_front, Vector3.zero, 1)
      holderEffectFront:SetXY(contentPane.width / 2, contentPane.height / 2)
      contentPane:AddChildAt(holderEffectFront, contentPane:GetChildIndex(uis.ShowLoader) + 1)
    end
  end
end

PlayerBusinessCardWindow.OnBgScrollView = function(...)
  -- function num : 0_7 , upvalues : PlayerBusinessCardWindow
  (PlayerBusinessCardWindow.UpdateChooseBgArrow)()
end

PlayerBusinessCardWindow.UpdateChooseBgArrow = function(...)
  -- function num : 0_8 , upvalues : uis
  local BackGroundChoice = uis.ListChoice
  local leftArrow = BackGroundChoice.LeftBtn
  local rightArrow = BackGroundChoice.RightBtn
  local bgList = BackGroundChoice.BgList
  if leftArrow and rightArrow then
    if (bgList.scrollPane).contentWidth <= bgList.width then
      leftArrow.visible = false
      rightArrow.visible = false
    else
      local posX = (bgList.scrollPane).posX
      if posX <= 0 then
        leftArrow.visible = false
      else
        leftArrow.visible = true
      end
      if (bgList.scrollPane).contentWidth - bgList.width <= posX then
        rightArrow.visible = false
      else
        rightArrow.visible = true
      end
    end
  end
end

PlayerBusinessCardWindow.InitBackground = function(onlyBg, ...)
  -- function num : 0_9 , upvalues : _ENV, curClickedCardId, uis, PlayerBusinessCardWindow, holder, contentPane, showModel, curClickedBgId, texture, holderEffectBack, holderEffectFront
  local fashionIds = (((TableData.gTable).BaseCardData)[curClickedCardId]).fashion_ids
  local fashionId = tonumber((split(fashionIds, ":"))[1])
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionId]
  local cg = fashionConfig.show_cg
  local effect = nil
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.BackgroundLoader).texture = nil
  ;
  (PlayerBusinessCardWindow.ClearAllHolder)()
  if not onlyBg then
    (Util.RecycleUIModel)(uis.ShowLoader)
  end
  if cg and cg ~= "" then
    holder = (LuaEffect.AddNotDeletedUIEffect)(cg, Vector3.zero, 1)
    holder:SetXY(contentPane.width / 2, contentPane.height / 2)
    contentPane:AddChildAt(holder, 0)
    if effect then
      showModel = effect:GetComponentInChildren(typeof(((CS.Spine).Unity).SkeletonAnimation))
    end
  else
    showModel = nil
    local show_background = curClickedBgId
    local bgConfig = ((TableData.gTable).BaseHomeBackgroundData)[show_background]
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R8 in 'UnsetPending'

    if bgConfig and bgConfig ~= "" then
      (uis.BackgroundLoader).texture = nil
      local path_ab = bgConfig.path_ab
      if (string.find)((string.lower)(path_ab), "fx_") ~= nil then
        holder = (LuaEffect.AddNotDeletedUIEffect)(path_ab, Vector3.zero, 1)
        holder:SetXY(contentPane.width / 2, contentPane.height / 2)
        contentPane:AddChildAt(holder, 0)
      else
        if texture then
          (ResHelper.UnloadTexture)(texture)
        end
        texture = (ResHelper.LoadTexture)(path_ab)
        if texture ~= nil then
          SetLoaderTexture(uis.BackgroundLoader, texture)
        end
      end
      if onlyBg ~= true then
        (PlayerBusinessCardWindow.UpdateBg)(fashionId)
      end
      if bgConfig.effect_back then
        holderEffectBack = (LuaEffect.AddNotDeletedUIEffect)(bgConfig.effect_back, Vector3.zero, 1)
        holderEffectBack:SetXY(contentPane.width / 2, contentPane.height / 2)
        contentPane:AddChildAt(holderEffectBack, contentPane:GetChildIndex(uis.ShowLoader))
      end
      if bgConfig.effect_front then
        holderEffectFront = (LuaEffect.AddNotDeletedUIEffect)(bgConfig.effect_front, Vector3.zero, 1)
        holderEffectFront:SetXY(contentPane.width / 2, contentPane.height / 2)
        contentPane:AddChildAt(holderEffectFront, contentPane:GetChildIndex(uis.ShowLoader) + 1)
      end
    end
  end
end

PlayerBusinessCardWindow.UpdateBg = function(fashionShow, ...)
  -- function num : 0_10 , upvalues : _ENV, uis, holder, contentPane, showModel, curClickedCardId
  (Util.RecycleUIModel)(uis.ShowLoader)
  if holder then
    (LuaEffect.DestroyEffect)(holder)
    holder = nil
  end
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionShow]
  local isStatic = (Util.GetPlayerSetting)(PlayerPrefsKeyName.MAIN_SHOW_STATIC, "0")
  if isStatic == "0" then
    local cg = fashionConfig.show_cg
    if cg and cg ~= "" then
      local effect = nil
      holder = (LuaEffect.AddNotDeletedUIEffect)(cg, Vector3.zero, 1)
      holder:SetXY(contentPane.width / 2, contentPane.height / 2)
      contentPane:AddChildAt(holder, 0)
      if effect then
        showModel = effect:GetComponentInChildren(typeof(((CS.Spine).Unity).SkeletonAnimation))
      end
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (uis.BackgroundLoader).visible = false
    else
      do
        do
          -- DECOMPILER ERROR at PC66: Overwrote pending register: R4 in 'AssignReg'

          ;
          (effect.CreateShowModel)(fashionShow, uis.ShowLoader, true)
          -- DECOMPILER ERROR at PC73: Confused about usage of register: R4 in 'UnsetPending'

          ;
          (uis.BackgroundLoader).visible = true
          do
            local t_Object = (Util.ShowUIModel)(fashionConfig.show_texture, uis.ShowLoader)
            ;
            (Util.UpdateShowTextureByConfig)(t_Object, fashionConfig)
            local fashionIds = (((TableData.gTable).BaseCardData)[curClickedCardId]).fashion_ids
            local cardData = (CardData.GetCardData)(curClickedCardId)
            local f1 = tonumber((split(fashionIds, ":"))[1])
            local f1Cfg = ((TableData.gTable).BaseFashionData)[f1]
            local f1Bool = f1Cfg.unlock_quality <= cardData.quality
            -- DECOMPILER ERROR at PC114: Confused about usage of register: R8 in 'UnsetPending'

            ;
            ((uis.Cothes_A_Btn).Cothes_A_Btn).touchable = f1Bool
            if f1Bool then
              (((uis.Cothes_A_Btn).Cothes_A_Btn):GetController("lock")).selectedIndex = 0
            else
              (((uis.Cothes_A_Btn).Cothes_A_Btn):GetController("lock")).selectedIndex = 1
            end
            local f2 = tonumber((split(fashionIds, ":"))[2])
            local f2Cfg = ((TableData.gTable).BaseFashionData)[f2]
            local f2Bool = f2Cfg.unlock_quality <= cardData.quality
            -- DECOMPILER ERROR at PC149: Confused about usage of register: R11 in 'UnsetPending'

            ;
            ((uis.Cothes_A_Btn).Cothes_B_Btn).touchable = f2Bool
            if f2Bool then
              (((uis.Cothes_A_Btn).Cothes_B_Btn):GetController("lock")).selectedIndex = 0
            else
              (((uis.Cothes_A_Btn).Cothes_B_Btn):GetController("lock")).selectedIndex = 1
            end
            local f3 = tonumber((split(fashionIds, ":"))[3])
            local f3Cfg = ((TableData.gTable).BaseFashionData)[f3]
            local f3Bool = f3Cfg.unlock_quality <= cardData.quality
            -- DECOMPILER ERROR at PC184: Confused about usage of register: R14 in 'UnsetPending'

            ;
            ((uis.Cothes_A_Btn).Cothes_C_Btn).touchable = f3Bool
            if f3Bool then
              (((uis.Cothes_A_Btn).Cothes_C_Btn):GetController("lock")).selectedIndex = 0
            else
              (((uis.Cothes_A_Btn).Cothes_C_Btn):GetController("lock")).selectedIndex = 1
            end
            -- DECOMPILER ERROR: 9 unprocessed JMP targets
          end
        end
      end
    end
  end
end

PlayerBusinessCardWindow.InitPlayerAttr = function(...)
  -- function num : 0_11 , upvalues : _ENV, visibleAttr, uis, blackImg, oriBlackImgHeight, guildNameTxt
  local titleID = (ActorData.GetWearTitle)()
  visibleAttr[1] = titleID > 0
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((((uis.FormShrink).Form).ContentListA).Info_B_Btn).visible = visibleAttr[1]
  if visibleAttr[1] then
    local configData = ((TableData.gTable).BasePlayerTitleData)[titleID]
    ;
    ((((((uis.FormShrink).Form).ContentListA).Info_B_Btn):GetChild("TitlePic")):GetChild("PicLoader")).url = (Util.GetItemUrl)(configData.icon)
    blackImg.height = 433
  else
    blackImg.height = 370
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((((uis.FormShrink).Form).ContentListA).root).y = ((((uis.FormShrink).Form).ContentListA).root).y - 67
  end
  oriBlackImgHeight = blackImg.height
  ;
  (((((uis.FormShrink).Form).ContentListA).Info_B_Btn).onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : visibleAttr
    visibleAttr[1] = not visibleAttr[1]
  end
)
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((((uis.FormShrink).Form).ContentListA).PlayerName).NameTxt).text = (ActorData.GetNickName)()
  ;
  (((((uis.FormShrink).Form).ContentListA).ABtn):GetChild("TitleTxt")).text = (PUtil.get)(60000235)
  ;
  (((((uis.FormShrink).Form).ContentListA).ABtn):GetChild("WordTxt")).text = (ActorData.GetFc)()
  ;
  (((((uis.FormShrink).Form).ContentListA).ABtn).onClick):Set(function(...)
    -- function num : 0_11_1 , upvalues : visibleAttr
    visibleAttr[2] = not visibleAttr[2]
  end
)
  ;
  (((((uis.FormShrink).Form).ContentListA).BBtn):GetChild("TitleTxt")).text = (PUtil.get)(108)
  guildNameTxt = ((((uis.FormShrink).Form).ContentListA).BBtn):GetChild("WordTxt")
  if (ActorData.GetGuildID)() ~= 0 then
    (GuildService.ReqGuildSummary)()
  else
    guildNameTxt.text = (PUtil.get)(60000379)
  end
  ;
  (((((uis.FormShrink).Form).ContentListA).BBtn).onClick):Set(function(...)
    -- function num : 0_11_2 , upvalues : visibleAttr
    visibleAttr[3] = not visibleAttr[3]
  end
)
  ;
  (((((uis.FormShrink).Form).ContentListA).CBtn):GetChild("TitleTxt")).text = (PUtil.get)(111)
  ;
  (((((uis.FormShrink).Form).ContentListA).CBtn):GetChild("WordTxt")).text = (ActorData.GetPlayerIndex)()
  ;
  (((((uis.FormShrink).Form).ContentListA).CBtn).onClick):Set(function(...)
    -- function num : 0_11_3 , upvalues : visibleAttr
    visibleAttr[4] = not visibleAttr[4]
  end
)
  ;
  (((((uis.FormShrink).Form).ContentListA).DBtn):GetChild("TitleTxt")).text = (PUtil.get)(277)
  ;
  (((((uis.FormShrink).Form).ContentListA).DBtn):GetChild("WordTxt")).text = #(CardData.GetObtainedCardList)()
  ;
  (((((uis.FormShrink).Form).ContentListA).DBtn).onClick):Set(function(...)
    -- function num : 0_11_4 , upvalues : visibleAttr
    visibleAttr[5] = not visibleAttr[5]
  end
)
  -- DECOMPILER ERROR at PC219: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((((uis.FormShrink).Form).ContentListA).Word).WordTxt).text = (Util.GetPlayerSetting)(PlayerPrefsKeyName.PLAYER_BUSINESS_INFO, (PUtil.get)(282))
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

PlayerBusinessCardWindow.CreateAttr = function(isSave, ...)
  -- function num : 0_12 , upvalues : uis, blackImg, oriBlackImgHeight, visibleAttr, _ENV, guildNameTxt, PlayerBusinessCardWindow
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (((uis.FormShrink).Form).ScreenShotCtr).selectedIndex = 1
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.FormShrink).ScreenShotCtr).selectedIndex = 1
  local list = (((uis.FormShrink).Form).ContentListB).ShowList
  blackImg.height = oriBlackImgHeight
  list:RemoveChildrenToPool()
  local subHeight = 0
  local mul = 0
  for i = 2, 5 do
    if visibleAttr[i] == false then
      subHeight = subHeight + 55
      mul = mul + 1
    end
  end
  if visibleAttr[1] then
    local item = list:AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "Info_B_Btn"))
    local titleID = (ActorData.GetWearTitle)()
    local configData = ((TableData.gTable).BasePlayerTitleData)[titleID]
    ;
    ((item:GetChild("TitlePic")):GetChild("PicLoader")).url = (Util.GetItemUrl)(configData.icon)
    ;
    (item:GetChild("n4")).visible = false
    ;
    (item:GetChild("n5")).visible = false
  end
  do
    blackImg.height = blackImg.height - (subHeight)
    local item = list:AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "PlayerName"))
    ;
    (item:GetChild("NameTxt")).text = (ActorData.GetNickName)()
    do
      if visibleAttr[2] then
        local item = list:AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "Info_A_Btn"))
        ;
        (item:GetChild("TitleTxt")).text = (PUtil.get)(60000235)
        ;
        (item:GetChild("WordTxt")).text = (ActorData.GetFc)()
        ;
        (item:GetChild("n9")).visible = false
        ;
        (item:GetChild("n10")).visible = false
      end
      do
        if visibleAttr[3] then
          local item = list:AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "Info_A_Btn"))
          ;
          (item:GetChild("TitleTxt")).text = (PUtil.get)(108)
          if (ActorData.GetGuildID)() ~= 0 then
            (item:GetChild("WordTxt")).text = guildNameTxt.text
          else
            ;
            (item:GetChild("WordTxt")).text = (PUtil.get)(60000379)
          end
          ;
          (item:GetChild("n9")).visible = false
          ;
          (item:GetChild("n10")).visible = false
        end
        do
          if visibleAttr[4] then
            local item = list:AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "Info_A_Btn"))
            ;
            (item:GetChild("TitleTxt")).text = (PUtil.get)(111)
            ;
            (item:GetChild("WordTxt")).text = (ActorData.GetPlayerIndex)()
            ;
            (item:GetChild("n9")).visible = false
            ;
            (item:GetChild("n10")).visible = false
          end
          do
            if visibleAttr[5] then
              local item = list:AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "Info_A_Btn"))
              ;
              (item:GetChild("TitleTxt")).text = (PUtil.get)(277)
              ;
              (item:GetChild("WordTxt")).text = #(CardData.GetObtainedCardList)()
              ;
              (item:GetChild("n9")).visible = false
              ;
              (item:GetChild("n10")).visible = false
            end
            local selfTalk = list:AddItemFromPool((UIPackage.GetItemURL)("ActorInfo", "Word"))
            ;
            (selfTalk:GetChild("WordTxt")).promptText = (PUtil.get)(282)
            ;
            (selfTalk:GetChild("WordTxt")).text = (((((uis.FormShrink).Form).ContentListA).Word).WordTxt).text
            ;
            (selfTalk:GetChild("Decorate_04_Image")).visible = false
            if isSave then
              (PlayerBusinessCardWindow.SavePhoto)()
            end
          end
        end
      end
    end
  end
end

PlayerBusinessCardWindow.SavePhoto = function(...)
  -- function num : 0_13 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  (GRoot.inst).touchable = false
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_13_0 , upvalues : _ENV
    ((CS.ScreenShotManager).Instance):StartScreenShoot(1334, 750, function(...)
      -- function num : 0_13_0_0 , upvalues : _ENV
      ((CS.ScreenShotManager).Instance):SavePngAndUpdate()
      -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (GRoot.inst).touchable = true
    end
)
  end
)
end

PlayerBusinessCardWindow.InitIssue = function(...)
  -- function num : 0_14 , upvalues : uis, _ENV, PlayerBusinessCardWindow
  local lastX = 0
  local lastY = 0
  local init = false
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.FormShrink).root).draggable_X = true
  ;
  (((uis.FormShrink).root).onDragStart):Add(function(eventContext, ...)
    -- function num : 0_14_0 , upvalues : lastX, lastY
    lastX = (eventContext.inputEvent).x
    lastY = (eventContext.inputEvent).y
  end
)
  ;
  (((uis.FormShrink).root).onDragMove):Add(function(eventContext, ...)
    -- function num : 0_14_1 , upvalues : lastX, lastY, _ENV, PlayerBusinessCardWindow, uis
    local x = (eventContext.inputEvent).x - lastX
    lastX = (eventContext.inputEvent).x
    local y = (eventContext.inputEvent).y - lastY
    lastY = (eventContext.inputEvent).y
    x = x / Screen.width * ResolutionHandler.Width
    y = y / Screen.height * ResolutionHandler.Height
    ;
    (PlayerBusinessCardWindow.MoveAttr)(((uis.FormShrink).root).x + x, ((uis.FormShrink).root).y + y)
  end
)
end

PlayerBusinessCardWindow.MoveAttr = function(posX, posY, ...)
  -- function num : 0_15 , upvalues : _ENV, uis, blackImg
  local minX = 0
  local minY = 0
  local limitX = ResolutionHandler.Width - ((uis.FormShrink).root).width
  local limitY = ResolutionHandler.Height - blackImg.height
  if limitX < posX then
    posX = limitX
  else
    if posX < 0 then
      posX = minX
    end
  end
  if limitY < posY then
    posY = limitY
  else
    if posY < 0 then
      posY = minY
    end
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.FormShrink).root).x = posX
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.FormShrink).root).y = posY
end

PlayerBusinessCardWindow.ClearAllHolder = function(...)
  -- function num : 0_16 , upvalues : holder, _ENV, holderEffectBack, holderEffectFront
  if holder then
    (LuaEffect.DestroyEffect)(holder)
    holder = nil
  end
  if holderEffectBack then
    (LuaEffect.DestroyEffect)(holderEffectBack)
    holderEffectBack = nil
  end
  if holderEffectFront then
    (LuaEffect.DestroyEffect)(holderEffectFront)
    holderEffectFront = nil
  end
end

PlayerBusinessCardWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_17 , upvalues : _ENV, guildNameTxt
  local windowMsgEnum = WindowMsgEnum.ActorInfo
  if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_NAME then
    guildNameTxt.text = para
  end
end

PlayerBusinessCardWindow.OnClose = function(...)
  -- function num : 0_18 , upvalues : uis, fxMainEffect, _ENV, playerSetWords, bgItems, contentPane, bridge, argTable, texture
  if (uis.ListChoice).BgList then
    (((uis.ListChoice).BgList).itemPool):Clear()
  end
  if fxMainEffect then
    (LuaEffect.DestroyEffect)(fxMainEffect)
    fxMainEffect = nil
  end
  playerSetWords = ""
  bgItems = {}
  uis = nil
  contentPane = nil
  bridge = nil
  argTable = nil
  if texture then
    (ResHelper.UnloadTexture)(texture)
    texture = nil
  end
end

return PlayerBusinessCardWindow

