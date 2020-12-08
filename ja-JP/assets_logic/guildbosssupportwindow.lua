-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_BossSupportWindowByName")
local GuildBossSupportWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local cardList = {}
local supportList = {}
GuildBossSupportWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildBossSupportWindow
  bridgeObj:SetView((WinResConfig.GuildBossSupportWindow).package, (WinResConfig.GuildBossSupportWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuildBoss_BossSupportWindowUis(contentPane)
  uis = uis.BossSupport
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CardHeadList).itemRenderer = GuildBossSupportWindow.CardRenderer
  ;
  (uis.CardHeadList):SetVirtual()
  ;
  (GuildBossSupportWindow.SetSupportShow)()
end

GuildBossSupportWindow.SetSupportShow = function(...)
  -- function num : 0_1 , upvalues : GuildBossSupportWindow, supportList, _ENV, uis
  (GuildBossSupportWindow.RefreshCardList)()
  supportList = (GuildBossMgr.GuildSupportCard)()
  for i = 1, 2 do
    do
      local data = supportList[i]
      local obj = (uis.BossSupportPlaceA).root
      if i == 2 then
        obj = (uis.BossSupportPlaceB).root
      end
      if data == nil or data <= 0 then
        ChangeUIController(obj, "c1", 1)
        ;
        (obj:GetChild("ChoiceTxt")).text = (PUtil.get)(20000553)
      else
        ChangeUIController(obj, "c1", 0)
        local cardData = (CardData.GetCardData)(data)
        ;
        (Util.SetHeadFrameByOneCard)(obj:GetChild("HeadFrame"), cardData, false)
        ;
        (obj:GetChild("PlayerNameTxt")).text = cardData.name
        ;
        (obj:GetChild("BattleWordTxt")).text = (PUtil.get)(60000235)
        ;
        (obj:GetChild("BattleNumberTxt")).text = cardData.fc
        local equipList = obj:GetChild("EquiptList")
        equipList.numItems = 0
        local equipInfo = cardData.equipInfo
        if equipInfo and #equipInfo > 0 then
          local equipInfoS = (Util.clone)(equipInfo)
          ;
          (table.sort)(equipInfoS, function(a, b, ...)
    -- function num : 0_1_0 , upvalues : _ENV, GuildBossSupportWindow
    local AEquipData = ((TableData.gTable).BaseEquipData)[a.id]
    local BEquipData = ((TableData.gTable).BaseEquipData)[b.id]
    local ASort = (GuildBossSupportWindow.GetEquipSort)(AEquipData.type)
    local BSort = (GuildBossSupportWindow.GetEquipSort)(BEquipData.type)
    do return BSort < ASort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
          local equipCount = #equipInfoS
          for i = 1, equipCount do
            local obj = UIMgr:CreateObject("CommonResource", "EquiptIcon")
            ;
            (Util.SetEquipFrame)(obj, equipInfoS[i])
            equipList:AddChild(obj)
          end
        end
        do
          local btn = obj:GetChild("CancelBtn")
          btn.text = (PUtil.get)(20000488)
          ;
          (btn.onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV, data, i
    (GuildBossService.ReqSupportSet)(data, (ProtoEnum.GUILD_WAR_SUPPORT).QUIT, i - 1)
  end
)
        end
      end
      do
        -- DECOMPILER ERROR at PC122: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

GuildBossSupportWindow.GetEquipSort = function(part, ...)
  -- function num : 0_2 , upvalues : _ENV
  if part == EquiptPartsType.Necklace then
    return 4
  else
    if part == EquiptPartsType.Ring then
      return 3
    else
      if part == EquiptPartsType.Weapon then
        return 2
      else
        return 1
      end
    end
  end
end

GuildBossSupportWindow.CardRenderer = function(index, obj, ...)
  -- function num : 0_3 , upvalues : cardList, _ENV, supportList
  local cardData = cardList[index + 1]
  ;
  (Util.SetHeadFrameByOneCard)(obj, cardData, false)
  local support = (GuildBossMgr.CardIsInSupport)(cardData.id)
  if support then
    ChangeUIController(obj, "c3", 6)
  else
    ChangeUIController(obj, "c3", 0)
  end
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : support, supportList, _ENV, cardData
    if support then
      return 
    end
    for i = 1, 2 do
      if supportList[i] == nil or supportList[i] <= 0 then
        (GuildBossService.ReqSupportSet)(cardData.id, (ProtoEnum.GUILD_WAR_SUPPORT).JOIN, i - 1)
        return 
      end
    end
    ;
    (MessageMgr.SendCenterTipsByWordID)(20000552)
  end
)
end

GuildBossSupportWindow.RefreshCardList = function(...)
  -- function num : 0_4 , upvalues : _ENV, cardList, GuildBossSupportWindow, uis
  local List = (CardData.GetObtainedCardList)()
  cardList = {}
  for _,v in ipairs(List) do
    (table.insert)(cardList, v)
  end
  ;
  (table.sort)(cardList, function(a, b, ...)
    -- function num : 0_4_0 , upvalues : GuildBossSupportWindow
    do return (GuildBossSupportWindow.CardSort)(b) < (GuildBossSupportWindow.CardSort)(a) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CardHeadList).numItems = #cardList
end

GuildBossSupportWindow.CardSort = function(cardData, ...)
  -- function num : 0_5 , upvalues : _ENV
  local sort = 0
  if (GuildBossMgr.CardIsInSupport)(cardData.id) then
    sort = 100000000000
  end
  return sort + cardData.fc
end

GuildBossSupportWindow.SetGetInfo = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis, GuildBossSupportWindow
  local FixedData = ((TableData.gTable).BaseFixedData)[Const.GuildBossSupportReward]
  local single = split(FixedData.array_value, ":")
  local SupportTimes = (GuildBossMgr.GuildSupportTimes)()
  local configData = (Util.GetConfigDataByID)(tonumber(single[2]))
  local icon = "[image]" .. configData.icon .. "[/image]" .. single[3]
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.BossSupportReward).Word_01_Txt).text = (PUtil.get)(20000489, SupportTimes, icon)
  local canGet = (GuildBossMgr.GuildSupportGetNum)()
  local CanIcon = "[image]" .. configData.icon .. "[/image]" .. canGet
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((uis.BossSupportReward).Word_02_Txt).text = (PUtil.get)(20000490, CanIcon)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((uis.BossSupportReward).Word_03_Txt).text = (PUtil.get)(20000491)
  local max = (GuildBossSupportWindow.GetSupportMaxNum)()
  local alreadyGet = (GuildBossMgr.GuildSupportAlreadyNum)()
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((uis.BossSupportReward).ItemNumberTxt).text = alreadyGet .. "/" .. max
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((uis.BossSupportReward).ItemProgressBar).value = alreadyGet / max * 100
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((uis.BossSupportReward).GetBtn).text = (PUtil.get)(60000023)
  ;
  (((uis.BossSupportReward).GetBtn).onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : canGet, _ENV
    if canGet > 0 then
      (GuildBossService.ReqSupportHarvest)()
    else
      ;
      (MessageMgr.SendCenterTipsByWordID)(20000492)
    end
  end
)
end

GuildBossSupportWindow.GetSupportMaxNum = function(...)
  -- function num : 0_7 , upvalues : _ENV
  local FixedData = ((TableData.gTable).BaseFixedData)[Const.GuildBossMaxSupport]
  return FixedData.int_value
end

GuildBossSupportWindow.InitInvariable = function(...)
  -- function num : 0_8 , upvalues : uis, _ENV, GuildBossSupportWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TitleTxt).text = (PUtil.get)(20000487)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(60000004)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_8_0 , upvalues : GuildBossSupportWindow
    (GuildBossSupportWindow.OnClickExit)()
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_8_1 , upvalues : GuildBossSupportWindow
    (GuildBossSupportWindow.OnClickExit)()
  end
)
end

GuildBossSupportWindow.OnClickExit = function(...)
  -- function num : 0_9 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.GuildBossSupportWindow).name)
end

GuildBossSupportWindow.OnShown = function(...)
  -- function num : 0_10 , upvalues : GuildBossSupportWindow
  (GuildBossSupportWindow.InitInvariable)()
  ;
  (GuildBossSupportWindow.SetGetInfo)()
end

GuildBossSupportWindow.OnHide = function(...)
  -- function num : 0_11
end

GuildBossSupportWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildBossSupportWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : GuildBossSupportWindow
  if msgId == 1 then
    (GuildBossSupportWindow.SetGetInfo)()
  else
    if msgId == 2 then
      (GuildBossSupportWindow.SetSupportShow)()
    end
  end
end

return GuildBossSupportWindow

