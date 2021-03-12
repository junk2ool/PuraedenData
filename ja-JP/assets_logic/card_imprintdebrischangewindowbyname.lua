-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_Popup_SByName")
require("Card_ImprintDebrisChangeByName")
GetCard_ImprintDebrisChangeWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_S = GetCommonResource_Popup_SUis(ui:GetChild("Popup_S"))
  uis.ImprintDebrisChange = GetCard_ImprintDebrisChangeUis(ui:GetChild("ImprintDebrisChange"))
  uis.root = ui
  return uis
end


