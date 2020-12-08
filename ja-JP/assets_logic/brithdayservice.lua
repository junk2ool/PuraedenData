-- params : ...
-- function num : 0 , upvalues : _ENV
BrithDayService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

BrithDayService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResBirthdayList, BrithDayService.OnResBirthdayList)
  ;
  (Net.AddListener)((Proto.MsgName).ResBirthdayReward, BrithDayService.OnResBirthdayReward)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

BrithDayService.ReqBirthdayList = function(...)
  -- function num : 0_1
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

BrithDayService.OnResBirthdayList = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  print("420返回卡牌生日列表", #msg.cardId)
  ;
  (BrithDayData.SetCardBrithDayData)(msg.cardId)
  if #msg.cardId >= 1 then
    (BrithDayMgr.OpenBrithDayWindow)(1)
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

BrithDayService.ReqBirthdayReward = function(cardId, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.cardId = cardId
  ;
  (Net.Send)((Proto.MsgName).ReqBirthdayReward, m, (Proto.MsgName).ResBirthdayReward)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

BrithDayService.OnResBirthdayReward = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  local rewardConfig = ((TableData.gTable).BaseActivityBirthdayData)[msg.cardId]
  local rewardStr = split(rewardConfig.rewards, ":")
  local item = {}
  local items = {}
  item.Type = tonumber(rewardStr[1])
  item.id = tonumber(rewardStr[2])
  item.Num = tonumber(rewardStr[3])
  ;
  (table.insert)(items, item)
  ;
  (MessageMgr.OpenRewardShowWindow)(items, function(...)
    -- function num : 0_4_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.BrithDayMainWindow).name)
    ;
    (BrithDayMgr.Fade)()
  end
)
end

;
(BrithDayService.Init)()

