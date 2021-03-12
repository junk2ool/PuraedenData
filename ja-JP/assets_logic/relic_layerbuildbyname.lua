-- params : ...
-- function num : 0 , upvalues : _ENV
GetRelic_LayerBuildUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.LayerLoader = ui:GetChild("LayerLoader")
  uis.LineLoader = ui:GetChild("LineLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


