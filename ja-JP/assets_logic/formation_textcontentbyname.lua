-- params : ...
-- function num : 0 , upvalues : _ENV
GetFormation_TextContentUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.ContentTxt = ui:GetChild("ContentTxt")
  uis.TabImage = ui:GetChild("TabImage")
  uis.root = ui
  return uis
end


