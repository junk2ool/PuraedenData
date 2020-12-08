-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_BuyNumberUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.titilenameTxt = ui:GetChild("titilenameTxt")
  uis.Word_01_Txt = ui:GetChild("Word_01_Txt")
  uis.DiamondBackImage = ui:GetChild("DiamondBackImage")
  uis.DiamondWordTxt = ui:GetChild("DiamondWordTxt")
  uis.DiamondLoader = ui:GetChild("DiamondLoader")
  uis.DiamondTxt = ui:GetChild("DiamondTxt")
  uis.DiamondGrp = ui:GetChild("DiamondGrp")
  uis.BuyBtn = ui:GetChild("BuyBtn")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.ChangeNumberTxt = ui:GetChild("ChangeNumberTxt")
  uis.ReduceBtn = ui:GetChild("ReduceBtn")
  uis.AddBtn = ui:GetChild("AddBtn")
  uis.MaxBtn = ui:GetChild("MaxBtn")
  uis.root = ui
  return uis
end


