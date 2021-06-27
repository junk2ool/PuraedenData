-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_BattleInfoByName")
require("ActivityDungeonTwo_PlayerHeadByName")
require("Title_TitlePicByName")
GetActivityDungeonTwo_PlayerUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.BattleInfo = GetActivityDungeonTwo_BattleInfoUis(ui:GetChild("BattleInfo"))
  uis.PlayerHead = GetActivityDungeonTwo_PlayerHeadUis(ui:GetChild("PlayerHead"))
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.PlayerHpProgressBar = ui:GetChild("PlayerHpProgressBar")
  uis.BattleBtn = ui:GetChild("BattleBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


