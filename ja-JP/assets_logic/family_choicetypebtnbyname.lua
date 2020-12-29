-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_ChoiceTypeBtnBgByName")
GetFamily_ChoiceTypeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceTypeBtnBg = GetFamily_ChoiceTypeBtnBgUis(ui:GetChild("ChoiceTypeBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


