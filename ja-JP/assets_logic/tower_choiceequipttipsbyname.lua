-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_ReturnEquiptTipsByName")
GetTower_ChoiceEquiptTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.ReturnEquiptTips = GetTower_ReturnEquiptTipsUis(ui:GetChild("ReturnEquiptTips"))
  uis.root = ui
  return uis
end


