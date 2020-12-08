-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_WordUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.ScreenShotCtr = ui:GetController("ScreenShot")
  uis.root = ui
  return uis
end


