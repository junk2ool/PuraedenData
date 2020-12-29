-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_CurrencyByName")
GetFamily_CurrencyBaseUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Currency = GetFamily_CurrencyUis(ui:GetChild("Currency"))
  uis.root = ui
  return uis
end


