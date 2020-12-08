-- params : ...
-- function num : 0 , upvalues : _ENV
require("Home_ResourcesByName")
GetHome_HeadUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.FcWordTxt = ui:GetChild("FcWordTxt")
  uis.FcTxt = ui:GetChild("FcTxt")
  uis.ExpProgressBar = ui:GetChild("ExpProgressBar")
  uis.Gold = GetHome_ResourcesUis(ui:GetChild("Gold"))
  uis.Diamonds = GetHome_ResourcesUis(ui:GetChild("Diamonds"))
  uis.Power = GetHome_ResourcesUis(ui:GetChild("Power"))
  uis.ClothesCtr = ui:GetController("Clothes")
  uis.root = ui
  return uis
end


