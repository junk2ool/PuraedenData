-- params : ...
-- function num : 0 , upvalues : _ENV
require("Relic_LayerBuildByName")
GetRelic_LayerBuildMapUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.L1 = GetRelic_LayerBuildUis(ui:GetChild("L1"))
  uis.L2 = GetRelic_LayerBuildUis(ui:GetChild("L2"))
  uis.L3 = GetRelic_LayerBuildUis(ui:GetChild("L3"))
  uis.L4 = GetRelic_LayerBuildUis(ui:GetChild("L4"))
  uis.L5 = GetRelic_LayerBuildUis(ui:GetChild("L5"))
  uis.L6 = GetRelic_LayerBuildUis(ui:GetChild("L6"))
  uis.L7 = GetRelic_LayerBuildUis(ui:GetChild("L7"))
  uis.L8 = GetRelic_LayerBuildUis(ui:GetChild("L8"))
  uis.L9 = GetRelic_LayerBuildUis(ui:GetChild("L9"))
  uis.L10 = GetRelic_LayerBuildUis(ui:GetChild("L10"))
  uis.L11 = GetRelic_LayerBuildUis(ui:GetChild("L11"))
  uis.L12 = GetRelic_LayerBuildUis(ui:GetChild("L12"))
  uis.L13 = GetRelic_LayerBuildUis(ui:GetChild("L13"))
  uis.L14 = GetRelic_LayerBuildUis(ui:GetChild("L14"))
  uis.L15 = GetRelic_LayerBuildUis(ui:GetChild("L15"))
  uis.L16 = GetRelic_LayerBuildUis(ui:GetChild("L16"))
  uis.L17 = GetRelic_LayerBuildUis(ui:GetChild("L17"))
  uis.L18 = GetRelic_LayerBuildUis(ui:GetChild("L18"))
  uis.L19 = GetRelic_LayerBuildUis(ui:GetChild("L19"))
  uis.L20 = GetRelic_LayerBuildUis(ui:GetChild("L20"))
  uis.root = ui
  return uis
end


