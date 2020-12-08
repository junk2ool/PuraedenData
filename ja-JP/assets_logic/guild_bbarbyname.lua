-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_BFillByName")
GetGuild_BBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetGuild_BFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


