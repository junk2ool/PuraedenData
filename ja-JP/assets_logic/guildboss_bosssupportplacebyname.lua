-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
require("CommonResource_Line_03ByName")
GetGuildBoss_BossSupportPlaceUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceTxt = ui:GetChild("ChoiceTxt")
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.Line = GetCommonResource_Line_03Uis(ui:GetChild("Line"))
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.BattleWordTxt = ui:GetChild("BattleWordTxt")
  uis.BattleNumberTxt = ui:GetChild("BattleNumberTxt")
  uis.EquiptList = ui:GetChild("EquiptList")
  uis.CancelBtn = ui:GetChild("CancelBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


