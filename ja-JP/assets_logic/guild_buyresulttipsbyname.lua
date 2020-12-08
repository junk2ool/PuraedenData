-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_BuyResultTipsUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.ItemList = ui:GetChild("ItemList")
  uis.root = ui
  return uis
end


