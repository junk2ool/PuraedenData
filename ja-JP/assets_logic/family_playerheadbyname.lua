-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_PlayerHeadUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Head_02_Image = ui:GetChild("Head_02_Image")
  uis.ActorHeadLoader = ui:GetChild("ActorHeadLoader")
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.root = ui
  return uis
end


