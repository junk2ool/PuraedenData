-- params : ...
-- function num : 0 , upvalues : _ENV
GetEquipt_EquiptPopAttribute_AUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.State_01_Image = ui:GetChild("State_01_Image")
  uis.State_02_Image = ui:GetChild("State_02_Image")
  uis.State_03_Image = ui:GetChild("State_03_Image")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


