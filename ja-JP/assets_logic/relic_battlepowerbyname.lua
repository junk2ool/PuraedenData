-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
GetRelic_BattlePowerUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = GetCommonResource_Base_01Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Base_02Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.mycombatTxt = ui:GetChild("mycombatTxt")
  uis.mycombatnumberTxt = ui:GetChild("mycombatnumberTxt")
  uis.root = ui
  return uis
end


