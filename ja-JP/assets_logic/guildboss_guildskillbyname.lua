-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("GuildBoss_SkillNumberByName")
require("GuildBoss_SkillUpByName")
require("GuildBoss_SkillTreeByName")
GetGuildBoss_GuildSkillUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.SkillNumber = GetGuildBoss_SkillNumberUis(ui:GetChild("SkillNumber"))
  uis.SkillUp = GetGuildBoss_SkillUpUis(ui:GetChild("SkillUp"))
  uis.SkillTree = GetGuildBoss_SkillTreeUis(ui:GetChild("SkillTree"))
  uis.root = ui
  return uis
end

