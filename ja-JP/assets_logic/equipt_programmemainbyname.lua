-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_ContrastByName")
require("Equipt_EditByName")
require("Equipt_ProgrammeListByName")
GetEquipt_ProgrammeMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Contrast = GetEquipt_ContrastUis(ui:GetChild("Contrast"))
  uis.Edit = GetEquipt_EditUis(ui:GetChild("Edit"))
  uis.ProgrammeList = GetEquipt_ProgrammeListUis(ui:GetChild("ProgrammeList"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


