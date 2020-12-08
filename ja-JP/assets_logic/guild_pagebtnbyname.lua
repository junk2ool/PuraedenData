-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_PageBtnBgByName")
require("CommonResource_RedDollByName")
GetGuild_PageBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PageBtnBg = GetGuild_PageBtnBgUis(ui:GetChild("PageBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


