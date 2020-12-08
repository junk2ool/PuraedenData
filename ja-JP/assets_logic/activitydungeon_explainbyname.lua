-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniByName")
GetActivityDungeon_ExplainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniUis(ui:GetChild("BlackBgAni"))
  uis.LeftBtn = ui:GetChild("LeftBtn")
  uis.RightBtn = ui:GetChild("RightBtn")
  uis.PageNumberList = ui:GetChild("PageNumberList")
  uis.PicList = ui:GetChild("PicList")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.root = ui
  return uis
end


