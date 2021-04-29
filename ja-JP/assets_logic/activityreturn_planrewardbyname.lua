-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityReturn_PlanRewardUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ItemList = ui:GetChild("ItemList")
  uis.TouchBtn = ui:GetChild("TouchBtn")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.PlanProgressBar = ui:GetChild("PlanProgressBar")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


