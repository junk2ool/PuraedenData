-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_FriendHeadByName")
require("Friends_OnLineByName")
require("Title_TitlePicByName")
GetFriends_FriendTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.FriendHead = GetFriends_FriendHeadUis(ui:GetChild("FriendHead"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.OnLine = GetFriends_OnLineUis(ui:GetChild("OnLine"))
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


