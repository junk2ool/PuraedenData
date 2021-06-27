-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeonTwo_RewardChangeBtnBgByName")
require("CommonResource_RedDollByName")
require("ActivityDungeonTwo_LineByName")
GetActivityDungeonTwo_RewardChangeBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RewardChangeBtnBg = GetActivityDungeonTwo_RewardChangeBtnBgUis(ui:GetChild("RewardChangeBtnBg"))
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.n12 = GetActivityDungeonTwo_LineUis(ui:GetChild("n12"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


