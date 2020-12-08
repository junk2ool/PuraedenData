-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_Line_02ByName")
require("CommonResource_Line_04ByName")
require("GuildBoss_BossSupportRewardByName")
require("GuildBoss_BossSupportPlaceByName")
GetGuildBoss_BossSupportUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.TitleTxt = ui:GetChild("TitleTxt")
  uis.CloseBtn = ui:GetChild("CloseBtn")
  uis.SureBtn = ui:GetChild("SureBtn")
  uis.Line = GetCommonResource_Line_02Uis(ui:GetChild("Line"))
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.CardHeadList = ui:GetChild("CardHeadList")
  uis.BossSupportReward = GetGuildBoss_BossSupportRewardUis(ui:GetChild("BossSupportReward"))
  uis.BossSupportPlaceA = GetGuildBoss_BossSupportPlaceUis(ui:GetChild("BossSupportPlaceA"))
  uis.BossSupportPlaceB = GetGuildBoss_BossSupportPlaceUis(ui:GetChild("BossSupportPlaceB"))
  uis.root = ui
  return uis
end


