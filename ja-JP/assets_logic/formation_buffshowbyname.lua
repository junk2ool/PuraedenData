-- params : ...
-- function num : 0 , upvalues : _ENV
require("Formation_TitleByName")
GetFormation_BuffShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Title = GetFormation_TitleUis(ui:GetChild("Title"))
  uis.BuffList = ui:GetChild("BuffList")
  uis.root = ui
  return uis
end


