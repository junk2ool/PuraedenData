-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_AddBtnBgByName")
require("CommonResource_RedDollByName")
GetFriends_AddBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AddBtnBg = GetFriends_AddBtnBgUis(ui:GetChild("AddBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


