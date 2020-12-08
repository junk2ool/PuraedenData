-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_AFillByName")
GetGuild_ABarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetGuild_AFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


