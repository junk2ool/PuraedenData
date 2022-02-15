-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_CardNameByName")
GetGachaCharacter001_CardTipsBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardName = GetCommonResource_CardNameUis(ui:GetChild("CardName"))
  uis.PicLoader = ui:GetChild("PicLoader")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


