-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetGuildBoss_PlayerIntegralUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.IntegralNumberTxt = ui:GetChild("IntegralNumberTxt")
  uis.TipsBtn = ui:GetChild("TipsBtn")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.root = ui
  return uis
end


