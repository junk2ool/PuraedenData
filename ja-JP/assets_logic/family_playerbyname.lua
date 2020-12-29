-- params : ...
-- function num : 0 , upvalues : _ENV
require("Family_BattleInfoByName")
require("Family_PlayerHeadByName")
require("Title_TitlePicByName")
GetFamily_PlayerUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.BattleInfo = GetFamily_BattleInfoUis(ui:GetChild("BattleInfo"))
  uis.VisitBtn = ui:GetChild("VisitBtn")
  uis.PlayerHead = GetFamily_PlayerHeadUis(ui:GetChild("PlayerHead"))
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.root = ui
  return uis
end


