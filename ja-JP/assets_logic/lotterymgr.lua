-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryMgr = {
LotteryBackGroundEffectsPool = {}
, 
BackGroundEffectsType = {Card_BackGround = UIEffectEnum.UI_GACHA_CANI, Coupon_BackGround = UIEffectEnum.UI_GACHA_CANI}
, isLotterying = false}
local self = LotteryMgr
-- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.SetIsLotterying = function(b, ...)
  -- function num : 0_0 , upvalues : self
  self.isLotterying = b
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.GetIsLotterying = function(...)
  -- function num : 0_1 , upvalues : self
  return self.isLotterying
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.AddBackGroundEffectsToPool = function(tag, effect, ...)
  -- function num : 0_2 , upvalues : _ENV, self
  local isExsit = false
  for index,value in ipairs(self.LotteryBackGroundEffectsPool) do
    if value.tag == tag then
      isExsit = true
      break
    end
  end
  do
    if isExsit == false then
      (table.insert)(self.LotteryBackGroundEffectsPool, {tag = tag, effect = effect})
    end
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.GetBackGroundEffectFromPoolByTag = function(tag, ...)
  -- function num : 0_3 , upvalues : _ENV, self
  local effect = nil
  for index,value in ipairs(self.LotteryBackGroundEffectsPool) do
    if value.tag == tag then
      effect = value.effect
      break
    end
  end
  do
    return effect
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.HideAllBackGroundEffects = function(...)
  -- function num : 0_4 , upvalues : _ENV, self
  for index,value in ipairs(self.LotteryBackGroundEffectsPool) do
    (value.effect):SetActive(false)
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.RemoveAllBackGroundEffectsFromPool = function(...)
  -- function num : 0_5 , upvalues : _ENV, self
  for index,value in ipairs(self.LotteryBackGroundEffectsPool) do
    if value.effect ~= nil then
      (ResHelper.DestroyGameObject)(value.effect)
    end
  end
  self.LotteryBackGroundEffectsPool = {}
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.CheckAssetIsEnough = function(str, extraNum, ...)
  -- function num : 0_6 , upvalues : _ENV
  if extraNum == nil then
    extraNum = 0
  end
  local cost = split(str, ":")
  local costItemNum = (ActorData.GetGoodsCount)(cost[2], tonumber(cost[1])) or 0
  local costNeedNum = tonumber(cost[3])
  if costNeedNum > costItemNum + extraNum then
    do return costItemNum == nil, costItemNum end
    do return false, 0 end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.SetCharacterCompBtnClick = function(comp, cardIds, ...)
  -- function num : 0_7 , upvalues : _ENV
  local ids = split(cardIds, ":")
  for index,value in ipairs(ids) do
    local btn = comp:GetChild("Card_0" .. tostring(index) .. "_Btn")
    do
      local id = tonumber(value)
      ;
      (btn.onClick):Add(function(...)
    -- function num : 0_7_0 , upvalues : _ENV, id
    OpenWindow("CardDetailsWindow", UILayer.HUD, id)
  end
)
    end
  end
end

local isFingerTouchEnable = false
local isClick = false
local lerpLength = 200
local boolSlider = 0
local fakeTotalSliderLength = 1600
local curSliderLength = 0
local animPercent = 0
local lastClickPosX = 0
local bookItem, lotteryEffect = nil, nil
local isAutoOpen = false
local callBackFunc, unlockEffect1, unlockEffect2, gachaCamera, gachaEndEffect = nil, nil, nil, nil, nil
local isEndEffectPlay = false
local lotteryData = nil
local effectType = 1
local tipsEffect = nil
local EffectTYPE = {BLUE = 1, PURPLE = 2, GOLD = 3, SURPRISE = 4}
-- DECOMPILER ERROR at PC60: Confused about usage of register: R22 in 'UnsetPending'

LotteryMgr.PlayLotteryEffects = function(_callBack, para, ...)
  -- function num : 0_8 , upvalues : isFingerTouchEnable, isClick, boolSlider, curSliderLength, animPercent, isAutoOpen, isEndEffectPlay, callBackFunc, lotteryData, _ENV, lotteryEffect, tipsEffect, gachaCamera, bookItem, effectType, EffectTYPE
  isFingerTouchEnable = false
  isClick = false
  boolSlider = 0
  curSliderLength = 0
  animPercent = 0
  isAutoOpen = false
  isEndEffectPlay = false
  callBackFunc = _callBack
  lotteryData = para
  local effect = ((CS.PostManager).Instance):ReturnLotteryPrefab()
  effect:SetActive(true)
  ;
  (Util.SetStageCameraActive)(false)
  lotteryEffect = effect
  tipsEffect = ((effect.transform):Find("jiantou")).gameObject
  ;
  (LuaSound.PlaySound)(LuaSound.LOTTERY_ONE, SoundBank.OTHER)
  gachaCamera = ((effect.transform):Find("GachaCamera")).gameObject
  ;
  (Util.PlayAnimation)(gachaCamera, "FX_ui_Gacha_carmera_ani")
  local cameraTime = (Util.GetClipLength)(gachaCamera, "FX_ui_Gacha_carmera_ani")
  bookItem = ((effect.transform):Find("gacha_book")).gameObject
  local bookIdleTime = (Util.GetClipLength)(bookItem, "idle2")
  local goldenNum = 0
  for index,value in ipairs((para.data).goods) do
    if value.type == PropType.CARD then
      local cardData = ((TableData.gTable).BaseCardData)[value.id]
      local intelligence = cardData.intelligence
      if effectType < intelligence then
        effectType = intelligence
      end
      if intelligence == EffectTYPE.GOLD then
        goldenNum = goldenNum + 1
      end
    end
  end
  if #(para.data).goods > 1 or (LotteryMgr.SurpriseRandom)(goldenNum < 1) then
    effectType = EffectTYPE.SURPRISE
  end
  ;
  (LotteryMgr.ShowWhichColor)()
  ;
  (Util.PlayAnimation)(bookItem, "idle2")
  ;
  (SimpleTimer.setTimeout)(cameraTime, function(...)
    -- function num : 0_8_0 , upvalues : _ENV, tipsEffect
    (UpdateMgr.AddUpdateHandler)(LotteryMgr.Update)
    tipsEffect:SetActive(true)
  end
)
  ;
  (SimpleTimer.setTimeout)(cameraTime + 0.3, function(...)
    -- function num : 0_8_1 , upvalues : isFingerTouchEnable
    isFingerTouchEnable = true
  end
)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC63: Confused about usage of register: R22 in 'UnsetPending'

LotteryMgr.SurpriseRandom = function(isTen, ...)
  -- function num : 0_9 , upvalues : _ENV
  local fixedStr = split((((TableData.gTable).BaseFixedData)[72010090]).array_value, ":")
  local add = tonumber(fixedStr[2])
  if isTen then
    add = tonumber(fixedStr[3])
  end
  local basic = tonumber(fixedStr[1])
  local chance = (Util.GetIntPlayerSetting)(PlayerPrefsKeyName.EXTRA_LOTTERY_SURPRISE_NUM, 0)
  basic = basic + chance
  local rand = (math.random)(1, 200)
  local success = rand <= basic
  print("%%%%%%%%%%%%%%%%%%%%%", basic, rand)
  if success then
    (Util.SetIntPlayerSetting)(PlayerPrefsKeyName.EXTRA_LOTTERY_SURPRISE_NUM, 0)
  else
    (Util.SetIntPlayerSetting)(PlayerPrefsKeyName.EXTRA_LOTTERY_SURPRISE_NUM, chance + add)
  end
  do return success end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC66: Confused about usage of register: R22 in 'UnsetPending'

LotteryMgr.Update = function(...)
  -- function num : 0_10 , upvalues : isFingerTouchEnable, _ENV, lastClickPosX, isClick, tipsEffect, unlockEffect1, unlockEffect2, lerpLength, isAutoOpen, curSliderLength, animPercent, fakeTotalSliderLength, bookItem, gachaCamera, isEndEffectPlay, gachaEndEffect, callBackFunc, lotteryEffect
  if isFingerTouchEnable then
    if (Input.GetMouseButtonDown)(0) then
      lastClickPosX = (Input.mousePosition).x
      isClick = true
      tipsEffect:SetActive(false)
      unlockEffect1:SetActive(true)
      unlockEffect2:SetActive(true)
    end
    if (Input.GetMouseButtonUp)(0) then
      isClick = false
      tipsEffect:SetActive(true)
      unlockEffect2:SetActive(false)
    end
    do
      if (Input.GetMouseButton)(0) then
        local detalMove = -(Input.mousePosition).x + lastClickPosX
        if lerpLength < detalMove then
          detalMove = lerpLength
          isFingerTouchEnable = false
          tipsEffect:SetActive(false)
          isAutoOpen = true
          ;
          (LuaSound.PlaySound)(LuaSound.LOTTERY_FLIP_BOOK, SoundBank.OTHER)
          return 
        end
        curSliderLength = curSliderLength + detalMove
        animPercent = curSliderLength / fakeTotalSliderLength
        if fakeTotalSliderLength * 0.25 < curSliderLength then
          curSliderLength = fakeTotalSliderLength
          isFingerTouchEnable = false
          isAutoOpen = true
          ;
          (LuaSound.PlaySound)(LuaSound.LOTTERY_FLIP_BOOK, SoundBank.OTHER)
        end
        if curSliderLength < 0 then
          curSliderLength = 0
        end
        if animPercent > 1 then
          animPercent = 1
        end
        if animPercent < 0 then
          animPercent = 0
        end
        lastClickPosX = (Input.mousePosition).x
        ;
        (Util.PlayAnimationWithNormalLizedTime)(bookItem, "open", animPercent)
        ;
        (LotteryMgr.SetAllParticleAlpha)(unlockEffect1, animPercent)
        ;
        (LotteryMgr.SetAllParticleAlpha)(unlockEffect2, animPercent)
        ;
        (Util.PlayAnimationWithNormalLizedTime)(gachaCamera, "FX_ui_Gacha_carmera_press_ani", animPercent)
      end
      if isClick == false and animPercent > 0 then
        curSliderLength = curSliderLength - 3 / animPercent
        if curSliderLength < 0 then
          curSliderLength = 0
        end
        animPercent = curSliderLength / fakeTotalSliderLength
        ;
        (Util.PlayAnimationWithNormalLizedTime)(bookItem, "open", animPercent)
        ;
        (LotteryMgr.SetAllParticleAlpha)(unlockEffect1, animPercent)
        ;
        (LotteryMgr.SetAllParticleAlpha)(unlockEffect2, animPercent)
        ;
        (Util.PlayAnimationWithNormalLizedTime)(gachaCamera, "FX_ui_Gacha_carmera_press_ani", animPercent)
      end
      if isAutoOpen then
        if unlockEffect1.activeSelf == false then
          unlockEffect1:SetActive(true)
          unlockEffect2:SetActive(true)
        end
        animPercent = animPercent + 0.01
        if isEndEffectPlay == false and animPercent > 0.7 then
          isEndEffectPlay = true
          gachaEndEffect:SetActive(true)
          ;
          (SimpleTimer.setTimeout)(3.7, function(...)
    -- function num : 0_10_0 , upvalues : callBackFunc
    callBackFunc()
  end
)
          ;
          (SimpleTimer.setTimeout)(3.8, function(...)
    -- function num : 0_10_1 , upvalues : gachaEndEffect, _ENV, lotteryEffect
    gachaEndEffect:SetActive(false)
    ;
    (LotteryMgr.ResetCardQualityEffects)()
    ;
    (Util.SetStageCameraActive)(true)
    lotteryEffect:SetActive(false)
  end
)
          ;
          (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_10_2 , upvalues : _ENV, animPercent, unlockEffect1, unlockEffect2
    (((LeanTween.value)(animPercent, 0, 0.8)):setOnUpdate(function(value, ...)
      -- function num : 0_10_2_0 , upvalues : _ENV, unlockEffect1, unlockEffect2
      (LotteryMgr.SetAllParticleAlpha)(unlockEffect1, value)
      ;
      (LotteryMgr.SetAllParticleAlpha)(unlockEffect2, value)
    end
)):setOnComplete(function(...)
      -- function num : 0_10_2_1 , upvalues : unlockEffect1, unlockEffect2
      unlockEffect1:SetActive(false)
      unlockEffect2:SetActive(false)
    end
)
  end
)
        end
        if animPercent >= 1 then
          (Util.SetAnimationSpeed)(bookItem, 1)
          ;
          (Util.SetAnimationSpeed)(gachaCamera, 1)
          ;
          (UpdateMgr.RemoveUpdateHandler)(LotteryMgr.Update)
          isAutoOpen = false
        else
          ;
          (Util.PlayAnimationWithNormalLizedTime)(bookItem, "open", animPercent)
          ;
          (LotteryMgr.SetAllParticleAlpha)(unlockEffect1, animPercent)
          ;
          (LotteryMgr.SetAllParticleAlpha)(unlockEffect2, animPercent)
          ;
          (Util.PlayAnimationWithNormalLizedTime)(gachaCamera, "FX_ui_Gacha_carmera_press_ani", animPercent)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC69: Confused about usage of register: R22 in 'UnsetPending'

LotteryMgr.ShowWhichColor = function(...)
  -- function num : 0_11 , upvalues : effectType, EffectTYPE, gachaEndEffect, lotteryEffect, unlockEffect1, unlockEffect2, _ENV
  if effectType == EffectTYPE.BLUE then
    gachaEndEffect = ((lotteryEffect.transform):Find("FX_gacha_end_eff_blue")).gameObject
    unlockEffect1 = ((lotteryEffect.transform):Find("FX_ui_openbook_blue")).gameObject
    unlockEffect2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/blue_light")).gameObject
  else
    if effectType == EffectTYPE.PURPLE then
      gachaEndEffect = ((lotteryEffect.transform):Find("FX_gacha_end_eff_purple")).gameObject
      unlockEffect1 = ((lotteryEffect.transform):Find("FX_ui_openbook_purple")).gameObject
      unlockEffect2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/purple_light")).gameObject
    else
      if effectType == EffectTYPE.GOLD then
        gachaEndEffect = ((lotteryEffect.transform):Find("FX_gacha_end_eff_gold")).gameObject
        unlockEffect1 = ((lotteryEffect.transform):Find("FX_ui_openbook_glod")).gameObject
        unlockEffect2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/gold_light")).gameObject
      else
        if effectType == EffectTYPE.SURPRISE then
          gachaEndEffect = ((lotteryEffect.transform):Find("FX_gacha_end_eff_gold")).gameObject
          unlockEffect1 = ((lotteryEffect.transform):Find("FX_ui_openbook_purple")).gameObject
          unlockEffect2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/purple_light")).gameObject
        end
      end
    end
  end
  ;
  (LotteryMgr.SetParticleStarColorAlpha)(unlockEffect1, 0.5)
  ;
  (LotteryMgr.SetParticleStarColorAlpha)(unlockEffect2, 0.5)
  ;
  (LotteryMgr.SetBookPageHDRColor)(((lotteryEffect.transform):Find("gacha_book/shu_B")).gameObject, 0.5)
  effectType = 1
  unlockEffect1:SetActive(false)
  unlockEffect2:SetActive(false)
  ;
  (LotteryMgr.ResetCardQualityEffects)()
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R22 in 'UnsetPending'

LotteryMgr.SetAllParticleAlpha = function(item, alpha, ...)
  -- function num : 0_12 , upvalues : _ENV
  if alpha >= 0.05 then
    alpha = 2.5 * alpha - 0.125
  else
    alpha = 0
  end
  local renderS = item:GetComponentsInChildren(typeof((CS.UnityEngine).Renderer))
  local count = renderS.Length
  for i = 0, count - 1 do
    local materials = (renderS[i]).materials
    local countm = materials.Length - 1
    for j = 0, countm do
      local mat = materials[j]
      local _Color = ((renderS[i]).material):GetColor("_Color")
      mat:SetColor("_Color", ((CS.UnityEngine).Color)(_Color.r, _Color.g, _Color.b, alpha))
    end
  end
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R22 in 'UnsetPending'

LotteryMgr.SetParticleStarColorAlpha = function(item, alpha, ...)
  -- function num : 0_13 , upvalues : _ENV
  if alpha >= 0.05 then
    alpha = 2.5 * alpha - 0.125
  else
    alpha = 0
  end
  local particles = item:GetComponentsInChildren(typeof((CS.UnityEngine).ParticleSystem))
  local count = particles.Length
  for i = 0, count - 1 do
    local ps = particles[i]
    local oriColor = ((ps.main).startColor).color
    local main = ps.main
    local color = ((CS.UnityEngine).Color)(oriColor.r, oriColor.g, oriColor.b, 0.5)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (ps.main).startColor = (((CS.UnityEngine).ParticleSystem).MinMaxGradient)(color)
  end
end

-- DECOMPILER ERROR at PC78: Confused about usage of register: R22 in 'UnsetPending'

LotteryMgr.SetBookPageHDRColor = function(page, hdrColorScale, ...)
  -- function num : 0_14 , upvalues : _ENV
  local renderS = page:GetComponentsInChildren(typeof((CS.UnityEngine).Renderer))
  local count = renderS.Length
  for i = 0, count - 1 do
    local materials = (renderS[i]).materials
    local countm = materials.Length - 1
    for j = 0, countm do
      local mat = materials[j]
      mat:SetColor("_EmissionColor", ((CS.UnityEngine).Color)(hdrColorScale, hdrColorScale, hdrColorScale, 1))
    end
  end
end

-- DECOMPILER ERROR at PC81: Confused about usage of register: R22 in 'UnsetPending'

LotteryMgr.ResetCardQualityEffects = function(...)
  -- function num : 0_15 , upvalues : lotteryEffect, _ENV
  local eb1 = ((lotteryEffect.transform):Find("FX_ui_openbook_blue")).gameObject
  local eb2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/blue_light")).gameObject
  local ep1 = ((lotteryEffect.transform):Find("FX_ui_openbook_purple")).gameObject
  local ep2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/purple_light")).gameObject
  local eg1 = ((lotteryEffect.transform):Find("FX_ui_openbook_glod")).gameObject
  local eg2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/gold_light")).gameObject
  ;
  (LotteryMgr.SetAllParticleAlpha)(eb1, 0)
  ;
  (LotteryMgr.SetAllParticleAlpha)(eb2, 0)
  ;
  (LotteryMgr.SetAllParticleAlpha)(ep1, 0)
  ;
  (LotteryMgr.SetAllParticleAlpha)(ep2, 0)
  ;
  (LotteryMgr.SetAllParticleAlpha)(eg1, 0)
  ;
  (LotteryMgr.SetAllParticleAlpha)(eg2, 0)
end


