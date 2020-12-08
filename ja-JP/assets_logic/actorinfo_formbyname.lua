-- params : ...
-- function num : 0 , upvalues : _ENV
GetActorInfo_FormUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_02_Image = ui:GetChild("Decorate_02_Image")
  uis.ContentList = ui:GetChild("ContentList")
  uis.root = ui
  return uis
end


