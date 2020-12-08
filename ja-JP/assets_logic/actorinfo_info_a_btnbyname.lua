-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_Info_A_BtnUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.ScreenShotCtr = ui:GetController("ScreenShot")
  uis.root = ui
  return uis
end


