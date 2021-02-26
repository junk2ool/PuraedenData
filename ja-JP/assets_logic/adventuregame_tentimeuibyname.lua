-- params : ...
-- function num : 0 , upvalues : _ENV
GetAdventureGame_TenTimeUIUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.titlenameTxt = ui:GetChild("titlenameTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.EventList = ui:GetChild("EventList")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.GoldBackImage = ui:GetChild("GoldBackImage")
  uis.SpendLoader = ui:GetChild("SpendLoader")
  uis.SpendTxt = ui:GetChild("SpendTxt")
  uis.root = ui
  return uis
end


