-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_BossRewardWindowByName")
local GuildBossRewardWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
BattleRewardType = {FirstReward = 1, TimeReward = 2, SeasonReward = 3}
local selectIndex = 0
local listData = {}
GuildBossRewardWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildBossRewardWindow
  bridgeObj:SetView((WinResConfig.GuildBossRewardWindow).package, (WinResConfig.GuildBossRewardWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuildBoss_BossRewardWindowUis(contentPane)
  uis = uis.BossReward
  ;
  (GuildBossRewardWindow.InitVariable)()
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.BossRewardChoice).RewardList).itemRenderer = GuildBossRewardWindow.ListRenderer
  ;
  ((uis.BossRewardChoice).RewardList):SetVirtual()
  ;
  ((uis.BossRewardChoice).RewardList):SetBeginAnim()
  local index = (GuildBossRewardWindow.InitOriginIndex)()
  ;
  (GuildBossRewardWindow.SetSelectIndex)(index)
end

GuildBossRewardWindow.InitOriginIndex = function(...)
  -- function num : 0_1 , upvalues : _ENV
  for i = BattleRewardType.FirstReward, BattleRewardType.SeasonReward do
    local list = (GuildBossMgr.RewardListData)()
    for _,v in ipairs(list) do
      local tableData = ((TableData.gTable).BaseGuildWarRewardData)[v.id]
      if tableData.type == i and (v.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN or v.status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT) then
        return i
      end
    end
  end
  return BattleRewardType.FirstReward
end

GuildBossRewardWindow.SetSelectIndex = function(index, ...)
  -- function num : 0_2 , upvalues : listData, uis, _ENV, GuildBossRewardWindow, selectIndex
  listData = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.BossRewardChoice).c1Ctr).selectedIndex = index - 1
  local list = (GuildBossMgr.RewardListData)()
  for _,v in ipairs(list) do
    local tableData = ((TableData.gTable).BaseGuildWarRewardData)[v.id]
    if tableData.type == index then
      local mState = v.status
      if BattleRewardType.SeasonReward == index then
        mState = (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_NOT
      end
      ;
      (table.insert)(listData, {ConfigData = tableData, state = mState})
    end
  end
  ;
  (table.sort)(listData, function(a, b, ...)
    -- function num : 0_2_0 , upvalues : GuildBossRewardWindow
    do return (GuildBossRewardWindow.GetRewardSort)(a) < (GuildBossRewardWindow.GetRewardSort)(b) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  ((uis.BossRewardChoice).RewardList):ScrollToView(0, false)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.BossRewardChoice).RewardList).numItems = #listData
  selectIndex = index
end

GuildBossRewardWindow.GetRewardSort = function(data, ...)
  -- function num : 0_3 , upvalues : _ENV
  local status = data.state
  local sort = (data.ConfigData).sort
  if status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
    sort = sort - 1000000
  else
    if status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
      sort = sort + 1000000
    end
  end
  return sort
end

GuildBossRewardWindow.ListRenderer = function(index, obj, ...)
  -- function num : 0_4 , upvalues : listData, _ENV
  local mData = listData[index + 1]
  local configData = mData.ConfigData
  local status = mData.state
  if status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
    ChangeUIController(obj, "c1", 0)
  else
    if status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_HAS then
      ChangeUIController(obj, "c1", 1)
    else
      ChangeUIController(obj, "c1", 2)
    end
  end
  ;
  (obj:GetChild("WordTxt")).text = configData.remark
  local list = obj:GetChild("RewardList")
  list.numItems = 0
  local rewardList = split(configData.reward, ",")
  for _,v in ipairs(rewardList) do
    (Util.SetFrameByConfig)(v, list)
  end
  local btn = obj:GetChild("GetBtn")
  btn.text = (PUtil.get)(20000010)
  ;
  (btn.onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : status, _ENV, configData
    if status == (ProtoEnum.E_STATUS_TYPE).STATUS_TYPE_CAN then
      (GuildBossService.ReqGetSeasonReward)(configData.id)
    end
  end
)
end

GuildBossRewardWindow.InitVariable = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV, selectIndex, GuildBossRewardWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.SureBtn).text = (PUtil.get)(20000370)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000500)
  ;
  (((uis.BossRewardChoice).ABtn):GetChild("NameTxt")).text = (PUtil.get)(20000498)
  ;
  (((uis.BossRewardChoice).BBtn):GetChild("NameTxt")).text = (PUtil.get)(20000499)
  ;
  (((uis.BossRewardChoice).CBtn):GetChild("NameTxt")).text = (PUtil.get)(20000500)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossRewardWindow).name)
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_5_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossRewardWindow).name)
  end
)
  ;
  (((uis.BossRewardChoice).ABtn).onClick):Set(function(...)
    -- function num : 0_5_2 , upvalues : selectIndex, _ENV, GuildBossRewardWindow
    if selectIndex ~= BattleRewardType.FirstReward then
      (GuildBossRewardWindow.SetSelectIndex)(BattleRewardType.FirstReward)
    end
  end
)
  ;
  (((uis.BossRewardChoice).BBtn).onClick):Set(function(...)
    -- function num : 0_5_3 , upvalues : selectIndex, _ENV, GuildBossRewardWindow
    if selectIndex ~= BattleRewardType.TimeReward then
      (GuildBossRewardWindow.SetSelectIndex)(BattleRewardType.TimeReward)
    end
  end
)
  ;
  (((uis.BossRewardChoice).CBtn).onClick):Set(function(...)
    -- function num : 0_5_4 , upvalues : selectIndex, _ENV, GuildBossRewardWindow
    if selectIndex ~= BattleRewardType.SeasonReward then
      (GuildBossRewardWindow.SetSelectIndex)(BattleRewardType.SeasonReward)
    end
  end
)
end

GuildBossRewardWindow.OnShown = function(...)
  -- function num : 0_6
end

GuildBossRewardWindow.OnHide = function(...)
  -- function num : 0_7
end

GuildBossRewardWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildBossRewardWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9 , upvalues : GuildBossRewardWindow, selectIndex
  if msgId == 1 then
    (GuildBossRewardWindow.SetSelectIndex)(selectIndex)
  end
end

return GuildBossRewardWindow

