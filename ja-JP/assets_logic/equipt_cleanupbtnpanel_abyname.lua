-- params : ...
-- function num : 0 , upvalues : _ENV
GetEquipt_CleanUpBtnPanel_AUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CleanUp_01_Btn = ui:GetChild("CleanUp_01_Btn")
  uis.CleanUp_02_Btn = ui:GetChild("CleanUp_02_Btn")
  uis.CleanUp_03_Btn = ui:GetChild("CleanUp_03_Btn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


