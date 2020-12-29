-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_BattleInfoUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.NameTxt = ui:GetChild("NameTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.BattleImage = ui:GetChild("BattleImage")
  uis.root = ui
  return uis
end


