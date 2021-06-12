-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_TypeBtnBgByName")
GetGuildBoss_TypeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TypeBtnBg = GetGuildBoss_TypeBtnBgUis(ui:GetChild("TypeBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


