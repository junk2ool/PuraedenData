-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_PlayerHeadByName")
require("Title_TitlePicByName")
require("Family_BattleInfoByName")
GetFamily_PlayerInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlayerHead = GetFamily_PlayerHeadUis(ui:GetChild("PlayerHead"))
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.BattleInfo = GetFamily_BattleInfoUis(ui:GetChild("BattleInfo"))
  uis.ApplyBtn = ui:GetChild("ApplyBtn")
  uis.NextBtn = ui:GetChild("NextBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


