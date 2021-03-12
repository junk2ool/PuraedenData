-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Base_01ByName")
require("CommonResource_Base_02ByName")
GetRelic_BattleSpendUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = GetCommonResource_Base_01Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = GetCommonResource_Base_02Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.vitalityTxt = ui:GetChild("vitalityTxt")
  uis.vitalitynumberTxt = ui:GetChild("vitalitynumberTxt")
  uis.vitalitynumber_01_Txt = ui:GetChild("vitalitynumber_01_Txt")
  uis.root = ui
  return uis
end


