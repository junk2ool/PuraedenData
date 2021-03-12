-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_ImprintSkillShowUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ImprintSkillLoader = ui:GetChild("ImprintSkillLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


