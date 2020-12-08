-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_HeadFrameInfoByName")
require("ActorInfo_HeadFrameChoiceByName")
GetActorInfo_HeadChoiceUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HeadChoiceTxt = ui:GetChild("HeadChoiceTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.HeadFrameInfo = GetActorInfo_HeadFrameInfoUis(ui:GetChild("HeadFrameInfo"))
  uis.HeadFrameChoice = GetActorInfo_HeadFrameChoiceUis(ui:GetChild("HeadFrameChoice"))
  uis.root = ui
  return uis
end


