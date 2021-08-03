-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_ReturnPicByName")
GetTower_ReturnBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ReturnPic = GetTower_ReturnPicUis(ui:GetChild("ReturnPic"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


