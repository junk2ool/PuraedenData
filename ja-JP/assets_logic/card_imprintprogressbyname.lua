-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_ImprintProgressUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BackImage = ui:GetChild("BackImage")
  uis.ProgressTxt = ui:GetChild("ProgressTxt")
  uis.root = ui
  return uis
end


