-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityDungeonTwo_AutoRewardShowUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ImportantTxt = ui:GetChild("ImportantTxt")
  uis.ImportantList = ui:GetChild("ImportantList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


