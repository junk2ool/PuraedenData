-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_RedDollByName")
require("Adventure_DailyDungeonTipsByName")
require("AdventureIcon_AdventureTipsByName")
GetAdventure_DailyDungeonBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameImage = ui:GetChild("NameImage")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.DailyDungeonTips = GetAdventure_DailyDungeonTipsUis(ui:GetChild("DailyDungeonTips"))
  uis.Tips = GetAdventureIcon_AdventureTipsUis(ui:GetChild("Tips"))
  uis.buttonCtr = ui:GetController("button")
  uis.TimeCtr = ui:GetController("Time")
  uis.root = ui
  return uis
end


