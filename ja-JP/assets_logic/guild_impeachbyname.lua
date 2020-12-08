-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_ImpeachTipsByName")
require("CommonResource_Line_03ByName")
GetGuild_ImpeachUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Tips_A = GetGuild_ImpeachTipsUis(ui:GetChild("Tips_A"))
  uis.Tips_B = GetGuild_ImpeachTipsUis(ui:GetChild("Tips_B"))
  uis.n14 = GetCommonResource_Line_03Uis(ui:GetChild("n14"))
  uis.NameWordTxt = ui:GetChild("NameWordTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.BattleOutBtn = ui:GetChild("BattleOutBtn")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


