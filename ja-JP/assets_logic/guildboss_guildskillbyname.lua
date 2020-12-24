-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("GuildBoss_SkillUpByName")
require("GuildBoss_SkillTreeByName")
require("GuildBoss_SkillNumberByName")
GetGuildBoss_GuildSkillUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.SkillUp = GetGuildBoss_SkillUpUis(ui:GetChild("SkillUp"))
  uis.SkillTree = GetGuildBoss_SkillTreeUis(ui:GetChild("SkillTree"))
  uis.SkillNumber = GetGuildBoss_SkillNumberUis(ui:GetChild("SkillNumber"))
  uis.root = ui
  return uis
end


