-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_ExtendByName")
require("Family_HemmingByName")
GetFamily_CurrencyUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Extend = GetFamily_ExtendUis(ui:GetChild("Extend"))
  uis.Hemming = GetFamily_HemmingUis(ui:GetChild("Hemming"))
  uis.root = ui
  return uis
end


