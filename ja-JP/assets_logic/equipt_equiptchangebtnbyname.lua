-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_EquiptChangeBtnBgByName")
GetEquipt_EquiptChangeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.EquiptChangeBtnBg = GetEquipt_EquiptChangeBtnBgUis(ui:GetChild("EquiptChangeBtnBg"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


