-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_04ByName")
require("ActorInfo_ActorHeadByName")
GetActorInfo_HeadFrameInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BagWindowImage = ui:GetChild("BagWindowImage")
  uis.n4 = GetCommonResource_Line_04Uis(ui:GetChild("n4"))
  uis.FrameNameTxt = ui:GetChild("FrameNameTxt")
  uis.UnLockTxt = ui:GetChild("UnLockTxt")
  uis.UnLockWordTxt = ui:GetChild("UnLockWordTxt")
  uis.ActorHead = GetActorInfo_ActorHeadUis(ui:GetChild("ActorHead"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


