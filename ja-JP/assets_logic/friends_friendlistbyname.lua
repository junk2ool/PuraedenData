-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_SearchByName")
GetFriends_FriendListUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Add_A_Btn = ui:GetChild("Add_A_Btn")
  uis.Add_B_Btn = ui:GetChild("Add_B_Btn")
  uis.Add_C_Btn = ui:GetChild("Add_C_Btn")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.FriendTipsList = ui:GetChild("FriendTipsList")
  uis.Search = GetFriends_SearchUis(ui:GetChild("Search"))
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.NothingTxt = ui:GetChild("NothingTxt")
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.NothingGrp = ui:GetChild("NothingGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


