-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_ListChoiceByName")
require("ActorInfo_FormShrinkByName")
require("ActorInfo_CothesByName")
GetActorInfo_PlayerCardUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundLoader = ui:GetChild("BackgroundLoader")
  uis.ShowLoader = ui:GetChild("ShowLoader")
  uis.ListChoice = GetActorInfo_ListChoiceUis(ui:GetChild("ListChoice"))
  uis.FormShrink = GetActorInfo_FormShrinkUis(ui:GetChild("FormShrink"))
  uis.Cothes_A_Btn = GetActorInfo_CothesUis(ui:GetChild("Cothes_A_Btn"))
  uis.LookBtn = ui:GetChild("LookBtn")
  uis.OutBtn = ui:GetChild("OutBtn")
  uis.ScreenBtn = ui:GetChild("ScreenBtn")
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.ScreenShotCtr = ui:GetController("ScreenShot")
  uis.root = ui
  return uis
end


