-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_PushSetUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.PushTipsList = ui:GetChild("PushTipsList")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.ExplainTxt = ui:GetChild("ExplainTxt")
  uis.root = ui
  return uis
end


