-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryWindow_YouChangActivity = {}
local LotteryCardId = {day = 24001011}
local CostType = {Free = 1, Ticket = 2, Diamond = 3}
local countTimer = nil
local lotteryType = LotteryType.YouChangHuoDongUp
local fx_main, uis, beginTime, endTime = nil, nil, nil, nil
-- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_YouChangActivity.RefreshWindow = function(_uis, ...)
  -- function num : 0_0 , upvalues : uis, _ENV
  if uis == nil then
    uis = _uis
  end
  ;
  ((((uis.LotteryPanelGrp).GetCha_LuckBagGrp).SpecialOneTimeBtn):GetChild("Number_01_Txt")).text = ""
  ;
  (LotteryWindow_YouChangActivity.PreLoadFxMain)(uis)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_YouChangActivity.HideOrShowFxMain = function(isShow, ...)
  -- function num : 0_1 , upvalues : fx_main
  if fx_main ~= nil then
    fx_main:SetActive(isShow)
  end
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_YouChangActivity.PreLoadFxMain = function(uis, ...)
  -- function num : 0_2 , upvalues : _ENV, lotteryType
  local excelShowData = ((TableData.gTable).BaseLotteryShowData)[lotteryType]
  local str = split(excelShowData.card_ids, ":")
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((((uis.LotteryPanelGrp).GetCha_LuckBagGrp).CardPicLoader).CardPicLoader).url = (Util.GetItemUrl)(excelShowData.card_ids)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_YouChangActivity.ReceiveInitData = function(...)
  -- function num : 0_3 , upvalues : _ENV, beginTime, endTime, uis, LotteryCardId
  local lData = ((LotteryData.GetLotteryData)()).data
  print("beginTime", lData.beginTime, "endTime", lData.endTime, "onceSurplusNum", lData.onceSurplusNum, "moreSurplusNum", lData.moreSurplusNum)
  beginTime = lData.beginTime
  endTime = lData.endTime
  ;
  (LotteryWindow_YouChangActivity.SetButtonInfo)(((uis.LotteryPanelGrp).GetCha_LuckBagGrp).SpecialOneTimeBtn, LotteryCardId.day, 0, true)
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_YouChangActivity.SetButtonInfo = function(btn, id, freeNum, dayLottery, sound, ...)
  -- function num : 0_4 , upvalues : _ENV, beginTime, endTime, CostType, LotteryCardId
  local excelData = ((TableData.gTable).BaseLotteryData)[id]
  local costStr, haveCount, needCount = nil, nil, nil
  local isKaQuan = excelData.type == 3
  if freeNum > 0 then
    (btn:GetChild("Number_01_Loader")).visible = false
    if btn:GetChild("FreeNumberTxt") then
      (btn:GetChild("FreeNumberTxt")).visible = true
      ;
      (btn:GetChild("FreeNumberTxt")).text = (PUtil.get)(89, freeNum, excelData.day_free_num)
    end
    ;
    (btn:GetChild("Number_01_Txt")).text = (PUtil.get)(90)
  else
    (btn:GetChild("Number_01_Loader")).visible = true
    if btn:GetChild("FreeNumberTxt") then
      (btn:GetChild("FreeNumberTxt")).visible = false
    end
    if isKaQuan or dayLottery then
      costStr = split(excelData.cost, ":")
    elseif (string.len)(excelData.first_cost) > 1 then
      local cStr1 = split(excelData.first_cost, ":")
      haveCount = (ActorData.GetGoodsCount)(cStr1[2], tonumber(cStr1[1])) or 0
      needCount = tonumber(cStr1[3])
      if needCount <= haveCount then
        costStr = cStr1
      else
        local cStr2 = split(excelData.cost, ":")
        costStr = cStr2
      end
    else
      local cStr2 = split(excelData.cost, ":")
      costStr = cStr2
    end
    if costStr[2] then
      (btn:GetChild("Number_01_Loader")).url = (Util.GetItemUrl)(((Util.GetConfigDataByID)(costStr[2])).icon)
    end
    if costStr[3] then
      (btn:GetChild("Number_01_Txt")).text = costStr[3]
    end
  end
  ;
  (btn.onClick):ClearCallFunc()
  ;
  (btn.onClick):Add(function(...)
    -- function num : 0_4_0 , upvalues : _ENV, beginTime, endTime, freeNum, id, CostType, sound, excelData, LotteryCardId, dayLottery
    local curTime = (ActorData.GetServerTime)()
    print("------------curTime", curTime, beginTime, endTime)
    if beginTime <= curTime and curTime <= endTime then
      (MessageMgr.SendCenterTips)((PUtil.get)(223))
      UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_REFRESHLOTTERYLIST, {})
      do return  end
      if freeNum > 0 then
        loge("免费次数")
        ;
        (LotteryService.ReqLotteryDraw)(id)
        ;
        (LotteryData.SaveCurCostMode)(CostType.Free)
        if sound ~= nil then
          (LuaSound.PlaySound)(sound, SoundBank.OTHER)
        end
      else
        local cost = split(excelData.first_cost, ":")
        local costItemNum = (ActorData.GetGoodsCount)(cost[2], tonumber(cost[1])) or 0
        local costNeedNum = tonumber(cost[3])
        if costNeedNum ~= nil and costNeedNum <= costItemNum then
          loge("钻石招募券")
          if id == LotteryCardId.day then
            if dayLottery then
              (LotteryData.SaveCurCostMode)(CostType.Day)
            else
              ;
              (MessageMgr.SendCenterTips)((PUtil.get)(174))
              return 
            end
          else
            ;
            (LotteryData.SaveCurCostMode)(CostType.Ticket)
          end
          ;
          (MessageMgr.OpenCostResConfirmWindow)(224, excelData.first_cost, function(...)
      -- function num : 0_4_0_0 , upvalues : _ENV, id, sound
      (LotteryService.ReqLotteryDraw)(id)
      if sound ~= nil then
        (LuaSound.PlaySound)(sound, SoundBank.OTHER)
      end
    end
)
        else
          loge("消耗绑钻或者非绑钻   " .. tostring(id))
          if id == LotteryCardId.day then
            print("++++++++++++++++++++++dayLottery", dayLottery)
            if dayLottery then
              (LotteryData.SaveCurCostMode)(CostType.Day)
              local bind = (LotteryMgr.CheckAssetIsEnough)(excelData.cost)
              local bindId = tonumber((split(excelData.cost, ":"))[2])
              if bind then
                (MessageMgr.OpenCostResConfirmWindow)(224, excelData.cost, function(...)
      -- function num : 0_4_0_1 , upvalues : _ENV, id, sound
      (LotteryService.ReqLotteryDraw)(id)
      if sound ~= nil then
        (LuaSound.PlaySound)(sound, SoundBank.OTHER)
      end
    end
)
              else
                ;
                (MessageMgr.OpenAssetNotEnoughtWindow)(bindId)
              end
            else
              do
                ;
                (MessageMgr.SendCenterTips)((PUtil.get)(174))
                do return  end
                ;
                (LotteryData.SaveCurCostMode)(CostType.Diamond)
                ;
                (MessageMgr.OpenCostResConfirmWindow)(224, excelData.cost, function(...)
      -- function num : 0_4_0_2 , upvalues : _ENV, id, sound
      (LotteryService.ReqLotteryDraw)(id)
      if sound ~= nil then
        (LuaSound.PlaySound)(sound, SoundBank.OTHER)
      end
    end
)
              end
            end
          end
        end
      end
    end
  end
)
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_YouChangActivity.ReceiveDrawedData = function(para, ...)
  -- function num : 0_5 , upvalues : _ENV, lotteryType
  (ActorData.SubLotteryActivityNum)((para.data).lotteryId, 1)
  ;
  (LotteryMgr.PlayLotteryEffects)(function(...)
    -- function num : 0_5_0 , upvalues : _ENV, lotteryType
    (LotteryService.ReqLotteryInit)(lotteryType)
    UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW_ANIMATION_END, {})
  end
, para)
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_YouChangActivity.ShowResult = function(para, ...)
  -- function num : 0_6 , upvalues : _ENV
  OpenWindow("LotteryRewardWindow", UILayer.HUD, para, 0)
  ;
  (LotteryMgr.HideAllBackGroundEffects)()
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_YouChangActivity.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, fx_main
  uis = nil
  fx_main = nil
end


