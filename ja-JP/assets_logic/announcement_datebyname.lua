-- params : ...
-- function num : 0 , upvalues : _ENV
GetAnnouncement_DateUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.DateTxt = ui:GetChild("DateTxt")
  uis.root = ui
  return uis
end


