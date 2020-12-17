-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_Cothes_C_BtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.buttonCtr = ui:GetController("button")
  uis.lockCtr = ui:GetController("lock")
  uis.root = ui
  return uis
end


