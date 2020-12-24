-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_PlayerHeadByName")
require("Guild_OneSelfChatWordByName")
require("CommonResource_HeadFrameLoaderByName")
GetGuild_OneSelfChatUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.OneSelfGrp = GetGuild_PlayerHeadUis(ui:GetChild("OneSelfGrp"))
  uis.OneSelfChatWordGrp = GetGuild_OneSelfChatWordUis(ui:GetChild("OneSelfChatWordGrp"))
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.HeadFrameLoader = GetCommonResource_HeadFrameLoaderUis(ui:GetChild("HeadFrameLoader"))
  uis.root = ui
  return uis
end


