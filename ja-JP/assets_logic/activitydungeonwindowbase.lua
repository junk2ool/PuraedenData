-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityDungeonWindowBase = {
fields = {}
}
local this = ActivityDungeonWindowBase
ActivityDungeonWindowBase.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, this
  local activityId = (ActivityDungeonData.GetCurrentActivityDungeonId)()
  local windowConfig = WinResConfig["ActivityDungeonWindow" .. tostring(activityId)]
  bridgeObj:SetView(windowConfig.package, windowConfig.comName)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (this.fields).windowConfig = windowConfig
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (this.fields).argTable = bridgeObj.argTable
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (this.fields).contentPane = bridgeObj.contentPane
  ;
  (this.InitPanel)(activityId)
end

ActivityDungeonWindowBase.OnShown = function(...)
  -- function num : 0_1
end

ActivityDungeonWindowBase.OnHide = function(...)
  -- function num : 0_2
end

ActivityDungeonWindowBase.OnClose = function(...)
  -- function num : 0_3 , upvalues : this, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (this.fields).argTable = nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (this.fields).contentPane = nil
  ;
  (CommonWinMgr.RemoveAssets)(((this.fields).windowConfig).name)
end

ActivityDungeonWindowBase.InitPanel = function(activityId, ...)
  -- function num : 0_4 , upvalues : _ENV, this
  local bgLoader = (FairyUIUtils.FindLoader)((this.GetContentPane)(), "BgLoader")
  if bgLoader then
    local imageConfigData = ((TableData.gTable).BaseActivityImageConfigData)[activityId]
    if imageConfigData and imageConfigData.activity_old_stage_bkg then
      bgLoader.url = (Util.GetItemUrl)(imageConfigData.activity_old_stage_bkg)
    end
  end
  loge("Can Not Find Image Config Data With " .. tostring(activityId))
end

ActivityDungeonWindowBase.InitAssetStrip = function(param, assetStripGrp, ...)
  -- function num : 0_5 , upvalues : ActivityDungeonWindowBase, _ENV
  param.windowName = ((ActivityDungeonWindowBase.fields).windowConfig).name
  param.Tip = (PUtil.get)(20000216)
  param.model = assetStripGrp
  local activityId = (ActivityDungeonData.GetCurrentActivityDungeonId)()
  local imageConfigData = ((TableData.gTable).BaseActivityImageConfigData)[activityId]
  if imageConfigData then
    param.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, tonumber(imageConfigData.activity_shop_asset), tonumber(imageConfigData.activity_slot_asset)}
    ;
    (CommonWinMgr.RegisterAssets)(param)
  else
    loge("Can Not Find Image Config Data With " .. tostring(activityId))
  end
end

ActivityDungeonWindowBase.HandleMessage = function(msgId, param, ...)
  -- function num : 0_6
end

ActivityDungeonWindowBase.GetContentPane = function(...)
  -- function num : 0_7 , upvalues : this
  return (this.fields).contentPane
end

ActivityDungeonWindowBase.GetWindowConfig = function(...)
  -- function num : 0_8 , upvalues : this
  return (this.fields).windowConfig
end

return ActivityDungeonWindowBase

