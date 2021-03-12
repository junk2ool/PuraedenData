-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_SkillChoiceByName")
require("Card_ImprintProgressByName")
require("Card_ClickTipsByName")
GetCard_ImprintSkillUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.SkillChoice = GetCard_SkillChoiceUis(ui:GetChild("SkillChoice"))
  uis.ImprintSkillLoader = ui:GetChild("ImprintSkillLoader")
  uis.ImprintProgress = GetCard_ImprintProgressUis(ui:GetChild("ImprintProgress"))
  uis.ClickTips = GetCard_ClickTipsUis(ui:GetChild("ClickTips"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


