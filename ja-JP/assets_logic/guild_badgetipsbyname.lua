-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_FrameEffByName")
require("Guild_GuildIconByName")
GetGuild_BadgeTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.FrameEffGrp = GetCommonResource_FrameEffUis(ui:GetChild("FrameEffGrp"))
  uis.GuildIconGrp = GetGuild_GuildIconUis(ui:GetChild("GuildIconGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


