-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_ImpeachWindowByName")
local GuildImpeachWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local data = {}
local selfStatue = nil
GuildImpeachWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, data, uis, selfStatue, GuildImpeachWindow
  bridgeObj:SetView((WinResConfig.GuildImpeachWindow).package, (WinResConfig.GuildImpeachWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  data = argTable[1]
  uis = GetGuild_ImpeachWindowUis(contentPane)
  selfStatue = nil
  uis = uis.Impeach
  ;
  (GuildImpeachWindow.SetPercentShow)()
  ;
  (GuildImpeachWindow.SetBtnEvent)()
  ;
  (GuildImpeachWindow.SetInvariable)()
end

GuildImpeachWindow.GetCountAndPer = function(...)
  -- function num : 0_1 , upvalues : data, _ENV, selfStatue
  local mList = data.voteInfo
  local agree = 0
  local disagree = 0
  for _,v in ipairs(mList) do
    if v.vote then
      agree = agree + 1
    else
      disagree = disagree + 1
    end
    if v.memberIndex == (ActorData.GetPlayerIndex)() then
      selfStatue = v.vote
    end
  end
  return agree, disagree
end

GuildImpeachWindow.SetPercentShow = function(...)
  -- function num : 0_2 , upvalues : GuildImpeachWindow, _ENV, uis, selfStatue
  local agree, disagree = (GuildImpeachWindow.GetCountAndPer)()
  local count = agree + disagree
  local max = (math.max)(agree, disagree)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.Tips_A).c2Ctr).selectedIndex = 0
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  if selfStatue == true then
    ((uis.Tips_A).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.Tips_A).c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.Tips_A).NumberTxt).text = (PUtil.get)(20000612, agree)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

  if count <= 0 then
    ((uis.Tips_A).BProgressBar).value = 0
  else
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.Tips_A).BProgressBar).value = agree / max * 100
  end
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.Tips_B).c2Ctr).selectedIndex = 1
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R4 in 'UnsetPending'

  if selfStatue ~= nil and selfStatue == false then
    ((uis.Tips_B).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.Tips_B).c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.Tips_B).NumberTxt).text = (PUtil.get)(20000612, disagree)
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R4 in 'UnsetPending'

  if count <= 0 then
    ((uis.Tips_B).AProgressBar).value = 0
  else
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.Tips_B).AProgressBar).value = disagree / max * 100
  end
end

GuildImpeachWindow.SetInvariable = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, selfStatue
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TitleTxt).text = (PUtil.get)(20000605)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.NameWordTxt).text = (PUtil.get)(20000608)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Tips_A).WordTxt).text = (PUtil.get)(20000609)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Tips_B).WordTxt).text = (PUtil.get)(20000610)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(20000611)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleOutBtn).text = (PUtil.get)(20000606)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

  if selfStatue == nil then
    (uis.SureBtn).text = (PUtil.get)(20000607)
  else
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.SureBtn).text = (PUtil.get)(20000016)
  end
end

GuildImpeachWindow.SetBtnEvent = function(...)
  -- function num : 0_4 , upvalues : selfStatue, uis, _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  if selfStatue == nil then
    (uis.c1Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 1
  end
  ;
  ((uis.BattleOutBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV, uis
    (GuildService.ReqVoting)(false)
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 1
  end
)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : uis, _ENV
    if (uis.c1Ctr).selectedIndex == 0 then
      (GuildService.ReqVoting)(true)
      -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = 1
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.SureBtn).text = (PUtil.get)(20000016)
    else
      UIMgr:CloseWindow((WinResConfig.GuildImpeachWindow).name)
      UIMgr:RemoveWindowList((WinResConfig.GuildImpeachWindow).name)
    end
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_4_2 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildImpeachWindow).name)
    UIMgr:RemoveWindowList((WinResConfig.GuildImpeachWindow).name)
  end
)
end

GuildImpeachWindow.OnShown = function(...)
  -- function num : 0_5 , upvalues : uis, data, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  (uis.NameTxt).text = data.organizerName
  ;
  (LuaTime.CountDown)(data.voteEnd * 0.001 - (ActorData.GetServerTime)() * 0.001, uis.WordTxt, function(...)
    -- function num : 0_5_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildImpeachWindow).name)
    ;
    (MessageMgr.SendCenterTipsByWordID)(20000613)
  end
, true)
end

GuildImpeachWindow.OnHide = function(...)
  -- function num : 0_6
end

GuildImpeachWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildImpeachWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8 , upvalues : data, GuildImpeachWindow
  if msgId == 1 then
    data = para
    ;
    (GuildImpeachWindow.SetPercentShow)()
    ;
    (GuildImpeachWindow.SetBtnEvent)()
  end
end

return GuildImpeachWindow

