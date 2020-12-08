-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_TipsInfo_03ByName")
require("Guild_PlayerHeadByName")
GetGuild_InspectTipsUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlayerNameTxt = ui:GetChild("PlayerNameTxt")
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.YesBtn = ui:GetChild("YesBtn")
  uis.NoBtn = ui:GetChild("NoBtn")
  uis.Battle = GetGuild_TipsInfo_03Uis(ui:GetChild("Battle"))
  uis.PlayerHeadGrp = GetGuild_PlayerHeadUis(ui:GetChild("PlayerHeadGrp"))
  uis.HeadImage = ui:GetChild("HeadImage")
  uis.HeadList = ui:GetChild("HeadList")
  uis.root = ui
  return uis
end


