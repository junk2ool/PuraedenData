-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_PlayerHeadByName")
require("CommonResource_HeadFrameLoaderByName")
require("Title_TitlePicByName")
require("Guild_TipsInfo_03ByName")
require("Guild_TipsInfo_02ByName")
require("Guild_ChatStatusByName")
GetGuild_MemberTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.PlayerHeadGrp = GetGuild_PlayerHeadUis(ui:GetChild("PlayerHeadGrp"))
  uis.HeadFrameLoader = GetCommonResource_HeadFrameLoaderUis(ui:GetChild("HeadFrameLoader"))
  uis.TitlePic = GetTitle_TitlePicUis(ui:GetChild("TitlePic"))
  uis.MainTips_01_Grp = GetGuild_TipsInfo_03Uis(ui:GetChild("MainTips_01_Grp"))
  uis.MainTips_02_Grp = GetGuild_TipsInfo_02Uis(ui:GetChild("MainTips_02_Grp"))
  uis.ChatStatus = GetGuild_ChatStatusUis(ui:GetChild("ChatStatus"))
  uis.root = ui
  return uis
end


