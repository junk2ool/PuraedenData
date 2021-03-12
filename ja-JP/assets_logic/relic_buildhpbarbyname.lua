-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_BuildHpFillByName")
GetRelic_BuildHpBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetRelic_BuildHpFillUis(ui:GetChild("bar"))
  uis.PercentageTxt = ui:GetChild("PercentageTxt")
  uis.root = ui
  return uis
end


