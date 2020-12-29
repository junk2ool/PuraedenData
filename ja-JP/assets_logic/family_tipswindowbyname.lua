-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_TipsByName")
GetFamily_TipsWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Tips = GetFamily_TipsUis(ui:GetChild("Tips"))
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


