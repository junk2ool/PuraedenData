-- params : ...
-- function num : 0 , upvalues : _ENV
GetSignActivity_RewardUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.RewardList = ui:GetChild("RewardList")
  uis.root = ui
  return uis
end


