-- params : ...
-- function num : 0 , upvalues : _ENV
GetLottery_StartWordUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.BackgroundEffectLoader = ui:GetChild("BackgroundEffectLoader")
  uis.Lines1Txt = ui:GetChild("Lines1Txt")
  uis.Lines2Txt = ui:GetChild("Lines2Txt")
  uis.LinesLoader = ui:GetChild("LinesLoader")
  uis.c1Ctr = ui:GetController("c1")
  uis.root = ui
  return uis
end


