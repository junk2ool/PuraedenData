-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_ShopTipsByName")
GetActivityDungeonTwo_ShopTipsAnimationUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ShopTips = GetActivityDungeonTwo_ShopTipsUis(ui:GetChild("ShopTips"))
  uis.root = ui
  return uis
end


