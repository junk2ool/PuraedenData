-- params : ...
-- function num : 0 , upvalues : _ENV
require("Bag_ChoiceBtnBgByName")
require("CommonResource_RedDollByName")
GetBag_ChoiceBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceBtnBg = GetBag_ChoiceBtnBgUis(ui:GetChild("ChoiceBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end

