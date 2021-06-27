-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_TipsByName")
GetActivityDungeonTwo_HelpListUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.PlayerList = ui:GetChild("PlayerList")
  uis.Tips = GetActivityDungeonTwo_TipsUis(ui:GetChild("Tips"))
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.TouchNumberTxt = ui:GetChild("TouchNumberTxt")
  uis.root = ui
  return uis
end


