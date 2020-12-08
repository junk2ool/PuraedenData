-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_BigRewardUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BigRewardLoader = ui:GetChild("BigRewardLoader")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


