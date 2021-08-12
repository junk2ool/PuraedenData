-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_CurrencyByName")
GetFamily_CurrencyWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.Currency = GetFamily_CurrencyUis(ui:GetChild("Currency"))
  uis.root = ui
  return uis
end


