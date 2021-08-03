-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_Layer_012ByName")
require("Tower_LayerNumberByName")
GetTower_Map_012Uis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Layer = GetTower_Layer_012Uis(ui:GetChild("Layer"))
  uis.LayerNumber = GetTower_LayerNumberUis(ui:GetChild("LayerNumber"))
  uis.LockImage = ui:GetChild("LockImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


