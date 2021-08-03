-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_ThemePicByName")
GetTower_ThemeMainBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ThemePic = GetTower_ThemePicUis(ui:GetChild("ThemePic"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


