-- params : ...
-- function num : 0 , upvalues : _ENV
GetHeroDungeon_SpeedSweepUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.RewardTxt = ui:GetChild("RewardTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.CardList = ui:GetChild("CardList")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.DefaultBtn = ui:GetChild("DefaultBtn")
  uis.DefaultTxt = ui:GetChild("DefaultTxt")
  uis.SpendImage = ui:GetChild("SpendImage")
  uis.IconImage = ui:GetChild("IconImage")
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.SpeedSweepBtn = ui:GetChild("SpeedSweepBtn")
  uis.root = ui
  return uis
end


