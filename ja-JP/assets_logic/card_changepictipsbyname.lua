-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_ChangePicTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.OneBtn = ui:GetChild("OneBtn")
  uis.TwoBtn = ui:GetChild("TwoBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


