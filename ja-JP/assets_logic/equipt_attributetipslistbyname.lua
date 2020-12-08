-- params : ...
-- function num : 0 , upvalues : _ENV
GetEquipt_AttributeTipsLIstUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.Decorate_01_Image = ui:GetChild("Decorate_01_Image")
  uis.BattleTxt = ui:GetChild("BattleTxt")
  uis.BattleNameTxt = ui:GetChild("BattleNameTxt")
  uis.TipsList = ui:GetChild("TipsList")
  uis.root = ui
  return uis
end


