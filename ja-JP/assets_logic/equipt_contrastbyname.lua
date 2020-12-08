-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_ProgrammeInfoByName")
GetEquipt_ContrastUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.ProgrammeInfo_A = GetEquipt_ProgrammeInfoUis(ui:GetChild("ProgrammeInfo_A"))
  uis.ProgrammeInfo_B = GetEquipt_ProgrammeInfoUis(ui:GetChild("ProgrammeInfo_B"))
  uis.Nothing_01_Image = ui:GetChild("Nothing_01_Image")
  uis.NothingTxt = ui:GetChild("NothingTxt")
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.NothingGrp = ui:GetChild("NothingGrp")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


