-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_PlayerHpProgressFillByName")
GetActivityDungeonTwo_PlayerHpProgressBarUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.bar = GetActivityDungeonTwo_PlayerHpProgressFillUis(ui:GetChild("bar"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.root = ui
  return uis
end


