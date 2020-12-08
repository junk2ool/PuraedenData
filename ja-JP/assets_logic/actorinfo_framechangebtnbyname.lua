-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_FrameChangeBtnBgByName")
require("CommonResource_RedDollByName")
GetActorInfo_FrameChangeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RewardChangeBtnBg = GetActorInfo_FrameChangeBtnBgUis(ui:GetChild("RewardChangeBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


