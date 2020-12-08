-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_GuildBossEndByName")
local GuildBossSeasonEndWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
GuildBossSeasonEndWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis
  bridgeObj:SetView((WinResConfig.GuildBossSeasonEndWindow).package, (WinResConfig.GuildBossSeasonEndWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuildBoss_GuildBossEndUis(contentPane)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildBossSeasonEndWindow).name)
  end
)
end

GuildBossSeasonEndWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : argTable, uis, _ENV
  local data = argTable[1]
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TouchTxt).text = (PUtil.get)(33)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.MaxTxt).text = (PUtil.get)(20000468)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.NowTxt).text = (PUtil.get)(20000469)
  local lastRank = data[2]
  local currentRank = data[1]
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  if lastRank and lastRank > 0 then
    (uis.MaxNumberTxt).text = (PUtil.get)(20000470, lastRank)
  else
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.MaxNumberTxt).visible = false
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.MaxTxt).visible = false
  end
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

  if currentRank and currentRank > 0 then
    (uis.NowNumberTxt).text = (PUtil.get)(20000470, currentRank)
  else
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.NowNumberTxt).visible = false
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.NowTxt).visible = false
  end
  local rank = data[1]
  if rank and rank > 0 then
    local maxRank = (GuildBossMgr.GetMaxRank)()
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

    if maxRank < rank then
      ((uis.EndRank).RankNumberTxt).text = maxRank
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((uis.EndRank).PlusImage).visible = true
    else
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((uis.EndRank).RankNumberTxt).text = rank
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((uis.EndRank).PlusImage).visible = false
    end
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((uis.EndRank).c1Ctr).selectedIndex = 0
  else
    do
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((uis.EndRank).c1Ctr).selectedIndex = 1
    end
  end
end

GuildBossSeasonEndWindow.OnHide = function(...)
  -- function num : 0_2
end

GuildBossSeasonEndWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildBossSeasonEndWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_4
end

return GuildBossSeasonEndWindow

