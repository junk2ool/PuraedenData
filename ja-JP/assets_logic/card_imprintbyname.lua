-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_ImprintMapByName")
require("Card_SpendByName")
GetCard_ImprintUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ImprintMap = GetCard_ImprintMapUis(ui:GetChild("ImprintMap"))
  uis.SpendA = GetCard_SpendUis(ui:GetChild("SpendA"))
  uis.SpendB = GetCard_SpendUis(ui:GetChild("SpendB"))
  uis.ImprintUpBtn = ui:GetChild("ImprintUpBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


