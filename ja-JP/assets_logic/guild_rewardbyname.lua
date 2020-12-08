-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuild_RewardUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Spend_01_Loader = ui:GetChild("Spend_01_Loader")
  uis.SpendTxt = ui:GetChild("SpendTxt")
  uis.root = ui
  return uis
end


