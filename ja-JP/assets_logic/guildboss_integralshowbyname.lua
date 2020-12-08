-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("GuildBoss_PlayerIntegralByName")
GetGuildBoss_IntegralShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TalentTxt = ui:GetChild("TalentTxt")
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.ShrinkBtn = ui:GetChild("ShrinkBtn")
  uis.PlayerIntegral = GetGuildBoss_PlayerIntegralUis(ui:GetChild("PlayerIntegral"))
  uis.PlayerIntegralList = ui:GetChild("PlayerIntegralList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


