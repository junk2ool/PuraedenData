-- params : ...
-- function num : 0 , upvalues : _ENV
require("Title_TitlePicByName")
GetActorInfo_Info_B_BtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.buttonCtr = ui:GetController("button")
  uis.ScreenShotCtr = ui:GetController("ScreenShot")
  uis.root = ui
  return uis
end


