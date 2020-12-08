-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_EquiptInfoByName")
GetEquipt_Info_BUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.EquiptIcon_A = GetEquipt_EquiptInfoUis(ui:GetChild("EquiptIcon_A"))
  uis.EquiptIcon_B = GetEquipt_EquiptInfoUis(ui:GetChild("EquiptIcon_B"))
  uis.EquiptIcon_C = GetEquipt_EquiptInfoUis(ui:GetChild("EquiptIcon_C"))
  uis.EquiptIcon_D = GetEquipt_EquiptInfoUis(ui:GetChild("EquiptIcon_D"))
  uis.root = ui
  return uis
end


