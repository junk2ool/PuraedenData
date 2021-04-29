-- params : ...
-- function num : 0 , upvalues : _ENV
GetActivityReturn_TimeWordUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.root = ui
  return uis
end


