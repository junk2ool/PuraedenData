-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_AddHeadByName")
require("Friends_TipsInfoByName")
GetFriends_PlayerInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AddHead = GetFriends_AddHeadUis(ui:GetChild("AddHead"))
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.Guild = GetFriends_TipsInfoUis(ui:GetChild("Guild"))
  uis.Battle = GetFriends_TipsInfoUis(ui:GetChild("Battle"))
  uis.A_Btn = ui:GetChild("A_Btn")
  uis.B_Btn = ui:GetChild("B_Btn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


