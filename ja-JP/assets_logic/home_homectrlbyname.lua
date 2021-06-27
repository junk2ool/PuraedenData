-- params : ...
-- function num : 0 , upvalues : _ENV
require("Home_BottomButtonByName")
require("Home_HeadByName")
require("Home_BtnPanelByName")
require("Home_ActivityByName")
require("Home_BackGroundChoiceByName")
GetHome_HomeCtrlUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BottomButton = GetHome_BottomButtonUis(ui:GetChild("BottomButton"))
  uis.FriendBtn = ui:GetChild("FriendBtn")
  uis.HandbookBtn = ui:GetChild("HandbookBtn")
  uis.GuildBtn = ui:GetChild("GuildBtn")
  uis.FamilyBtn = ui:GetChild("FamilyBtn")
  uis.Top_BagBtn = ui:GetChild("Top_BagBtn")
  uis.DailyBtn = ui:GetChild("DailyBtn")
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


