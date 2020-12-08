-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("Friends_ChatHeadListByName")
require("Friends_ChatFrameByName")
GetFriends_FriendChatUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.ChatHeadList = GetFriends_ChatHeadListUis(ui:GetChild("ChatHeadList"))
  uis.ChatFrame = GetFriends_ChatFrameUis(ui:GetChild("ChatFrame"))
  uis.root = ui
  return uis
end


