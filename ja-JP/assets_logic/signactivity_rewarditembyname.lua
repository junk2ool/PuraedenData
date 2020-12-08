-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("CommonResource_AllItemIconByName")
GetSignActivity_RewardItemUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.FrameEff = GetCommonResource_FrameEffUis(ui:GetChild("FrameEff"))
  uis.Item = GetCommonResource_AllItemIconUis(ui:GetChild("Item"))
  uis.DayTxt = ui:GetChild("DayTxt")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


