-- params : ...
-- function num : 0 , upvalues : _ENV
GetLotteryIntegral_RewardItemUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.IconLoader = ui:GetChild("IconLoader")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.ItemNumberTxt = ui:GetChild("ItemNumberTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


