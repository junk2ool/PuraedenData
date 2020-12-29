-- params : ...
-- function num : 0 , upvalues : _ENV
require("Home_LotteryTipsByName")
require("Home_HeadByName")
require("Home_BtnPanelByName")
require("Home_ActivityByName")
require("Home_BackGroundChoiceByName")
GetHome_HomeCtrlUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.CardBtn = ui:GetChild("CardBtn")
  uis.TeamBtn = ui:GetChild("TeamBtn")
  uis.EquipmentBtn = ui:GetChild("EquipmentBtn")
  uis.AdventureBtn = ui:GetChild("AdventureBtn")
  uis.ShopBtn = ui:GetChild("ShopBtn")
  uis.LotteryBtn = ui:GetChild("LotteryBtn")
  uis.TaskBtn = ui:GetChild("TaskBtn")
  uis.FriendBtn = ui:GetChild("FriendBtn")
  uis.HandbookBtn = ui:GetChild("HandbookBtn")
  uis.GuildBtn = ui:GetChild("GuildBtn")
  uis.FamilyBtn = ui:GetChild("FamilyBtn")
  uis.Top_BagBtn = ui:GetChild("Top_BagBtn")
  uis.DailyBtn = ui:GetChild("DailyBtn")
  uis.LotteryTips = GetHome_LotteryTipsUis(ui:GetChild("LotteryTips"))
  uis.LeftList = ui:GetChild("LeftList")
  uis.Mainhead_04_Grp = ui:GetChild("Mainhead_04_Grp")
  uis.HeadGrp = GetHome_HeadUis(ui:GetChild("HeadGrp"))
  uis.BtnPanel = GetHome_BtnPanelUis(ui:GetChild("BtnPanel"))
  uis.ServerNameTxt = ui:GetChild("ServerNameTxt")
  uis.Activity = GetHome_ActivityUis(ui:GetChild("Activity"))
  uis.CarnivalBtn = ui:GetChild("CarnivalBtn")
  uis.ActivityDungeonBtn = ui:GetChild("ActivityDungeonBtn")
  uis.Top_MailBtn = ui:GetChild("Top_MailBtn")
  uis.AnnouncementBtn = ui:GetChild("AnnouncementBtn")
  uis.ActorInfoBtn = ui:GetChild("ActorInfoBtn")
  uis.BackGroundChoice = GetHome_BackGroundChoiceUis(ui:GetChild("BackGroundChoice"))
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


