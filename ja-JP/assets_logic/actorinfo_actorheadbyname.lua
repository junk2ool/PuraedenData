-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameLoaderByName")
require("CommonResource_RedDollByName")
GetActorInfo_ActorHeadUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ActorHeadLoader = ui:GetChild("ActorHeadLoader")
  uis.HeadFrameLoader = GetCommonResource_HeadFrameLoaderUis(ui:GetChild("HeadFrameLoader"))
  uis.RedDollGrp = GetCommonResource_RedDollUis(ui:GetChild("RedDollGrp"))
  uis.HeadBtn = ui:GetChild("HeadBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.lockCtr = ui:GetController("lock")
  uis.root = ui
  return uis
end


