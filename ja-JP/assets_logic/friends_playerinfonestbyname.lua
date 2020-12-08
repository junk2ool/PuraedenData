-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_PlayerInfoByName")
GetFriends_PlayerInfoNestUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlayerInfo = GetFriends_PlayerInfoUis(ui:GetChild("PlayerInfo"))
  uis.root = ui
  return uis
end


