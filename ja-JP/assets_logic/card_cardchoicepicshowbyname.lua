-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_ChangePicTipsByName")
GetCard_CardChoicePicShowUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PictureLoader = ui:GetChild("PictureLoader")
  uis.ChangePicTips = GetCard_ChangePicTipsUis(ui:GetChild("ChangePicTips"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


