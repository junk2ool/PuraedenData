-- params : ...
-- function num : 0 , upvalues : _ENV
GetTower_BattleTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


