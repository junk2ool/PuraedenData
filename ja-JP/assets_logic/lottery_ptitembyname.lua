-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_CardShowByName")
require("Lottery_BuyNumberByName")
GetLottery_PtItemUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardShow = GetLottery_CardShowUis(ui:GetChild("CardShow"))
  uis.PtBackImage = ui:GetChild("PtBackImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.BuyNumber = GetLottery_BuyNumberUis(ui:GetChild("BuyNumber"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


