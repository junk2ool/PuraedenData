-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_CardNameByName")
GetActivityDungeonTwo_CardInfoUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardName = GetCommonResource_CardNameUis(ui:GetChild("CardName"))
  uis.CardTipsLoader = ui:GetChild("CardTipsLoader")
  uis.CardQLoader = ui:GetChild("CardQLoader")
  uis.buttonCtr = ui:GetController("button")
  uis.root = ui
  return uis
end


