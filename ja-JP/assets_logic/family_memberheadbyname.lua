-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
GetFamily_MemberHeadUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HeadFrame = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrame"))
  uis.AImage = ui:GetChild("AImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


