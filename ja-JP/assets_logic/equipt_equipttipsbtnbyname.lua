-- params : ...
-- function num : 0 , upvalues : _ENV
GetEquipt_EquiptTipsBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


