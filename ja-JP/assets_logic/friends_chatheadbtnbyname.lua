-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_OnLineByName")
require("Friends_MessageTipsByName")
GetFriends_ChatHeadBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.Decorate_03_Image = ui:GetChild("Decorate_03_Image")
  uis.ActorHeadLoader = ui:GetChild("ActorHeadLoader")
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.OnLine = GetFriends_OnLineUis(ui:GetChild("OnLine"))
  uis.MessageTips = GetFriends_MessageTipsUis(ui:GetChild("MessageTips"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


