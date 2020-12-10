-- params : ...
-- function num : 0 , upvalues : _ENV
GetPrize_SkipUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.SkipBtn = ui:GetChild("SkipBtn")
  uis.SkipTxt = ui:GetChild("SkipTxt")
  uis.root = ui
  return uis
end


