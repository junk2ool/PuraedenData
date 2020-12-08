-- params : ...
-- function num : 0 , upvalues : _ENV
GetGuildBoss_SkillWordUis = function(ui, ...)
  -- function num : 0_0
  local uis = {}
  uis.LevelTxt = ui:GetChild("LevelTxt")
  uis.WordTxt = ui:GetChild("WordTxt")
  uis.root = ui
  return uis
end


