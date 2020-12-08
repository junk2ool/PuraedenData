-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
GetGuildBoss_AllBossTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.AllBossList = ui:GetChild("AllBossList")
  uis.root = ui
  return uis
end


