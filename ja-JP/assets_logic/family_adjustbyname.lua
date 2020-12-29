-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_AdjustUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TurnBtn = ui:GetChild("TurnBtn")
  uis.DeleteBtn = ui:GetChild("DeleteBtn")
  uis.root = ui
  return uis
end


