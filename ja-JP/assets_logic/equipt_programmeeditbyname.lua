-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
require("CommonResource_Line_03ByName")
GetEquipt_ProgrammeEditUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.BattleTxt = ui:GetChild("BattleTxt")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.NameBtn = ui:GetChild("NameBtn")
  uis.InfoList = ui:GetChild("InfoList")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


