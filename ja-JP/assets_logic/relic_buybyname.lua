-- params : ...
-- function num : 0 , upvalues : _ENV
GetRelic_BuyUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.ItemLoader = ui:GetChild("ItemLoader")
  uis.ItemNameTxt = ui:GetChild("ItemNameTxt")
  uis.ItemWordTxt = ui:GetChild("ItemWordTxt")
  uis.HaveNumber_01_Txt = ui:GetChild("HaveNumber_01_Txt")
  uis.HaveNumberTxt = ui:GetChild("HaveNumberTxt")
  uis.HaveNumberGrp = ui:GetChild("HaveNumberGrp")
  uis.GoldBackImage = ui:GetChild("GoldBackImage")
  uis.OneLoader = ui:GetChild("OneLoader")
  uis.OneTxt = ui:GetChild("OneTxt")
  uis.ReduceBtn = ui:GetChild("ReduceBtn")
  uis.AddBtn = ui:GetChild("AddBtn")
  uis.Add10Btn = ui:GetChild("Add10Btn")
  uis.MaxBtn = ui:GetChild("MaxBtn")
  uis.Decorate_22_Image = ui:GetChild("Decorate_22_Image")
  uis.ChangeNumberTxt = ui:GetChild("ChangeNumberTxt")
  uis.BuyNumberGrp = ui:GetChild("BuyNumberGrp")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.BuyBtn = ui:GetChild("BuyBtn")
  uis.BuyTipsMessageGrp = ui:GetChild("BuyTipsMessageGrp")
  uis.root = ui
  return uis
end


