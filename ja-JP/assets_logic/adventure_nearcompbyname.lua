-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventure_NearCompUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TimeCtr = ui:GetController("Time")
  uis.root = ui
  return uis
end


