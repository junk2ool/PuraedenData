-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_TypeBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


