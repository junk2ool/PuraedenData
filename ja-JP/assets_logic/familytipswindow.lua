-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_TipsWindowByName")
local FamilyTipsWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local itemId = nil
local TipsType = {Seed = 1, Furniture = 2}
local tipsType = TipsType.Seed
local _furnitureId, _time = nil, nil
FamilyTipsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, tipsType, TipsType, itemId, _furnitureId, _time, FamilyTipsWindow
  bridgeObj:SetView((WinResConfig.FamilyTipsWindow).package, (WinResConfig.FamilyTipsWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetFamily_TipsWindowUis(contentPane)
  if argTable[1] then
    tipsType = argTable[1]
  end
  if argTable[2] then
    if tipsType == TipsType.Seed then
      itemId = argTable[2]
    else
      _furnitureId = argTable[2]
    end
  end
  if argTable[3] then
    _time = argTable[3]
  end
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.FamilyTipsWindow).name, true, true)
  end
)
  local configData = nil
  if tipsType == TipsType.Seed then
    (FamilyTipsWindow.SetSeedTipsInfo)(itemId)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.root).x = contentPane.width * 0.15
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.root).y = contentPane.height * 0.25
  else
    if tipsType == TipsType.Furniture then
      local pos = argTable[4]
      pos.x = pos.x - ((uis.Tips).root).width * 0.5
      pos.y = pos.y - ((uis.Tips).root).height
      if pos.x < 0 then
        pos.x = pos.x + (((uis.Tips).root).width - (argTable[5]).x) * 0.5
      else
        if ResolutionHandler.Width <= pos.x + ((uis.Tips).root).width then
          pos.x = pos.x - (((uis.Tips).root).width - (argTable[5]).x) * 0.5
        else
          pos.x = pos.x
        end
      end
      -- DECOMPILER ERROR at PC119: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((uis.Tips).root).xy = pos
      ;
      (FamilyTipsWindow.SetFurnitrueInfo)()
    end
  end
end

FamilyTipsWindow.SetFurnitrueInfo = function(...)
  -- function num : 0_1 , upvalues : _ENV, _furnitureId, uis, _time
  local config = ((TableData.gTable).BaseFamilyFurnitureData)[_furnitureId]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.Tips).ItemFrame).IconLoader).url = (Util.GetItemUrl)(config.icon)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.Tips).ItemFrame).NumberTxt).text = ""
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Tips).ItemNameTxt).text = config.name
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  if config.type == HomelandFurnitureType.Wall or config.type == HomelandFurnitureType.Floor or config.type == HomelandFurnitureType.Background then
    ((uis.Tips).HaveNumber_01_Txt).text = ""
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.Tips).HaveNumberTxt).text = ""
  else
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.Tips).HaveNumber_01_Txt).text = (PUtil.get)(60000553)
    local size = split(config.size, ":")
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.Tips).HaveNumberTxt).text = size[1] .. " x " .. size[2]
  end
  do
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.Tips).ItemWordTxt).text = config.remark
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R1 in 'UnsetPending'

    if config.time == -1 then
      ((uis.Tips).TimeTxt).text = ""
    else
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.Tips).TimeTxt).text = (PUtil.get)(60000554) .. ":" .. (LuaTime.GetLeftTimeStr)(_time, true)
    end
  end
end

FamilyTipsWindow.SetSeedTipsInfo = function(itemId, ...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local configData = ((TableData.gTable).BaseFamilyFarmSeedData)[itemId]
  if configData == nil then
    return 
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.Tips).ItemFrame).NumberTxt).visible = false
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.Tips).ItemFrame).IconLoader).url = (Util.GetItemUrl)(configData.icon)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.Tips).ItemFrame).QualityCtr).selectedIndex = configData.quality
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.Tips).ItemNameTxt).text = configData.name
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.Tips).HaveNumber_01_Txt).text = (PUtil.get)(249)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.Tips).HaveNumberTxt).text = (LuaTime.GetTimeStr)(configData.end_time)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.Tips).ItemWordTxt).text = configData.remark
  local rewards = split(configData.reward_show, ",")
  local rewardsStr = ""
  for index,value in ipairs(rewards) do
    local splitStr = split(value, ":")
    local itemId = tonumber(splitStr[2])
    local itemNum = splitStr[3]
    local cfgData = nil
    if splitStr[1] == "1" then
      cfgData = ((TableData.gTable).BasePropData)[itemId]
    else
      if splitStr[1] == "2" then
        cfgData = ((TableData.gTable).BaseAssetData)[itemId]
      end
    end
    print("1111111111111111", cfgData, splitStr)
    if cfgData then
      local iconStr = split(cfgData.icon, ":")
      rewardsStr = rewardsStr .. "<img src=\'" .. UIMgr:GetItemUrl(iconStr[1], iconStr[2]) .. "\' " .. "width=\'" .. tostring(26) .. "\' " .. "height=\'" .. tostring(26) .. "\'>" .. splitStr[3]
      print("iconStr", iconStr)
    end
  end
  -- DECOMPILER ERROR at PC124: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.Tips).TimeTxt).text = (PUtil.get)(250) .. rewardsStr
end

FamilyTipsWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, contentPane, argTable, itemId
  uis = nil
  contentPane = nil
  argTable = {}
  itemId = nil
end

FamilyTipsWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_4
end

return FamilyTipsWindow

