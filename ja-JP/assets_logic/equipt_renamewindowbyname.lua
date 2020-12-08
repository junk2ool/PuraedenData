-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
require("CommonResource_Popup_SByName")
require("Equipt_ReNameByName")
GetEquipt_ReNameWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.Popup_S = GetCommonResource_Popup_SUis(ui:GetChild("Popup_S"))
  uis.ReNameGrp = GetEquipt_ReNameUis(ui:GetChild("ReNameGrp"))
  uis.root = ui
  return uis
end


