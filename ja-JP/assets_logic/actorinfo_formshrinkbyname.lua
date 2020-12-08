-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_FormByName")
GetActorInfo_FormShrinkUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Form = GetActorInfo_FormUis(ui:GetChild("Form"))
  uis.ShrinkBtn = ui:GetChild("ShrinkBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.ScreenShotCtr = ui:GetController("ScreenShot")
  uis.root = ui
  return uis
end


