-- params : ...
-- function num : 0 , upvalues : _ENV
require("SignActivity_SignActivityByName")
local SignActivityMainWindow = {}
local uis, contentPane, bridge, argTable, loginData = nil, nil, nil, nil, nil
local activityId = 33000801
SignActivityMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, bridge, argTable, uis, loginData, SignActivityMainWindow
  bridgeObj:SetView((WinResConfig.SignActivityMainWindow).package, (WinResConfig.SignActivityMainWindow).comName)
  contentPane = bridgeObj.contentPane
  bridge = bridgeObj
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetSignActivity_SignActivityUis(contentPane)
  loginData = argTable[1] or nil
  if loginData == nil then
    return 
  end
  ;
  (SignActivityMainWindow.RefreshWindow)()
end

SignActivityMainWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : activityId, _ENV, uis, loginData
  activityId = (ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).Total_Login)
  local activityData = ((TableData.gTable).BaseActivityData)[activityId]
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.BgLoader).url = (Util.GetItemUrl)(activityData.bg_pic)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TitleLoader).url = (Util.GetItemUrl)(activityData.name_pic)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Time).TimeTxt).text = (PUtil.get)(260) .. "  " .. "[color=#3dffbd]" .. (LuaTime.GetFormatTimeStr)("%m/%d %H:%M", (loginData.baseActivityInfo).beginTime) .. " - " .. (LuaTime.GetFormatTimeStr)("%m/%d %H:%M", (loginData.baseActivityInfo).endTime) .. "[/color]"
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.WordTxt).text = (PUtil.get)(261)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Time).root).visible = false
  local curRewardId = nil
  ;
  ((uis.Reward).RewardList):RemoveChildrenToPool()
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

  if #(loginData.loginDayActInfo).rewardList < 7 then
    ((uis.Reward).RewardList).align = (FairyGUI.AlignType).Center
  end
  local showIndex = #(loginData.loginDayActInfo).rewardList
  for index,value in ipairs((loginData.loginDayActInfo).rewardList) do
    local loginConfig = ((TableData.gTable).BaseActivityLoginData)[value.id]
    local rewardItem = ((uis.Reward).RewardList):AddItemFromPool()
    local rewardStr = split(loginConfig.rewards, ":")
    ;
    (Util.SetAllItemIcon)(rewardItem:GetChild("Item"), tonumber(rewardStr[2]), tonumber(rewardStr[3]))
    ;
    (rewardItem:GetController("c1")).selectedIndex = value.status
    if value.status == 1 then
      curRewardId = value.id
      showIndex = index
    end
    ;
    (rewardItem:GetChild("DayTxt")).text = (PUtil.get)(20000459, index)
  end
  ;
  ((uis.Reward).RewardList):ScrollToView(showIndex - 1)
  ;
  ((uis.root).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, activityId, curRewardId
    (ActivityService.ReqGetReward)(activityId, curRewardId)
  end
)
end

SignActivityMainWindow.OnClose = function(...)
  -- function num : 0_2 , upvalues : uis, contentPane, bridge, argTable
  uis = nil
  contentPane = nil
  bridge = nil
  argTable = nil
end

return SignActivityMainWindow

