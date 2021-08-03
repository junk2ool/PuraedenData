-- params : ...
-- function num : 0 , upvalues : _ENV
GetTower_EquiptTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.EquiptLoader = ui:GetChild("EquiptLoader")
  uis.EquiptNameTxt = ui:GetChild("EquiptNameTxt")
  uis.AttributeList = ui:GetChild("AttributeList")
  uis.root = ui
  return uis
end


