-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("Equipt_EquiptChangeBtnPanelByName")
GetEquipt_ProgrammeListUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.DecorateImage = GetCommonResource_Line_03Uis(ui:GetChild("DecorateImage"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.EquiptChangeBtnPanelGrp = GetEquipt_EquiptChangeBtnPanelUis(ui:GetChild("EquiptChangeBtnPanelGrp"))
  uis.CancelBtn = ui:GetChild("CancelBtn")
  uis.DelBtn = ui:GetChild("DelBtn")
  uis.KeepBtn = ui:GetChild("KeepBtn")
  uis.OrderBtn = ui:GetChild("OrderBtn")
  uis.EquiptList = ui:GetChild("EquiptList")
  uis.UseBtn = ui:GetChild("UseBtn")
  uis.EditBtn = ui:GetChild("EditBtn")
  uis.ProgrammeList = ui:GetChild("ProgrammeList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


