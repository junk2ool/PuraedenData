-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_RedDollByName")
require("AdventureGame_ThemeCardLabelByName")
GetAdventureGame_ThemeCardBtnUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.CardNameLoader = ui:GetChild("CardNameLoader")
  uis.CardHeadLoader = ui:GetChild("CardHeadLoader")
  uis.WordImage = ui:GetChild("WordImage")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.RedDot = GetCommonResource_RedDollUis(ui:GetChild("RedDot"))
  uis.One = GetAdventureGame_ThemeCardLabelUis(ui:GetChild("One"))
  uis.Two = GetAdventureGame_ThemeCardLabelUis(ui:GetChild("Two"))
  uis.Three = GetAdventureGame_ThemeCardLabelUis(ui:GetChild("Three"))
  uis.ItemLoader = ui:GetChild("ItemLoader")
  uis.ItemNameTxt = ui:GetChild("ItemNameTxt")
  uis.ItemWord = GetAdventureGame_ThemeCardLabelUis(ui:GetChild("ItemWord"))
  uis.buttonCtr = ui:GetController("button")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


