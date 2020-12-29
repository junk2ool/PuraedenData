-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_VisitChangeBtnBgByName")
require("CommonResource_RedDollByName")
GetFamily_VisitChangeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.VisitChangeBtnBg = GetFamily_VisitChangeBtnBgUis(ui:GetChild("VisitChangeBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


