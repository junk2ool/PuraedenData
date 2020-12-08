-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_GuildIconByName")
require("Guild_TipsInfo_01ByName")
require("Guild_TipsInfo_02ByName")
require("Guild_TipsInfo_03ByName")
GetGuild_ApplyTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.GuildIconGrp = GetGuild_GuildIconUis(ui:GetChild("GuildIconGrp"))
  uis.GuildLevelTxt = ui:GetChild("GuildLevelTxt")
  uis.GuildNameTxt = ui:GetChild("GuildNameTxt")
  uis.ConditionTxt = ui:GetChild("ConditionTxt")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.JoinBtn = ui:GetChild("JoinBtn")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.MemberTxt = ui:GetChild("MemberTxt")
  uis.TipsInfo_01_Grp = GetGuild_TipsInfo_01Uis(ui:GetChild("TipsInfo_01_Grp"))
  uis.TipsInfo_03_Grp = GetGuild_TipsInfo_02Uis(ui:GetChild("TipsInfo_03_Grp"))
  uis.TipsInfo_04_Grp = GetGuild_TipsInfo_03Uis(ui:GetChild("TipsInfo_04_Grp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


