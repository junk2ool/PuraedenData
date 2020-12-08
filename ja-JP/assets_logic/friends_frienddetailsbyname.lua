-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_DetailsNameByName")
require("Friends_DetailsCardByName")
GetFriends_FriendDetailsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.DetailsName = GetFriends_DetailsNameUis(ui:GetChild("DetailsName"))
  uis.DetailsCard_1 = GetFriends_DetailsCardUis(ui:GetChild("DetailsCard_1"))
  uis.DetailsCard_2 = GetFriends_DetailsCardUis(ui:GetChild("DetailsCard_2"))
  uis.DetailsCard_3 = GetFriends_DetailsCardUis(ui:GetChild("DetailsCard_3"))
  uis.DetailsCard_4 = GetFriends_DetailsCardUis(ui:GetChild("DetailsCard_4"))
  uis.DetailsCard_5 = GetFriends_DetailsCardUis(ui:GetChild("DetailsCard_5"))
  uis.DetailsCard_6 = GetFriends_DetailsCardUis(ui:GetChild("DetailsCard_6"))
  uis.DeleteBtn = ui:GetChild("DeleteBtn")
  uis.BattleBtn = ui:GetChild("BattleBtn")
  uis.ChartBtn = ui:GetChild("ChartBtn")
  uis.root = ui
  return uis
end


