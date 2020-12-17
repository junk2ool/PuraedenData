-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_ImprintSkillLineByName")
GetCard_ImprintMapUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.MapLoader = ui:GetChild("MapLoader")
  uis.Line1 = GetCard_ImprintSkillLineUis(ui:GetChild("Line1"))
  uis.Line2 = GetCard_ImprintSkillLineUis(ui:GetChild("Line2"))
  uis.Line3 = GetCard_ImprintSkillLineUis(ui:GetChild("Line3"))
  uis.Line4 = GetCard_ImprintSkillLineUis(ui:GetChild("Line4"))
  uis.ImprintSkill_1_Btn = ui:GetChild("ImprintSkill_1_Btn")
  uis.ImprintSkill_2_Btn = ui:GetChild("ImprintSkill_2_Btn")
  uis.ImprintSkill_3_Btn = ui:GetChild("ImprintSkill_3_Btn")
  uis.ImprintSkill_4_Btn = ui:GetChild("ImprintSkill_4_Btn")
  uis.ImprintSkill_5_Btn = ui:GetChild("ImprintSkill_5_Btn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


