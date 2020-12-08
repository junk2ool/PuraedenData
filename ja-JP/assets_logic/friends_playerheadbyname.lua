-- params : ...
-- function num : 0 , upvalues : _ENV
GetFriends_PlayerHeadUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Head_02_Image = ui:GetChild("Head_02_Image")
  uis.ActorHeadLoader = ui:GetChild("ActorHeadLoader")
  uis.root = ui
  return uis
end


