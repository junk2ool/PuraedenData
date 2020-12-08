-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_NewsShowByName")
GetGuildBoss_BattleNewsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.NewsShow = GetGuildBoss_NewsShowUis(ui:GetChild("NewsShow"))
  uis.OtherGuildList = ui:GetChild("OtherGuildList")
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.root = ui
  return uis
end


