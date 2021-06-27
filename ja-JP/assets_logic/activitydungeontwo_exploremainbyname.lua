-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_SpendByName")
require("CommonResource_Line_04ByName")
require("ActivityDungeonTwo_AutoRewardShowByName")
require("ActivityDungeonTwo_UpCardByName")
GetActivityDungeonTwo_ExploreMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ABtn = ui:GetChild("ABtn")
  uis.BBtn = ui:GetChild("BBtn")
  uis.CBtn = ui:GetChild("CBtn")
  uis.ExplainWordList = ui:GetChild("ExplainWordList")
  uis.Spend = GetActivityDungeonTwo_SpendUis(ui:GetChild("Spend"))
  uis.Line = GetCommonResource_Line_04Uis(ui:GetChild("Line"))
  uis.RewardShow = GetActivityDungeonTwo_AutoRewardShowUis(ui:GetChild("RewardShow"))
  uis.UpCard = GetActivityDungeonTwo_UpCardUis(ui:GetChild("UpCard"))
  uis.c1Ctr = ui:GetController("c1")
  uis.c2Ctr = ui:GetController("c2")
  uis.root = ui
  return uis
end


