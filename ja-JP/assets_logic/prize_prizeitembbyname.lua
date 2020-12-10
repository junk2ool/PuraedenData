-- params : ...
-- function num : 0 , upvalues : _ENV
require("Prize_ChoiceEffectByName")
GetPrize_PrizeItemBUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ChoiceEffect = GetPrize_ChoiceEffectUis(ui:GetChild("ChoiceEffect"))
  uis.ItemLoader = ui:GetChild("ItemLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


