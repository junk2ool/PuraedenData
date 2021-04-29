-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityReturn_DayTimeBtnBgByName")
GetActivityReturn_DayTimeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.DayTimeBtnBg = GetActivityReturn_DayTimeBtnBgUis(ui:GetChild("DayTimeBtnBg"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


