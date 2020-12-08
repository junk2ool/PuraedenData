-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
require("HandBook_AlbumCGListByName")
require("HandBook_AlbumActivityCGByName")
require("HandBook_AlbumPanelByName")
GetHandBook_AlbumUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.NumberTxt = ui:GetChild("NumberTxt")
  uis.AlbumCGList = GetHandBook_AlbumCGListUis(ui:GetChild("AlbumCGList"))
  uis.AlbumActivityCG = GetHandBook_AlbumActivityCGUis(ui:GetChild("AlbumActivityCG"))
  uis.AlbumPanelGrp = GetHandBook_AlbumPanelUis(ui:GetChild("AlbumPanelGrp"))
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


