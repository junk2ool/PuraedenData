-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_03ByName")
require("CommonResource_HeadFrameByName")
GetEquipt_ProgrammeInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.BattleTxt = ui:GetChild("BattleTxt")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.InfoList = ui:GetChild("InfoList")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


