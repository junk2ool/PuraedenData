-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_SwitchByName")
GetActorInfo_PushTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Content_01_Txt = ui:GetChild("Content_01_Txt")
  uis.Content_01_Grp = GetActorInfo_SwitchUis(ui:GetChild("Content_01_Grp"))
  uis.root = ui
  return uis
end


