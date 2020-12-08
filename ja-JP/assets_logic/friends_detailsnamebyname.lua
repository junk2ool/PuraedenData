-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_TipsInfoByName")
GetFriends_DetailsNameUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.Guild = GetFriends_TipsInfoUis(ui:GetChild("Guild"))
  uis.Battle = GetFriends_TipsInfoUis(ui:GetChild("Battle"))
  uis.PlayerID = GetFriends_TipsInfoUis(ui:GetChild("PlayerID"))
  uis.CopyBtn = ui:GetChild("CopyBtn")
  uis.root = ui
  return uis
end


