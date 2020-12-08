-- params : ...
-- function num : 0 , upvalues : _ENV
require("Birthday_shadowByName")
GetBirthday_CardImgUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.shadow = GetBirthday_shadowUis(ui:GetChild("shadow"))
  uis.CardLoader = ui:GetChild("CardLoader")
  uis.root = ui
  return uis
end


