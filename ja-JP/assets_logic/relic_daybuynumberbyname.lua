-- params : ...
-- function num : 0 , upvalues : _ENV
GetRelic_DayBuyNumberUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.DayBuyNumberTxt = ui:GetChild("DayBuyNumberTxt")
  uis.root = ui
  return uis
end


