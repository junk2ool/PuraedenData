-- params : ...
-- function num : 0 , upvalues : _ENV
require("Birthday_BirthdayMainWindowByName")
BrithDayMainWindow = {}
local uis, contentPane, bridge, argTable, cardBrithDayId, curCardIndex, soundId, effectObj, loaderObj = nil, nil, nil, nil, nil, nil, nil, nil, nil
-- DECOMPILER ERROR at PC8: Confused about usage of register: R9 in 'UnsetPending'

BrithDayMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, uis, cardBrithDayId, curCardIndex
  bridgeObj:SetView((WinResConfig.BrithDayMainWindow).package, (WinResConfig.BrithDayMainWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = (GetBirthday_BirthdayMainWindowUis(contentPane)).BirthdayMain
  cardBrithDayId = not argTable or not argTable[1] or argTable[1] or nil
  curCardIndex = not argTable or not argTable[2] or argTable[2] or nil
  if cardBrithDayId ~= nil and curCardIndex ~= nil then
    (BrithDayMainWindow.RefreshWindow)()
  end
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R9 in 'UnsetPending'

BrithDayMainWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV, cardBrithDayId, uis, soundId
  local brithDayConfig = ((TableData.gTable).BaseActivityBirthdayData)[cardBrithDayId]
  local cardConfig = ((TableData.gTable).BaseCardData)[cardBrithDayId]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.Assembly_03).NameTxt).text = cardConfig.name
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.TimeTxt).text = brithDayConfig.date_remark
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.Assembly_04).WordTxt).text = brithDayConfig.remark
  local fashionConfig = ((TableData.gTable).BaseFashionData)[brithDayConfig.fashion_id]
  local t1 = (Util.ShowUIModel)(fashionConfig.show_texture, (uis.CardImg).CardLoader)
  ;
  (Util.UpdateShowTextureByConfig)(t1, fashionConfig)
  local t2 = (Util.ShowUIModel)(fashionConfig.show_texture, uis.BgCardLoader)
  ;
  (Util.UpdateShowTextureByConfig)(t2, fashionConfig)
  soundId = (LuaSound.AudioMgrPlaySound)(brithDayConfig.voice_path, false)
  ;
  (BrithDayMainWindow.SetShadow)()
  ;
  ((uis.root).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, cardBrithDayId
    (BrithDayService.ReqBirthdayReward)(cardBrithDayId)
  end
)
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R9 in 'UnsetPending'

BrithDayMainWindow.SetShadow = function(...)
  -- function num : 0_2 , upvalues : _ENV, effectObj, loaderObj, uis
  local effect = (LuaEffect.AddUIEffect)("ImageShadow", false, false)
  effectObj = (((effect.displayObject).gameObject).transform):Find("ImageShadow(Clone)")
  loaderObj = (((((uis.CardImg).CardLoader).displayObject).gameObject).transform):Find("Image")
  local copyMesh = (GameObject.Instantiate)((loaderObj:GetComponent(typeof((CS.UnityEngine).MeshFilter))).mesh)
  ;
  (effectObj:GetComponent(typeof((CS.UnityEngine).MeshFilter))).mesh = copyMesh
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((effectObj:GetComponent(typeof((CS.UnityEngine).Renderer))).material).mainTexture = ((loaderObj:GetComponent(typeof((CS.UnityEngine).Renderer))).material).mainTexture
  ;
  (((uis.CardImg).shadow).root):AddChild(effect)
  effectObj.localPosition = loaderObj.localPosition
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R9 in 'UnsetPending'

BrithDayMainWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, contentPane, bridge, argTable, _ENV, curCardIndex
  uis = nil
  contentPane = nil
  bridge = nil
  argTable = nil
  ;
  (BrithDayMgr.OpenBrithDayWindow)(curCardIndex + 1)
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R9 in 'UnsetPending'

BrithDayMainWindow.Fade = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, effectObj
  ((LeanTween.value)(1, 0, 0.35)):setOnUpdate(function(value, ...)
    -- function num : 0_4_0 , upvalues : uis, effectObj, _ENV
    (((uis.CardImg).CardLoader).material):SetFloat("_Alpha", value)
    ;
    ((effectObj:GetComponent(typeof((CS.UnityEngine).Renderer))).material):SetFloat("_AlphaValue", value)
  end
)
end

return BrithDayMainWindow

