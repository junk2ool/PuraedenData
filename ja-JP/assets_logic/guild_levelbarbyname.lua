-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_LevelFillByName")
GetGuild_LevelBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetGuild_LevelFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


