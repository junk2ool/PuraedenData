-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_HeadFrameChoiceUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.HeadBtn = ui:GetChild("HeadBtn")
  uis.FrameBtn = ui:GetChild("FrameBtn")
  uis.HeadList = ui:GetChild("HeadList")
  uis.FrameList = ui:GetChild("FrameList")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


