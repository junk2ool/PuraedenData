-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_HeadChoiceWindowByName")
local HeadChoiceWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local scrollViewHead, scrollViewFrame = nil, nil
local heads = {}
local frames = {}
local ChooseType = {Head = 1, Frame = 2}
local chooseType = ChooseType.Head
local curSelectedHeadID = nil
local curSelectedFrameID = 78610001
HeadChoiceWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, chooseType, ChooseType, curSelectedHeadID, HeadChoiceWindow, curSelectedFrameID, heads, scrollViewHead, frames, scrollViewFrame
  bridgeObj:SetView((WinResConfig.HeadChoiceWindow).package, (WinResConfig.HeadChoiceWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActorInfo_HeadChoiceWindowUis(contentPane)
  ;
  (((uis.HeadChoiceGrp).CloseBtn).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow("HeadChoiceWindow")
  end
)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.HeadChoiceGrp).HeadChoiceTxt).text = (PUtil.get)(116)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.HeadChoiceGrp).SureBtn).text = (PUtil.get)(30)
  ;
  (((uis.HeadChoiceGrp).SureBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    UIMgr:CloseWindow("HeadChoiceWindow")
  end
)
  ;
  ((((uis.HeadChoiceGrp).HeadFrameChoice).HeadBtn):GetChild("NameTxt")).text = (PUtil.get)(263)
  ;
  ((((uis.HeadChoiceGrp).HeadFrameChoice).HeadBtn).onClick):Set(function(...)
    -- function num : 0_0_2 , upvalues : chooseType, ChooseType, curSelectedHeadID, _ENV, HeadChoiceWindow
    if chooseType == ChooseType.Head then
      return 
    end
    chooseType = ChooseType.Head
    curSelectedHeadID = (ActorData.GetFashionHead)()
    ;
    (HeadChoiceWindow.RefreshWindow)()
  end
)
  ;
  ((((uis.HeadChoiceGrp).HeadFrameChoice).FrameBtn):GetChild("NameTxt")).text = (PUtil.get)(264)
  ;
  ((((uis.HeadChoiceGrp).HeadFrameChoice).FrameBtn).onClick):Set(function(...)
    -- function num : 0_0_3 , upvalues : chooseType, ChooseType, curSelectedFrameID, _ENV, HeadChoiceWindow
    if chooseType == ChooseType.Frame then
      return 
    end
    curSelectedFrameID = (ActorData.GetFashionFrame)()
    chooseType = ChooseType.Frame
    ;
    (HeadChoiceWindow.RefreshWindow)()
  end
)
  chooseType = ChooseType.Head
  if not argTable[1] then
    local alreadyHaveIcon = {}
  end
  if (_G.next)(heads) == nil then
    for k,v in pairs((TableData.gTable).BasePlayerHeadIconData) do
      local isHave = false
      for index,value in ipairs(alreadyHaveIcon) do
        if value == v.id then
          isHave = true
        end
      end
      v.isHave = isHave
      if v.open_time == nil or tonumber(v.open_time) < (LuaTime.GetTimeStamp)() then
        (table.insert)(heads, v)
      end
    end
  end
  do
    ;
    (HeadChoiceWindow.Sort)(heads)
    scrollViewHead = ((uis.HeadChoiceGrp).HeadFrameChoice).HeadList
    scrollViewHead:SetVirtual()
    scrollViewHead.itemRenderer = HeadChoiceWindow.RefreshHeadItem
    curSelectedHeadID = (ActorData.GetFashionHead)()
    if not argTable[2] then
      local alreadyHaveFrame = {}
    end
    if (_G.next)(frames) == nil then
      for k,v in pairs((TableData.gTable).BasePlayerHeadFrameData) do
        local isHave = false
        for index,value in ipairs(alreadyHaveFrame) do
          if value == v.id then
            isHave = true
          end
        end
        v.isHave = isHave
        if v.open_time == nil or tonumber(v.open_time) < (LuaTime.GetTimeStamp)() then
          (table.insert)(frames, v)
        end
      end
    end
    do
      ;
      (HeadChoiceWindow.Sort)(frames)
      scrollViewFrame = ((uis.HeadChoiceGrp).HeadFrameChoice).FrameList
      scrollViewFrame:SetVirtual()
      scrollViewFrame.itemRenderer = HeadChoiceWindow.RefreshFrameItem
      ;
      (HeadChoiceWindow.RefreshWindow)()
      ;
      (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
    end
  end
end

HeadChoiceWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : chooseType, ChooseType, HeadChoiceWindow, heads, frames
  if chooseType == ChooseType.Head then
    (HeadChoiceWindow.RefreshListNumber)(#heads)
  else
    if chooseType == ChooseType.Frame then
      (HeadChoiceWindow.RefreshFrameListNumber)(#frames)
    end
  end
end

HeadChoiceWindow.RefreshListNumber = function(number, ...)
  -- function num : 0_2 , upvalues : scrollViewHead, HeadChoiceWindow
  scrollViewHead.numItems = number
  ;
  (HeadChoiceWindow.SetHeadInfo)()
end

HeadChoiceWindow.RefreshHeadItem = function(index, item, ...)
  -- function num : 0_3 , upvalues : heads, _ENV, curSelectedHeadID, scrollViewHead, HeadChoiceWindow
  local data = heads[index + 1]
  local c1 = item:GetController("c1")
  ;
  ((item:GetChild("ActorHeadGrp")):GetController("c2")).selectedIndex = 1
  local headLoader = (item:GetChild("ActorHeadGrp")):GetChild("ActorHeadLoader")
  headLoader.url = (Util.GetResUrl)(data.icon_path)
  local selectedIndex = 0
  ;
  (item:GetChild("UseTxt")).text = (PUtil.get)(68)
  if data.id == (ActorData.GetFashionHead)() then
    selectedIndex = 1
    ;
    ((item:GetChild("ActorHeadGrp")):GetController("lock")).selectedIndex = 0
  else
    if data.isHave then
      selectedIndex = 0
      ;
      ((item:GetChild("ActorHeadGrp")):GetController("lock")).selectedIndex = 0
    else
      ;
      ((item:GetChild("ActorHeadGrp")):GetController("lock")).selectedIndex = 1
    end
  end
  c1.selectedIndex = selectedIndex
  if curSelectedHeadID == data.id then
    (item:GetController("c2")).selectedIndex = 1
  else
    ;
    (item:GetController("c2")).selectedIndex = 0
  end
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : item, _ENV, data, selectedIndex, curSelectedHeadID, scrollViewHead, heads, HeadChoiceWindow
    if ((item:GetChild("ActorHeadGrp")):GetController("lock")).selectedIndex == 0 then
      (ActorInfoService.ReqSet)((ProtoEnum.E_SET_TYPE).FASHION_HEAD, tostring(data.id))
    else
    end
    -- DECOMPILER ERROR at PC34: Unhandled construct in 'MakeBoolean' P1

    if ((item:GetChild("ActorHeadGrp")):GetController("lock")).selectedIndex ~= 1 or selectedIndex ~= 1 then
      curSelectedHeadID = data.id
      scrollViewHead.numItems = #heads
      ;
      (HeadChoiceWindow.SetHeadInfo)(data)
    end
  end
)
end

HeadChoiceWindow.RefreshFrameListNumber = function(number, ...)
  -- function num : 0_4 , upvalues : scrollViewFrame, HeadChoiceWindow
  scrollViewFrame.numItems = number
  ;
  (HeadChoiceWindow.SetHeadInfo)()
end

HeadChoiceWindow.RefreshFrameItem = function(index, item, ...)
  -- function num : 0_5 , upvalues : frames, _ENV, curSelectedFrameID, scrollViewFrame, HeadChoiceWindow
  local data = frames[index + 1]
  local c1 = item:GetController("c1")
  local c2 = item:GetController("lock")
  local frameLoader = item:GetChild("HeadFrameLoader")
  frameLoader.url = (Util.GetResUrl)(data.icon_path)
  if data.id == curSelectedFrameID then
    c1.selectedIndex = 1
  else
    c1.selectedIndex = 0
    local c2SelectIndex = 1
    if data.isHave then
      c2SelectIndex = 0
    else
      c2SelectIndex = 1
    end
    c2.selectedIndex = c2SelectIndex
  end
  do
    ;
    (item.onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : c2, _ENV, data, c1, curSelectedFrameID, scrollViewFrame, frames, HeadChoiceWindow
    if c2.selectedIndex == 0 then
      (ActorInfoService.ReqSet)((ProtoEnum.E_SET_TYPE).FASHION_FRAME, tostring(data.id))
    else
    end
    -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

    if c2.selectedIndex ~= 1 or c1.selectedIndex ~= 1 then
      curSelectedFrameID = data.id
      scrollViewFrame.numItems = #frames
      ;
      (HeadChoiceWindow.SetHeadInfo)(nil, data)
    end
  end
)
  end
end

HeadChoiceWindow.SetHeadInfo = function(headData, frameData, ...)
  -- function num : 0_6 , upvalues : _ENV, heads, frames, uis, chooseType, ChooseType
  if headData == nil and frameData == nil then
    print("==================初始化", (ActorData.GetFashionHead)(), (ActorData.GetFashionFrame)())
    for index,value in ipairs(heads) do
      if value.id == (ActorData.GetFashionHead)() then
        headData = 
      end
    end
    for index,value in ipairs(frames) do
      if value.id == (ActorData.GetFashionFrame)() then
        frameData = 
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

    if headData then
      ((((uis.HeadChoiceGrp).HeadFrameInfo).ActorHead).ActorHeadLoader).url = (Util.GetResUrl)(headData.icon_path)
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((uis.HeadChoiceGrp).HeadFrameInfo).FrameNameTxt).text = headData.name
    end
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R2 in 'UnsetPending'

    if frameData then
      (((((uis.HeadChoiceGrp).HeadFrameInfo).ActorHead).HeadFrameLoader).HeadFrameLoader).url = (Util.GetResUrl)(frameData.icon_path)
    end
    ;
    ((((((uis.HeadChoiceGrp).HeadFrameInfo).ActorHead).HeadFrameLoader).root):GetController("lock")).selectedIndex = 0
    ;
    (((((uis.HeadChoiceGrp).HeadFrameInfo).ActorHead).root):GetController("lock")).selectedIndex = 0
    if chooseType == ChooseType.Head then
      local conditions = split(headData.condition, ":")
      local cardId = tonumber(conditions[2])
      local needIntimacyLv = tonumber(conditions[3])
      local cardData = (CardData.GetCardData)(cardId)
      local intimacyLv = 0
      if cardData and cardData.intimacyLv then
        intimacyLv = cardData.intimacyLv
      end
      -- DECOMPILER ERROR at PC115: Confused about usage of register: R7 in 'UnsetPending'

      if headData.isHave then
        (((uis.HeadChoiceGrp).HeadFrameInfo).c1Ctr).selectedIndex = 1
        ;
        (((((uis.HeadChoiceGrp).HeadFrameInfo).ActorHead).root):GetController("lock")).selectedIndex = 0
      else
        -- DECOMPILER ERROR at PC128: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (((uis.HeadChoiceGrp).HeadFrameInfo).c1Ctr).selectedIndex = 0
        -- DECOMPILER ERROR at PC136: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (((uis.HeadChoiceGrp).HeadFrameInfo).UnLockTxt).text = (PUtil.get)(67)
        -- DECOMPILER ERROR at PC141: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (((uis.HeadChoiceGrp).HeadFrameInfo).UnLockWordTxt).text = headData.des
        ;
        (((((uis.HeadChoiceGrp).HeadFrameInfo).ActorHead).root):GetController("lock")).selectedIndex = 1
      end
    else
      do
        -- DECOMPILER ERROR at PC161: Confused about usage of register: R2 in 'UnsetPending'

        if chooseType == ChooseType.Frame and frameData then
          (((uis.HeadChoiceGrp).HeadFrameInfo).FrameNameTxt).text = frameData.name
          -- DECOMPILER ERROR at PC168: Confused about usage of register: R2 in 'UnsetPending'

          if frameData.isHave then
            (((uis.HeadChoiceGrp).HeadFrameInfo).c1Ctr).selectedIndex = 1
            ;
            ((((((uis.HeadChoiceGrp).HeadFrameInfo).ActorHead).HeadFrameLoader).root):GetController("lock")).selectedIndex = 0
          else
            -- DECOMPILER ERROR at PC182: Confused about usage of register: R2 in 'UnsetPending'

            ;
            (((uis.HeadChoiceGrp).HeadFrameInfo).c1Ctr).selectedIndex = 0
            -- DECOMPILER ERROR at PC190: Confused about usage of register: R2 in 'UnsetPending'

            ;
            (((uis.HeadChoiceGrp).HeadFrameInfo).UnLockTxt).text = (PUtil.get)(67)
            -- DECOMPILER ERROR at PC195: Confused about usage of register: R2 in 'UnsetPending'

            ;
            (((uis.HeadChoiceGrp).HeadFrameInfo).UnLockWordTxt).text = frameData.des
            ;
            ((((((uis.HeadChoiceGrp).HeadFrameInfo).ActorHead).HeadFrameLoader).root):GetController("lock")).selectedIndex = 1
          end
        end
      end
    end
  end
end

HeadChoiceWindow.Sort = function(temp, ...)
  -- function num : 0_7 , upvalues : _ENV
  local tb = temp
  for index,value in ipairs(tb) do
    value.weight = 0
    if value.isHave then
      value.weight = value.weight + 10000
    end
    value.weight = value.weight - value.sort
  end
  ;
  (table.sort)(tb, function(a, b, ...)
    -- function num : 0_7_0
    do return b.weight < a.weight end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  temp = tb
end

HeadChoiceWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : uis, contentPane, argTable, scrollViewHead, scrollViewFrame, heads, frames
  uis = nil
  contentPane = nil
  argTable = {}
  scrollViewHead = nil
  scrollViewFrame = nil
  heads = {}
  frames = {}
end

HeadChoiceWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9 , upvalues : _ENV, HeadChoiceWindow
  local windowMsgEnum = WindowMsgEnum.ActorInfo
  if msgId == windowMsgEnum.E_MSG_SETFASHIONHEAD then
    (HeadChoiceWindow.RefreshWindow)()
  else
    if msgId == windowMsgEnum.E_MSG_SETFASHIONFRAME then
      (HeadChoiceWindow.RefreshWindow)()
    end
  end
end

return HeadChoiceWindow

