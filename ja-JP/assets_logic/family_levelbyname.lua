-- params : ...
-- function num : 0 , upvalues : _ENV
GetFamily_LevelUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.LevelExpTxt = ui:GetChild("LevelExpTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.FarmLevelTxt = ui:GetChild("FarmLevelTxt")
  uis.root = ui
  return uis
end


