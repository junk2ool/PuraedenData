-- params : ...
-- function num : 0 , upvalues : _ENV
require("Formation_TitleByName")
require("Formation_BuffShowByName")
require("Formation_BuffWordByName")
require("Formation_TextContentByName")
require("Formation_BuffInfoWindowByName")
local BuffInfoWindow = {}
local contentPane, uis, benefit, detrimental, normalDesc = nil, nil, nil, nil, nil
local CreateLine = function(content, ...)
  -- function num : 0_0 , upvalues : _ENV
  if (Util.StringIsNullOrEmpty)(content) then
    return 
  end
  local lineModel = UIMgr:CreateObject((WinResConfig.FormationWindow).package, "TextContent")
  local model = GetFormation_TextContentUis(lineModel)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (model.ContentTxt).UBBEnabled = true
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  if (string.sub)(content, 0, 2) == "$$" then
    (model.TabImage).visible = false
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (model.ContentTxt).text = (string.sub)(content, 3)
  else
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (model.ContentTxt).text = content
  end
  return lineModel
end

local AppendBuffDescList = function(fairyList, title, buffDescList, selectedIndex, ...)
  -- function num : 0_1 , upvalues : _ENV
  local buffShowObj = UIMgr:CreateObject((WinResConfig.FormationWindow).package, "BuffShow")
  local buffShowUis = GetFormation_BuffShowUis(buffShowObj)
  fairyList:AddChild(buffShowObj)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((buffShowUis.Title).TitleTxt).text = title
  for k,v in pairs(buffDescList) do
    local obj = UIMgr:CreateObject((WinResConfig.FormationWindow).package, "BuffWord")
    local buffWord = GetFormation_BuffWordUis(obj)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (buffWord.WordTxt).text = v.remark
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (buffWord.IconLoader).url = (Util.GetItemUrl)(v.pic)
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (buffWord.c1Ctr).selectedIndex = selectedIndex or 0
    ;
    (buffShowUis.BuffList):AddChild(obj)
  end
end

local UpdateContent = function(uis, benefit, detrimental, ...)
  -- function num : 0_2 , upvalues : AppendBuffDescList
  AppendBuffDescList((uis.BuffInfo).ContentList, "增益", benefit, 0)
  AppendBuffDescList((uis.BuffInfo).ContentList, "减益", detrimental, 1)
end

BuffInfoWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_3 , upvalues : _ENV, contentPane, normalDesc, uis, benefit, detrimental, CreateLine, UpdateContent
  bridgeObj:SetView((WinResConfig.BuffInfoWindow).package, (WinResConfig.BuffInfoWindow).comName)
  contentPane = bridgeObj.contentPane
  local argTable = bridgeObj.argTable
  normalDesc = argTable[1] or ""
  uis = GetFormation_BuffInfoWindowUis(contentPane)
  local buffDescData = (TableData.gTable).BaseBattleBuffDescData
  benefit = {}
  detrimental = {}
  for k,v in pairs(buffDescData) do
    if v.type == 1 then
      (table.insert)(benefit, v)
    else
      if v.type == 2 then
        (table.insert)(detrimental, v)
      end
    end
  end
  local splits = split(normalDesc, "::")
  for k,v in ipairs(splits) do
    if not (Util.StringIsNullOrEmpty)(v) then
      local line = CreateLine(v)
      if line then
        ((uis.BuffInfo).ContentList):AddChild(line)
      end
    end
  end
  UpdateContent(uis, benefit, detrimental)
end

BuffInfoWindow.OnShown = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BuffInfo).SureBtn).text = (PUtil.get)(20000016)
  ;
  (((uis.BuffInfo).SureBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.BuffInfoWindow).name)
  end
)
  ;
  (((uis.BuffInfo).CloseBtn).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.BuffInfoWindow).name)
  end
)
end

BuffInfoWindow.OnHide = function(...)
  -- function num : 0_5 , upvalues : uis
  (((uis.BuffInfo).SureBtn).onClick):Clear()
  ;
  (((uis.BuffInfo).CloseBtn).onClick):Clear()
end

return BuffInfoWindow

