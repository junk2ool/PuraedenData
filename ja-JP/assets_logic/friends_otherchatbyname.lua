-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_PlayerHeadByName")
require("Friends_OtherChatWordByName")
GetFriends_OtherChatUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.OtherPlayerGrp = GetFriends_PlayerHeadUis(ui:GetChild("OtherPlayerGrp"))
  uis.OtherChatWordGrp = GetFriends_OtherChatWordUis(ui:GetChild("OtherChatWordGrp"))
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.root = ui
  return uis
end


