-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
GetGuild_ImpeachTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.n3 = GetCommonResource_Line_03Uis(ui:GetChild("n3"))
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.AProgressBar = ui:GetChild("AProgressBar")
  uis.BProgressBar = ui:GetChild("BProgressBar")
  uis.c2Ctr = ui:GetController("c2")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


