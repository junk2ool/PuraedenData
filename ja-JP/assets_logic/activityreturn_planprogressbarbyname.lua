-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityReturn_PlanProgressFillByName")
GetActivityReturn_PlanProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetActivityReturn_PlanProgressFillUis(ui:GetChild("bar"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.root = ui
  return uis
end


