-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_BlackBgAniBByName")
require("CommonResource_AssetStripByName")
GetLottery_PtExchangeUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BlackBgAni = GetCommonResource_BlackBgAniBUis(ui:GetChild("BlackBgAni"))
  uis.RedImage = ui:GetChild("RedImage")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.DecorateImage = ui:GetChild("DecorateImage")
  uis.CardList = ui:GetChild("CardList")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.PtNumberTxt = ui:GetChild("PtNumberTxt")
  uis.Decorate_05_Image = ui:GetChild("Decorate_05_Image")
  uis.TipsTxt = ui:GetChild("TipsTxt")
  uis.root = ui
  return uis
end


