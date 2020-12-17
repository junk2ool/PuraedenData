-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_ContentListAByName")
require("ActorInfo_ContentListBByName")
GetActorInfo_FormUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.ContentListA = GetActorInfo_ContentListAUis(ui:GetChild("ContentListA"))
  uis.ContentListB = GetActorInfo_ContentListBUis(ui:GetChild("ContentListB"))
  uis.ScreenShotCtr = ui:GetController("ScreenShot")
  uis.root = ui
  return uis
end


