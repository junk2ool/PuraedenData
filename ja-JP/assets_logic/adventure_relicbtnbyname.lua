-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_RedDollByName")
require("AdventureIcon_AdventureTipsByName")
require("Adventure_RelicTipsByName")
GetAdventure_RelicBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameImage = ui:GetChild("NameImage")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.Tips = GetAdventureIcon_AdventureTipsUis(ui:GetChild("Tips"))
  uis.RelicTips = GetAdventure_RelicTipsUis(ui:GetChild("RelicTips"))
  uis.buttonCtr = ui:GetController("button")
  uis.TimeCtr = ui:GetController("Time")
  uis.root = ui
  return uis
end

