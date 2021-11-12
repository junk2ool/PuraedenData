-- params : ...
-- function num : 0 , upvalues : _ENV
require("Home_LotteryTipsByName")
require("Home_LotteryTenTipsByName")
require("Home_GiftTipsByName")
GetHome_BottomButtonUis = function(ui, ...)
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
  uis.LotteryTips = GetHome_LotteryTipsUis(ui:GetChild("LotteryTips"))
  uis.LotteryTenTips = GetHome_LotteryTenTipsUis(ui:GetChild("LotteryTenTips"))
  uis.GiftTips = GetHome_GiftTipsUis(ui:GetChild("GiftTips"))
  uis.ClothesCtr = ui:GetController("Clothes")
  uis.root = ui
  return uis
end


