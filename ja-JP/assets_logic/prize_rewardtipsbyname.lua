-- params : ...
-- function num : 0 , upvalues : _ENV
require("Prize_RewardByName")
GetPrize_RewardTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Reward = GetPrize_RewardUis(ui:GetChild("Reward"))
  uis.root = ui
  return uis
end


