-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_PlotDetailByName")
GetActivityDungeonTwo_PlotDetailWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlotDetail = GetActivityDungeonTwo_PlotDetailUis(ui:GetChild("PlotDetail"))
  uis.root = ui
  return uis
end


