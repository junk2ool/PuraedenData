-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("CommonResource_RedDollByName")
GetActivityDungeonTwo_ExploreBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Choice = GetCommonResource_FrameEffUis(ui:GetChild("Choice"))
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.Box = GetCommonResource_RedDollUis(ui:GetChild("Box"))
  uis.ExploreNameTxt = ui:GetChild("ExploreNameTxt")
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


