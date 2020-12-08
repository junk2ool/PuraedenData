-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_HeadFrameByName")
GetCommonResource_GuildBossHeadUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.HeadFrameGrp = GetCommonResource_HeadFrameUis(ui:GetChild("HeadFrameGrp"))
  uis.Decorate_04_Image = ui:GetChild("Decorate_04_Image")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.root = ui
  return uis
end


