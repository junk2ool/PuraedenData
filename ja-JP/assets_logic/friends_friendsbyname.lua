-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
GetFriends_FriendsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.MessageBtn = ui:GetChild("MessageBtn")
  uis.FriendBtn = ui:GetChild("FriendBtn")
  uis.FriendTipsList = ui:GetChild("FriendTipsList")
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.NothingTxt = ui:GetChild("NothingTxt")
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.NothingGrp = ui:GetChild("NothingGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


