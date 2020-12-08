-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_GuildBossOpenByName")
local GuildBossSeasonStartWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
GuildBossSeasonStartWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis
  bridgeObj:SetView((WinResConfig.GuildBossSeasonStartWindow).package, (WinResConfig.GuildBossSeasonStartWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuildBoss_GuildBossOpenUis(contentPane)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossSeasonStartWindow).name)
  end
)
end

GuildBossSeasonStartWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, argTable
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TouchTxt).text = (PUtil.get)(33)
  local data = argTable[1]
  local startTime = (LuaTime.GetFormatTimeStr)("%Y/%m/%d \n %H:%M", data[1])
  local fightTime = (LuaTime.GetFormatTimeStr)("%Y/%m/%d \n %H:%M", data[2])
  local endTime = (LuaTime.GetFormatTimeStr)("%Y/%m/%d \n %H:%M", data[3])
  ;
  (((uis.OpenTips).root):GetChild("StageTimeA")).text = startTime
  ;
  (((uis.OpenTips).root):GetChild("StageTimeB")).text = fightTime
  ;
  (((uis.OpenTips).root):GetChild("StageTimeC")).text = endTime
  ;
  (((uis.OpenTips).root):GetChild("StageA")).text = (PUtil.get)(20000464)
  ;
  (((uis.OpenTips).root):GetChild("StageB")).text = (PUtil.get)(20000465)
  ;
  (((uis.OpenTips).root):GetChild("StageC")).text = (PUtil.get)(20000466)
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (uis.WordTxt).text = (PUtil.get)(20000467)
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (uis.TimeTxt).text = (LuaTime.GetFormatTimeStr)("%Y/%m/%d", data[1]) .. "-" .. (LuaTime.GetFormatTimeStr)("%Y/%m/%d", data[3])
  local info = (GuildBossMgr.GuildBossInfo)()
  -- DECOMPILER ERROR at PC97: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.OpenTips).c1Ctr).selectedIndex = info.status - 1
end

GuildBossSeasonStartWindow.OnHide = function(...)
  -- function num : 0_2
end

GuildBossSeasonStartWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildBossSeasonStartWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_4
end

return GuildBossSeasonStartWindow

