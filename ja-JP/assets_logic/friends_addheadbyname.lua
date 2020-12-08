-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_OnLineByName")
GetFriends_AddHeadUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HeadLoader = ui:GetChild("HeadLoader")
  uis.OnLine = GetFriends_OnLineUis(ui:GetChild("OnLine"))
  uis.root = ui
  return uis
end


