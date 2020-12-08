-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_PlayerHeadByName")
require("Friends_OneSelfChatWordByName")
GetFriends_OneSelfChatUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.OneSelfGrp = GetFriends_PlayerHeadUis(ui:GetChild("OneSelfGrp"))
  uis.OneSelfChatWordGrp = GetFriends_OneSelfChatWordUis(ui:GetChild("OneSelfChatWordGrp"))
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.root = ui
  return uis
end


