-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_PlayerHeadByName")
require("Guild_OtherChatWordByName")
require("CommonResource_HeadFrameLoaderByName")
require("Guild_ChatStatusByName")
GetGuild_OtherChatUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.OtherPlayerGrp = GetGuild_PlayerHeadUis(ui:GetChild("OtherPlayerGrp"))
  uis.OtherChatWordGrp = GetGuild_OtherChatWordUis(ui:GetChild("OtherChatWordGrp"))
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.HeadFrameLoader = GetCommonResource_HeadFrameLoaderUis(ui:GetChild("HeadFrameLoader"))
  uis.ChatStatus = GetGuild_ChatStatusUis(ui:GetChild("ChatStatus"))
  uis.root = ui
  return uis
end


