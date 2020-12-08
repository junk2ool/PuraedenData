-- params : ...
-- function num : 0 , upvalues : _ENV
require("GuildBoss_GuildChangeBtnBgByName")
require("CommonResource_RedDollByName")
GetGuildBoss_GuildChangeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RewardChangeBtnBg = GetGuildBoss_GuildChangeBtnBgUis(ui:GetChild("RewardChangeBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


