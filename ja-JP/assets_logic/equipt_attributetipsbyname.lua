-- params : ...
-- function num : 0 , upvalues : _ENV
GetEquipt_AttributeTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.root = ui
  return uis
end


