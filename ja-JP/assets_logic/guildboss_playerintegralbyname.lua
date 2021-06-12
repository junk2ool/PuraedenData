-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("CommonResource_HeadFrameByName")
GetGuildBoss_PlayerIntegralUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.IntegralNumberTxt = ui:GetChild("IntegralNumberTxt")
  uis.TipsBtn = ui:GetChild("TipsBtn")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


