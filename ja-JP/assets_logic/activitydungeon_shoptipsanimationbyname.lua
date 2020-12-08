-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_ShopTipsByName")
GetActivityDungeon_ShopTipsAnimationUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ShopTips = GetActivityDungeon_ShopTipsUis(ui:GetChild("ShopTips"))
  uis.root = ui
  return uis
end


