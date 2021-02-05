-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_FamilyLevelUpByName")
local FarmLevelUpWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local farmLvl = nil
FarmLevelUpWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, farmLvl, uis, FarmLevelUpWindow
  bridgeObj:SetView((WinResConfig.FarmLevelUpWindow).package, (WinResConfig.FarmLevelUpWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  farmLvl = argTable[1]
  uis = GetFamily_FamilyLevelUpUis(contentPane)
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SHOW_REWARD, SoundBank.OTHER)
  ;
  (Util.SetNotFoundEffect)(uis.CardLoader)
  ;
  ((uis.TouchScreenBtn).onClick):Set(FarmLevelUpWindow.OnCloseWindow)
  ;
  (MessageMgr.OnRegisterBackWinFunc)((WinResConfig.FarmLevelUpWindow).name, FarmLevelUpWindow.OnCloseWindow)
end

FarmLevelUpWindow.OnCloseWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.FarmLevelUpWindow).name)
end

FarmLevelUpWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, farmLvl
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TouchTxt).text = (PUtil.get)(20000224)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.LevelTxt).text = farmLvl
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_CHARACTER_LEVEL_UP, false, uis.root, Vector2((GRoot.inst).width / 2, (GRoot.inst).height * 1 / 2))
  local title = (uis.root):GetChild("1")
  local pos = Vector2(title.x + title.width / 2, title.y + title.height / 2)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
end

FarmLevelUpWindow.OnHide = function(...)
  -- function num : 0_3
end

FarmLevelUpWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, contentPane, argTable
  (Util.RecycleUIModel)(uis.CardLoader)
  uis = nil
  contentPane = nil
  argTable = {}
end

FarmLevelUpWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return FarmLevelUpWindow

