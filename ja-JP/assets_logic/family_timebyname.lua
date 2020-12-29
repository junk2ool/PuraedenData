-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_TimeUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.root = ui
  return uis
end


