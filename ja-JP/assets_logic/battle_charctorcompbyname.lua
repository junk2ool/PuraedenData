-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_SpNumberByName")
GetBattle_CharctorCompUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HeadIconLoader = ui:GetChild("HeadIconLoader")
  uis.SpNumber = GetBattle_SpNumberUis(ui:GetChild("SpNumber"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


