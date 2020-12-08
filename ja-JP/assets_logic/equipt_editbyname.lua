-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_ProgrammeEditByName")
GetEquipt_EditUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.ProgrammeEdit = GetEquipt_ProgrammeEditUis(ui:GetChild("ProgrammeEdit"))
  uis.root = ui
  return uis
end


