-- params : ...
-- function num : 0 , upvalues : _ENV
GetLottery_LuckBagBtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.Number_01_Loader = ui:GetChild("Number_01_Loader")
  uis.Number_01_Txt = ui:GetChild("Number_01_Txt")
  uis.Tips1Txt = ui:GetChild("Tips1Txt")
  uis.Tips2Txt = ui:GetChild("Tips2Txt")
  uis.Tips3Txt = ui:GetChild("Tips3Txt")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


