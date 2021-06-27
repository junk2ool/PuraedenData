-- params : ...
-- function num : 0 , upvalues : _ENV
local MessageMgr = {}
local _rewardInfo = {}
MessageMgr.OpenRewardWindow = function(data, fun, id, title, tips, ...)
  -- function num : 0_0 , upvalues : _rewardInfo, _ENV
  _rewardInfo = {}
  local info = {}
  info.Data = data
  info.Func = fun
  info.Id = id
  info.Title = title
  info.Tips = tips
  ;
  (table.insert)(_rewardInfo, info)
  OpenWindow((WinResConfig.RewardDisplayWindow).name, UILayer.HUD)
end

MessageMgr.OpenMultiplyRewardWindow = function(ids, datas, fun, title, tips, ...)
  -- function num : 0_1 , upvalues : _rewardInfo, _ENV
  _rewardInfo = {}
  local info = nil
  local count = #ids
  for i = 1, count do
    (table.insert)(_rewardInfo, {Id = ids[i], Data = datas[i], Func = fun, Title = title, Tips = tips})
  end
  OpenWindow((WinResConfig.RewardDisplayWindow).name, UILayer.HUD)
end

MessageMgr.CheckNeedShowReward = function(...)
  -- function num : 0_2 , upvalues : _rewardInfo
  do return #_rewardInfo > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

MessageMgr.PopRewardData = function(...)
  -- function num : 0_3 , upvalues : _ENV, _rewardInfo
  if not (table.remove)(_rewardInfo, 1) then
    local data = {}
  end
  return data.Data, data.Func, data.Title, data.Tips, data.Id
end

MessageMgr.CloseRewardWindow = function(id, state, ...)
  -- function num : 0_4 , upvalues : _ENV
  local window = UIMgr:GetWindow((WinResConfig.RewardDisplayWindow).name)
  if window and window.isShowing and state then
    UIMgr:CloseWindow((WinResConfig.RewardDisplayWindow).name)
  end
end

MessageMgr.CenterTipsWaitContent = {}
MessageMgr.CenterTipsIsPlaying = false
MessageMgr.SendCenterTips = function(msg, ...)
  -- function num : 0_5 , upvalues : MessageMgr, _ENV
  MessageMgr.CurrentCenterTips = msg
  if UIMgr:IsWindowOpen((WinResConfig.CenterTipsWindow).name) then
    UIMgr:SendWindowMessage((WinResConfig.CenterTipsWindow).name, 1)
  else
    OpenWindow((WinResConfig.CenterTipsWindow).name, UILayer.Popup)
  end
end

MessageMgr.SendCenterTipsByWordID = function(id, ...)
  -- function num : 0_6 , upvalues : MessageMgr, _ENV
  if id > 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(id))
  end
end

MessageMgr.CenterTipsIsPlay = function(isPlay, ...)
  -- function num : 0_7 , upvalues : MessageMgr
  MessageMgr.CenterTipsIsPlaying = isPlay
end

MessageMgr.PlayWaitTips = function(...)
  -- function num : 0_8 , upvalues : MessageMgr, _ENV
  if #MessageMgr.CenterTipsWaitContent > 0 then
    MessageMgr.CurrentCenterTips = (MessageMgr.CenterTipsWaitContent)[1]
    OpenWindow((WinResConfig.CenterTipsWindow).name, UILayer.Popup)
    ;
    (table.remove)(MessageMgr.CenterTipsWaitContent, 1)
  end
end

MessageMgr.GetCenterTipsContent = function(...)
  -- function num : 0_9 , upvalues : MessageMgr
  return MessageMgr.CurrentCenterTips
end

local m2 = {}
local m = {}
MessageMgr.CurrentSettleData = {}
MessageMgr.OpenSettleWindow = function(mData, ...)
  -- function num : 0_10 , upvalues : MessageMgr, _ENV
  MessageMgr.CurrentSettleData = mData
  if mData.isSuccess then
    OpenWindow((WinResConfig.BattleSettleWindow).name, UILayer.HUD)
  end
end

MessageMgr.GetSettleData = function(...)
  -- function num : 0_11 , upvalues : MessageMgr
  return MessageMgr.CurrentSettleData
end

MessageMgr.OpenFailureSettleWindow = function(fun1, fun2, ...)
  -- function num : 0_12 , upvalues : _ENV
  OpenWindow((WinResConfig.BattleSettleFailureWindow).name, UILayer.HUD, fun1, fun2)
end

local m3 = {}
local m4 = {}
local m5 = {}
FormationType = {Basic = 0, Single = 1, Tower = 2, Expedition = 3, CG = 4, GuildBattle = 5, Edit = 6, Relic = 99}
local m6 = {}
local m7 = {}
MessageMgr.formationData = {}
MessageMgr.OpenFormationWindow = function(data, ...)
  -- function num : 0_13 , upvalues : _ENV, MessageMgr
  ld("FormationPreset")
  local formationData = MessageMgr.formationData
  formationData.myselfList = data.myselfList
  formationData.enemyList = data.enemyList
  formationData.PrepareList = data.PrepareList
  formationData.otherPlayerList = data.otherPlayerList
  formationData.battleType = data.battleType
  formationData.stageId = data.stageId
  formationData.ExternalData = data.ExternalData
  formationData.GuildBossExternal = data.GuildBossExternal
  formationData.RelicData = data.RelicData
  formationData.BtnData = data.BtnData
  formationData.formationType = data.formationType
  formationData.closeFun = data.closeFun
  formationData.backFun = data.backFun
  formationData.isShowConfirmWindow = data.isShowConfirmWindow
  formationData.confirmContent = data.confirmContent
  formationData.isSelfClose = data.isSelfClose
  formationData.DetailBtn = data.DetailBtn
  formationData.FCFactor = data.FCFactor
  formationData.tureEnemyFC = data.tureEnemyFC
  OpenWindow((WinResConfig.FormationWindow).name, UILayer.HUD)
end

MessageMgr.GetFormationData = function(...)
  -- function num : 0_14 , upvalues : MessageMgr
  return MessageMgr.formationData
end

MessageMgr.OpenFormationPresetEditWindow = function(preset, closeWin, ...)
  -- function num : 0_15 , upvalues : _ENV, MessageMgr
  local formationData = {}
  local new = (_G.next)(preset) == nil
  formationData.formationType = FormationType.Edit
  formationData.myselfList = (Util.CovertRemoteFormationToLocal)(preset.deckSchemes)
  formationData.presetId = preset.id
  if new then
    formationData.presetName = (PUtil.get)(60000603) .. #FormationPresetData.PresetData + 1
  else
    formationData.presetName = preset.name
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

  FormationPresetData.EditPreset = preset
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (FormationPresetData.EditPreset).name = formationData.presetName
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

  FormationPresetData.OriginFormation = (Util.Copy)(preset.deckSchemes)
  formationData.backFun = function(formation, ...)
    -- function num : 0_15_0 , upvalues : _ENV, new
    (Util.BeforeCloseFormation)(formation, function(...)
      -- function num : 0_15_0_0 , upvalues : _ENV
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

      FormationPresetData.FormationData = nil
      UIMgr:SendWindowMessage((WinResConfig.FormationWindow).name, (WindowMsgEnum.FormationPreset).E_MSG_REFRESH)
      OpenWindow((WinResConfig.FormationPresetWindow).name, UILayer.HUD)
    end
, function(...)
      -- function num : 0_15_0_1 , upvalues : _ENV
      return (Util.CovertRemoteFormationToLocal)(FormationPresetData.OriginFormation), 60000062
    end
, function(newFormation, ...)
      -- function num : 0_15_0_2 , upvalues : _ENV, new
      ((Util.CovertLoaclFormationToRemote)(newFormation))
      local formation = nil
      local type = nil
      if new then
        type = FormationPresetChangeType.Add
      else
        if (_G.next)(newFormation) == nil then
          type = FormationPresetChangeType.Delete
        else
          type = FormationPresetChangeType.Alter
        end
      end
      ;
      (FormationPresetService.ReqAddOrUpdateDeckScheme)(type, (FormationPresetData.EditPreset).id, (FormationPresetData.EditPreset).name, formation)
    end
)
  end

  formationData.closeFun = function(...)
    -- function num : 0_15_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    FormationPresetData.FormationData = nil
    UIMgr:SendWindowMessage((WinResConfig.FormationWindow).name, (WindowMsgEnum.FormationPreset).E_MSG_REFRESH)
    UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
  end

  formationData.isSelfClose = true
  formationData.BtnData = {}
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (formationData.BtnData).btnTxt = (PUtil.get)(60000026)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (formationData.BtnData).fun = function(formation, presetName, ...)
    -- function num : 0_15_2 , upvalues : new, _ENV, MessageMgr
    if new then
      if (_G.next)(formation) == nil then
        (MessageMgr.SendCenterTips)((PUtil.get)(60000602))
      else
        ;
        (FormationPresetService.ReqAddOrUpdateDeckScheme)(FormationPresetChangeType.Add, (FormationPresetData.EditPreset).id, presetName, (Util.CovertLoaclFormationToRemoteTight)(formation))
        new = false
      end
    else
      if not new and (_G.next)(formation) == nil then
        (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000601), function(...)
      -- function num : 0_15_2_0 , upvalues : _ENV
      (FormationPresetService.ReqAddOrUpdateDeckScheme)(FormationPresetChangeType.Delete, (FormationPresetData.EditPreset).id)
    end
)
      else
        ;
        (FormationPresetService.ReqAddOrUpdateDeckScheme)(FormationPresetChangeType.Alter, (FormationPresetData.EditPreset).id, presetName, (Util.CovertLoaclFormationToRemoteTight)(formation))
      end
    end
  end

  -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

  FormationPresetData.FormationData = formationData
  if closeWin then
    UIMgr:SendWindowMessage((WinResConfig.FormationWindow).name, (WindowMsgEnum.FormationPreset).E_MSG_REFRESH)
    UIMgr:CloseWindow(closeWin)
  else
    OpenWindow((WinResConfig.FormationWindow).name, UILayer.HUD)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

local _confirmWinPool = {}
local _confirmStack = {}
MessageMgr.GetConfirmWin = function(...)
  -- function num : 0_16 , upvalues : _confirmWinPool, _ENV
  if #_confirmWinPool ~= 0 then
    local content = (table.remove)(_confirmWinPool, #_confirmWinPool)
    content.visible = true
    content.touchable = true
    return content
  else
    do
      do return UIMgr:CreateUIPage((WinResConfig.ConfirmWindow).package, (WinResConfig.ConfirmWindow).comName) end
    end
  end
end

MessageMgr.RecycleConfirmWin = function(content, ...)
  -- function num : 0_17 , upvalues : _ENV, _confirmWinPool
  content.touchable = false
  content.visible = false
  ;
  (table.insert)(_confirmWinPool, content)
end

MessageMgr.ClearAll = function(...)
  -- function num : 0_18 , upvalues : _confirmWinPool, _confirmStack
  _confirmWinPool = {}
  _confirmStack = {}
end

MessageMgr.OpenConfirmWindow = function(content, confirmCB, cancelCB, title, confirmTxt, cancelTxt, haveCloseBtn, layer, confirmID, ...)
  -- function num : 0_19 , upvalues : _ENV, MessageMgr
  if layer == nil then
    layer = UILayer.God
  end
  ;
  (MessageMgr.ShowConfirm)(layer, confirmID, content, confirmCB, title, cancelCB, confirmTxt, cancelTxt, true, haveCloseBtn)
end

MessageMgr.OpenSoloConfirmWindow = function(content, confirmCB, title, confirmTxt, haveCloseBtn, noMoreTips, layer, confirmID, ...)
  -- function num : 0_20 , upvalues : _ENV, MessageMgr
  if layer == nil then
    layer = UILayer.God
  end
  ;
  (MessageMgr.ShowConfirm)(layer, confirmID, content, confirmCB, title, nil, confirmTxt, "", false, haveCloseBtn, noMoreTips)
end

MessageMgr.ShowConfirm = function(layer, confirmID, ...)
  -- function num : 0_21 , upvalues : _ENV, MessageMgr, _confirmStack
  if UIMgr:IsWindowOpen((WinResConfig.ConfirmWindow).name) == false then
    OpenWindow((WinResConfig.ConfirmWindow).name, layer, true, 0, true, {...})
  end
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_WARNING, SoundBank.OTHER)
  local content = (MessageMgr.GetConfirmWin)()
  local args = {}
  args.content = content
  args.Id = confirmID
  args.argTable = {...}
  UIMgr:SendWindowMessage((WinResConfig.ConfirmWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_INIT_CONFIRM, content)
  UIMgr:SendWindowMessage((WinResConfig.ConfirmWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_CHANGE_CONFIRM_ARG, args)
  UIMgr:SendWindowMessage((WinResConfig.ConfirmWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_SHOW_CONFIRM)
  ;
  (table.insert)(_confirmStack, args)
end

MessageMgr.IsConfirmShow = function(confirmID, ...)
  -- function num : 0_22 , upvalues : _confirmStack, _ENV
  if #_confirmStack == 0 then
    return false
  end
  for _,args in ipairs(_confirmStack) do
    if args.Id == confirmID then
      return true
    end
  end
  return false
end

MessageMgr.CloseConfirm = function(confirmID, func, ...)
  -- function num : 0_23 , upvalues : _confirmStack, _ENV
  if #_confirmStack == 0 then
    return 
  end
  local args = _confirmStack[#_confirmStack]
  if confirmID ~= nil and args.Id ~= confirmID then
    return 
  end
  ;
  (table.remove)(_confirmStack, #_confirmStack)
  if #_confirmStack == 0 then
    (GuideMgr.SetGuideShow)(true)
    UIMgr:CloseWindow((WinResConfig.ConfirmWindow).name, function(...)
    -- function num : 0_23_0 , upvalues : _ENV, func
    UIMgr:SendWindowMessage((WinResConfig.ConfirmWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_CLOSE_CONFIRM)
    if func ~= nil then
      func()
    end
  end
)
  else
    UIMgr:SendWindowMessage((WinResConfig.ConfirmWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_CHANGE_CONFIRM_ARG, _confirmStack[#_confirmStack])
    UIMgr:SendWindowMessage((WinResConfig.ConfirmWindow).name, (WindowMsgEnum.MessageWindow).E_MSG_POP_UP_CONFIRM)
    if func ~= nil then
      func()
    end
  end
end

MessageMgr.GetLeftConfirmAmount = function(...)
  -- function num : 0_24 , upvalues : _confirmStack
  return #_confirmStack
end

MessageMgr.OpenCostResConfirmWindow = function(contentID, cost, func, func2, fun3, onlyShowDiamond, ...)
  -- function num : 0_25 , upvalues : _ENV, MessageMgr
  local enough, costInfo = (Util.CheckCostResources)(cost, func2, fun3)
  if enough == false then
    return 
  end
  local set = (Util.GetPlayerSetting)(PlayerPrefsKeyName.IGNORE_DIAMOND_CONSUM_TIPS, "0")
  if set ~= "0" then
    if func ~= nil then
      func()
    end
    return 
  end
  local count = #costInfo
  local totalCost = 0
  local haveDiamond = false
  for i = 1, count do
    totalCost = totalCost + (costInfo[i]).Amount
    haveDiamond = haveDiamond or (costInfo[i]).Id == AssetType.DIAMOND
  end
  -- DECOMPILER ERROR at PC73: Unhandled construct in 'MakeBoolean' P3

  -- DECOMPILER ERROR at PC73: Unhandled construct in 'MakeBoolean' P1

  if ((count == 1 and (costInfo[1]).Id ~= AssetType.DIAMOND and (costInfo[1]).Id ~= AssetType.DIAMOND_BIND and (costInfo[1]).Id ~= 21160001) or not onlyShowDiamond or haveDiamond or not costInfo.OnlyDiamond) and func ~= nil then
    func()
  end
  do return  end
  local content = nil
  if costInfo.DiamondIndex ~= nil then
    local showCost = {Id = AssetType.DIAMOND_BIND, Type = PropType.ASSET, Amount = (costInfo[1]).Amount}
    showCost.Amount = showCost.Amount + (costInfo[costInfo.DiamondIndex]).Amount
    content = (PUtil.get)(contentID, (MessageMgr.GetCostImgHtml)(showCost), ...)
  else
    local costStr = ""
    count = #costInfo
    for i = 1, count do
      costStr = costStr .. (MessageMgr.GetCostImgHtml)(costInfo[i])
    end
    content = (PUtil.get)(contentID, costStr, ...)
  end
  -- DECOMPILER ERROR at PC130: Confused about usage of register: R13 in 'UnsetPending'

  if costInfo.OnlyDiamond then
    (costInfo[1]).Id = AssetType.DIAMOND
  end
  OpenWindow((WinResConfig.SpendTipsWindow).name, UILayer.HUD, content, costInfo, func, func2)
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

MessageMgr.GetCostImgHtmlByStr = function(costStr, txtColor, picSize, ...)
  -- function num : 0_26 , upvalues : _ENV, MessageMgr
  local costInfo = split(costStr, ":")
  local cost = {}
  cost = {Id = tonumber(costInfo[2]), Type = tonumber(costInfo[1]), Amount = tonumber(costInfo[3])}
  return (MessageMgr.GetCostImgHtml)(cost, txtColor, picSize)
end

MessageMgr.GetCostImgHtml = function(cost, txtColor, picSize, ...)
  -- function num : 0_27 , upvalues : _ENV
  if cost.Amount == 0 then
    return ""
  else
    local htmlSize = Const.CostImgSize
    if picSize then
      htmlSize = picSize
    end
    local ConfigData = (Util.GetConfigByItemIDAndType)(cost.Id, cost.Type)
    local str = "<img src=\'" .. (Util.GetItemUrl)(ConfigData.icon) .. "\' "
    str = str .. "width=\'" .. htmlSize .. "\' "
    str = str .. "height=\'" .. htmlSize .. "\'/>"
    if txtColor then
      str = str .. "[color=" .. txtColor .. "]" .. cost.Amount .. "[/color] "
    else
      str = str .. "[color=" .. Const.GreenColor .. "]" .. cost.Amount .. "[/color] "
    end
    return str
  end
end

MessageMgr.OpenAssetNotEnoughtWindow = function(id, func, func2, needAmount, showAmount, AimNum, ...)
  -- function num : 0_28 , upvalues : _ENV, MessageMgr
  if not ((TableData.gTable).BaseAssetData)[id] then
    local config = ((TableData.gTable).BasePropData)[id]
  end
  if (FunctionControlMgr.GetFunctionState)(ControlID.GetWay_GetWay, false) == false then
    (MessageMgr.SendCenterTips)((PUtil.get)(177, config.name))
  else
    if id == AssetType.ACTIVITYDUNGEON_COIN then
      local coinName = (((TableData.gTable).BaseAssetData)[AssetType.ACTIVITYDUNGEON_COIN]).name
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(177, coinName))
    else
      do
        local cb = function(...)
    -- function num : 0_28_0 , upvalues : id, _ENV, AimNum, needAmount, func
    if id == AssetType.GOLD or id == AssetType.EQUIP_EXP then
      (Util.ShowGetWay)(id)
    else
      if id == AssetType.DIAMOND then
        ld("Shop")
        ;
        (ShopMgr.ExternalGotoShop)(ShopType.Recharge)
      else
        if id == AssetType.SPIRIT then
          (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).ENERGY_BUY_TIME_TYPE)
        else
          if id == AssetType.ENDURANCE then
            (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).STA_BUY_TIME_TYPE)
          else
            if id == AssetType.PHYSICAL then
              (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).VIT_BUY_TIME_TYPE)
            else
              if AimNum and AimNum > 0 then
                (Util.ShowGetWay)(id, nil, needAmount, AimNum)
              else
                ;
                (Util.ShowGetWay)(id, nil, needAmount)
              end
            end
          end
        end
      end
    end
    if func ~= nil then
      func()
    end
  end

        if showAmount then
          if ((TableData.gTable).BaseAssetData)[id] then
            (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000612, config.name, (MessageMgr.GetCostImgHtmlByStr)(PropType.ASSET .. ":" .. id .. ":" .. needAmount, Const.RedColor)), cb, func2)
          else
            ;
            (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000612, config.name, (MessageMgr.GetCostImgHtmlByStr)(PropType.ITEM .. ":" .. id .. ":" .. needAmount, Const.RedColor)), cb, func2)
          end
        else
          ;
          (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000037, config.name), cb, func2)
        end
      end
    end
  end
end

local _buyTimesCosts = {}
local _leftBuyTime = 0
local _currentBuyTimesCostInfo, _currentBuyTimeIndex, _currentBuyTime, _currentBuyTimeCost, _currentBuyTimeType, _currentBuyTimeStatus, _maxBuyTime, _maxBuyTimeCost, _maxBuyTimeIndex, _maxBuyTimeStatus, _buyTimeFunction, _boughtTimes, _confirmTips = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
BuyTimesStatue = {Enough = 1, NotEnough = 2, HelpEnough = 3}
MessageMgr.GetBuyTimesInfo = function(...)
  -- function num : 0_29 , upvalues : MessageMgr, _buyTimesCosts
  (MessageMgr.InitBuyTimesData)()
  return _buyTimesCosts
end

MessageMgr.OpenBuyTimesWindow = function(type, boughtTimes, func, tips, ...)
  -- function num : 0_30 , upvalues : MessageMgr, _currentBuyTimesCostInfo, _buyTimesCosts, _currentBuyTimeType, _boughtTimes, _buyTimeFunction, _confirmTips, _ENV, _maxBuyTime, _currentBuyTime, _currentBuyTimeCost, _currentBuyTimeStatus
  (MessageMgr.InitBuyTimesData)()
  _currentBuyTimesCostInfo = _buyTimesCosts[type]
  if not (MessageMgr.CheckReachMaxBuyTimes)(_currentBuyTimesCostInfo, boughtTimes) then
    return 
  end
  _currentBuyTimeType = type
  _boughtTimes = boughtTimes
  _buyTimeFunction = func
  _confirmTips = tips
  ;
  (MessageMgr.InitBuyOneTime)()
  ;
  (MessageMgr.FindMaxBuyTimes)()
  OpenWindow((WinResConfig.BuyTipsMessageWindow).name, UILayer.HUD, _maxBuyTime, _currentBuyTime, {cost = _currentBuyTimeCost, statue = _currentBuyTimeStatus}, func)
end

MessageMgr.InitBuyTimesData = function(...)
  -- function num : 0_31 , upvalues : _ENV, _buyTimesCosts
  if (_G.next)(_buyTimesCosts) == nil then
    for k,v in pairs((TableData.gTable).BaseBuyTimeData) do
      if _buyTimesCosts[v.type] == nil then
        _buyTimesCosts[v.type] = {}
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (_buyTimesCosts[v.type]).Costs = {}
        -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (_buyTimesCosts[v.type]).HaveLimits = true
      end
      local cost = {}
      cost.Floor = v.start
      cost.Ceil = v.finish
      cost.Cost = v.cost
      cost.Reward = v.reward
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

      if v.finish < 0 then
        (_buyTimesCosts[v.type]).HaveLimits = false
      end
      ;
      (table.insert)((_buyTimesCosts[v.type]).Costs, cost)
    end
    for k,v in pairs(_buyTimesCosts) do
      (table.sort)(v.Costs, function(x, y, ...)
    -- function num : 0_31_0
    if x.Ceil < 0 or y.Ceil < 0 then
      if x.Ceil < 0 and y.Ceil < 0 then
        return false
      else
        if x.Ceil < 0 then
          return false
        else
          return true
        end
      end
    else
      return x.Floor < y.Floor
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
      v.MaxBuyTime = ((v.Costs)[#v.Costs]).Ceil
    end
  end
end

MessageMgr.InitBuyOneTime = function(...)
  -- function num : 0_32 , upvalues : _currentBuyTime, _currentBuyTimesCostInfo, _currentBuyTimeIndex, _boughtTimes, _ENV, _currentBuyTimeStatus, _currentBuyTimeCost
  _currentBuyTime = 1
  local count = #_currentBuyTimesCostInfo.Costs
  _currentBuyTimeIndex = 1
  for i = count, 1, -1 do
    if ((_currentBuyTimesCostInfo.Costs)[i]).Floor <= _boughtTimes + 1 then
      _currentBuyTimeIndex = i
      break
    end
  end
  do
    local nextCost = ((_currentBuyTimesCostInfo.Costs)[_currentBuyTimeIndex]).Cost
    nextCost = split(nextCost, ":")
    local needType = tonumber(nextCost[2])
    local needCost = tonumber(nextCost[3])
    local resCount = (ActorData.GetAssetCount)(needType)
    if resCount < needCost then
      if needType == AssetType.DIAMOND_BIND then
        if (ActorData.GetAssetCount)(AssetType.DIAMOND) + resCount < needCost then
          _currentBuyTimeStatus = BuyTimesStatue.NotEnough
        else
          _currentBuyTimeStatus = BuyTimesStatue.HelpEnough
        end
      else
        _currentBuyTimeStatus = BuyTimesStatue.NotEnough
      end
      _currentBuyTimeCost = {
[1] = {Type = needType, Amount = needCost}
}
    else
      _currentBuyTimeCost = {
[1] = {Type = needType, Amount = needCost}
}
      _currentBuyTimeStatus = BuyTimesStatue.Enough
    end
  end
end

MessageMgr.FindMaxBuyTimes = function(...)
  -- function num : 0_33 , upvalues : _ENV, _currentBuyTimesCostInfo, _currentBuyTimeIndex, _maxBuyTime, _boughtTimes, _maxBuyTimeCost, _maxBuyTimeStatus
  local defaultCost = split(((_currentBuyTimesCostInfo.Costs)[_currentBuyTimeIndex]).Cost, ":")
  local defaultCostType = tonumber(defaultCost[2])
  local resCount = ((ActorData.GetAssetCount)(defaultCostType))
  -- DECOMPILER ERROR at PC14: Overwrote pending register: R3 in 'AssignReg'

  local eachCost = .end
  local count = #_currentBuyTimesCostInfo.Costs
  local costInfo, lowerLimit, eachTimes, eachCostAmount = nil, nil, nil, nil
  local useDiamond = false
  _maxBuyTime = _currentBuyTimesCostInfo.MaxBuyTime - _boughtTimes
  _maxBuyTimeCost = {}
  _maxBuyTimeCost[1] = {}
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R10 in 'UnsetPending'

  ;
  (_maxBuyTimeCost[1]).Type = defaultCostType
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R10 in 'UnsetPending'

  ;
  (_maxBuyTimeCost[1]).Amount = 0
  for i = _currentBuyTimeIndex, count do
    eachCost = (_currentBuyTimesCostInfo.Costs)[i]
    costInfo = split(eachCost.Cost, ":")
    if i == _currentBuyTimeIndex then
      lowerLimit = _boughtTimes + 1
    else
      lowerLimit = eachCost.Floor
    end
    eachTimes = eachCost.Ceil - lowerLimit + 1
    eachCostAmount = tonumber(costInfo[3])
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (_maxBuyTimeCost[1]).Amount = (_maxBuyTimeCost[1]).Amount + (eachTimes) * eachCostAmount
  end
  if (_maxBuyTimeCost[1]).Amount <= resCount then
    _maxBuyTimeStatus = BuyTimesStatue.Enough
  else
    if defaultCostType == AssetType.DIAMOND_BIND then
      resCount = resCount + (ActorData.GetAssetCount)(AssetType.DIAMOND)
      if (_maxBuyTimeCost[1]).Amount <= resCount then
        _maxBuyTimeStatus = BuyTimesStatue.HelpEnough
      else
        _maxBuyTimeStatus = BuyTimesStatue.NotEnough
      end
    else
      _maxBuyTimeStatus = BuyTimesStatue.NotEnough
    end
  end
end

MessageMgr.Increase10BuyTime = function(...)
  -- function num : 0_34 , upvalues : _currentBuyTime, _boughtTimes, _currentBuyTimesCostInfo, MessageMgr, _ENV
  if _currentBuyTimesCostInfo.MaxBuyTime <= _currentBuyTime + _boughtTimes and _currentBuyTimesCostInfo.MaxBuyTime ~= -1 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000043))
    return 
  end
  for i = 1, 10 do
    (MessageMgr.IncreaseBuyTime)(false)
  end
end

MessageMgr.IncreaseBuyTime = function(showTips, ...)
  -- function num : 0_35 , upvalues : _currentBuyTime, _boughtTimes, _currentBuyTimesCostInfo, MessageMgr, _ENV, _currentBuyTimeIndex, _currentBuyTimeCost, _currentBuyTimeStatus
  if showTips and _currentBuyTimesCostInfo.MaxBuyTime <= _currentBuyTime + _boughtTimes and _currentBuyTimesCostInfo.MaxBuyTime ~= -1 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000043))
    return 
  end
  local count = #_currentBuyTimesCostInfo.Costs
  local index = _currentBuyTimeIndex
  local item = (_currentBuyTimesCostInfo.Costs)[index]
  local eachCostType, eachCostAmount, cost = nil, nil, nil
  if item.Ceil < _currentBuyTime + _boughtTimes + 1 then
    index = index + 1
    if (_currentBuyTimesCostInfo.Costs)[index] == nil then
      if _currentBuyTimesCostInfo.HaveLimits then
        return 
      else
        index = index - 1
      end
    end
    cost = split(((_currentBuyTimesCostInfo.Costs)[index]).Cost, ":")
  else
    cost = split(item.Cost, ":")
  end
  eachCostType = tonumber(cost[2])
  eachCostAmount = tonumber(cost[3])
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (_currentBuyTimeCost[1]).Amount = (_currentBuyTimeCost[1]).Amount + eachCostAmount
  local resCount = (ActorData.GetAssetCount)(eachCostType)
  if resCount < (_currentBuyTimeCost[1]).Amount then
    if eachCostType == AssetType.DIAMOND_BIND then
      resCount = resCount + (ActorData.GetAssetCount)(AssetType.DIAMOND)
      if resCount < (_currentBuyTimeCost[1]).Amount then
        _currentBuyTimeStatus = BuyTimesStatue.NotEnough
      else
        _currentBuyTimeStatus = BuyTimesStatue.HelpEnough
      end
    else
      _currentBuyTimeStatus = BuyTimesStatue.NotEnough
    end
  end
  _currentBuyTimeIndex = index
  _currentBuyTime = _currentBuyTime + 1
  UIMgr:SendWindowMessage((WinResConfig.BuyTipsMessageWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_REFRESH_BUY_TIMES, _currentBuyTime)
  UIMgr:SendWindowMessage((WinResConfig.BuyTipsMessageWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_REFRESH_BUY_COSTS, {cost = _currentBuyTimeCost, statue = _currentBuyTimeStatus})
end

MessageMgr.DecreaseBuyTime = function(...)
  -- function num : 0_36 , upvalues : _currentBuyTime, MessageMgr, _ENV, _currentBuyTimesCostInfo, _currentBuyTimeIndex, _boughtTimes, _currentBuyTimeCost, _currentBuyTimeStatus
  if _currentBuyTime == 1 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000044))
    return 
  end
  if _currentBuyTime < 1 then
    return 
  end
  local count = #_currentBuyTimesCostInfo.Costs
  local item = (_currentBuyTimesCostInfo.Costs)[_currentBuyTimeIndex]
  local eachCostType, eachCostAmount = nil, nil
  local cost = split(item.Cost, ":")
  if _currentBuyTime + _boughtTimes - 1 < item.Floor then
    _currentBuyTimeIndex = _currentBuyTimeIndex - 1
  end
  eachCostType = tonumber(cost[2])
  eachCostAmount = tonumber(cost[3])
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (_currentBuyTimeCost[1]).Amount = (_currentBuyTimeCost[1]).Amount - eachCostAmount
  local resCount = (ActorData.GetAssetCount)(eachCostType)
  if (_currentBuyTimeCost[1]).Amount <= resCount then
    _currentBuyTimeStatus = BuyTimesStatue.Enough
  end
  _currentBuyTime = _currentBuyTime - 1
  UIMgr:SendWindowMessage((WinResConfig.BuyTipsMessageWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_REFRESH_BUY_TIMES, _currentBuyTime)
  UIMgr:SendWindowMessage((WinResConfig.BuyTipsMessageWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_REFRESH_BUY_COSTS, {cost = _currentBuyTimeCost, statue = _currentBuyTimeStatus})
end

MessageMgr.MaxBuyTime = function(...)
  -- function num : 0_37 , upvalues : _currentBuyTime, _maxBuyTime, MessageMgr, _ENV, _currentBuyTimeCost, _maxBuyTimeCost, _currentBuyTimeIndex, _currentBuyTimesCostInfo, _currentBuyTimeStatus, _maxBuyTimeStatus
  if _currentBuyTime == _maxBuyTime then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000043))
    return 
  end
  _currentBuyTime = _maxBuyTime
  _currentBuyTimeCost = (Util.Copy)(_maxBuyTimeCost)
  _currentBuyTimeIndex = #_currentBuyTimesCostInfo.Costs
  _currentBuyTimeStatus = _maxBuyTimeStatus
  loge("_maxBuyTimeStatus:" .. _maxBuyTimeStatus)
  UIMgr:SendWindowMessage((WinResConfig.BuyTipsMessageWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_REFRESH_BUY_TIMES, _currentBuyTime)
  UIMgr:SendWindowMessage((WinResConfig.BuyTipsMessageWindow).name, (WindowMsgEnum.MessageWindow).E_Msg_REFRESH_BUY_COSTS, {cost = _currentBuyTimeCost, statue = _currentBuyTimeStatus})
end

MessageMgr.TryBuyTimes = function(...)
  -- function num : 0_38 , upvalues : _currentBuyTime, MessageMgr, _ENV, _currentBuyTimeStatus, _currentBuyTimeCost, _confirmTips, _currentBuyTimesCostInfo, _currentBuyTimeIndex, _buyTimeFunction
  if _currentBuyTime == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000044))
    return false
  end
  if _currentBuyTimeStatus == BuyTimesStatue.NotEnough then
    (MessageMgr.OpenAssetNotEnoughtWindow)((_currentBuyTimeCost[#_currentBuyTimeCost]).Type, function(...)
    -- function num : 0_38_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.BuyTipsMessageWindow).name)
  end
)
    return false
  else
    if _currentBuyTimeStatus == BuyTimesStatue.HelpEnough or (_currentBuyTimeCost[1]).Type == AssetType.DIAMOND then
      (MessageMgr.OpenCostResConfirmWindow)(_confirmTips, ((_currentBuyTimesCostInfo.Costs)[_currentBuyTimeIndex]).Cost, function(...)
    -- function num : 0_38_1 , upvalues : _buyTimeFunction, _currentBuyTime, _ENV
    if _buyTimeFunction ~= nil then
      _buyTimeFunction(_currentBuyTime)
    end
    UIMgr:CloseWindow((WinResConfig.BuyTipsMessageWindow).name)
  end
)
      return false
    else
      if _buyTimeFunction ~= nil then
        _buyTimeFunction(_currentBuyTime)
      end
      return true
    end
  end
end

MessageMgr.CheckReachMaxBuyTimes = function(info, boughtTimes, ...)
  -- function num : 0_39 , upvalues : MessageMgr, _ENV
  if info.HaveLimits and info.MaxBuyTime <= boughtTimes and info.MaxBuyTime ~= -1 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000043))
    return false
  else
    return true
  end
end

MessageMgr.BuyOneTimes = function(type, boughtTimes, func, ...)
  -- function num : 0_40 , upvalues : MessageMgr, _buyTimesCosts, _ENV
  (MessageMgr.InitBuyTimesData)()
  local info = _buyTimesCosts[type]
  if not (MessageMgr.CheckReachMaxBuyTimes)(info, boughtTimes) then
    return 
  end
  local count = #info.Costs
  for i = count, 1, -1 do
    if ((info.Costs)[i]).Ceil < boughtTimes + 1 then
      if (info.Costs)[i + 1] == nil then
        info = (info.Costs)[i]
        break
      end
      info = (info.Costs)[i + 1]
      break
    end
  end
  do
    if info.Cost == nil then
      info = (info.Costs)[1]
    end
    local assetType, content = nil, nil
    if type == BuyTimesType.PurchaseSprite then
      assetType = AssetType.SPIRIT
      content = 60000438
    else
      if type == BuyTimesType.PurchaseEndurance then
        assetType = AssetType.ENDURANCE
        content = 60000436
      end
    end
    local name = (((TableData.gTable).BaseAssetData)[assetType]).name
    local gain = split(info.Reward, ":")
    gain = tonumber(gain[3])
    if (ActorData.GetMaxStoreAsset)(assetType) < gain + (ActorData.GetAssetCount)(assetType) then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000437, name))
      return 
    end
    ;
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(content, (MessageMgr.GetCostImgHtmlByStr)(info.Cost), "[color=" .. Const.GreenColor .. "]" .. gain .. "[/color]", name), function(...)
    -- function num : 0_40_0 , upvalues : _ENV, info, func
    if not (Util.CheckCostResources)(info.Cost) then
      return 
    end
    if func ~= nil then
      func(1)
    end
  end
)
  end
end

MessageMgr.OpenRewardShowWindow = function(items, closeFun, ...)
  -- function num : 0_41 , upvalues : _ENV
  OpenWindow((WinResConfig.RewardShowWindow).name, UILayer.HUD1, items, closeFun)
end

MessageMgr.OpenRewardByStr = function(str, Fun, ...)
  -- function num : 0_42 , upvalues : _ENV, MessageMgr
  local ext = (Util.ParseConfigStr)(str)
  local items = {}
  for _,v in pairs(ext) do
    local item = {}
    item.Type = v[1]
    item.id = v[2]
    item.Num = v[3]
    ;
    (table.insert)(items, item)
  end
  ;
  (MessageMgr.OpenRewardShowWindow)(items, Fun)
end

MessageMgr.OpenRewardByGoods = function(goods, fun, ...)
  -- function num : 0_43 , upvalues : _ENV, MessageMgr
  local items = {}
  for _,v in ipairs(goods) do
    if v.type <= PropType.HEAD_FRAME and v.value > 0 and v.type ~= PropType.OTHER then
      local item = {}
      item.id = v.id
      item.Num = v.value
      item.Type = v.type
      ;
      (table.insert)(items, item)
    end
  end
  ;
  (MessageMgr.OpenRewardShowWindow)(items, fun)
end

MessageMgr.ShowGetGoods = function(goods, equips, showProp, props, ...)
  -- function num : 0_44 , upvalues : _ENV, MessageMgr
  local items = {}
  local item = {}
  local count = nil
  if goods ~= nil then
    count = #goods
    local eachGoods = nil
    for i = 1, count do
      eachGoods = goods[i]
      if NoShowGetGoods[eachGoods.id] == nil and eachGoods.type ~= (ProtoEnum.E_GOODS_TYPE).OTHER then
        if eachGoods.value <= 0 then
          do
            item = {}
            item.Type = eachGoods.type
            item.id = eachGoods.id
            item.Num = eachGoods.value
            item.attr = eachGoods.attr
            ;
            (table.insert)(items, item)
            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  do
    if showProp then
      count = #props
      for i = 1, count do
        local eachGoods = props[i]
        if NoShowGetGoods[eachGoods.id] == nil and eachGoods.count > 0 then
          item = {}
          item.Type = (ProtoEnum.E_GOODS_TYPE).PROP
          item.id = eachGoods.id
          item.Num = eachGoods.count
          ;
          (table.insert)(items, item)
        end
      end
    end
    do
      if equips ~= nil then
        count = #equips
        for i = 1, count do
          local eachGoods = equips[i]
          if NoShowGetGoods[eachGoods.id] == nil then
            item = {}
            item.Type = (ProtoEnum.E_GOODS_TYPE).EQUIP
            item.id = eachGoods.id
            item.Num = 1
            ;
            (table.insert)(items, item)
          end
        end
      end
      do
        print("========11111=======", #items)
        if #items > 0 then
          (MessageMgr.OpenRewardShowWindow)(items)
        end
      end
    end
  end
end

MessageMgr.OpenItemBuyTipsWindowBySingle = function(item, ...)
  -- function num : 0_45 , upvalues : MessageMgr
  (MessageMgr.OpenItemBuyTipsWindow)({item})
end

MessageMgr.OpenItemBuyTipsWindow = function(items, ...)
  -- function num : 0_46 , upvalues : _ENV
  if items == nil or #items <= 0 then
    return 
  end
  if UIMgr:IsWindowOpen((WinResConfig.ItemBuyTipsWindow).name) then
    UIMgr:SendWindowMessage((WinResConfig.ItemBuyTipsWindow).name, 1, items)
  else
    OpenWindow((WinResConfig.ItemBuyTipsWindow).name, UILayer.Popup, items)
  end
end

MessageMgr.OpenItemBuyTipsWindowByGoodsObj = function(goodsObjS, ...)
  -- function num : 0_47 , upvalues : _ENV, MessageMgr
  local itemS = {}
  for _,v in ipairs(goodsObjS) do
    local item = {}
    item.id = v.id
    item.Num = v.value
    ;
    (table.insert)(itemS, item)
  end
  ;
  (MessageMgr.OpenItemBuyTipsWindow)(itemS)
end

MessageMgr.OpenItemBuyTipsWindowByStr = function(str, ...)
  -- function num : 0_48 , upvalues : _ENV, MessageMgr
  local itemS = {}
  local itemStr = (Util.ParseConfigStr)(str)
  for _,v in ipairs(itemStr) do
    local item = {}
    item.id = tonumber(v[2])
    item.Num = tonumber(v[3])
    ;
    (table.insert)(itemS, item)
  end
  ;
  (MessageMgr.OpenItemBuyTipsWindow)(itemS)
end

MessageMgr.SendNoticeMsg = function(content, replace, ...)
  -- function num : 0_49 , upvalues : _ENV
  if UIMgr:IsWindowOpen((WinResConfig.NoticeWindow).name) then
    UIMgr:SendWindowMessage((WinResConfig.NoticeWindow).name, 1, {content, replace})
  else
    OpenWindow((WinResConfig.NoticeWindow).name, UILayer.Notice, content, replace)
  end
end

MessageMgr.OpenMonsterDetailWindow = function(defaultStage, formation, stageCount, setStageItem, stageLockChecker, getStageTip, getMonsterGroups, LockAction, ...)
  -- function num : 0_50 , upvalues : _ENV
  OpenWindow((WinResConfig.MonsterDetailWindow).name, UILayer.HUD, defaultStage, formation, stageCount, setStageItem, stageLockChecker, getStageTip, getMonsterGroups, LockAction)
end

local IgnoreWindowList = {(WinResConfig.LoadingWindow).name, (WinResConfig.PlotChapterFinshWindow).name, (WinResConfig.HandBookCGShowWindow).name, (WinResConfig.PlotChapterBoxGetWindow).name, (WinResConfig.BattleFailConvergeWindow).name, (WinResConfig.CardGetShowWindow).name}
local CloseAppWindow = {(WinResConfig.LoginWindow).name}
local mWindowFunc = {}
MessageMgr.AndroidBackBtnFun = function(winName, ...)
  -- function num : 0_51 , upvalues : MessageMgr, IgnoreWindowList, _ENV, CloseAppWindow, mWindowFunc
  if not (MessageMgr.IsInSpecialList)(IgnoreWindowList, winName) then
    if winName == (WinResConfig.PlotPlayPanelWindow).name then
      if (PlotPlayMgr.GetIsCanSkip)() and OvertureMgr.isPlaying == false then
        UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_SKIP_BTN)
      else
        UIMgr:SendWindowMessage((WinResConfig.PlotPlayPanelWindow).name, (WindowMsgEnum.PlotPlay).E_MSG_BLANK_BTN)
      end
      return 
    end
    if OvertureMgr.isPlaying == true or (GuideMgr.IsInMainGuide)() or UIMgr:IsWindowOpen((WinResConfig.GuidePictureWindow).name) then
      return 
    end
    if (MessageMgr.IsInSpecialList)(CloseAppWindow, winName) then
      (MessageMgr.OpenConfirmWindow)((PUtil.get)(20000521), function(...)
    -- function num : 0_51_0 , upvalues : _ENV
    (Application.Quit)()
  end
, nil, nil, nil, nil, nil, UILayer.HUD1)
    else
      if winName == (WinResConfig.BattleUIWindow).name then
        if OvertureMgr.isPlaying == true then
          return 
        end
        if BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).ARENA then
          OpenWindow((WinResConfig.SystemSetWindow).name, UILayer.HUD, SystemSetType.Arena, BattleData.Replay)
        else
          OpenWindow((WinResConfig.SystemSetWindow).name, UILayer.HUD, SystemSetType.Battle)
        end
      else
        if winName == (WinResConfig.ConfirmWindow).name then
          UIMgr:SendWindowMessage((WinResConfig.ConfirmWindow).name, (WindowMsgEnum.MessageWindow).E_MSG_CLOSE_CANCEL)
        else
          if winName == (WinResConfig.LotteryWindow).name and not (LotteryMgr.GetIsLotterying)() then
            UIMgr:CloseWindow(winName)
          end
        end
      end
    end
  end
  local func = mWindowFunc[winName]
  if func then
    func()
  else
    UIMgr:CloseWindow(winName)
  end
end

MessageMgr.OnRegisterBackWinFunc = function(winName, func, ...)
  -- function num : 0_52 , upvalues : mWindowFunc
  if winName == nil or func == nil or mWindowFunc[winName] ~= nil then
    return 
  end
  mWindowFunc[winName] = func
end

MessageMgr.SetAndroidBackWaitTime = function(...)
  -- function num : 0_53
  return 0.3
end

MessageMgr.IsInSpecialList = function(list, str, ...)
  -- function num : 0_54 , upvalues : _ENV
  for _,v in pairs(list) do
    if v == str then
      return true
    end
  end
  return false
end

MessageMgr.SetFullPhysicalPush = function(type, ...)
  -- function num : 0_55 , upvalues : _ENV
  local status = (ActorData.GetPushStatus)(type)
  if status ~= false then
    local PushIDs = (SuperSDKUtil.GetPushIDByType)(type)
    for _,v in ipairs(PushIDs) do
      (SuperSDKUtil.DeleteLocalPush)(v)
    end
    for _,v in ipairs(PushIDs) do
      local current = (ActorData.GetAssetCount)(AssetType.PHYSICAL)
      local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[(ActorData.GetLevel)() + 72300000]
      local max = LevelUpData.max_vit
      if max <= current then
        return -1
      end
      local FixedData = ((TableData.gTable).BaseFixedData)[Const.MaxPhysicalFixedID]
      local configData = split(FixedData.array_value, ":")
      local singleTime = tonumber(configData[1])
      local playTime = (os.time)() + singleTime * (max - current)
      local pushData = ((TableData.gTable).BaseMessagePushData)[tonumber(v)]
      ;
      (SuperSDKUtil.AddLocalPush)(v, playTime + pushData.relative_push_time)
    end
  end
end

MessageMgr.SetCandyGetPush = function(type, ...)
  -- function num : 0_56 , upvalues : _ENV
  local status = (ActorData.GetPushStatus)(type)
  if status ~= false then
    local PushIDs = (SuperSDKUtil.GetPushIDByType)(type)
    for _,v in ipairs(PushIDs) do
      (SuperSDKUtil.DeleteLocalPush)(v)
    end
    for _,v in ipairs(PushIDs) do
      local pushData = ((TableData.gTable).BaseMessagePushData)[tonumber(v)]
      local pushTime = (LuaTime.GetTimeWithParameter)(pushData.push_parameter)
      ;
      (SuperSDKUtil.AddLocalPush)(v, pushTime + pushData.relative_push_time)
    end
  end
end

MessageMgr.SetFixTimePush = function(type, ...)
  -- function num : 0_57 , upvalues : _ENV
  local status = (ActorData.GetPushStatus)(type)
  if status ~= false then
    local PushIDs = (SuperSDKUtil.GetPushIDByType)(type)
    for _,v in ipairs(PushIDs) do
      (SuperSDKUtil.DeleteLocalPush)(v)
    end
    for _,v in ipairs(PushIDs) do
      local pushData = ((TableData.gTable).BaseMessagePushData)[tonumber(v)]
      local pushTime = (LuaTime.GetTimeWithParameter)(pushData.push_parameter)
      ;
      (SuperSDKUtil.AddLocalPush)(v, pushTime + pushData.relative_push_time)
    end
  end
end

MessageMgr.SetPushTypeData = function(type, isAdd, ...)
  -- function num : 0_58 , upvalues : _ENV, MessageMgr
  local status = not (ActorData.GetPushStatus)(type) or isAdd
  local PushIDs = (SuperSDKUtil.GetPushIDByType)(type)
  if PushType.Full_Physical == type then
    if status then
      for _,v in ipairs(PushIDs) do
        (MessageMgr.SetFullPhysicalPush)(type)
      end
    else
      do
        for _,v in ipairs(PushIDs) do
          (SuperSDKUtil.DeleteLocalPush)(v)
        end
        do
          -- DECOMPILER ERROR at PC50: Unhandled construct in 'MakeBoolean' P1

          if PushType.Farm_Ripe == type and status and HomelandData ~= nil then
            local time = (HomelandData.FindLongestTime)()
            if time > 0 then
              local pushData = ((TableData.gTable).BaseMessagePushData)[tonumber(PushIDs[1])]
              ;
              (SuperSDKUtil.AddLocalPush)(type, time + pushData.relative_push_time)
            end
          end
          do
            ;
            (SuperSDKUtil.DeleteLocalPush)(PushIDs[1])
            if PushType.Candy_Get == type then
              if status then
                (MessageMgr.SetCandyGetPush)(type)
              else
                for _,v in ipairs(PushIDs) do
                  (SuperSDKUtil.DeleteLocalPush)(v)
                end
              end
            else
              do
                if PushType.Fix_Time == type then
                  if status then
                    (MessageMgr.SetFixTimePush)(type)
                  else
                    for _,v in ipairs(PushIDs) do
                      (SuperSDKUtil.DeleteLocalPush)(v)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

return MessageMgr

