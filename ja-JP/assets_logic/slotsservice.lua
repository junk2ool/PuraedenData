-- params : ...
-- function num : 0 , upvalues : _ENV
SlotsService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

SlotsService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResSlotsData, SlotsService.OnResSlotsData)
  ;
  (Net.AddListener)((Proto.MsgName).ResSlotsReset, SlotsService.OnResSlotsReset)
  ;
  (Net.AddListener)((Proto.MsgName).ResSlotsOperation, SlotsService.ResSlotsOperation)
  ;
  (Net.AddListener)((Proto.MsgName).ResSlotsRecord, SlotsService.OnResSlotsRecord)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

SlotsService.ReqSlotsData = function(type, ...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  m.type = type
  ;
  (Net.Send)((Proto.MsgName).ReqSlotsData, m, (Proto.MsgName).ResSlotsData)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

SlotsService.OnResSlotsData = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (SlotsData.CanReset)(msg.reset)
  ;
  (SlotsData.SlotRound)(msg.round)
  ;
  (SlotsData.GetItemData)(msg.RewardItems)
  ;
  (SlotsData.ChangeTotalRound)(msg.totalRoundNum)
  ;
  (SlotsData.GetCurrentType)(msg.type)
  if msg.type == (SlotsData.SlotType).ACTIVITY_SLOT then
    OpenWindow((WinResConfig.ActivityDungeonExchangeWindow).name, UILayer.HUD)
  else
    if msg.type == (SlotsData.SlotType).PRIZE_SLOT then
      OpenWindow((WinResConfig.PrizeWindow).name, UILayer.HUD)
    end
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

SlotsService.ReqSlotsReset = function(type, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.type = type
  ;
  (Net.Send)((Proto.MsgName).ReqSlotsReset, m, (Proto.MsgName).ResSlotsReset)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

SlotsService.OnResSlotsReset = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (SlotsData.SlotRound)(msg.round)
  local total = (SlotsData.ChangeTotalRound)()
  ;
  (SlotsData.ChangeTotalRound)(total + 1)
  ;
  (SlotsData.CanReset)(false)
  UIMgr:SendWindowMessage((WinResConfig.ActivityDungeonExchangeWindow).name, (WindowMsgEnum.ActivityDungeonExchange).E_MSG_RESET)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

SlotsService.ReqSlotsOperation = function(type, times, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.type = type
  m.times = times
  ;
  (Net.Send)((Proto.MsgName).ReqSlotsOperation, m, (Proto.MsgName).ResSlotsOperation)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

SlotsService.ResSlotsOperation = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  local uitype = (SlotsData.GetUITypeBySlotsType)(msg.type)
  if uitype == (SlotsData.SlotType).ACTIVITY_SLOT then
    local preSlot = (SlotsData.SlotRound)()
    if msg.resetRound and preSlot < msg.round then
      (SlotsData.SetRoundItemData)({round = preSlot, data = -1})
    end
    ;
    (SlotsData.SetRoundItemData)((msg.RewardItems)[1])
    ;
    (SlotsData.CanReset)(msg.reset)
    ;
    (SlotsData.ChangeTotalRound)(msg.totalRoundNum)
    ;
    (SlotsData.ChangeRound)(msg.resetRound)
    ;
    (SlotsData.SlotRound)(msg.round)
    UIMgr:SendWindowMessage((WinResConfig.ActivityDungeonExchangeWindow).name, (WindowMsgEnum.ActivityDungeonExchange).E_MSG_REFRESH)
  else
    do
      if uitype == (SlotsData.SlotType).PRIZE_SLOT then
        (SlotsData.SetRoundItemData)((msg.RewardItems)[1])
        ;
        (SlotsData.CanReset)(msg.reset)
        ;
        (SlotsData.ChangeTotalRound)(msg.totalRoundNum)
        ;
        (SlotsData.ChangeRound)(msg.resetRound)
        ;
        (SlotsData.SlotRound)(msg.round)
        UIMgr:SendWindowMessage((WinResConfig.PrizeWindow).name, (WindowMsgEnum.PrizeWindow).E_MSG_SLOTS_REFRESH)
        UIMgr:SendWindowMessage((WinResConfig.PrizeWindow).name, (WindowMsgEnum.PrizeWindow).E_MSG_SLOTS_SET_POOLS, msg.showSlotsRecord)
      end
    end
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

SlotsService.ReqSlotsRecord = function(type, ...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  m.type = type
  ;
  (Net.Send)((Proto.MsgName).ReqSlotsRecord, m, (Proto.MsgName).ResSlotsRecord)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

SlotsService.OnResSlotsRecord = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  if msg.type == (SlotsData.SlotType).PRIZE_SLOT then
    if #msg.slotsRecord > 0 then
      OpenWindow((WinResConfig.PrizeRecordWindow).name, UILayer.HUD, msg.slotsRecord)
    else
      ;
      (MessageMgr.SendCenterTipsByWordID)(20000634)
    end
  end
end

;
(SlotsService.Init)()

