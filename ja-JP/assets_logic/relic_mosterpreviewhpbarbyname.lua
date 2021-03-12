-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_MosterPreviewHpFillByName")
GetRelic_MosterPreviewHpBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetRelic_MosterPreviewHpFillUis(ui:GetChild("bar"))
  uis.root = ui
  return uis
end


