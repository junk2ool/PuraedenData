-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetGuildBoss_BossSupportRewardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.Word_02_Txt = ui:GetChild("Word_02_Txt")
  uis.Word_03_Txt = ui:GetChild("Word_03_Txt")
  uis.GetBtn = ui:GetChild("GetBtn")
  uis.ItemProgressBar = ui:GetChild("ItemProgressBar")
  uis.ItemNumberTxt = ui:GetChild("ItemNumberTxt")
  uis.root = ui
  return uis
end


