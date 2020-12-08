-- params : ...
-- function num : 0 , upvalues : _ENV
require("Friends_MessageTipsByName")
GetFriends_Button_B_BtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.RedDot = GetFriends_MessageTipsUis(ui:GetChild("RedDot"))
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


