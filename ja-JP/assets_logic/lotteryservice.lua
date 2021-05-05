-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResLotteryInit, LotteryService.OnResLotteryInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResLotteryDraw, LotteryService.OnResLotteryDraw)
  ;
  (Net.AddListener)((Proto.MsgName).ResLotteryRecord, LotteryService.OnResLotteryRecord)
  ;
  (Net.AddListener)((Proto.MsgName).ResInitConversion, LotteryService.OnResInitConversion)
  ;
  (Net.AddListener)((Proto.MsgName).ResLotteryConversion, LotteryService.OnResLotteryConversion)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.ReqLotteryInit = function(lType, ...)
  -- function num : 0_1 , upvalues : _ENV
  print("抽奖初始化    lType", lType)
  local send = {type = lType}
  ;
  (Net.Send)((Proto.MsgName).ReqLotteryInit, send, (Proto.MsgName).ResLotteryInit)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.OnResLotteryInit = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  print("抽奖初始化返回  onceFreeNum", msg.onceFreeNum, "onceCdTime", msg.onceCdTime, "moreFreeNum", msg.moreFreeNum, "moreCdTime", msg.moreCdTime, "onceSurplusNum", msg.onceSurplusNum, "moreSurplusNum", msg.moreSurplusNum)
  UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_INIT, {data = msg})
  UIMgr:SendWindowMessage((WinResConfig.HomeWindow).name, (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_FREE_10_LOTTERY, msg.moreFreeNum)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.ReqLotteryDraw = function(id, ...)
  -- function num : 0_3 , upvalues : _ENV
  print("抽奖    id", id)
  local send = {lotteryId = id}
  ;
  (Net.Send)((Proto.MsgName).ReqLotteryDraw, send, (Proto.MsgName).ResLotteryDraw)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.OnResLotteryDraw = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  print("抽奖返回 lotteryId", msg.lotteryId, #msg.goods)
  local LotteryData = ((TableData.gTable).BaseLotteryData)[msg.lotteryId]
  if LotteryData.type == 5 then
    local freeType = nil
    local configs = (TableData.gTable).BaseActivityData
    for k,v in pairs(configs) do
      -- DECOMPILER ERROR at PC45: Unhandled construct in 'MakeBoolean' P1

      if v.type == (ActivityMgr.ActivityType).Free_Lottery and tonumber(v.parameter1) == msg.lotteryId and msg.freeNum == 0 then
        (RedDotMgr.EliminateRedDot)((WinResConfig.LotteryWindow).name, RedDotComID.Lottery_FreeMultiple)
      end
      do break end
    end
    do
      do
        UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW, {data = msg})
        UIMgr:SendWindowMessage("LotteryRewardWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW, {data = msg})
        ;
        (HandBookData.CheckFetterData)()
        if UIMgr:IsWindowOpen("HomeWindow") and (Application.platform == RuntimePlatform.WindowsEditor or Application.platform == RuntimePlatform.OSXEditor) then
          local str = ""
          local count, item = nil, nil
          if msg.goods ~= nil then
            count = #msg.goods
            local eachGoods = nil
            for i = 1, count do
              eachGoods = (msg.goods)[i]
              if NoShowGetGoods[eachGoods.id] == nil and eachGoods.type ~= (ProtoEnum.E_GOODS_TYPE).OTHER then
                item = {}
                item.Type = eachGoods.type
                item.id = eachGoods.id
                item.Num = eachGoods.value
                item.attr = eachGoods.attr
                if item.Num > 1 then
                  str = str .. item.id .. "x" .. item.Num .. "    "
                else
                  str = str .. item.id .. "    "
                end
              end
            end
          end
          do
            if msg.showProp then
              count = #msg.props
              for i = 1, count do
                local eachGoods = (msg.props)[i]
                if NoShowGetGoods[eachGoods.id] == nil and eachGoods.count > 0 then
                  item = {}
                  item.Type = (ProtoEnum.E_GOODS_TYPE).PROP
                  item.id = eachGoods.id
                  item.Num = eachGoods.count
                  if item.Num > 1 then
                    str = str .. item.id .. "x" .. item.Num .. "    "
                  else
                    str = str .. item.id .. "    "
                  end
                end
              end
            end
            do
              if msg.equips ~= nil then
                count = #msg.equips
                for i = 1, count do
                  local eachGoods = (msg.equips)[i]
                  if NoShowGetGoods[eachGoods.id] == nil then
                    item = {}
                    item.Type = (ProtoEnum.E_GOODS_TYPE).EQUIP
                    item.id = eachGoods.id
                    item.Num = 1
                    if item.Num > 1 then
                      str = str .. item.id .. "x" .. item.Num .. "    "
                    else
                      str = str .. item.id .. "    "
                    end
                  end
                end
              end
              do
                ;
                ((CS.FileManager).WriteFile)("LotteryTestResult.txt", str .. "\n")
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.ReqLotteryRecord = function(...)
  -- function num : 0_5 , upvalues : _ENV
  print("--请求扭蛋记录")
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqLotteryRecord, m, (Proto.MsgName).ResLotteryRecord)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.OnResLotteryRecord = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  print("--返回扭蛋记录", msg, msg.lotteryRecord)
  local recordNum = 0
  for key,value in pairs(msg.lotteryRecord) do
    recordNum = recordNum + 1
  end
  if recordNum == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(233))
    return 
  end
  if msg and msg.lotteryRecord then
    OpenWindow((WinResConfig.LotteryRecordWindow).name, UILayer.HUD, msg.lotteryRecord)
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.ReqInitConversion = function(type, ...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  m.type = type
  ;
  (Net.Send)((Proto.MsgName).ReqInitConversion, m, (Proto.MsgName).ResInitConversion)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.OnResInitConversion = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  OpenWindow((WinResConfig.LotteryScoreExchangeWindow).name, UILayer.HUD, msg.integral, msg.type, msg.initConversion)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.ReqLotteryConversion = function(type, id, ...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  m.type = type
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqLotteryConversion, m, (Proto.MsgName).ResLotteryConversion)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.OnResLotteryConversion = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  UIMgr:SendWindowMessage((WinResConfig.LotteryScoreExchangeWindow).name, (WindowMsgEnum.Lottery).E_MSG_LOTTERYCONVERSION, {data = msg})
end

;
(LotteryService.Init)()

