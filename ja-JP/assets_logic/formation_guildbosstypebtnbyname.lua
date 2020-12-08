-- params : ...
-- function num : 0 , upvalues : _ENV
require("Formation_GuildBossTypeBtnBgByName")
GetFormation_GuildBossTypeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.GuildBossTypeBtnBg = GetFormation_GuildBossTypeBtnBgUis(ui:GetChild("GuildBossTypeBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


