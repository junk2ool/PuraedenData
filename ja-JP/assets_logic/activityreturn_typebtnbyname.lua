-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityReturn_TypeBtnBgByName")
require("CommonResource_RedDollByName")
GetActivityReturn_TypeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TypeBtnBg = GetActivityReturn_TypeBtnBgUis(ui:GetChild("TypeBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


