-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("CommonResource_HeadFrameByName")
require("CommonResource_EquiptPlanByName")
GetEquipt_ProgrammeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.FrameEff = GetCommonResource_FrameEffUis(ui:GetChild("FrameEff"))
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.EquiptPlan = GetCommonResource_EquiptPlanUis(ui:GetChild("EquiptPlan"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.PlanCtr = ui:GetController("Plan")
  uis.root = ui
  return uis
end


