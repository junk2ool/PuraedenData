-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_ChoiceBtnBgByName")
GetGuild_ChoiceBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceBtnBg = GetGuild_ChoiceBtnBgUis(ui:GetChild("ChoiceBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


