-- params : ...
-- function num : 0 , upvalues : _ENV
GetCard_ImprintEffectUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.EffectLoader = ui:GetChild("EffectLoader")
  uis.ImprintBtn = ui:GetChild("ImprintBtn")
  uis.root = ui
  return uis
end


