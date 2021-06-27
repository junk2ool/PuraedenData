-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityDungeonTwo_PlotSpot_1Uis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.LockImage = ui:GetChild("LockImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


