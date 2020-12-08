-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_CothesUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Cothes_A_Btn = ui:GetChild("Cothes_A_Btn")
  uis.Cothes_B_Btn = ui:GetChild("Cothes_B_Btn")
  uis.Cothes_C_Btn = ui:GetChild("Cothes_C_Btn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


