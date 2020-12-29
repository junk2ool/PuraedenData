-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_PlayerChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.FriendsBtn = ui:GetChild("FriendsBtn")
  uis.GuildBtn = ui:GetChild("GuildBtn")
  uis.PlayerList = ui:GetChild("PlayerList")
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.NothingTxt = ui:GetChild("NothingTxt")
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.NothingGrp = ui:GetChild("NothingGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


