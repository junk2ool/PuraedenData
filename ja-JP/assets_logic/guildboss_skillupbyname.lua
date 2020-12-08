-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("GuildBoss_SkillByName")
require("GuildBoss_SkillWordByName")
require("GuildBoss_SpendByName")
GetGuildBoss_SkillUpUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.SkilI = GetGuildBoss_SkillUis(ui:GetChild("SkilI"))
  uis.MaxImage = ui:GetChild("MaxImage")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.LvTxt = ui:GetChild("LvTxt")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.SkillWordA = GetGuildBoss_SkillWordUis(ui:GetChild("SkillWordA"))
  uis.SkillWordB = GetGuildBoss_SkillWordUis(ui:GetChild("SkillWordB"))
  uis.Spend = GetGuildBoss_SpendUis(ui:GetChild("Spend"))
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


