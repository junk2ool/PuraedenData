-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_FriendTipsByName")
GetFriends_FriendTipsNestUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.FriendTips = GetFriends_FriendTipsUis(ui:GetChild("FriendTips"))
  uis.root = ui
  return uis
end


