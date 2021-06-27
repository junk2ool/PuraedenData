-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_CirclePropFrameByName")
GetActivityDungeonTwo_StageNumberUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CirclePropFrame = GetActivityDungeonTwo_CirclePropFrameUis(ui:GetChild("CirclePropFrame"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


