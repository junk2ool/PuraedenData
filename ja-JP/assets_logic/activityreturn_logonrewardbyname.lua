-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityReturn_LogonRewardUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TimeList = ui:GetChild("TimeList")
  uis.ItemList = ui:GetChild("ItemList")
  uis.TouchBtn = ui:GetChild("TouchBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


