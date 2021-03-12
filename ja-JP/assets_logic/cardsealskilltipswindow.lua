-- params : ...
-- function num : 0 , upvalues : _ENV
require("DescriptionTips_SkillTipsWindowByName")
local CardSealSkillTipsWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local sealSkillID = nil
CardSealSkillTipsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, sealSkillID, uis
  bridgeObj:SetView((WinResConfig.CardSealSkillTipsWindow).package, (WinResConfig.CardSealSkillTipsWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  sealSkillID = argTable[1]
  uis = GetDescriptionTips_SkillTipsWindowUis(contentPane)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.CardSealSkillTipsWindow).name)
  end
)
  uis = uis.SkillTipsGrp
end

CardSealSkillTipsWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : _ENV, sealSkillID, uis
  local configData = ((TableData.gTable).BaseCardSealSkillUpData)[sealSkillID]
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.c2Ctr).selectedIndex = 4
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.SkillFrameGrp).SkillLoader).url = (Util.GetItemUrl)(configData.icon_path)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SkillNameTxt).text = configData.name
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.SkillFrameGrp).c1Ctr).selectedIndex = 4
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SkillLevelTxt).visible = false
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SkillTypeTxt).text = (PUtil.get)(20000656)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.OpenConditionTxt).visible = false
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SkillWordTxt).text = configData.remark
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.root).xy = Vector2((ResolutionHandler.AdaptOffset).X + 630, (ResolutionHandler.AdaptOffset).Y + 330)
end

CardSealSkillTipsWindow.OnHide = function(...)
  -- function num : 0_2
end

CardSealSkillTipsWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

CardSealSkillTipsWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_4
end

return CardSealSkillTipsWindow

