-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_SkillChoiceEffByName")
GetGuildBoss_SkillUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.SkillChoiceEff = GetGuildBoss_SkillChoiceEffUis(ui:GetChild("SkillChoiceEff"))
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


