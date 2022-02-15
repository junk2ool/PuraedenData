-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("ActivityDungeonTwo_TimeByName")
GetActivityDungeonTwo_ActivityMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BgLoader = ui:GetChild("BgLoader")
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.LogoLoader = ui:GetChild("LogoLoader")
  uis.AssetStrip = GetCommonResource_AssetStripUis(ui:GetChild("AssetStrip"))
  uis.PlotBtn = ui:GetChild("PlotBtn")
  uis.ChoiceShopBtn = ui:GetChild("ChoiceShopBtn")
  uis.ExchangeBtn = ui:GetChild("ExchangeBtn")
  uis.Time = GetActivityDungeonTwo_TimeUis(ui:GetChild("Time"))
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.CardInfoBtn = ui:GetChild("CardInfoBtn")
  uis.BattleBtn = ui:GetChild("BattleBtn")
  uis.root = ui
  return uis
end


