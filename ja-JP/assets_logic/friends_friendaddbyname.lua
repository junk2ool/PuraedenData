-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_FriendListByName")
require("CommonResource_AssetStripByName")
GetFriends_FriendAddUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.FriendList = GetFriends_FriendListUis(ui:GetChild("FriendList"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.root = ui
  return uis
end


