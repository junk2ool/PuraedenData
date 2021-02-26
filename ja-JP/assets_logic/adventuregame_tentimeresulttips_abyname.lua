-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetAdventureGame_TenTimeResultTips_AUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.n59 = GetCommonResource_Line_03Uis(ui:GetChild("n59"))
  uis.ItemList = ui:GetChild("ItemList")
  uis.root = ui
  return uis
end


