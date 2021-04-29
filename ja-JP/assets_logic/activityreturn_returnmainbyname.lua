-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityReturn_PlanMainByName")
require("ActivityReturn_LogonMainByName")
require("CommonResource_AssetStripByName")
GetActivityReturn_ReturnMainUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.PlanMain = GetActivityReturn_PlanMainUis(ui:GetChild("PlanMain"))
  uis.LogonMain = GetActivityReturn_LogonMainUis(ui:GetChild("LogonMain"))
  uis.AssetStripGrp = GetCommonResource_AssetStripUis(ui:GetChild("AssetStripGrp"))
  uis.LogonBtn = ui:GetChild("LogonBtn")
  uis.PlanBtn = ui:GetChild("PlanBtn")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


