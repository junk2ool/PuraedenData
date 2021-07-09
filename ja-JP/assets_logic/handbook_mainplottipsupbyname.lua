-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_MainPlotTipsByName")
GetHandBook_MainPlotTipsUpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.MainPlotTips = GetHandBook_MainPlotTipsUis(ui:GetChild("MainPlotTips"))
  uis.root = ui
  return uis
end


