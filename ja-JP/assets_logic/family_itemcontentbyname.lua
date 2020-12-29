-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_ItemFrameByName")
require("CommonResource_NewCompByName")
GetFamily_ItemContentUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ItemFrame = GetCommonResource_ItemFrameUis(ui:GetChild("ItemFrame"))
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.NewCompGrp = GetCommonResource_NewCompUis(ui:GetChild("NewCompGrp"))
  uis.UseImage = ui:GetChild("UseImage")
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


