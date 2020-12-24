-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameLoaderByName")
GetGuild_PlayerHeadUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Head_02_Image = ui:GetChild("Head_02_Image")
  uis.ActorHeadLoader = ui:GetChild("ActorHeadLoader")
  uis.HeadFrameLoader = GetCommonResource_HeadFrameLoaderUis(ui:GetChild("HeadFrameLoader"))
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.TouchBtn = ui:GetChild("TouchBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


