-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_PlotSpot_1ByName")
GetActivityDungeonTwo_Map_2Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Spot_1 = GetActivityDungeonTwo_PlotSpot_1Uis(ui:GetChild("Spot_1"))
  uis.Spot_2 = GetActivityDungeonTwo_PlotSpot_1Uis(ui:GetChild("Spot_2"))
  uis.Spot_3 = GetActivityDungeonTwo_PlotSpot_1Uis(ui:GetChild("Spot_3"))
  uis.Spot_4 = GetActivityDungeonTwo_PlotSpot_1Uis(ui:GetChild("Spot_4"))
  uis.root = ui
  return uis
end


