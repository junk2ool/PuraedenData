-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_LevelExpFillByName")
GetFamily_LevelExpBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetFamily_LevelExpFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


