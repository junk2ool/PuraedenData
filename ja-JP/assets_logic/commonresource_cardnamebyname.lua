-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_CardNameUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.CardTxt = ui:GetChild("CardTxt")
  uis.CVTxt = ui:GetChild("CVTxt")
  uis.CVImage = ui:GetChild("CVImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


