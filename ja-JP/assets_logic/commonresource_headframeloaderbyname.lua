-- params : ...
-- function num : 0 , upvalues : _ENV
GetCommonResource_HeadFrameLoaderUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.HeadFrameLoader = ui:GetChild("HeadFrameLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.lockCtr = ui:GetController("lock")
  uis.root = ui
  return uis
end


