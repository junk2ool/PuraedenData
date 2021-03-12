-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_ShopTipsByName")
GetRelic_ShopTipsAnimationUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ShopTips = GetRelic_ShopTipsUis(ui:GetChild("ShopTips"))
  uis.root = ui
  return uis
end


