-- params : ...
-- function num : 0 , upvalues : _ENV
require("Birthday_Assembly_02ByName")
require("Birthday_Assembly_01ByName")
require("Birthday_CardImgByName")
require("Birthday_Assembly_03ByName")
require("Birthday_Assembly_04ByName")
require("Birthday_Assembly_05ByName")
GetBirthday_BirthdayMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BgCardLoader = ui:GetChild("BgCardLoader")
  uis.Assembly_02 = GetBirthday_Assembly_02Uis(ui:GetChild("Assembly_02"))
  uis.Assembly_01 = GetBirthday_Assembly_01Uis(ui:GetChild("Assembly_01"))
  uis.CardImg = GetBirthday_CardImgUis(ui:GetChild("CardImg"))
  uis.Assembly_03 = GetBirthday_Assembly_03Uis(ui:GetChild("Assembly_03"))
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.Assembly_04 = GetBirthday_Assembly_04Uis(ui:GetChild("Assembly_04"))
  uis.TouchBtn = ui:GetChild("TouchBtn")
  uis.Assembly_05 = GetBirthday_Assembly_05Uis(ui:GetChild("Assembly_05"))
  uis.root = ui
  return uis
end


