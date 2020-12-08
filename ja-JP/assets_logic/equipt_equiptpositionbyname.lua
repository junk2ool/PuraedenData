-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetEquipt_EquiptPositionUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.NecklaceBtn = ui:GetChild("NecklaceBtn")
  uis.RingBtn = ui:GetChild("RingBtn")
  uis.WeaponBtn = ui:GetChild("WeaponBtn")
  uis.ClothesBtn = ui:GetChild("ClothesBtn")
  uis.root = ui
  return uis
end


