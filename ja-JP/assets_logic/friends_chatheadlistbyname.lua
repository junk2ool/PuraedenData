-- params : ...
-- function num : 0 , upvalues : _ENV
GetFriends_ChatHeadListUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ChatHeadList = ui:GetChild("ChatHeadList")
  uis.root = ui
  return uis
end


