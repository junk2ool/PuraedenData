-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityDungeon_StageListUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.StageList = ui:GetChild("StageList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


