-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_BuySpendUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.RewardTxt = ui:GetChild("RewardTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.BuySpendList = ui:GetChild("BuySpendList")
  uis.SpendWordTxt = ui:GetChild("SpendWordTxt")
  uis.SpendItemLoader = ui:GetChild("SpendItemLoader")
  uis.SpendNumberTxt = ui:GetChild("SpendNumberTxt")
  uis.root = ui
  return uis
end


