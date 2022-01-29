-- params : ...
-- function num : 0 , upvalues : _ENV
require("CardPop_CardDetailsByName")
require("CommonResource_SkillFrameByName")
local CardDetailsWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local cardId = nil
local SELF_LABEL_MAX = 4
local holder, showModel = nil, nil
CardDetailsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, cardId, CardDetailsWindow
  bridgeObj:SetView((WinResConfig.CardDetailsWindow).package, (WinResConfig.CardDetailsWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetCardPop_CardDetailsUis(contentPane)
  if argTable[1] then
    cardId = argTable[1]
  end
  ;
  (CardDetailsWindow.RefreshWindow)()
end

CardDetailsWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, cardId, SELF_LABEL_MAX, holder, contentPane, showModel
  local m = {}
  m.windowName = (WinResConfig.CardDetailsWindow).name
  m.Tip = (PUtil.get)(172)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.AssetStripGrp).CloseAssetGrp).visible = false
  local excelData = ((TableData.gTable).BaseCardData)[cardId]
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

  if excelData.name_pic then
    ((uis.InformationGrp).JueseNameLoader).url = (Util.GetItemUrl)(excelData.name_pic)
  end
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.InformationGrp).CardNameTxt).text = excelData.name
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.InformationGrp).CVNameTxt).text = excelData.cv_name
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.InformationGrp).c1Ctr).selectedIndex = excelData.intelligence - 1
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = excelData.intelligence
  local props = {(uis.InformationGrp).One, (uis.InformationGrp).Two, (uis.InformationGrp).Three}
  local propsTxt = {((uis.InformationGrp).One).LabelTxt, ((uis.InformationGrp).Two).LabelTxt, ((uis.InformationGrp).Three).LabelTxt}
  local selfLabel = split(excelData.card_label_show, ":")
  for i = 1, #props do
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R9 in 'UnsetPending'

    ((props[i]).root).visible = false
  end
  for i = 1, #selfLabel do
    -- DECOMPILER ERROR at PC104: Confused about usage of register: R9 in 'UnsetPending'

    ((props[SELF_LABEL_MAX - i]).root).visible = true
    -- DECOMPILER ERROR at PC114: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (propsTxt[SELF_LABEL_MAX - i]).text = (PUtil.get)(tonumber(selfLabel[i]))
  end
  ;
  ((uis.InformationGrp).StarList):RemoveChildrenToPool()
  do
    for i = 1, excelData.star do
      ((uis.InformationGrp).StarList):AddItemFromPool()
    end
  end
  -- DECOMPILER ERROR at PC138: Confused about usage of register: R5 in 'UnsetPending'

  if excelData.cv_pic then
    ((uis.InformationGrp).CVNameLoader).url = (Util.GetItemUrl)(excelData.cv_pic)
  end
  local fashionIds = split(excelData.fashion_ids, ":")
  local fashionId = tonumber(fashionIds[#fashionIds])
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  -- DECOMPILER ERROR at PC155: Confused about usage of register: R8 in 'UnsetPending'

  if fashionData.show_cg ~= nil then
    (uis.c1Ctr).selectedIndex = 0
    local effect = nil
    holder = (LuaEffect.AddNotDeletedUIEffect)(fashionData.show_cg, Vector3.zero, 1)
    holder:SetXY(contentPane.width / 2, contentPane.height / 2)
    contentPane:AddChildAt(holder, 0)
    if effect then
      showModel = effect:GetComponentInChildren(typeof(((CS.Spine).Unity).SkeletonAnimation))
    end
  else
    do
      -- DECOMPILER ERROR at PC190: Overwrote pending register: R8 in 'AssignReg'

      ;
      (effect.RecycleUIModel)(uis.CardLoader)
      ;
      (Util.CreateShowModel)(fashionId, uis.CardLoader, true, false, true)
      -- DECOMPILER ERROR at PC211: Confused about usage of register: R8 in 'UnsetPending'

      if fashionData.unlock_remark then
        (uis.WordTxt).text = (PUtil.get)(186, fashionData.unlock_remark)
      end
      ;
      (uis.SkillMessageList):RemoveChildrenToPool()
      local skills = {excelData.unique_skill_id, excelData.special_skill_id, excelData.ex_passiveSkillId}
      for i = 1, #skills do
        if skills[i] ~= nil then
          local skillGrp = GetCommonResource_SkillFrameUis((uis.SkillMessageList):AddItemFromPool())
          local skillData = (TableData.GetBaseSkillData)(skills[i])
          -- DECOMPILER ERROR at PC241: Confused about usage of register: R15 in 'UnsetPending'

          ;
          (skillGrp.SkillLoader).url = (Util.GetResUrl)(skillData.icon_path)
          ;
          ((skillGrp.SkillLoader).onClick):Clear()
          ;
          ((skillGrp.SkillLoader).onClick):Add(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, skillData, excelData
    OpenWindow("SkillTipsWindow", UILayer.HUD)
    local data = {}
    data.skillData = skillData
    data.skillLevel = 0
    data.cardData = excelData
    data.position = 1
    UIMgr:SendWindowMessage((WinResConfig.SkillTipsWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_SKILLDETAIL, data)
  end
)
          local skillType = skillData.type
          -- DECOMPILER ERROR at PC255: Confused about usage of register: R16 in 'UnsetPending'

          if skillType == 2 then
            (skillGrp.c1Ctr).selectedIndex = 2
          else
            -- DECOMPILER ERROR at PC260: Confused about usage of register: R16 in 'UnsetPending'

            if skillType == 3 then
              (skillGrp.c1Ctr).selectedIndex = 1
            else
              -- DECOMPILER ERROR at PC265: Confused about usage of register: R16 in 'UnsetPending'

              if skillType == 6 then
                (skillGrp.c1Ctr).selectedIndex = 3
              else
                -- DECOMPILER ERROR at PC268: Confused about usage of register: R16 in 'UnsetPending'

                ;
                (skillGrp.c1Ctr).selectedIndex = 0
              end
            end
          end
        end
      end
    end
  end
end

CardDetailsWindow.OnClose = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis, contentPane, argTable, cardId, holder, showModel
  (CommonWinMgr.RemoveAssets)((WinResConfig.CardDetailsWindow).name)
  uis = nil
  contentPane = nil
  argTable = nil
  cardId = nil
  if holder then
    (LuaEffect.DestroyEffect)(holder)
    holder = nil
  end
  showModel = nil
end

CardDetailsWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_3
end

return CardDetailsWindow

