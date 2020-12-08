-- params : ...
-- function num : 0 , upvalues : _ENV
require("Birthday_BirthdayMainByName")
GetBirthday_BirthdayMainWindowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BirthdayMain = GetBirthday_BirthdayMainUis(ui:GetChild("BirthdayMain"))
  uis.root = ui
  return uis
end


