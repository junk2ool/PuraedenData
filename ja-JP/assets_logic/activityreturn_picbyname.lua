-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityReturn_PicUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.root = ui
  return uis
end


