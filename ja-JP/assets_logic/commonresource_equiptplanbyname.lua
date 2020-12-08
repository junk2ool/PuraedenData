-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_EquiptPlanUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PlanNumberTxt = ui:GetChild("PlanNumberTxt")
  uis.root = ui
  return uis
end


